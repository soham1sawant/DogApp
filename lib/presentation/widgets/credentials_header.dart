import 'package:flutter/material.dart';

class CredentialsHeader extends StatelessWidget {
  const CredentialsHeader({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Text(
        heading,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.height * 0.075,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}