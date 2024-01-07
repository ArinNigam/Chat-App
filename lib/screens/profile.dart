import 'package:firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late User loggedInUser;

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  String getUserName(String x) {
    int ind = x.indexOf('@');
    return x.substring(0, ind);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 20,
          ),
          Container(
              height: 25,
              width: 25,
              child: Image.asset("images/profile_pic.png")),
          SizedBox(
            width: 20,
          ),
          Text(getUserName(loggedInUser.email.toString())),
          SizedBox(
            width: 100,
          ),
          Column(
            children: [
              Text(
                "Groups",
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
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
              Padding(
                padding: EdgeInsets.all(18.0),
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
              Padding(
                padding: EdgeInsets.all(18.0),
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
            ],
          )
        ]),
      ),
    );
  }
}
