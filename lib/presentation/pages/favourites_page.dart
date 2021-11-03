import 'package:dog_app/logic/favourite_breeds.dart';
import 'package:provider/provider.dart';
import '../widgets/main_header.dart';
import '../widgets/main_list.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
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
              Expanded(
                  child: MainList(
                breeds: Provider.of<FavouriteBreeds>(context, listen: true)
                    .favouriteBreeds,
                removeButton: true,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
