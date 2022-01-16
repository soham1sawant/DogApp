import 'package:dog_app/view/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Email",
              labelText: "Email",
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: "Cannot be empty"),
              EmailValidator(errorText: "Enter a valid email id"),
            ]),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Password",
              labelText: "Password",
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: "Cannot be empty"),
              MinLengthValidator(8,
                  errorText: "Password should be atleast 8 characters"),
              PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                  errorText: "Atleast one special character required"),
              PatternValidator(r'(?=.*?[0123456789])',
                  errorText: "Atleast one number required"),
            ]),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            child: Text(
              "Login",
              style: TextStyle(
                color: Theme.of(context).focusColor,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
