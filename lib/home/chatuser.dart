import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreenuser extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final CollectionReference _messagesCollection = FirebaseFirestore.instance.collection('messages');

  void _sendMessage(String message) {
    _messagesCollection.add({
      'sender': 'user_id', // Replace with authenticated user's ID
      'message': message,
      'timestamp': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.blue[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.withOpacity(0.7), Colors.grey.withOpacity(0.3)],
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: _messagesCollection.orderBy('timestamp', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index].data() as Map<String, dynamic>;
                      final isFromUser = message['sender'] == 'user_id';

                      return Align(
                        alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isFromUser ? Colors.redAccent[100] : Colors.blue[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              message['message'],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                      )
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_sharp,color: Colors.blue[500],),
                  onPressed: () {
                    String message = _textEditingController.text;
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                      _textEditingController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
