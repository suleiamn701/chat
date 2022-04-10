import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat/3y7GseaGYyLACmOeqTL1/message')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['message']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chat/3y7GseaGYyLACmOeqTL1/message').add({
            'message':'This data added from code'
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// return Scaffold(
// body: ListView.builder(
// itemCount: 10,
// itemBuilder: (ctx, index) => Container(
// padding: EdgeInsets.all(8),
// child: Text('This is Item in ListView'),
// )),
// floatingActionButton: FloatingActionButton(
// onPressed: () {
// FirebaseFirestore.instance
//     .collection('chat/3y7GseaGYyLACmOeqTL1/message')
//     .snapshots()
//     .listen((data) {
// data.docs.forEach((documents) {
// print(documents['message']);
// });
// });
// },
// child: Icon(Icons.add),
// ),
// );
