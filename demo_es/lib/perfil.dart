import 'package:demo_es/home.dart';
import 'package:demo_es/login.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  final Map<String, dynamic> userInfo = {
    'nome': 'Nome do Usuário',
    'email': 'email@usuario.com',
    'fotoPerfil': 'https://cdn-icons-png.flaticon.com/512/9187/9187604.png',
    'anuncios': [
      'Anúncio 1',
      'Anúncio 2',
      'Anúncio 3',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(userInfo['fotoPerfil']!),
              ),
            ),
            SizedBox(height: 16),
            Text(
              userInfo['nome']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              userInfo['email']!,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),
            Text(
              'Anúncios Ativos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userInfo['anuncios'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userInfo['anuncios'][index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de alteração de dados
              },
              child: Text('Alterar Dados'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de logout
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}