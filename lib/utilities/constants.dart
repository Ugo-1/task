import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';

InputBorder kTextNonErrorBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(
    SizeMg.radius(10.0),
  ),
);

InputBorder kTextErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: SizeMg.width(1.2),
  ),
  borderRadius: BorderRadius.circular(
    SizeMg.radius(10.0),
  ),
);

InputBorder kTextAddTaskBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    SizeMg.radius(15.0),
  ),
  borderSide: BorderSide(
    color: Colors.grey.shade400,
  ),
);

InputBorder kErrorAddTaskBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    SizeMg.radius(15.0),
  ),
  borderSide: BorderSide(
    color: Colors.red,
    width: SizeMg.width(1.2),
  ),
);

TextStyle kLabelAddTaskTs = GoogleFonts.lexendDeca(
  fontSize: SizeMg.text(15.0),
  fontWeight: FontWeight.w500,
  color: const Color(0xff6E6A7C),
);

TextStyle kInputAddTaskTs = GoogleFonts.lexendDeca(
  fontSize: SizeMg.text(15.0),
  fontWeight: FontWeight.w500,
  color: Colors.black,
);