import 'package:demo/app/modules/profile/presenter/components/profile_form.dart';
import 'package:demo/app/modules/profile/presenter/components/profile_image_edit.dart';
import 'package:demo/app/modules/profile/presenter/components/update_profile_button.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.theme.primaryColor),
        title: Text(
          translation().userProfile,
          style: TextStyle(color: context.theme.colorScheme.onBackground),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const ProfileImageEdit(),
              ProfileForm(formKey: formKey),
              UpdateProfileButton(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}
