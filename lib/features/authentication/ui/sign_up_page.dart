import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../core/widgets/authentication_button.dart';
import '../../../core/widgets/credentials_header.dart';
import '../bloc/auth_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

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

  void _createAccountWithEmailAndPassword(context) {
    if (_formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
          SignUpRequested(_emailController.text, _passwordController.text));
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
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CredentialsHeader(heading: "Sign Up"),
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
                              validator: emailValidator,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            TextFormField(
                              validator: passwordValidator,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "New Password",
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            TextFormField(
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  _passwordController.clear();
                                  return "Passwords do not match!";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "New Password",
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            AuthenticationButton(
                              size: size,
                              text: "SIGN UP",
                              onTapAction: () {
                                _createAccountWithEmailAndPassword(context);
                              },
                            ),
                            SizedBox(height: size.height * 0.02),
                            AuthenticationButton(
                              size: size,
                              text: "Log In",
                              onTapAction: () {
                                Navigator.pushReplacementNamed(context, '/signin');
                                log("pushed /");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }
}
