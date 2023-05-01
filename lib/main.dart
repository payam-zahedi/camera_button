import 'package:camera_button/src/camera_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: CameraButtonPage()));
}
