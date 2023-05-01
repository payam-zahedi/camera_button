import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'camera_button.dart';

/// CameraApp is the Main Application.
class CameraButtonPage extends StatefulWidget {
  /// Default Constructor
  const CameraButtonPage({super.key});

  @override
  State<CameraButtonPage> createState() => _CameraButtonPageState();
}

class _CameraButtonPageState extends State<CameraButtonPage> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();

    _initCameras().then(
      (cameras) {
        if (!mounted) {
          return;
        }
        _initController(cameras);
      },
    ).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<List<CameraDescription>> _initCameras() async {
    return await availableCameras();
  }

  void _initController(List<CameraDescription> cameras) {
    controller = CameraController(
      kIsWeb ? cameras[0] : cameras[1],
      ResolutionPreset.max,
    );

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0e0e0),
      body: CameraButtonWidget(controller: controller),
    );
  }
}
