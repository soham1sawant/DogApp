import '../../data/models/breeds.dart';
import '../../data/repository/data_repository.dart';

import '../widgets/main_header.dart';
import '../widgets/main_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BreedsModel> breeds;

  @override
  void initState() async {
    final DataRepository dataRepository = DataRepository();
    breeds = await dataRepository.getDogData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Dog App", icon: true),
              Expanded(
                  child: MainList(
                breeds: breeds,
                removeButton: false,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
