import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/screens/login.dart';
import 'package:taskmgmt_app/screens/register.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  static String id = 'Get started';

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Image(
                image: const AssetImage('assets/images/main_task.jpg'),
                fit: BoxFit.cover,
                height: SizeMg.height(450.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeMg.width(60.0),
                  vertical: SizeMg.height(10.0)),
              child: Text(
                'Organize your daily tasks',
                style: GoogleFonts.lexendDeca(
                  fontSize: SizeMg.text(24.0),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                SizeMg.width(60.0),
                SizeMg.height(10.0),
                SizeMg.width(60.0),
                SizeMg.height(40.0),
              ),
              child: Text(
                'This productive tool is meant to assist you better organize and control your tasks!',
                style: GoogleFonts.lexendDeca(
                  fontSize: SizeMg.text(14.0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeMg.width(25.0)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RegisterScreen.id);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff5F33E1),
                  padding: EdgeInsets.symmetric(vertical: SizeMg.height(15.0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizeMg.radius(14.0)),
                  ),
                ),
                child: Text(
                  'Get started',
                  style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeMg.text(19.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeMg.width(25.0),
                right: SizeMg.width(25.0),
                top: SizeMg.width(5.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.id,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: SizeMg.height(15.0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizeMg.radius(14.0)),
                  ),
                ),
                child: Text(
                  'I already have an account',
                  style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeMg.text(16.0),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
