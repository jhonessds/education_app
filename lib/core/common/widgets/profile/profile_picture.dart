import 'dart:math';

import 'package:asp/asp.dart';
import 'package:demo/app/modules/profile/presenter/views/profile_view.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/common/widgets/profile/profile_name.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/extensions/string_ext.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    this.size = 35,
    this.mRight = 10,
    this.onTap,
    super.key,
  });
  final double size;
  final double mRight;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(right: mRight),
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: currentUserState.value.profilePicture.isNullOrEmpty
                    ? ProfileName(size: size)
                    : FastCachedImage(
                        height: size,
                        width: size,
                        key: ValueKey(Random().nextInt(100)),
                        url: currentUserState.value.profilePicture,
                        cacheHeight: size.toInt(),
                        cacheWidth: size.toInt(),
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
                          return ProfileName(size: size);
                        },
                      ),
              ),
              Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink(
                  child: InkWell(
                    splashColor: context.theme.primaryColor.withAlpha(120),
                    onTap: onTap,
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
