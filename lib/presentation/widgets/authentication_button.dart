import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Center(
            child: Text(
          "LOG IN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).focusColor,
          ),
        )),
        height: size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(
            size.height * 0.045,
          )),
        ),
      ),
      onTap: () {},
    );
  }
}