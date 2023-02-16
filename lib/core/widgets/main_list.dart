import 'package:dog_app/features/dogbreeds/ui/home_detail_page.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainList extends StatelessWidget {

  const MainList({
    super.key,
    required this.breeds,
    required this.removeButton,
    required this.isFavouritesPage,
  });
  final List<BreedsModel> breeds;
  final bool removeButton;
  final bool isFavouritesPage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scrollbar(
      interactive: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<HomeDetailPage>(
                builder: (context) => HomeDetailPage(theBreed: breeds[index]),
              ),
            ),
            child: Container(
              key: Key(breeds[index].id.toString()),
              padding: isFavouritesPage
                  ? EdgeInsets.zero
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
                        fontSize: orientation == Orientation.portrait
                            ? size.height * 0.032
                            : size.height * 0.055,
                      ),
                    ),
                  ),
                  if (removeButton)
                    IconButton(
                      key: Key('remove-${breeds[index].name}'),
                      icon: const Icon(Icons.cancel_outlined),
                      color: Theme.of(context).primaryColor,
                      iconSize: orientation == Orientation.portrait
                          ? size.height * 0.035
                          : size.height * 0.055,
                      onPressed: () {
                        context
                            .read<FavouritesBloc>()
                            .add(FavouritesRemoved(breeds[index]));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Removed from Favourites'),
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
