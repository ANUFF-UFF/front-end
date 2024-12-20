import 'package:demo_es/perfil.dart';
import 'package:flutter/material.dart';

class AnuncioScreen extends StatefulWidget {
  final Map<String, String> info;
  const AnuncioScreen({required this.info, super.key});

  @override
  _AnuncioScreenState createState() => _AnuncioScreenState();
}

class _AnuncioScreenState extends State<AnuncioScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [
    'Comentário sobre o anúncio aqui.',
    'Muito interessante!',
    'Parece um ótimo produto.',
  ];

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.add(_commentController.text.trim());
        _commentController.clear();
      });
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
              IntrinsicHeight(
                child: Row(
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
                                  image: AssetImage(widget.info['imagem'] ?? 'images/background.jpeg'),
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
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
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
                                      (widget.info['preco'] ?? '500'),
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
                              onPressed: () {},
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
                                Text(widget.info['autor'] ?? 'Sem autor'),
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
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Comentários',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('images/celular.png'),
                      ),
                      title: Text('Usuário ${index + 1}'),
                      subtitle: Text(_comments[index]),
                      onTap: () {},
                    );
                  },
                ),
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
