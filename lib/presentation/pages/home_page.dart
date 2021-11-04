import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/dog_data.dart';
import '../widgets/main_header.dart';
import '../widgets/main_list.dart';

class HomePage extends StatelessWidget {
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
                  future: Provider.of<DogData>(context, listen: false)
                      .fetchBreeds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Icon(Icons.error);
                      }
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
