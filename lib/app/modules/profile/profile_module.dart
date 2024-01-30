import 'package:demo/app/modules/profile/presenter/views/profile_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const ProfileView(),
    );
  }
}
