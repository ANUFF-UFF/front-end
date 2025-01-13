import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CriarAnuncioPage extends StatefulWidget {

  int autor;

  CriarAnuncioPage({required this.autor});

  @override
  _CreateAdScreenState createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CriarAnuncioPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

void _submitAd() async {
  final String title = _titleController.text;
  final String description = _descriptionController.text;
  final String preco = _precoController.text;
  final String image = _imageController.text;

  if (title.isEmpty || description.isEmpty || preco.isEmpty || image.isEmpty ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Por favor, preencha todos os campos e selecione uma imagem.')),
    );
    return;
  }

  // Configurar os dados do anúncio
  final newAd = {
    'titulo': title,
    'descricao': description,
    'autor': widget.autor,
    'preco': double.parse(preco),
    'foto': image, 
  };

  // Enviar para o servidor
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/anuncios/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newAd),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anúncio criado com sucesso!')),
      );

      // Limpa os campos após enviar
      _titleController.clear();
      _descriptionController.clear();
      _precoController.clear();
      _imageController.clear();

      // Navega de volta à página de anúncios
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar o anúncio. Tente novamente.')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro de conexão. Tente novamente.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 30.0, 
          color: Colors.blue, 
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800), 
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 32),
                  TextField(
                    controller: _precoController,
                    decoration: InputDecoration(
                      labelText: 'Preco',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 35),
                  TextField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'Image',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 75),
                  ElevatedButton(
                      onPressed: () {
                        _submitAd();
                      },
                      child: Text('Criar Anúncio'),
                    ),
                ],
               ),
              ),
            ),
           ),
          ),
        );
      }
    }
