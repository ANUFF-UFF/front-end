import 'dart:convert';
import 'package:demo_es/chat.dart';
import 'package:demo_es/perfil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnuncioScreen extends StatefulWidget {
  final Map<String, dynamic> info;
  final Map<String, dynamic> usuario;
  const AnuncioScreen({required this.usuario, required this.info, super.key});

  @override
  _AnuncioScreenState createState() => _AnuncioScreenState();
}

class _AnuncioScreenState extends State<AnuncioScreen> {
  final TextEditingController _commentController = TextEditingController();
  int avaliacao = 0;

  Future<List<Map<String, dynamic>>> getAvaliacao() async {

    String url = "http://127.0.0.1:8000/avaliacoes/anuncio/${widget.info['id'].toString()}/";
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic> jsonList = jsonDecode(response.body);

    if (jsonList.isNotEmpty) {
      List<Map<String, dynamic>> ret = jsonList.cast<Map<String, dynamic>>();

      
      for (int index = 0; index < ret.length; index++) {
        url = "http://127.0.0.1:8000/usuarios/${ret[index]['autor'].toString()}/";
        response = await http.get(Uri.parse(url));
        Map<String, dynamic> result = jsonDecode(response.body);
        ret[index]['nome'] = result['nome'];
        ret[index]['foto'] = result['foto'];
      }

      return ret;
    } else {
      throw Exception("Erro ao buscar os dados");
    }
  }

  void _addComment() async {
    if (_commentController.text.trim().isNotEmpty) {

      final data = {
        'nota': avaliacao,
        'comentario': _commentController.text,
        'autor': widget.usuario['id'],
        'anuncio': widget.info['id'],
      };

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/avaliacao/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
      // Comentário enviado com sucesso
        setState(() {
          _commentController.clear(); // Limpa o campo de texto
          avaliacao = 0; // Reseta a avaliação
        });

        // Atualiza os comentários
        setState(() {});
      } else {
        // Exibe um erro, se necessário
        print("Erro ao adicionar comentário: ${response.body}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ANUFF', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue)),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
            icon: const Icon(Icons.account_circle),
            iconSize: 40.0,
            onPressed: ()  {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PerfilPage()),
      );
      },
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          constraints: const BoxConstraints(maxWidth: 1500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PageView(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(widget.info['foto'] ?? 'images/background.jpeg'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (widget.info['titulo'] ?? 'Sem Titulo'),
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: widget.info['nota'].round() > index ? Colors.amber : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Preço:',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'R\$ ',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    (widget.info['preco'].toString()),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            (widget.info['descricao'] ?? ''),
                            style: const TextStyle(fontSize: 16),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(chatInfo: widget.info, usuarioLogadoId: widget.usuario['id']),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.chat,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Chat com o Vendedor',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black26,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                          ),
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/celular.png'),
                            ),
                            title: Row(children: [
                              Text(widget.info['nome_autor'] ?? 'Sem autor'),
                              const SizedBox(width: 16),
                              Row(
                                children: List.generate(
                                  3,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ]),
                            subtitle: const Text('Ver perfil'),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Comentários',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              FutureBuilder(
                future: getAvaliacao(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();

                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());

                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(snapshot.data![index]['foto'] ?? 'images/celular.png'),
                            ),
                            title: Text(snapshot.data![index]['nome']),
                            subtitle: Row(
                              children: [
                                Text(snapshot.data![index]['comentario']),
                                Row(
                                  children: List.generate(
                                    5,
                                    (indexS) => Icon(
                                        Icons.star,
                                        color: snapshot.data![index]['nota'] >= indexS ? Colors.amber : Colors.grey,
                                        size: 10
                                    )
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  } else {
                    return Text('Não há Avaliações');
                  }
                },
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Adicione um comentário...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: Icon(Icons.star,
                          color: avaliacao >= index ? Colors.amber : Colors.grey,
                          size: 20
                          ),
                        onPressed: () {
                          setState(() {
                            avaliacao = index;
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: _addComment,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
