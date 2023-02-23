import 'package:flutter/material.dart';

class DeleteUserButton extends StatelessWidget {
  const DeleteUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(
            size.height * 0.045,
          ),
        ),
      ),
      child: Center(
        child: Text(
          'Delete User',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: size.height * 0.03,
          ),
        ),
      ),
    );
  }
}
