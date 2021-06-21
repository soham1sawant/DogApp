import '../../logic/bloc/data_bloc.dart';
import '../widgets/home_page/main_header.dart';
import '../widgets/home_page/main_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(29),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(),
              BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  if (state is DataInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is DataLoadSuccess) {
                    return Expanded(child: MainList(breeds: state.breeds));
                  } else if (state is DataLoadFailure) {
                    return Icon(Icons.error);
                  } else {
                    return Icon(Icons.error);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
