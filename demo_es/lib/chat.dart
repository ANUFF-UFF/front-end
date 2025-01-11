import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, String> info;

  const ChatScreen({required this.info, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Estado global para armazenar mensagens por vendedor.
  static final Map<String, List<Map<String, String>>> _messagesBySeller = {};

  List<Map<String, String>> get _messages =>
      _messagesBySeller[widget.info['autor']] ?? [];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final now = DateTime.now();
      final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);

      setState(() {
        // Adiciona a mensagem ao estado global associado ao vendedor.
        _messagesBySeller.putIfAbsent(widget.info['autor']!, () => []);
        _messagesBySeller[widget.info['autor']]!.add({
          'text': text,
          'timestamp': formattedDate,
        });
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.info['autor'] ?? 'Chat com o vendedor'), // Nome do vendedor no título
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true, // Exibe as mensagens mais recentes no topo
              itemBuilder: (context, index) {
                final message = _messages.reversed.toList()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
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
                          style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
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
