import 'package:demo/core/utils/core_utils.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsapp({required String whatsapp}) async {
  final phoneNumber = whatsapp.replaceAll('+', '');
  final whatsappUrl = Uri.parse('https://wa.me/$phoneNumber');

  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  } else {
    CoreUtils.showSnackBar('Whatsapp não instalado!', isError: true);
  }
}
