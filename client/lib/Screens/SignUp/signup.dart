import 'package:client/hash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:client/interface.dart';
import '../SignIn/signin.dart';
import '../../constants.dart';
import '../SignIn/LogoDark.dart';
import 'EmailField.dart';
import 'UserNameField.dart';
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
          style: GoogleFonts.habibi(
            textStyle: TextStyle(
              color: LightGrey.withOpacity(0.8),
              fontSize: 24,
            ),
          ),
        ),
        onPressed: () {
          if (userNameFieldController.text.length == 0 ||
              emailFieldController.text.length == 0 ||
              passwordFieldController.text.length == 0 ||
              passwordFieldConfirmController.text.length == 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: DarkBlueAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: LightBlueAccent.withOpacity(0.2),
                ),
              ),
              padding: EdgeInsets.all(8),
              content: Text(
                "Fields cannot be empty",
                textAlign: TextAlign.center,
                style: GoogleFonts.habibi(
                  textStyle: TextStyle(
                    color: LightGrey.withOpacity(0.8),
                    fontSize: 20,
                  ),
                ),
              ),
            ));
          } else if (passwordFieldController.text !=
              passwordFieldConfirmController.text) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: DarkBlueAccent,
              behavior: SnackBarBehavior.floating,
              // width: ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: LightBlueAccent.withOpacity(0.2),
                ),
              ),
              padding: EdgeInsets.all(8),
              content: Text(
                "Passwords do not match",
                textAlign: TextAlign.center,
                style: GoogleFonts.habibi(
                  textStyle: TextStyle(
                    color: LightGrey.withOpacity(0.8),
                    fontSize: 20,
                  ),
                ),
              ),
            ));
            print("Password not the same"); // request password again
            passwordFieldController.clear(); // clears password
            passwordFieldConfirmController.clear(); // clears password2
          } else {
            var t = HttpStuff();//Our Http Interface
            t.signup(
                userNameFieldController.text,
                hash(passwordFieldConfirmController.text),
                emailFieldController.text);//Parameters for signup

            print(emailFieldController
                .text); // check if this email is taken in DB
            print(userNameFieldController.text); // Check if useranme is in use
            // this will print an error message if the email doesnt meet Regex, maybe can do it right before checking db
            print(passwordFieldController
                .text); // we will have to also do regex on this, then encrypt it and send it to db
            print(hash(passwordFieldController.text));
            print(passwordFieldConfirmController.text);
            print(hash(passwordFieldConfirmController.text));
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
          style: GoogleFonts.habibi(
            textStyle: TextStyle(
                color: LightGrey.withOpacity(0.8),
                fontSize: 20,
                decoration: TextDecoration.underline),
          ),
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
        child: Form(
          child: TextFormField(
              controller: passwordFieldController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: GoogleFonts.habibi(
                textStyle:
                    TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                labelText: 'Password...',
                labelStyle: GoogleFonts.habibi(
                  textStyle: TextStyle(
                      color: LightGrey.withOpacity(0.8), fontSize: 20),
                  // fillColor: LightBlueAccent.withOpacity(0.2),
                ),
              ),
              onSaved: (String? pass) {
                print("Saved pass: $pass");
                // print(passwordFieldController.text);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password cannot be empty";
                }
                return null;
              }),
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
        child: Form(
          child: TextFormField(
            controller: passwordFieldConfirmController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            style: GoogleFonts.habibi(
              textStyle: TextStyle(
                color: LightGrey.withOpacity(0.8),
                fontSize: 20,
              ),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              labelText: 'Confirm Password...',
              labelStyle: GoogleFonts.habibi(
                textStyle:
                    TextStyle(color: LightGrey.withOpacity(0.8), fontSize: 20),
              ),
            ),
            onSaved: (String? pass) {
              print("Saved pass: $pass");
              // print(passwordFieldConfirmController.text);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              } else if (value != passwordFieldController.text) {
                return "Passwords must match";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
