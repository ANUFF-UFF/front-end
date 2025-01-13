import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> chatInfo;
  final int usuarioLogadoId; // Adicionado para identificar o usuário logado

  const ChatScreen({
    required this.chatInfo,
    required this.usuarioLogadoId,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final chatId = widget.chatInfo['id'];
      final response = await http.get(
        Uri.parse('http://localhost:8000/chats/$chatId/mensagens'),
      );

      if (response.statusCode == 200) {
        final List messages = json.decode(response.body);
        setState(() {
          _messages.clear();
          _messages.addAll(messages.map((msg) => {
                'text': msg['conteudo'],
                'timestamp': DateFormat('dd/MM/yyyy HH:mm')
                    .format(DateTime.parse(msg['enviada_em'])),
                'remetenteId': msg['remetente_id'], // Incluindo remetente_id
              }));
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar mensagens');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar mensagens: $e')),
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      try {
        final chatId = widget.chatInfo['id'];
        final response = await http.post(
          Uri.parse('http://localhost:8000/chats/$chatId/mensagens'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'conteudo': text,
            'remetente_id': widget.usuarioLogadoId, // Incluindo remetente_id
          }),
        );

        if (response.statusCode == 201) {
          final now = DateTime.now();
          final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);

          setState(() {
            _messages.insert(0, {
              'text': text,
              'timestamp': formattedDate,
              'remetenteId': widget.usuarioLogadoId,
            });
          });

          _messageController.clear();
        } else {
          throw Exception('Erro ao enviar mensagem');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar mensagem: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatInfo['nomeVendedor'] ?? 'Chat com o vendedor'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isCurrentUser =
                          message['remetenteId'] == widget.usuarioLogadoId;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Align(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? Colors.teal[100]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  message['text']!,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                message['timestamp']!,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Digite sua mensagem...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send),
                  backgroundColor: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
