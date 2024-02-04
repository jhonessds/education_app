import 'dart:io';

import 'package:demo/app/app_widget.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

Future<void> changeProfilePicture() async {
  final context = NavigationService.instance.currentContext;

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
              text: translation().chooseTheOrigin,
              fontWeight: FontWeight.w600,
              color: context.theme.primaryColor,
              fontSize: 21,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(translation().fromCamera),
              onTap: () async => processRequest(source: ImageSource.camera),
            ),
            Divider(
              color: context.theme.disabledColor,
              indent: 10,
              endIndent: 10,
              height: 5,
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(translation().fromGallery),
              onTap: () async => processRequest(source: ImageSource.gallery),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.only(
                left: 13,
                right: 13,
                top: 25,
                bottom: context.height * 0.02,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  backgroundColor: context.theme.primaryColor,
                ),
                onPressed: () => Modular.to.pop(),
                child: Text(
                  translation().cancel,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> processRequest({required ImageSource source}) async {
  File? imageFile;
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    imageFile = File(pickedFile.path);
    Modular.to.pop();
    loadingWidget();
    final profileCtrl = Modular.get<ProfileController>();
    final result = await profileCtrl.saveProfilePicture(
      file: imageFile,
    );
    Modular.to.pop();
    if (result) {
      CoreUtils.bottomSnackBar(
        translation().savedChanges,
        type: SnackBarType.save,
      );
    } else {
      CoreUtils.bottomSnackBar(translation().problemWithRequest);
    }
  }
}
