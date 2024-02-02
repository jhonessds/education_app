import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/settings/flex_scheme_selector.dart';
import 'package:demo/core/common/widgets/settings/language_selector.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then(
      (infos) => setState(() => version = infos.version),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).cardColor,
      width: screenSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          SimpleText(
            text: '${translation().version} $version - ',
            withTextScale: false,
          ),
          GestureDetector(
            onTap: () async {
              await launchUrl(
                Uri.parse('https://devjhones.com.br/'),
                mode: LaunchMode.externalApplication,
              );
            },
            child: const SimpleText(
              text: 'DevJhones.com',
              color: Colors.blue,
              decoration: TextDecoration.underline,
              withTextScale: false,
            ),
          ),
          IconButton(
            onPressed: () async => languageSelector(),
            icon: const Icon(
              Icons.translate,
            ),
          ),
          IconButton(
            onPressed: () async => flexSchemeSelector(),
            icon: const Icon(
              Icons.palette,
            ),
          ),
        ],
      ),
    );
  }
}
