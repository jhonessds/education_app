import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/app/app_widget.dart';
import 'package:demo/core/abstraction/logger.dart';
import 'package:demo/core/common/models/environment_model.dart';
import 'package:demo/core/environments/config/env_dev.dart';
import 'package:demo/core/environments/flavors_config.dart';
import 'package:demo/modules/app_module.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
    await Firebase.initializeApp();

    FlavorConfig(
      flavor: Flavor.prod,
      env: EnvironmentModel.fromJson(development),
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );

    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  }, (error, stack) {
    logger(error);
    logger(stack);
  });
}
