import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:taskmgmt_app/services/add_task_data.dart';
import 'package:taskmgmt_app/services/notifications.dart';
import 'package:taskmgmt_app/utilities/constants.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:taskmgmt_app/services/authentication.dart';

class AddTaskScreen extends StatefulWidget {
  static String id = 'AddTask';

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _firestore = FirebaseFirestore.instance;
  final AuthenticationService _authService = locator<AuthenticationService>();
  final _formAddTaskKey = GlobalKey<FormState>();
  final now = DateTime.now();

  String date = Jiffy(DateTime.now()).format('yyyy-MM-dd');
  String description = '';

  late String taskName;
  late int from;
  late int to;

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.black,
        ),
        title: Text(
          'Add Task',
          style: GoogleFonts.lexendDeca(
            fontSize: SizeMg.text(19.0),
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeMg.width(23.0),
              vertical: SizeMg.height(30.0),
            ),
            child: Form(
              key: _formAddTaskKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    style: kInputAddTaskTs,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: kLabelAddTaskTs,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: kTextAddTaskBorder,
                      focusedBorder: kTextAddTaskBorder,
                      errorBorder: kErrorAddTaskBorder,
                      focusedErrorBorder: kTextAddTaskBorder,
                    ),
                    onChanged: (String val) {
                      setState(() {
                        taskName = val;
                      });
                    },
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter the task's name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: SizeMg.height(22.0),
                  ),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    style: kInputAddTaskTs,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: kLabelAddTaskTs,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: kTextAddTaskBorder,
                      focusedBorder: kTextAddTaskBorder,
                    ),
                    onChanged: (String val) {
                      setState(() {
                        description = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: SizeMg.height(22.0),
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'yyyy-MM-dd',
                    initialValue: date,
                    firstDate: now,
                    lastDate: DateTime(2100),
                    style: kInputAddTaskTs,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        FontAwesomeIcons.solidCalendarDays,
                        color: Color(0xff5F33E1),
                        size: 17.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Date',
                      labelStyle: kLabelAddTaskTs,
                      enabledBorder: kTextAddTaskBorder,
                      focusedBorder: kTextAddTaskBorder,
                      errorBorder: kErrorAddTaskBorder,
                      focusedErrorBorder: kTextAddTaskBorder,
                    ),
                    onChanged: (String val) {
                      setState(() {
                        date = val;
                      });
                    },
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Choose a date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: SizeMg.height(22.0),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          style: kInputAddTaskTs,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidClock,
                              color: Color(0xff5F33E1),
                              size: 17.0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'From',
                            labelStyle: kLabelAddTaskTs,
                            enabledBorder: kTextAddTaskBorder,
                            focusedBorder: kTextAddTaskBorder,
                            errorBorder: kTextErrorBorder,
                            focusedErrorBorder: kTextAddTaskBorder,
                          ),
                          onChanged: (String val) {
                            setState(() {
                              from = Jiffy('$date $val', 'yyyy-MM-dd HH:mm')
                                  .valueOf();
                            });
                          },
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'Choose a time';
                            }
                            if (from < now.millisecondsSinceEpoch) {
                              return 'Choose a later time';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: SizeMg.width(15.0),
                      ),
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          style: kInputAddTaskTs,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidClock,
                              color: Color(0xff5F33E1),
                              size: 17.0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'To',
                            labelStyle: kLabelAddTaskTs,
                            enabledBorder: kTextAddTaskBorder,
                            focusedBorder: kTextAddTaskBorder,
                            errorBorder: kErrorAddTaskBorder,
                            focusedErrorBorder: kTextAddTaskBorder,
                          ),
                          onChanged: (String val) {
                            setState(() {
                              to = Jiffy('$date $val', 'yyyy-MM-dd HH:mm')
                                  .valueOf();
                            });
                          },
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'Choose a time';
                            }
                            if (to <= from) {
                              return 'Choose a later time';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeMg.height(80.0),
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
                        'Add Task',
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
    );
  }

  void _saveChanges() {
    if (_formAddTaskKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Task reminder set'),
        backgroundColor: Color(0xff5F33E1),
      ));
      final timeFrame = Jiffy.unixFromMillisecondsSinceEpoch(from);
      final toTimeFrame = Jiffy.unixFromMillisecondsSinceEpoch(to);
      createTaskScheduledReminder(
          bodyText: 'Time to begin your task - "$taskName"',
          buttonText: "Get Started",
          yearText: timeFrame.year,
          dayText: timeFrame.date,
          monthText: timeFrame.month,
          hourText: timeFrame.hour,
          minuteText: timeFrame.minute,
      );
      createTaskScheduledReminder(
        bodyText: 'Your task "$taskName" is over. Hope you did it?',
        buttonText: "Mark Completed",
        yearText: toTimeFrame.year,
        dayText: toTimeFrame.date,
        monthText: toTimeFrame.month,
        hourText: toTimeFrame.hour,
        minuteText: toTimeFrame.minute,
      );
      _addTask();
      _move();
    }
  }

  void _addTask() async {
    await _firestore.collection(_authService.currentUser!.id).add(AddTaskData(
        date: Jiffy(date, 'yyyy-MM-dd').format('dd-MM-yyyy'),
        description: description.trim(),
        from: from,
        taskName: taskName.trim(),
        to: to)
        .toJson()
    );
  }

  void _move(){
    Navigator.pop(context);
  }
}
