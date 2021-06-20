import '../../../data/models/breeds.dart';
import '../../pages/home_detail_page.dart';
import 'package:flutter/material.dart';

class MainList extends StatelessWidget {
  final List<BreedsModel> breeds;

  const MainList({Key key, this.breeds}) : super(key: key);
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
                  builder: (context) => HomeDetailPage(
                        theBreed: breeds[index],
                      ))),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              breeds[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
