import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    Key? key,
    required this.size,
    required this.text,
    required this.onTapAction,
  }) : super(key: key);

  final Size size;
  final String text;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapAction(),
      child: Container(
        height: size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(
            size.height * 0.045,
          )),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).focusColor,
          ),
        )),
      ),
    );
  }
}
