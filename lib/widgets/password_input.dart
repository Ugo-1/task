import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/utilities/constants.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';

class ContainerPasswordInput extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;

  const ContainerPasswordInput({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ContainerPasswordInputState createState() => _ContainerPasswordInputState();
}

class _ContainerPasswordInputState extends State<ContainerPasswordInput> {

  bool obscureText = true;
  Color color = Colors.transparent;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeMg.height(15.0),
      ),
      child: TextFormField(
        onTap: (){
          setState(() {
            color = Colors.black54;
            errorText = null;
          });
        },
        cursorColor: Colors.black,
        style: GoogleFonts.lato(
          fontSize: SizeMg.text(16.0),
          letterSpacing: 0.6,
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeMg.width(12.0),
            vertical: SizeMg.height(20.0),
          ),
          hintText: widget.hintText,
          filled: true,
          prefixIcon: const Icon(
            FontAwesomeIcons.lock,
            color: Colors.black54,
            size: 15.0,
          ),
          fillColor: Colors.grey.shade200,
          enabledBorder: kTextNonErrorBorder,
          focusedBorder: kTextNonErrorBorder,
          errorBorder: kTextErrorBorder,
          focusedErrorBorder: kTextNonErrorBorder,
          suffixIcon: IconButton(
            icon: obscureText? const Icon(FontAwesomeIcons.eye) : const Icon(FontAwesomeIcons.eyeSlash),
            color: color,
            iconSize: 15.0,
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
        onChanged: widget.onChanged,
        validator: (String? value){
          if (value == null || value.isEmpty) {
            return 'Please enter password';
          }
          if (value.length < 6){
            return 'Password length is less than 6';
          }
          return null;
        },
      ),
    );
  }
}
