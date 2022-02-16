import 'package:flutter/material.dart';

import '../../widgets/authentication_button.dart';
import '../../widgets/credentials_header.dart';

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
          const CredentialsHeader(heading: "Login In"),
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
                  AuthenticationButton(
                    size: size,
                    text: "LOG IN",
                    f: () {},
                  ),
                  SizedBox(height: size.height * 0.02),
                  AuthenticationButton(
                    size: size,
                    text: "Sign Up",
                    f: () => Navigator.pushNamed(context, '/signup'),
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
