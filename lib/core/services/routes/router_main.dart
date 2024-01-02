import 'package:demo/core/common/views/page_under_construction.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/dependencies/injection_container_main.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:demo/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:demo/src/auth/presentation/views/forgot_password_view.dart';
import 'package:demo/src/auth/presentation/views/sign_in_view.dart';
import 'package:demo/src/auth/presentation/views/sign_up_view.dart';
import 'package:demo/src/dashboard/presentation/views/dashboard_view.dart';
import 'package:demo/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:demo/src/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.dart';
