import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/custom_input_field.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class AddNotification extends StatefulWidget {
  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {

  TimeOfDay selectedTime = TimeOfDay.now();
  final _titleController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String agendaText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

//  DateTime selectedDate = DateTime.now();
//
//  Future<Null> selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              onChanged: (value) {
                agendaText = value;
              },
              //decoration: kMessageTextFieldDecoration,
            ),
            CustomInputField(
              controller: _titleController,
              hintText: 'Agenda',
              inputType: TextInputType.text,
              autoFocus: true,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  onPressed: selectTime,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.access_time),
                      SizedBox(width: 4),
                      Text(selectedTime.format(context)
                      ),
                    ],
                  ),
                ),
//                SizedBox(width: 5.0),
//                FlatButton(
//                  color: Colors.blue,
//                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                  onPressed: () => selectDate(context),
//                  child: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Icon(Icons.calendar_today),
//                      SizedBox(width: 4),
//                      Text(selectedDate.toString()
//                      ),
//                    ],
//                  ),
//                ),
              ],
            ),
            SizedBox(height: 10.0,),
            FlatButton(
              child: Text('ADD',style: TextStyle(color: Colors.white),),
              color: Colors.purple[700],
              onPressed: (){
                if (agendaText != null){
                  _firestore.collection('notify').add({
                    'time' : selectedTime,
                    'agenda': agendaText,
                    'sender': loggedInUser.email,
                    'date' : DateTime.now().toIso8601String().toString(),
                  });
                }
               // print(selectedDate);
                print(selectedTime);
                //Provider.of<TaskData>(context,listen: false).addTask(newTaskTitle);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
