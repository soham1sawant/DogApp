import 'dart:developer';

import 'package:dog_app/core/widgets/authentication_button.dart';
import 'package:dog_app/core/widgets/credentials_header.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/authentication/ui/sign_up_page.dart';
import 'package:dog_app/features/dogbreeds/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

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

  void _authenticateWithEmailAndPassword(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    log(size.height.toString());
    log(size.width.toString());


    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<HomePage>(builder: (context) => const HomePage()),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          )); //
        } else if (state is SignOutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      builder: (context, state) {
        if (state is UnAuthenticatedState) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CredentialsHeader(heading: 'Log In'),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.065,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          key: const Key('login_email_field'),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: emailValidator,
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFormField(
                          key: const Key('login_password_field'),
                          controller: _passwordController,
                          validator: passwordValidator,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        InkWell(
                          key: const Key('log_in_button'),
                          child: const AuthenticationButton(text: 'LOG IN'),
                          onTap: () =>
                              _authenticateWithEmailAndPassword(context),
                        ),
                        SizedBox(height: size.height * 0.02),
                        InkWell(
                          key: const Key('sign_up_page_button'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<SignUpPage>(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: const AuthenticationButton(text: 'SIGN UP'),
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
