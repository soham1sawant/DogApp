import '../../data/models/breeds.dart';
import '../widgets/main_header.dart';
import '../widgets/main_list.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  static List<BreedsModel> likedList = [];

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
              MainHeader(header: "Favourites", icon: false),
              Expanded(child: MainList(breeds: likedList, removeButton: true,)),
            ],
          ),
        ),
      ),
    );
  }
}
