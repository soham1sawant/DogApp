import 'package:dog_app/features/dog_data/viewmodel/dog_data_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/main_header.dart';
import '../../widgets/main_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child: MainList(
                  breeds: Provider.of<DogData>(context).dogbreeds,
                  removeButton: false,
                  hasData: (Provider.of<DogData>(context).dogbreeds == null ||
                          Provider.of<DogData>(context).dogbreeds.isEmpty)
                      ? false
                      : true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
