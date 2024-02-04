import 'package:demo/app/modules/profile/presenter/components/gender_input.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final bioCtrl = TextEditingController();
  final profileCtrl = Modular.get<ProfileController>();
  UserModel currentUser = currentUserState.value;

  @override
  void initState() {
    super.initState();
    fullNameCtrl.text = currentUser.name;
    emailCtrl.text = currentUser.email;
    genderCtrl.text = currentUser.gender.translated;
    profileCtrl.gender = currentUser.gender;
    bioCtrl.text = currentUser.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 13,
        right: 13,
        bottom: 20,
        top: context.height * 0.07,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomInput(
              labelText: translation().fullName,
              controller: fullNameCtrl,
              maxlines: 1,
              borderRadius: 25,
              mgBottom: 20,
              validator: InputValidator.emptyCheck(translation().requiredField),
              onChange: (value) => profileCtrl.name = value,
            ),
            if (UserHelper.authMethod() == AuthMethodType.email)
              CustomInput(
                controller: emailCtrl,
                labelText: translation().email,
                keyboardType: TextInputType.emailAddress,
                mgBottom: 20,
                borderRadius: 25,
                validator: InputValidator.emailValidator,
                onChange: (value) => profileCtrl.email = value,
              ),
            GenderInput(genderCtrl: genderCtrl, profileCtrl: profileCtrl),
            CustomInput(
              labelText: translation().bio,
              controller: bioCtrl,
              borderRadius: 25,
              mgBottom: 20,
              maxlines: 2,
              contentPaddingV: 10,
              maxLength: 100,
              onChange: (value) => profileCtrl.bio = value,
            ),
          ],
        ),
      ),
    );
  }
}
