import 'package:catalogmarvellucas/pages/home/home_page.dart';
import 'package:catalogmarvellucas/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = SplashController();

  @override
  void initState() {
    controller.initializedFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: controller.initialized,
            builder: (_, __, ___) {
              if (controller.error.value) {
                return Text('Não foi possível inicializar o firebase');
              }

              if (!controller.initialized.value) {
                return CircularProgressIndicator();
              }

              return ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false);
                },
                child: Text('Entrar'),
              );
            }),
      ),
    );
  }
}
