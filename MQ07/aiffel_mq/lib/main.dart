import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(PetObesity(firstCamera: firstCamera));
}

class PetObesity extends StatelessWidget {
  final CameraDescription firstCamera;

  const PetObesity({super.key, required this.firstCamera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(camera: firstCamera),
      },
    );
  }
}
