import 'dart:convert';
import 'package:dog_app/models/breeds.dart';
import 'package:dog_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    Response jsonString = await get("https://dog.ceo/api/breeds/list/all");
    final data = welcomeFromMap(jsonString.body);
    print(data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dog App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyTheme.darkBluishColor,
                    ),
                    textScaleFactor: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
