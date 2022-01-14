import 'package:dog_app/3model/models/breeds.dart';
import '../../2viewmodel/favourite_breeds_viewmodel.dart';
import '../pages/home detail page/home_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainList extends StatelessWidget {
  final List<BreedsModel> breeds;
  final removeButton;

  const MainList({Key key, @required this.breeds, @required this.removeButton})
      : super(key: key);
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
  }
}
