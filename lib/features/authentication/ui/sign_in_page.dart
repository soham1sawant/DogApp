import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../core/widgets/authentication_button.dart';
import '../../../core/widgets/credentials_header.dart';
import '../bloc/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  ]);

  void _authenticateWithEmailAndPassword(context) {
    if (_formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
          SignInRequested(_emailController.text, _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Error, try again.")));
        } else if (state is SignOutErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Error, try again.")));
        }
      },
      builder: (context, state) {
        if (state is UnAuthenticatedState) {
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
                            _authenticateWithEmailAndPassword(context);
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        AuthenticationButton(
                          size: size,
                          text: "Sign Up",
                          onTapAction: () {
                            Navigator.pushReplacementNamed(context, "/signup");
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
        } else if (state is LoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Container();
      },
    );
  }
}
