import 'package:dog_app/data/models/breeds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/dog_data.dart';
import '../widgets/main_header.dart';
import '../widgets/main_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BreedsModel> breedsList;

  Future<List<BreedsModel>> _getList() async {
    if (this.breedsList != null) {
      return this.breedsList;
    } else {
      final dogData = DogData();
      this.breedsList = await dogData.fetchBreeds();
      return this.breedsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Dog App", icon: true),
              Expanded(
                child: FutureBuilder(
                  future: this._getList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return MainList(breeds: snapshot.data, removeButton: false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
