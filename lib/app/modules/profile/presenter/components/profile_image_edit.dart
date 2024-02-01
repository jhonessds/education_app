import 'dart:math';

import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/common/widgets/profile/profile_name.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/extensions/string_ext.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileImageEdit extends StatefulWidget {
  const ProfileImageEdit({super.key});

  @override
  State<ProfileImageEdit> createState() => _ProfileImageEditState();
}

class _ProfileImageEditState extends State<ProfileImageEdit> {
  SessionController sessionCtrl = Modular.get<SessionController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    text: 'Escolha a origem',
                    fontWeight: FontWeight.w600,
                    color: context.theme.primaryColor,
                    fontSize: 21,
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('From Camera'),
                    onTap: () {},
                  ),
                  Divider(
                    color: context.theme.disabledColor,
                    indent: 10,
                    endIndent: 10,
                    height: 5,
                  ),
                  ListTile(
                    leading: const Icon(Icons.document_scanner_outlined),
                    title: const Text('From Gallery'),
                    onTap: () {},
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
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: context.height * 0.15,
            height: context.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(color: context.theme.disabledColor, width: 4),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: sessionCtrl.currentUser.profilePicture.isNullOrEmpty
                  ? const ProfileName(
                      size: 22,
                      fontSize: 70,
                    )
                  : FastCachedImage(
                      key: ValueKey(Random().nextInt(100)),
                      url: sessionCtrl.currentUser.profilePicture!,
                      cacheHeight: (context.height * 0.15).toInt(),
                      cacheWidth: (context.height * 0.15).toInt(),
                      fit: BoxFit.cover,
                      loadingBuilder: (context, progress) {
                        if (progress.isDownloading &&
                            progress.totalBytes != null) {
                          return Center(
                            child: CircularProgressIndicator(
                              value: progress.downloadedBytes /
                                  progress.totalBytes!,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const ProfileName(
                          size: 22,
                          fontSize: 70,
                        );
                      },
                    ),
            ),
          ),
          Positioned(
            bottom: context.height * 0.01,
            left: context.width * 0.25,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border:
                    Border.all(color: context.theme.disabledColor, width: 2),
                color: context.theme.colorScheme.background,
              ),
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16,
                  color: context.theme.colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
