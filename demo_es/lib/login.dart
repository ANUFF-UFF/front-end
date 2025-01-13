import 'dart:convert';
import 'package:demo_es/home.dart';
import 'package:flutter/material.dart';
import 'package:demo_es/register.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late Map<String, dynamic> usuario;

  Future<int> verificarUsuario(String email, String senha) async {
    String url = "http://127.0.0.1:8000/login";
    try {
      http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode({
          "email": email,
          "senha": senha
        })
      );

      usuario = jsonDecode(response.body);

      return response.statusCode;
    } catch (e) {
      return 0;
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ANUFF',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 700,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                )
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 700,
                child: TextField(
                  obscureText: true,
                  controller: senhaController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                )
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  int res = await verificarUsuario(emailController.text, senhaController.text);

                  if (res == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Anuff(usuario: usuario),
                      ),
                    );
                  } else if (res == 401) {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Email, ou Senha Inválidos'),
                          );
                        },
                      );
                    });
                  } else {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Falha com API'),
                          );
                        },
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Não tem uma conta? Cadastre-se',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
