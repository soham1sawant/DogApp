import 'package:dog_app/features/authentication/ui/delete_user_page.dart';
import 'package:flutter/material.dart';

import 'package:dog_app/core/widgets/delete_user_button.dart';
import 'package:dog_app/core/widgets/main_header.dart';

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
                  Navigator.of(context).push(
                    MaterialPageRoute<DeleteUserPage>(
                      builder: (context) => DeleteUserPage(),
                    ),
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