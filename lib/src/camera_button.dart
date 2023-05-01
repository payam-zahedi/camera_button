import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const _buttonWidth = 300.0;
const _buttonHeight = 100.0;

class CameraButtonWidget extends StatelessWidget {
  const CameraButtonWidget({
    super.key,
    required this.controller,
  });

  final CameraController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (controller?.value.isInitialized == true)
          Center(child: _CameraView(controller: controller!)),
        const Center(child: _Button()),
      ],
    );
  }
}

class _CameraView extends StatelessWidget {
  const _CameraView({
    required this.controller,
  });

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    const defaultSize = 500.0;
    const opacity = 0.4;

    return SizedBox(
      width: defaultSize.clamp(0, deviceWidth),
      child: ClipRRect(
        clipper: CustomRRect(),
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix(
            <double>[
              // line one
              0.2126 + 0.7874 * opacity, 0.7152 - 0.7152 * opacity,
              0.0722 - 0.0722 * opacity, 0, 0,
              // line two
              0.2126 - 0.2126 * opacity, 0.7152 + 0.2848 * opacity,
              0.0722 - 0.0722 * opacity, 0, 0,
              // line three
              0.2126 - 0.2126 * opacity, 0.7152 - 0.7152 * opacity,
              0.0722 + 0.9278 * opacity, 0, 0,
              // line four
              0, 0, 0, 1, 0,
            ],
          ),
          child: Center(
            child: CameraPreview(
              controller,
              child: const EffectWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: NeumorphicButton(
        minDistance: kIsWeb ? .5 : 0,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        style: const NeumorphicStyle(
          depth: 16,
          lightSource: LightSource(0, -0.5),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.stadium(),
          color: Colors.transparent,
          shadowDarkColor: Colors.black54,
          border: NeumorphicBorder(
            color: Colors.white12,
            width: 3,
          ),
        ),
        onPressed: () {},
        child: SizedBox(
          width: _buttonWidth + 4,
          height: _buttonHeight + 2,
          child: Center(
            child: Text(
              'Button',
              style: TextStyle(
                color: const Color.fromARGB(kIsWeb ? 80 : 160, 0, 0, 0),
                fontSize: 48,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    offset: const Offset(0, -1),
                    blurRadius: 0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  Shadow(
                    offset: const Offset(0, 1),
                    blurRadius: 0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EffectWidget extends StatelessWidget {
  const EffectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Container(
          color: Colors.white12,
          width: _buttonWidth,
          height: _buttonHeight,
        ),
      ),
    );
  }
}

class CustomRRect extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: _buttonWidth,
      height: _buttonHeight,
    );
    return RRect.fromRectAndRadius(rect, const Radius.circular(100));
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}
