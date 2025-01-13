import 'dart:convert';
import 'package:demo_es/criarAnuncio.dart';
import 'package:demo_es/advertiserPage.dart';
import 'package:demo_es/perfil.dart';
import 'package:demo_es/anuncio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class Anuff extends StatefulWidget {
  final Map<String, dynamic> usuario;

  Anuff({required this.usuario, super.key});

  @override
  State<Anuff> createState() => _AnuffState();
}

class _AnuffState extends State<Anuff> {

  Future<List<Map<String, dynamic>>> getAnuncios() async {

    String url = "http://127.0.0.1:8000/anuncios/";
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic> jsonList = jsonDecode(response.body);

    if (jsonList.isNotEmpty) {
      List<Map<String, dynamic>> ret = jsonList.cast<Map<String, dynamic>>();

      return ret;
    } else {
      throw Exception("Erro ao buscar os dados");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ANUFF', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue)),
        leadingWidth: 500.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
          child: SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 40.0,
            onPressed: () async {
              final bool anuncioCriado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CriarAnuncioPage(),
                ),
              );
              //logica de atualizacao dos anuncios
              // if (anuncioCriado == true) {
              //   _loadAnuncios(); // Recarrega os anúncios ao retornar
              // }
            },
          ),
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
      body: FutureBuilder(
        future: getAnuncios(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());

          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: MasonryGridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Anuncio(anuncios: snapshot.data!, index: index, usuario: widget.usuario );
                },
              ),
            );
          } else {
            return Text('Não há Anuncios');
          }
        },
      )
    );
  }
}


class Anuncio extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> anuncios;
  final Map<String, dynamic> usuario;

  const Anuncio({required this.usuario, required this.anuncios, required this.index, super.key});

  @override
  State<Anuncio> createState() => _AnuncioState();
}

class _AnuncioState extends State<Anuncio> {
  bool _isOpen = false;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.anuncios[widget.index]['titulo']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: widget.anuncios[widget.index]['nota'].round() >= 1 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, color: widget.anuncios[widget.index]['nota'].round() >= 2 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, color: widget.anuncios[widget.index]['nota'].round() >= 3 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, color: widget.anuncios[widget.index]['nota'].round() >= 4 ? Colors.amber : Colors.grey),
                      Icon(Icons.star, color: widget.anuncios[widget.index]['nota'].round() >= 5 ? Colors.amber : Colors.grey)
                    ],
                  )
                ],
              )
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnuncioScreen(info: widget.anuncios[widget.index], usuario: widget.usuario),
                  ),
                );
              },
              child: Image.asset(
                widget.anuncios[widget.index]['foto']!,
                fit: BoxFit.cover,
              )
            ),
            ExpansionPanelList(
              expansionCallback: (i, isOpen) {
                setState(() {
                  _isOpen = isOpen;
                });
              },
              children: [ExpansionPanel(
                isExpanded: _isOpen,
                headerBuilder: (context, isOpen) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Descrição', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(widget.anuncios[widget.index]['nome_autor']!, style: const TextStyle(fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.account_circle),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdvertiserPage(
                                      info: {
                                        'autor': widget.anuncios[widget.index]['autor'],
                                        'fotoPerfil': 'images/celular.png',
                                        'ocupacao': 'Empresário',
                                        'reputacao': widget.anuncios[widget.index]['reputacao'],
                                      },
                                      anunciosAutor: widget.anuncios
                                          .where((a) => a['autor'] == widget.anuncios[widget.index]['autor'])
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    )
                    );
                }, 
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.anuncios[widget.index]['descricao']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )]
            )
          ],
        ),
      ),
    );
  }
}
