import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FlexScheme> setFlexScheme(String flexScheme) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('flexScheme', flexScheme);
  return _getFlexScheme(flexScheme);
}

Future<FlexScheme> getFlexScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final flexScheme = prefs.getString('flexScheme');
  return _getFlexScheme(flexScheme);
}

Future<FlexScheme> setDarkFlexScheme(String flexScheme) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('darkFlexScheme', flexScheme);
  return _getFlexScheme(flexScheme);
}

Future<FlexScheme> getDarkFlexScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final flexScheme = prefs.getString('darkFlexScheme');
  return _getFlexScheme(flexScheme);
}

FlexScheme _getFlexScheme(String? flexScheme) {
  switch (flexScheme) {
    case 'material':
      return FlexScheme.material;
    case 'materialHc':
      return FlexScheme.materialHc;
    case 'blue':
      return FlexScheme.blue;
    case 'indigo':
      return FlexScheme.indigo;
    case 'hippieBlue':
      return FlexScheme.hippieBlue;
    case 'aquaBlue':
      return FlexScheme.aquaBlue;
    case 'brandBlue':
      return FlexScheme.brandBlue;
    case 'deepBlue':
      return FlexScheme.deepBlue;
    case 'sakura':
      return FlexScheme.sakura;
    case 'mandyRed':
      return FlexScheme.mandyRed;
    case 'red':
      return FlexScheme.red;
    case 'redWine':
      return FlexScheme.redWine;
    case 'purpleBrown':
      return FlexScheme.purpleBrown;
    case 'green':
      return FlexScheme.green;
    case 'money':
      return FlexScheme.money;
    case 'jungle':
      return FlexScheme.jungle;
    case 'greyLaw':
      return FlexScheme.greyLaw;
    case 'wasabi':
      return FlexScheme.wasabi;
    case 'gold':
      return FlexScheme.gold;
    case 'mango':
      return FlexScheme.mango;
    case 'amber':
      return FlexScheme.amber;
    case 'vesuviusBurn':
      return FlexScheme.vesuviusBurn;
    case 'deepPurple':
      return FlexScheme.deepPurple;
    case 'ebonyClay':
      return FlexScheme.ebonyClay;
    case 'barossa':
      return FlexScheme.barossa;
    case 'shark':
      return FlexScheme.shark;
    case 'bigStone':
      return FlexScheme.bigStone;
    case 'damask':
      return FlexScheme.damask;
    case 'bahamaBlue':
      return FlexScheme.bahamaBlue;
    case 'mallardGreen':
      return FlexScheme.mallardGreen;
    case 'espresso':
      return FlexScheme.espresso;
    case 'outerSpace':
      return FlexScheme.outerSpace;
    case 'blueWhale':
      return FlexScheme.blueWhale;
    case 'sanJuanBlue':
      return FlexScheme.sanJuanBlue;
    case 'rosewood':
      return FlexScheme.rosewood;
    case 'blumineBlue':
      return FlexScheme.blumineBlue;
    case 'flutterDash':
      return FlexScheme.flutterDash;
    case 'materialBaseline':
      return FlexScheme.materialBaseline;
    case 'verdunHemlock':
      return FlexScheme.verdunHemlock;
    case 'dellGenoa':
      return FlexScheme.dellGenoa;
    case 'redM3':
      return FlexScheme.redM3;
    case 'pinkM3':
      return FlexScheme.pinkM3;
    case 'purpleM3':
      return FlexScheme.purpleM3;
    case 'indigoM3':
      return FlexScheme.indigoM3;
    case 'blueM3':
      return FlexScheme.blueM3;
    case 'cyanM3':
      return FlexScheme.cyanM3;
    case 'tealM3':
      return FlexScheme.tealM3;
    case 'greenM3':
      return FlexScheme.greenM3;
    case 'limeM3':
      return FlexScheme.limeM3;
    case 'yellowM3':
      return FlexScheme.yellowM3;
    case 'orangeM3':
      return FlexScheme.orangeM3;
    case 'deepOrangeM3':
      return FlexScheme.deepOrangeM3;
    default:
      return FlexScheme.brandBlue;
  }
}
