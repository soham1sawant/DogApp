import 'dart:convert';
import 'dart:io';
import 'package:dog_app/widgets/home_page/main_header.dart';
import 'package:dog_app/widgets/home_page/main_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dog_app/models/breeds.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  loaddata() async {
    final String key = "00af7d92-3d1c-4860-b0a3-fd060f0eb807";
    final breedsjson = await get(Uri.parse("https://api.thedogapi.com/v1/breeds"),
        headers: {HttpHeaders.authorizationHeader: key});
    final decodedjson = jsonDecode(breedsjson.body);
    BreedsList.items = List.from(decodedjson)
        .map<BreedsModel>((item) => BreedsModel.fromJson(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(29),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(),
              if (BreedsList.items != null && BreedsList.items.isNotEmpty)
                Expanded(child: MainList())
              else
                Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}