import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/screens/login.dart';
import 'package:taskmgmt_app/screens/todo.dart';
import 'package:taskmgmt_app/services/authentication.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';
import 'package:taskmgmt_app/widgets/inputs.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:taskmgmt_app/widgets/password_input.dart';
import 'package:taskmgmt_app/utilities/dialogbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static String id = 'Register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formSignUpKey = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  bool _saving = false;

  late String email;
  late String userName;
  late String password;
  late String confirmPassword;

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
            fit: BoxFit.fill,
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
                key: _formSignUpKey,
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
                      padding: EdgeInsets.only(
                        top: SizeMg.height(40.0),
                      ),
                      child: Text(
                        'Welcome',
                        style: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeMg.text(40.0),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Joined us before?',
                          style: GoogleFonts.lexendDeca(
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: SizeMg.width(5.0),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.id);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.lexendDeca(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeMg.height(10.0),
                    ),
                    ContainerInput(
                      hintText: 'Email',
                      icon: FontAwesomeIcons.at,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    ContainerInput(
                      hintText: 'Username',
                      icon: FontAwesomeIcons.faceSmile,
                      textInputType: TextInputType.text,
                      onChanged: (val) {
                        userName = val;
                      },
                    ),
                    ContainerPasswordInput(
                      hintText: 'Password',
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    ContainerPasswordInput(
                      hintText: 'Confirm Password',
                      onChanged: (val) {
                        confirmPassword = val;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeMg.width(25.0),
                        vertical: SizeMg.height(30.0),
                      ),
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff5F33E1),
                          padding: EdgeInsets.symmetric(
                              vertical: SizeMg.height(15.0)),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(SizeMg.radius(14.0)),
                          ),
                        ),
                        child: Text(
                          'Register',
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

  void _saveChanges() {
    if (_formSignUpKey.currentState?.validate() ?? false) {
      _register();
    }
  }

  void _register() async {
    setState(() {
      _saving = true;
    });
    if (password == confirmPassword) {
      try {
        final user = await _authenticationService.registerUser(
          email: email.trim(),
          password: password,
          userName: userName.trim(),
        );
        if (user) {
          _moveToTodo();
        }
      } on FirebaseAuthException catch (e) {
        if ([
          'email-already-in-use',
          'invalid-email',
          'operation-not-allowed',
        ].contains(e.code)) {
          dialogBox(e.message.toString(), context);
        } else {
          dialogBox("Something happened. Try again later", context);
        }
      } catch (e) {
        dialogBox("Something happened. Try again later", context);
      }
    } else {
      dialogBox("Passwords don't match", context);
    }

    setState(() {
      _saving = false;
    });
  }

  void _moveToTodo() {
    Navigator.pushReplacementNamed(context, TodoScreen.id);
  }
}
