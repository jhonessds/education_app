import 'dart:math';

import 'package:asp/asp.dart';
import 'package:demo/app/modules/profile/presenter/components/change_profile_image.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/common/widgets/profile/profile_name.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/extensions/string_ext.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImageEdit extends StatelessWidget {
  const ProfileImageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return GestureDetector(
          onTap: () async => changeProfilePicture(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: context.height * 0.15,
                height: context.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    color: context.theme.disabledColor,
                    width: 4,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: currentUserState.value.profilePicture.isNullOrEmpty
                      ? const ProfileName(size: 22, fontSize: 70)
                      : FastCachedImage(
                          width: context.height * 0.15,
                          height: context.height * 0.15,
                          key: ValueKey(Random().nextInt(100)),
                          url: currentUserState.value.profilePicture!,
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
                    border: Border.all(
                      color: context.theme.disabledColor,
                      width: 2,
                    ),
                    color: context.theme.colorScheme.background,
                  ),
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () async => changeProfilePicture(),
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
      },
    );
  }
}
