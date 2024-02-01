import 'package:demo/app/modules/profile/presenter/components/profile_image_edit.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.theme.primaryColor),
        title: Text(
          'User Profile',
          style: TextStyle(color: context.theme.colorScheme.onBackground),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              ProfileImageEdit(),
            ],
          ),
        ),
      ),
    );
  }
}
