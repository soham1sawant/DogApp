import 'package:flutter/material.dart';

import '../../widgets/authentication_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Log In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.075,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Form(
            key: const Key("login-page"),
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
                  AuthenticationButton(size: size),
                  SizedBox(height: size.height * 0.02),
                  AuthenticationButton(size: size),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}