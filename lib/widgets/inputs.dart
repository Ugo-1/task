import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/utilities/constants.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';

class ContainerInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final Function(String) onChanged;

  const ContainerInput({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.textInputType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeMg.height(15.0),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        style: GoogleFonts.lato(
          fontSize: SizeMg.text(16.0),
          letterSpacing: 0.6,
        ),
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeMg.width(12.0),
            vertical: SizeMg.height(20.0),
          ),
          hintText: hintText,
          filled: true,
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
            size: 15.0,
          ),
          fillColor: Colors.grey.shade200,
          enabledBorder: kTextNonErrorBorder,
          focusedBorder: kTextNonErrorBorder,
          errorBorder: kTextErrorBorder,
          focusedErrorBorder: kTextNonErrorBorder,
        ),
        onChanged: onChanged,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}