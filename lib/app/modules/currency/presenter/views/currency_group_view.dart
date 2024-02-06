import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';

class CurrencyGroupView extends StatelessWidget {
  const CurrencyGroupView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SimpleText(
          text: 'Your Groups',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: context.theme.colorScheme.onBackground,
        ),
      ),
      body: Column(
        children: [
          CustomInput(
            hintText: 'Search Group',
            mgLeft: 15,
            maxlines: 1,
            mgTop: 20,
            borderRadius: 25,
            prefixIcon: const Icon(Icons.search),
            fillColor: context.theme.colorScheme.background,
            mgRight: 15,
            unfocus: true,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 25,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    minLeadingWidth: 10,
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 12),
                            Icon(
                              IconlyLight.category,
                              color: context.theme.primaryColor,
                            ),
                            const SimpleText(
                              mgLeft: 6,
                              text: 'USD to CAD',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_vert_outlined),
                      itemBuilder: (context) => [
                        PopupMenuItem<void>(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.trash_outline,
                                color: context.theme.colorScheme.error,
                              ),
                              const SizedBox(width: 5),
                              const SimpleText(
                                text: 'Delete',
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem<void>(
                          height: 1,
                          child: Divider(height: 1),
                        ),
                        PopupMenuItem<void>(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.edit_2_outline,
                                color: context.theme.primaryColor,
                              ),
                              const SizedBox(width: 5),
                              const SimpleText(
                                text: 'Edit',
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
