import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';


class TaskCard extends StatelessWidget {

  final Color color;
  final String from;
  final String to;
  final String taskName;
  final String description;

  const TaskCard({Key? key, required this.color, required this.from, required this.to, required this.taskName, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final fromHr = from.replaceRange(5, null, '');
    final fromTime = from.replaceRange(0, 5, '');

    SizeMg.init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: SizeMg.height(18.0)),
      child: Row(
        children: [
          Text(
            '$fromHr\n$fromTime',
            style: GoogleFonts.lato(
              fontSize: SizeMg.text(16.0),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: SizeMg.width(20.0),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: SizeMg.height(15.0),
                horizontal: SizeMg.width(15.0),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeMg.radius(12.0)),
                color: color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    taskName,
                    style: GoogleFonts.lato(
                      fontSize: SizeMg.text(18.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: SizeMg.height(5.0),
                  ),
                  (description.isEmpty)
                      ? SizedBox(height: SizeMg.height(0.0),)
                      : Text(
                    description,
                    style: GoogleFonts.lato(
                      fontSize: SizeMg.text(14.0),
                      color: Colors.black54,
                    ),
                  ),
                  (description.isEmpty)
                      ? SizedBox(height: SizeMg.height(0.0),)
                      : SizedBox(
                    height: SizeMg.height(5.0),
                  ),
                  Text(
                    '$from - $to',
                    style: GoogleFonts.lato(
                      fontSize: SizeMg.text(15.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
