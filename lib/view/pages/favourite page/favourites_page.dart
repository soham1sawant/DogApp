import '../../widgets/main_header.dart';
import '../../widgets/main_list.dart';
import '../../../features/favourite_breeds/viewmodel/favourite_breeds_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class FavouritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Favourites", icon: false),
              Expanded(
                  child: MainList(
                breeds: Provider.of<FavouriteBreeds>(context, listen: true)
                    .favouriteBreeds,
                removeButton: true,
                hasData: true,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
