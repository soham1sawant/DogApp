import 'package:flutter/material.dart';

class CredentialsHeader extends StatelessWidget {
  const CredentialsHeader({
    super.key,
    required this.heading,
  });

  final String heading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
