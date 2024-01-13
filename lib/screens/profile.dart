import 'package:firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? loggedInUser = FirebaseAuth.instance.currentUser;

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      setState(() {
        loggedInUser = user;
      });
    }
  }

  String getUserName(String x) {
    int ind = x.indexOf('@');
    return x.substring(0, ind);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF141D72),
          elevation: 2.0,
          title: Text("Chat Connect"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Text(
                "Groups",
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ]),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF000F2A), Color(0xFF073863)],
                    // Optional: Specify stops for a more complex gradient
                    // stops: [0.0, 0.5, 1.0],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.asset("images/profile_pic.png")),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        style: TextStyle(fontSize: 32),
                        getUserName(loggedInUser!.email.toString())),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF423691), Color(0xFF050709)],
                    // Optional: Specify stops for a more complex gradient
                    // stops: [0.0, 0.5, 1.0],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextButton(
                              child: Text("group1"),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ChatScreen.id,
                                  arguments: "group1",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextButton(
                              child: Text("group2"),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ChatScreen.id,
                                  arguments: "group2",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextButton(
                              child: Text("group3"),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ChatScreen.id,
                                  arguments: "group3",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
