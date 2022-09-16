import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:taskmgmt_app/screens/get_started.dart';
import 'package:taskmgmt_app/services/notifications.dart';
import 'package:taskmgmt_app/services/task_collection.dart';
import 'package:taskmgmt_app/services/user.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';
import 'package:taskmgmt_app/widgets/card_task.dart';
import 'package:taskmgmt_app/widgets/empty_stream_tasks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:taskmgmt_app/services/authentication.dart';

class TaskStream extends StatefulWidget {
  final String uid;
  final String userName;

  const TaskStream({Key? key, required this.uid, required this.userName})
      : super(key: key);

  @override
  _TaskStreamState createState() => _TaskStreamState();
}

class _TaskStreamState extends State<TaskStream> {

  final AuthenticationService _authService = locator<AuthenticationService>();
  final _firestore = FirebaseFirestore.instance;
  String today = Jiffy().format('dd-MM-yyyy');
  final String todayDayOfWeek = Jiffy().EEEE;
  int timeNow = DateTime.now().millisecondsSinceEpoch;
  final List<int> colorList = [
    0xFFF1F4FF,
    0xFFEFFCEF,
    0xFFE6F5FB,
    0xFFFCFCE2,
    0xFFF1F4FF
  ];
  final Random random = Random();

  CustomUser? user;

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection(widget.uid)
          .orderBy('to', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: SpinKitSpinningLines(color: Color(0xff5F33E1)));
        }
        final tasks = snapshot.data!.docs;
        List<Widget?> taskContainer = [];
        for (QueryDocumentSnapshot task in tasks) {
          final taskCollection = TaskCollection.fromCollection(task);
          if (taskCollection.date == today) {
            taskContainer.add(GestureDetector(
              onLongPress: () => _dismissDelete(task.id),
              child: TaskCard(
                color: Color(colorList[random.nextInt(5)]),
                from: taskCollection.from,
                to: taskCollection.to,
                taskName: taskCollection.taskName,
                description: taskCollection.description,
              ),
            ));
          } else if (taskCollection.date != today){
            if (taskCollection.milliTo! <=
                DateTime.now().millisecondsSinceEpoch) {
              _firestore.collection(widget.uid).doc(task.id).delete();
              continue;
            }
          }
        }

        if (taskContainer.isEmpty) {
          return EmptyTaskStream(
            userName: widget.userName,
            todayDayOfWeek: todayDayOfWeek,
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            top: SizeMg.height(100.0),
            right: SizeMg.width(20.0),
            left: SizeMg.width(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage('assets/images/todo_icon.png'),
                    height: SizeMg.height(40.0),
                    alignment: Alignment.centerLeft,
                    color: const Color(0xff5F33E1),
                    fit: BoxFit.fitHeight,
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            _authService.logOut();
                            cancelScheduledNotifications();
                            Navigator.pushNamedAndRemoveUntil(context, GetStarted.id, (Route route) => false);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.rightFromBracket,
                                color: Color(0xff5F33E1),
                              ),
                              SizedBox(
                                width: SizeMg.width(10.0),
                              ),
                              Text(
                                'LogOut',
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.black,
                                  fontSize: SizeMg.text(15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: cancelScheduledNotifications,
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.bellSlash,
                                color: Color(0xff5F33E1),
                              ),
                              SizedBox(
                                width: SizeMg.width(10.0),
                              ),
                              Text(
                                'Cancel Set Notifications',
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.black,
                                  fontSize: SizeMg.text(15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SizeMg.height(50.0),
              ),
              Text(
                'Hi ${widget.userName}!',
                style: GoogleFonts.lexendDeca(
                  fontSize: SizeMg.text(32.0),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Your tasks for today, $todayDayOfWeek',
                style: GoogleFonts.lexendDeca(
                  fontSize: SizeMg.text(15.0),
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: SizeMg.height(10.0),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskContainer.length,
                  itemBuilder: (context, index) {
                    return taskContainer[index]!;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _dismissDelete(docId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Confirmation"),
            content: const Text("Are you sure you want to delete this item?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.lexendDeca(
                    color: Colors.grey,
                    fontSize: SizeMg.text(18.0),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _firestore.collection(widget.uid).doc(docId).delete();
                  Navigator.pop(context);
                },
                child: Text(
                  "Delete",
                  style: GoogleFonts.lexendDeca(
                    color: const Color(0xff5F33E1),
                    fontSize: SizeMg.text(18.0),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
