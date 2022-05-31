import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart';

void setupWindow({
  required String title,
  required double windowHeight,
  required double windowWidth,
}) {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();

    setWindowTitle(title);

    setWindowMinSize(Size(windowWidth, windowHeight));
    setWindowMaxSize(Size(windowWidth, windowHeight));

    getCurrentScreen().then((screen) {
      setWindowFrame(
        Rect.fromCenter(
          center: screen!.frame.center,
          width: windowWidth,
          height: windowHeight,
        ),
      );
    });
  }
}

String formatTime(Duration duration) {
  return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m ${duration.inSeconds.remainder(60)}s';
}
