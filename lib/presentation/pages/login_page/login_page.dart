import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../widgets/authentication_button.dart';
import '../../widgets/credentials_header.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'at least one special character required'),
    PatternValidator(r'(?=.*?[0123456789])',
        errorText: 'at least one number required'),
  ]);
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    validator: emailValidator,
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    controller: _passwordController,
                    validator: passwordValidator,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  AuthenticationButton(
                    size: size,
                    text: "LOG IN",
                    onTapAction: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.pushNamed(context, "/home");
                        log("Pushed /home");
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  AuthenticationButton(
                    size: size,
                    text: "Sign Up",
                    onTapAction: () {
                      Navigator.pushNamed(context, "/signup");
                      log("Pushed /signup");
                    },
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
