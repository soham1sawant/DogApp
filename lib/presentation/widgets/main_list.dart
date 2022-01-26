import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
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
    Size size = MediaQuery.of(context).size;

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
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                size.height * 0.007,
                0,
                size.height * 0.007,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    breeds[index].name,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.032,
                    ),
                  ),
                  if (removeButton)
                    IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      color: Theme.of(context).primaryColor,
                      iconSize: size.height * 0.04,
                      onPressed: () {
                        context
                            .read<FavouritesBloc>()
                            .add(FavouritesRemoved(breeds[index]));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Removed from Favourites"),
                            duration: Duration(milliseconds: 900),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}