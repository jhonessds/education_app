import 'package:demo/app/modules/profile/data/datasources/profile_datasource.dart';
import 'package:demo/app/modules/profile/data/repos/profile_repository_impl.dart';
import 'package:demo/app/modules/profile/domain/repos/profile_repository.dart';
import 'package:demo/app/modules/profile/domain/usecases/delete_user.dart';
import 'package:demo/app/modules/profile/domain/usecases/save_profile_picture.dart';
import 'package:demo/app/modules/profile/domain/usecases/update_user.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/app/modules/profile/presenter/views/profile_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<ProfileDataSource>(ProfileDataSourceImpl.new)
      ..addLazySingleton<ProfileRepository>(ProfileRepositoryImpl.new)
      // Use Cases
      ..addLazySingleton<UpdateUser>(UpdateUser.new)
      ..addLazySingleton<SaveProfilePicture>(UpdateUser.new)
      ..addLazySingleton<DeleteUser>(DeleteUser.new)
      // Controllers
      ..addLazySingleton<ProfileController>(ProfileController.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const ProfileView(),
    );
  }
}
