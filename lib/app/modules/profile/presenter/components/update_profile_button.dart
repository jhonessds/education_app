import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UpdateProfileButton extends StatefulWidget {
  const UpdateProfileButton({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<UpdateProfileButton> createState() => _UpdateProfileButtonState();
}

class _UpdateProfileButtonState extends State<UpdateProfileButton> {
  final btnController = RoundedLoadingButtonController();
  final profileCtrl = Modular.get<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(
        left: 13,
        right: 13,
        bottom: context.height * 0.02,
      ),
      child: RoundedLoadingButton(
        borderRadius: 70,
        color: Theme.of(context).primaryColor,
        controller: btnController,
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            final user = currentUserState.value;
            late UserModel userToUpdate;

            userToUpdate = user.copyWith(
              name: profileCtrl.name,
              bio: profileCtrl.bio,
              email: profileCtrl.email,
              gender: profileCtrl.gender,
            );

            final result = await profileCtrl.updateUser(user: userToUpdate);
            btnController.stop();
            if (result) {
              Modular.to.pop();
              CoreUtils.bottomSnackBar(
                translation().savedChanges,
                type: SnackBarType.save,
              );
            } else {
              CoreUtils.topSnackBar(profileCtrl.errorMessage);
            }
          } else {
            btnController.stop();
          }
        },
        width: context.width,
        child: Text(
          translation().save,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
