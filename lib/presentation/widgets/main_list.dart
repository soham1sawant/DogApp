import '../../logic/bloc/favourite_button/favourite_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/breeds.dart';
import '../pages/home_detail_page.dart';
import 'package:flutter/material.dart';

class MainList extends StatelessWidget {
  final List<BreedsModel> breeds;
  final removeButton;

  const MainList({Key key, @required this.breeds, @required this.removeButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
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
                      color: Theme.of(context).accentColor,
                      iconSize: 27.0,
                      onPressed: () {
                        context
                            .read<FavouriteCubit>()
                            .removeFromFavourite(breeds[index]);
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
