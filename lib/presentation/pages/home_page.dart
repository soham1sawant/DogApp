import '../widgets/main_header.dart';
import '../widgets/main_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Dog App", icon: true),
              Expanded(child: MainList(breeds: state.breeds, removeButton: false,))
            ],
          ),
        ),
      ),
    );
  }
}
