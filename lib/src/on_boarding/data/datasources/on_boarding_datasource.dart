import 'package:demo/core/errors/cache_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'isFirstTime';

class OnBoardingLocalDataSrcImpl extends OnBoardingLocalDataSource {
  const OnBoardingLocalDataSrcImpl({required this.prefs});

  final SharedPreferences prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = prefs.getBool(kFirstTimerKey) ?? true;
      return result;
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }
}
