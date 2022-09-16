import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:taskmgmt_app/screens/todo.dart';
import 'package:taskmgmt_app/screens/get_started.dart';
import 'package:taskmgmt_app/services/authentication.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationService _authService = locator<AuthenticationService>();

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Don't Allow",
                  style: GoogleFonts.lexendDeca(
                    color: Colors.grey,
                    fontSize: SizeMg.text(18.0),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: Text(
                  "Allow",
                  style: GoogleFonts.lexendDeca(
                    color: const Color(0xff5F33E1),
                    fontSize: SizeMg.text(18.0),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
    AwesomeNotifications().actionStream.listen((notification){
      firstScreen();
    });
    firstScreen();
  }

  void firstScreen() async {
    if (await _authService.isUserLoggedIn()) {
      Navigator.pushReplacementNamed(context, TodoScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, GetStarted.id);
    }
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Image(
          image: const AssetImage('assets/images/todo_icon.png'),
          color: const Color(0xff5F33E1),
          height: SizeMg.height(80.0),
        ),
      ),
    );
  }
}
