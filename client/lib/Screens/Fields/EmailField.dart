import 'package:client/Screens/SignUp/signup.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 262,
      child: Container(
        decoration: BoxDecoration(
            color: LightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: TextFormField(
          controller: emailFieldController,
          style: TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            labelText: 'Email...',
            labelStyle:
                TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
            // fillColor: LightBlueAccent.withOpacity(0.2),
          ),
          onFieldSubmitted: (String email) {
            print("Saved Email: $email");
          },
        ),
      ),
    );
  }
}