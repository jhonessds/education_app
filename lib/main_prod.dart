import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/common/models/environment_model.dart';
import 'package:education_app/core/environments/config/env_prod.dart';
import 'package:education_app/core/environments/flavors_config.dart';
import 'package:education_app/core/services/dependencies/injection_container_main.dart';
import 'package:education_app/core/utils/logger.dart';
import 'package:education_app/src/app_widget.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
    await Firebase.initializeApp();
    await init();

    FlavorConfig(
      flavor: Flavor.prod,
      env: EnvironmentModel.fromJson(production),
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );

    runApp(const AppWidget());
  }, (error, stack) {
    logger(error);
    logger(stack);
  });
}
