import 'package:flutter/material.dart';
import 'package:taskmgmt_app/screens/add_task.dart';
import 'package:taskmgmt_app/services/locator.dart';
import 'package:taskmgmt_app/services/authentication.dart';
import 'package:taskmgmt_app/utilities/size_manager.dart';
import 'package:taskmgmt_app/widgets/stream_tasks.dart';

class TodoScreen extends StatelessWidget {
  static String id = 'TodoScreen';

  TodoScreen({
    Key? key,
  }) : super(key: key);

  final AuthenticationService _authService = locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5F33E1),
        onPressed: () {
          Navigator.pushNamed(context, AddTaskScreen.id);
        },
        child: Image(
          image: const AssetImage('assets/images/to-do-list.png'),
          color: Colors.white,
          height: SizeMg.height(45.0),
        ),
      ),
      body: TaskStream(
        uid: _authService.currentUser!.id,
        userName: _authService.currentUser!.userName,
      ),
    );
  }
}
