// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final CollectionReference _messages = FirebaseFirestore.instance.collection(
//     'messages',
//   );

//   void _sendMessage() {
//     if (_controller.text.trim().isEmpty) return;

//     _messages.add({
//       'text': _controller.text,
//       'createdAt': Timestamp.now(),
//       // optionally: 'userId': 'currentUserId'
//     });

//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _messages
//                   .orderBy('createdAt', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData)
//                   return Center(child: CircularProgressIndicator());

//                 final docs = snapshot.data!.docs;

//                 return ListView.builder(
//                   reverse: true, // newest messages at the bottom
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     var message = docs[index]['text'];
//                     return ListTile(title: Text(message));
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: 'Type a message...'),
//                   ),
//                 ),
//                 IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
