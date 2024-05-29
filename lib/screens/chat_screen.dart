import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../components/message_bubble.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
String? group;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String? chatMessage;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getAllCollections();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  void getAllCollections() async {
    try {
      // Obtain a reference to the root of Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // List all collections (Note: This returns QuerySnapshot<QueryDocumentSnapshot>)
      QuerySnapshot collectionsSnapshot =
          await firestore.collectionGroup('').get();

      for (QueryDocumentSnapshot collection in collectionsSnapshot.docs) {
        String collectionName = collection.id;
        print('Collection Name: $collectionName');

        // Now you can access documents within each collection if needed
        QuerySnapshot documentsSnapshot =
            await firestore.collection(collectionName).get();

        // for (QueryDocumentSnapshot document in documentsSnapshot.docs) {
        //   Map<String, dynamic> data = document.data();
        //   print('Document ID: ${document.id}, Data: $data');
        // }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    group = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Image.asset('lib/assets/images/logo.png')),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
                //Implement logout functionality
              }),
        ],
        title: Text(group!.toUpperCase()),
        backgroundColor: const Color(0xFF141D72),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/chat_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          chatMessage = value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection(group!).add({
                          'text': chatMessage,
                          'sender': loggedInUser.email,
                        });
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: _firestore.collection(group!).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF031625),
            ),
          );
        } else {
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubble = [];
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');

            final messageWidget = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: loggedInUser.email == messageSender,
            );
            messageBubble.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubble,
            ),
          );
        }
      },
    );
  }
}
