import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/dogbreeds/models/breeds/breeds_model.dart';
import '../../features/dogbreeds/ui/home_detail_page.dart';
import '../../features/favourites/bloc/favourites_bloc.dart';

class MainList extends StatelessWidget {
  final List<BreedsModel> breeds;
  final bool removeButton;
  final bool isFavouritesPage;

  const MainList({
    Key? key,
    required this.breeds,
    required this.removeButton,
    required this.isFavouritesPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scrollbar(
      interactive: true,
      child: ListView.builder(
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
            child: Container(
              padding: (isFavouritesPage)
                  ? const EdgeInsets.all(0)
                  : EdgeInsets.fromLTRB(
                      0,
                      size.height * 0.004,
                      0,
                      size.height * 0.004,
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      breeds[index].name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.032,
                      ),
                    ),
                  ),
                  if (removeButton)
                    IconButton(
                      key: Key("remove-${breeds[index].name}"),
                      icon: const Icon(Icons.cancel_outlined),
                      color: Theme.of(context).primaryColor,
                      iconSize: size.height * 0.035,
                      onPressed: () {
                        context
                            .read<FavouritesBloc>()
                            .add(FavouritesRemoved(breeds[index]));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Removed from Favourites"),
                            duration: Duration(milliseconds: 900),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
