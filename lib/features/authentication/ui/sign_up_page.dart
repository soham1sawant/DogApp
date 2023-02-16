import 'package:dog_app/core/widgets/authentication_button.dart';
import 'package:dog_app/core/widgets/credentials_header.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/authentication/ui/sign_in_page.dart';
import 'package:dog_app/features/dogbreeds/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(
      r'(?=.*?[#?!@$%^&*-])',
      errorText: 'at least one special character required',
    ),
    PatternValidator(
      '(?=.*?[0123456789])',
      errorText: 'at least one number required',
    ),
  ]);
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ]);

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<HomePage>(builder: (context) => const HomePage()),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error, try again.')));
        } else if (state is SignOutErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error, try again.')));
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
                    const CredentialsHeader(heading: 'Sign Up'),
                    Form(
                      key: _formkey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.065,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              key: const Key('signup_email_field'),
                              validator: emailValidator,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            TextFormField(
                              key: const Key('signup_password1_field'),
                              validator: passwordValidator,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'New Password',
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            TextFormField(
                              key: const Key('signup_password2_field'),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'New Password',
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  _passwordController.clear();
                                  return 'Passwords do not match!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: size.height * 0.02),
                            InkWell(
                              key: const Key('sign_up_button'),
                              child:
                                  const AuthenticationButton(text: 'SIGN UP'),
                              onTap: () =>
                                  _createAccountWithEmailAndPassword(context),
                            ),
                            SizedBox(height: size.height * 0.02),
                            InkWell(
                              key: const Key('log_in_page_button'),
                              child: const AuthenticationButton(text: 'Log In'),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<SignInPage>(
                                    builder: (context) => SignInPage(),
                                  ),
                                );
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
