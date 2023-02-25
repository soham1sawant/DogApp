import 'package:dog_app/core/widgets/authentication_button.dart';
import 'package:dog_app/core/widgets/credentials_header.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class DeleteUserPage extends StatelessWidget {
  DeleteUserPage({super.key});

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

  void _deleteUserWithEmailAndPassword(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        DeleteUserRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CredentialsHeader(heading: 'Delete User'),
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
                    child: const AuthenticationButton(text: 'CONFIRM'),
                    onTap: () => _deleteUserWithEmailAndPassword(context),
                  ),
                  SizedBox(height: size.height * 0.02),
                  InkWell(
                    key: const Key('sign_up_page_button'),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute<SignUpPage>(
                      //     builder: (context) => SignUpPage(),
                      //   ),
                      // );
                    },
                    child: const AuthenticationButton(text: 'CANCEL'),
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
