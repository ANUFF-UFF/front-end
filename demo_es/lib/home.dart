import 'package:demo_es/advertiserPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Anuff extends StatefulWidget {
  const Anuff({super.key});

  @override
  State<Anuff> createState() => _AnuffState();
}

class _AnuffState extends State<Anuff> {
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
            padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
            icon: const Icon(Icons.account_circle),
            iconSize: 40.0,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: MasonryGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Anuncio(index: index);
          },
        ),
      ),
    );
  }
}


class Anuncio extends StatefulWidget {
  final int index;

  const Anuncio({required this.index, super.key});

  @override
  State<Anuncio> createState() => _AnuncioState();
}

class _AnuncioState extends State<Anuncio> {
  static List<Map<String, String>> anuncios = [{'titulo': 'Livro', 'imagem': 'images/livro.png', 'autor': 'Adriano', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend dolor quis mattis pharetra. Nulla feugiat dui vitae ligula porta mattis. Curabitur quis venenatis lectus. Aliquam et auctor odio, vel aliquet justo. Nulla ipsum mi, mollis vitae lacus nec, blandit congue urna. Maecenas tristique sem vel arcu vestibulum, quis efficitur diam sodales. Vestibulum in elementum tellus. Vestibulum rhoncus nibh vel risus aliquet faucibus. Sed at ex eget ipsum placerat commodo. Quisque pulvinar erat sagittis enim egestas sollicitudin. Proin nisi ipsum, scelerisque eu ornare sit amet, efficitur eu dolor. Donec sapien diam, congue nec luctus ut, condimentum at lacus. Cras eget rhoncus nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum facilisis ornare facilisis. Integer et mollis nunc, id fermentum nisi.'},
  {'titulo': 'Celular', 'imagem': 'images/celular.png', 'autor': 'Arthur', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend dolor quis mattis pharetra. Nulla feugiat dui vitae ligula porta mattis. Curabitur quis venenatis lectus. Aliquam et auctor odio, vel aliquet justo. Nulla ipsum mi, mollis vitae lacus nec, blandit congue urna. Maecenas tristique sem vel arcu vestibulum, quis efficitur diam sodales. Vestibulum in elementum tellus. Vestibulum rhoncus nibh vel risus aliquet faucibus. Sed at ex eget ipsum placerat commodo. Quisque pulvinar erat sagittis enim egestas sollicitudin. Proin nisi ipsum, scelerisque eu ornare sit amet, efficitur eu dolor. Donec sapien diam, congue nec luctus ut, condimentum at lacus. Cras eget rhoncus nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum facilisis ornare facilisis. Integer et mollis nunc, id fermentum nisi.'},
  {'titulo': 'Aulas de Física', 'imagem': 'images/fisica.png', 'autor': 'Andre', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend dolor quis mattis pharetra. Nulla feugiat dui vitae ligula porta mattis. Curabitur quis venenatis lectus. Aliquam et auctor odio, vel aliquet justo. Nulla ipsum mi, mollis vitae lacus nec, blandit congue urna. Maecenas tristique sem vel arcu vestibulum, quis efficitur diam sodales. Vestibulum in elementum tellus. Vestibulum rhoncus nibh vel risus aliquet faucibus. Sed at ex eget ipsum placerat commodo. Quisque pulvinar erat sagittis enim egestas sollicitudin. Proin nisi ipsum, scelerisque eu ornare sit amet, efficitur eu dolor. Donec sapien diam, congue nec luctus ut, condimentum at lacus. Cras eget rhoncus nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum facilisis ornare facilisis. Integer et mollis nunc, id fermentum nisi.'},
  {'titulo': 'Vaga em República', 'imagem': 'images/republica.png', 'autor': 'Maria Julia', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend dolor quis mattis pharetra. Nulla feugiat dui vitae ligula porta mattis. Curabitur quis venenatis lectus. Aliquam et auctor odio, vel aliquet justo. Nulla ipsum mi, mollis vitae lacus nec, blandit congue urna. Maecenas tristique sem vel arcu vestibulum, quis efficitur diam sodales. Vestibulum in elementum tellus. Vestibulum rhoncus nibh vel risus aliquet faucibus. Sed at ex eget ipsum placerat commodo. Quisque pulvinar erat sagittis enim egestas sollicitudin. Proin nisi ipsum, scelerisque eu ornare sit amet, efficitur eu dolor. Donec sapien diam, congue nec luctus ut, condimentum at lacus. Cras eget rhoncus nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum facilisis ornare facilisis. Integer et mollis nunc, id fermentum nisi.'},
  {'titulo': 'Vaga em República', 'imagem': 'images/republica.png', 'autor': 'Maria Julia', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend dolor quis mattis pharetra. Nulla feugiat dui vitae ligula porta mattis. Curabitur quis venenatis lectus. Aliquam et auctor odio, vel aliquet justo. Nulla ipsum mi, mollis vitae lacus nec, blandit congue urna. Maecenas tristique sem vel arcu vestibulum, quis efficitur diam sodales. Vestibulum in elementum tellus. Vestibulum rhoncus nibh vel risus aliquet faucibus. Sed at ex eget ipsum placerat commodo. Quisque pulvinar erat sagittis enim egestas sollicitudin. Proin nisi ipsum, scelerisque eu ornare sit amet, efficitur eu dolor. Donec sapien diam, congue nec luctus ut, condimentum at lacus. Cras eget rhoncus nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum facilisis ornare facilisis. Integer et mollis nunc, id fermentum nisi.'},
  {'titulo': 'Telescópio', 'imagem': 'images/background.jpeg', 'autor': 'Daniel', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend dolor quis mattis pharetra. Nulla feugiat dui vitae ligula porta mattis. Curabitur quis venenatis lectus. Aliquam et auctor odio, vel aliquet justo. Nulla ipsum mi, mollis vitae lacus nec, blandit congue urna. Maecenas tristique sem vel arcu vestibulum, quis efficitur diam sodales. Vestibulum in elementum tellus. Vestibulum rhoncus nibh vel risus aliquet faucibus. Sed at ex eget ipsum placerat commodo. Quisque pulvinar erat sagittis enim egestas sollicitudin. Proin nisi ipsum, scelerisque eu ornare sit amet, efficitur eu dolor. Donec sapien diam, congue nec luctus ut, condimentum at lacus. Cras eget rhoncus nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum facilisis ornare facilisis. Integer et mollis nunc, id fermentum nisi.'}];
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
                    anuncios[widget.index]['titulo']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber)
                    ],
                  )
                ],
              )
            ),
            Image.asset(
              anuncios[widget.index]['imagem']!,
              fit: BoxFit.cover,
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
                            Text(anuncios[widget.index]['autor']!, style: const TextStyle(fontSize: 16)),
                            IconButton(
                                icon: const Icon(Icons.account_circle, size: 30),
                                onPressed: () {
                                  // Navegar para a página do anunciante
                                  // Navegar para a página do anunciante
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AnunciantePage(
                                          nome: anuncios[widget.index]['autor']!, 
                                           anunciosAutor: anuncios
                                              .where((anuncio) => anuncio['autor'] == anuncios[widget.index]['autor'])
                                              .toList(), // Imagens do autor
                                        ),
                                      ),
                                    );
                                },
                              ),
                          ],
                        )
                      ],
                    )
                    );
                }, 
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    anuncios[widget.index]['descricao']!,
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
