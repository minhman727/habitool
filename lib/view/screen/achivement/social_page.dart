import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/achivement/view_note.dart';
import 'package:habitool/widgets/custom_appbar.dart';
import 'package:habitool/widgets/custom_appbar_social.dart';
import 'package:intl/intl.dart';

import 'add_note.dart';

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('social');

  List<Color> myColors = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
    Colors.purple[200],
    Colors.cyan[200],
    Colors.teal[200],
    Colors.tealAccent[200],
    Colors.pink[200],
  ];
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(
      //       MaterialPageRoute(
      //         builder: (context) => AddNote(),
      //       ),
      //     )
      //         .then((value) {
      //       print("Calling Set  State !");
      //       setState(() {});
      //     });
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: CustomColors.light,
      //   ),
      //
      //   backgroundColor: CustomColors.blue,
      //
      //
      // ),
      //
      appBar: CustomAppBarSocial(
          title: 'Cộng đồng',
          actionText: 'Thêm trạng thái ',

          action: () {
            Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
            setState(() {});
          });
          }),
      //
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text(
                  "You have no saved Notes !",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(4)];
                Map data = snapshot.data.docs[index].data();
                DateTime mydateTime = data['created'].toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data.docs[index].reference,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          //
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Roboto",
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}