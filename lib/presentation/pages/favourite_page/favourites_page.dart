import '../../widgets/main_header.dart';
import '../../widgets/main_list.dart';
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
                breeds: ,
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
