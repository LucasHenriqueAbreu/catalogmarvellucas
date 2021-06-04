import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class SplashController extends ChangeNotifier {
  ValueNotifier<bool> initialized = ValueNotifier(false);
  ValueNotifier<bool> error = ValueNotifier(false);

  Future<void> initializedFlutterFire() async {
    try {
      await Firebase.initializeApp();
      initialized.value = true;
    } catch (e) {
      error.value = true;
    }
  }
}