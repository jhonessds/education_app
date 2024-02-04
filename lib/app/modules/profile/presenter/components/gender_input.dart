import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GenderInput extends StatelessWidget {
  const GenderInput({
    required this.genderCtrl,
    required this.profileCtrl,
    super.key,
  });

  final TextEditingController genderCtrl;
  final ProfileController profileCtrl;

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: genderCtrl,
      labelText: translation().gender,
      keyboardType: TextInputType.emailAddress,
      mgBottom: 20,
      borderRadius: 25,
      readOnly: true,
      onTap: () async {
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          builder: (context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: context.width * 0.3,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 3,
                  ),
                  SimpleText(
                    mgTop: 10,
                    mgBottom: 20,
                    text: translation().chooseYourGender,
                    fontWeight: FontWeight.w600,
                    color: context.theme.primaryColor,
                    fontSize: 21,
                  ),
                  ListTile(
                    leading: const Icon(Icons.male),
                    title: Text(translation().male.capitalize()),
                    onTap: () {
                      profileCtrl.gender = GenderType.male;
                      genderCtrl.text = translation().male;
                      Modular.to.pop();
                    },
                    trailing: profileCtrl.gender == GenderType.male
                        ? const Icon(Icons.check)
                        : null,
                  ),
                  Divider(
                    color: context.theme.disabledColor,
                    indent: 10,
                    endIndent: 10,
                    height: 5,
                  ),
                  ListTile(
                    leading: const Icon(Icons.female),
                    title: Text(translation().female.capitalize()),
                    onTap: () {
                      profileCtrl.gender = GenderType.female;
                      genderCtrl.text = translation().female;
                      Modular.to.pop();
                    },
                    trailing: profileCtrl.gender == GenderType.female
                        ? const Icon(Icons.check)
                        : null,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
