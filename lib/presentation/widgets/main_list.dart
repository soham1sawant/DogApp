import 'package:dog_app/presentation/pages/home_detail_page/home_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/breeds.dart';
import '../../features/favourite_breeds/viewmodel/favourite_breeds_viewmodel.dart';

class MainList extends StatelessWidget {
  final List<BreedsModel> breeds;
  final removeButton;
  final bool hasData;

  const MainList({Key key, this.breeds, this.removeButton, this.hasData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasData == true) {
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
                      Provider.of<FavouriteBreeds>(context, listen: false)
                          .removeBreed(breeds[index]);

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
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
