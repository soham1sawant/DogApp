import 'package:flutter/material.dart';

import '../../widgets/authentication_button.dart';
import '../../widgets/credentials_header.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CredentialsHeader(heading: "Log In"),
          Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: size.width * 0.065,
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  AuthenticationButton(
                    size: size,
                    text: "LOG IN",
                    onTapAction: () {},
                  ),
                  SizedBox(height: size.height * 0.02),
                  AuthenticationButton(
                    size: size,
                    text: "Sign Up",
                    onTapAction: () => Navigator.pushNamed(context, "/signup"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
