import 'package:flutter/material.dart';

class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Remind Me")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Set up reminders here
          },
          child: Text("Set Reminder"),
        ),
      ),
    );
  }
}
