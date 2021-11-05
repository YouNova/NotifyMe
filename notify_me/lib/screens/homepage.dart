import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notify_me/screens/addtask.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('tasks')
              .document(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              //final docs = snapshot.data.documents;
              return ListView.builder(
                //itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff121211),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              // child: Text(
                              //   docs[index]['title'],
                              //   style: GoogleFonts.roboto(fontSize: 18),
                              // ),
                            ),
                          ],
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // await Firestore.instance
                              //     .collection('tasks')
                              //     .document(uid)
                              //     .collection('mytasks')
                              //     .document(docs[index]['time'])
                              //     .delete();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
      ),
    );
  }
}
