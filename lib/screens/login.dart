import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/screens/register.dart';
import 'package:taskmgmt_app/screens/todo.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';
import 'package:taskmgmt_app/widgets/inputs.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:taskmgmt_app/widgets/password_input.dart';
import 'package:taskmgmt_app/utilities/dialogbox.dart';
import 'package:taskmgmt_app/services/authentication.dart';


class LoginScreen extends StatefulWidget {

  static String id = 'Login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formLoginKey = GlobalKey<FormState>();
  final _authService = locator<AuthenticationService>();
  bool _saving = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ModalProgressHUD(
          inAsyncCall: _saving,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: SizeMg.width(30.0),
                right: SizeMg.width(30.0),
                top: SizeMg.height(70.0),
              ),
              child: Form(
                key: _formLoginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image(
                        image: const AssetImage('assets/images/todo_icon.png'),
                        height: SizeMg.height(30.0),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: SizeMg.height(70.0),),
                      child: Text(
                        'Hey,\nLogin Now.',
                        style: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeMg.text(40.0),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'If you are new - ',
                          style: GoogleFonts.lexendDeca(
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, RegisterScreen.id);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.lexendDeca(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeMg.height(30.0),
                    ),
                    ContainerInput(
                      hintText: 'Email',
                      icon: FontAwesomeIcons.at,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (val){
                        email = val;
                      },
                    ),
                    ContainerPasswordInput(
                      hintText: 'Password',
                      onChanged: (val){
                        password = val;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeMg.width(25.0),
                        vertical: SizeMg.height(90.0),
                      ),
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff5F33E1),
                          padding:
                          EdgeInsets.symmetric(vertical: SizeMg.height(15.0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SizeMg.radius(14.0)),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.lexendDeca(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeMg.text(19.0),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveChanges(){
    if (_formLoginKey.currentState?.validate() ?? false) {
      _login();
    }
  }

  void _login() async {
    setState(() {
      _saving = true;
    });

    try {
      final user = await _authService.loginUser(email: email, password: password);
      if (user){
        _moveToTodo();
      }
    } on FirebaseAuthException catch (e) {
      if ([
        'user-disabled',
        'invalid-email',
        'user-not-found',
        'wrong-password',
      ].contains(e.code)) {
        dialogBox(e.message.toString(), context);
      } else {
        dialogBox("Something happened. Try again later", context);
      }
    } catch (e) {
      dialogBox("Something happened. Try again later", context);
    }

    setState(() {
      _saving = false;
    });
  }

  void _moveToTodo(){
    Navigator.pushReplacementNamed(context, TodoScreen.id);
  }
}
