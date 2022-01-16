import 'package:dog_app/view/pages/login_page/widgets/login_form.dart';
import 'package:dog_app/view/widgets/main_header.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainHeader(header: "Login", icon: false),
                const SizedBox(
                  height: 40.0,
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
