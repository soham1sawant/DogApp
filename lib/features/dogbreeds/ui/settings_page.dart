import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

import 'package:dog_app/core/widgets/delete_user_button.dart';
import 'package:dog_app/core/widgets/main_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.032,
            vertical: size.width * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainHeader(
                header: 'Settings',
                favIcon: false,
                settingsIcon: false,
              ),
              SizedBox(height: size.height * 0.75),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.065),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(size.height * 0.025),
                          height: size.height * 0.2,
                          width: size.width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Are you sure ?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.035,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: ConfirmButton(
                                      key: const Key(
                                          'confirm_cancel_user_button'),
                                      text: 'Cancel',
                                      color: Theme.of(context).primaryColor,
                                      textColor: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(const DeleteUserRequested());
                                    },
                                    child: ConfirmButton(
                                      key: const Key('confirm_ok_user_button'),
                                      text: 'OK',
                                      color: Colors.red,
                                      textColor: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const DeleteUserButton(
                  key: Key('delete_user_button'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.045,
      width: size.width * 0.25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size.width * 0.065),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: size.height * 0.025,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
