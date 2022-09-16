import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';
import 'package:taskmgmt_app/services/notifications.dart';
import 'package:taskmgmt_app/screens/get_started.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:taskmgmt_app/services/authentication.dart';

class EmptyTaskStream extends StatelessWidget {

  final String todayDayOfWeek;
  final String userName;

  final AuthenticationService _authService = locator<AuthenticationService>();

  EmptyTaskStream({Key? key, required this.userName, required this.todayDayOfWeek}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeMg.height(100.0),
        right: SizeMg.width(30.0),
        left: SizeMg.width(30.0),
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
            'Hi $userName!',
            style: GoogleFonts.lexendDeca(
              fontSize: SizeMg.text(35.0),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '0 tasks for today $todayDayOfWeek',
            style: GoogleFonts.lexendDeca(
              fontSize: SizeMg.text(15.0),
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: SizeMg.height(30.0),
          ),
          Image(
            image: const AssetImage('assets/images/empty_task.jpg'),
            height: SizeMg.height(300.0),
          ),
          Text(
            'There are no tasks today',
            style: GoogleFonts.lexendDeca(
              fontSize: SizeMg.text(22.0),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeMg.height(10.0),
              horizontal: SizeMg.width(50.0),
            ),
            child: Text(
              'Create a new task or read a book',
              style: GoogleFonts.lexendDeca(
                  fontSize: SizeMg.text(19.0),
                  color: Colors.black54
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
