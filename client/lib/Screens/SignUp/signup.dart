import '../SignIn/signin.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../SignIn/LogoDark.dart';
import '../Fields/EmailField.dart';
import '../Fields/UserNameField.dart';

import 'background.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}

final userNameFieldController = TextEditingController();
final emailFieldController = TextEditingController();
final passwordFieldController = TextEditingController();
final passwordFieldConfirmController = TextEditingController();

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Size of the screen
    return Background(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LogoDark(size: size),
          const SizedBox(
            height: 10,
          ),
          UserNameField(),
          const SizedBox(
            height: 40,
          ),
          EmailField(),
          const SizedBox(
            height: 40,
          ),
          PasswordField(),
          SizedBox(height: 40),
          ConfirmPasswordField(),
          SizedBox(height: 20),
          ExistingUserText(),
          SizedBox(
            height: 20,
          ),
          SignUpBttn(),
        ],
      ),
    );
  }
}

class SignUpBttn extends StatelessWidget {
  const SignUpBttn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 262,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: MedBlueAccent.withOpacity(
                0.2), //Color.fromRGBO(27, 63, 207, .2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: LightBlueAccent.withOpacity(0.2),
              ), //color: Color.fromRGBO(44, 190, 248, 0.1)
            )),
        child: Text(
          "Sign up",
          style: TextStyle(
            color: LightGrey.withOpacity(0.8),
            fontSize: 26,
          ),
        ),
        onPressed: () {
          userNameFieldController.text; // check if this exists already
          emailFieldController.text; // check if this email is taken
          if (passwordFieldController.text ==
              passwordFieldConfirmController.text)
            print(
                "Password is the same"); // proceed to encryption and storing the data
          else {
            print("Password not the same"); // request password again
            passwordFieldController.clear(); // clears password
            passwordFieldConfirmController.clear(); // clears password2
          }
        },
      ),
    );
  }
}

class ExistingUserText extends StatelessWidget {
  const ExistingUserText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Already a user? Sign In!",
          style: TextStyle(
              color: LightGrey.withOpacity(0.8),
              fontSize: 20,
              decoration: TextDecoration.underline),
        ),
      ),
      onTap: () {
        Navigator.push(
            // this changes which page we go to
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    Signin())); // go to the sign in page instead if the user is registered already
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
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
          controller: passwordFieldController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            labelText: 'Password...',
            labelStyle:
                TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
            // fillColor: LightBlueAccent.withOpacity(0.2),
          ),
          onFieldSubmitted: (String pass) {
            print("Saved pass: $pass");
          },
        ),
      ),
    );
  }
}

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
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
          controller: passwordFieldConfirmController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            labelText: 'Confirm Password...',
            labelStyle:
                TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
            // fillColor: LightBlueAccent.withOpacity(0.2),
          ),
          onFieldSubmitted: (String pass) {
            print("Saved pass: $pass");
          },
        ),
      ),
    );
  }
}