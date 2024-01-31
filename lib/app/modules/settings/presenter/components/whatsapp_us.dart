import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';

class WhatsappUs extends StatelessWidget {
  const WhatsappUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.02),
      child: Card(
        elevation: 4,
        color: context.theme.cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SimpleText(
                maxlines: 3,
                fontSize: 16,
                textAlign: TextAlign.center,
                mgBottom: context.height * 0.03,
                text: translation().whatsAppUsText,
              ),
              Ink(
                child: InkWell(
                  child: SimpleText(
                    text: translation().whatsAppUs,
                    color: context.theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  onTap: () {
                    openWhatsapp(whatsapp: '5511969495790');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
