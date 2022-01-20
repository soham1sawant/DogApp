import 'package:dog_app/bloc/favourite_breeds/favouritebreeds_bloc.dart';
import 'package:dog_app/presentation/pages/home_detail_page/home_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/breeds.dart';

class MainList extends StatelessWidget {
  final List<BreedsModel> breeds;
  final removeButton;

  const MainList({Key key, this.breeds, this.removeButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: breeds.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDetailPage(theBreed: breeds[index]),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  breeds[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              if (removeButton)
                IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  color: Theme.of(context).primaryColor,
                  iconSize: 27.0,
                  onPressed: () {
                    if (BlocProvider.of<FavouriteBreedsBloc>(context)
                        .state
                        .favouriteBreeds
                        .contains(breeds[index])) {
                      BlocProvider.of<FavouriteBreedsBloc>(context)
                          .state
                          .favouriteBreeds
                          .remove(breeds[index]);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Removed from Favourites"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}