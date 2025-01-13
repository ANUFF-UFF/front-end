import 'package:flutter/material.dart';

class AdvertiserPage extends StatelessWidget {
  final Map<String, dynamic> info;
  final List<Map<String, String>> anunciosAutor;

  const AdvertiserPage({
    Key? key,
    required this.info,
    required this.anunciosAutor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil do Anunciante"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto de perfil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(info['fotoPerfil'] ?? ''),
              ),
            ),
            SizedBox(height: 16),

            // Nome
            Text(
              "Nome: ${info['autor'] ?? 'Não informado'}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Ocupação
            Text(
              "Ocupação: ${info['ocupacao'] ?? 'Não informado'}",
              style: TextStyle(fontSize: 16),
            ),

            // Reputação
            Row(
              children: [
                Text(
                  "Reputação: ",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  "${info['reputacao']?.toString() ?? '0.0'}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Título para os anúncios
            Text(
              "Seus Anúncios",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            // Lista de anúncios
            Expanded(
              child: anunciosAutor.isNotEmpty
                  ? ListView.builder(
                      itemCount: anunciosAutor.length,
                      itemBuilder: (context, index) {
                        final anuncio = anunciosAutor[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(anuncio['titulo'] ?? 'Título não informado'),
                            subtitle: Text(anuncio['descricao'] ?? 'Descrição não informada'),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("Nenhum anúncio encontrado."),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}