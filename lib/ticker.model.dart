import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class Ticker with ChangeNotifier {
  final _tickPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop)
    ..setSourceAsset('tick.wav');

  final _tockPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop)
    ..setSourceAsset('tock.wav');

  Timer? _timer;

  bool _isActive = false;

  var timePerTick = 0, totalTime = 0, totalTicks = 0, currentTick = 0;

  bool get isActive => _isActive;

  void set({required int secondsPerWord, required int totalMinutes}) {
    timePerTick = secondsPerWord;
    totalTime = totalMinutes;

    totalTicks = Duration(minutes: totalMinutes).inSeconds ~/ secondsPerWord;
    currentTick = 0;

    notifyListeners();
  }

  void start() {
    _isActive = true;

    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: timePerTick), (timer) async {
      if (timer.tick > totalTicks) {
        await Future.delayed(
          const Duration(milliseconds: 375),
          () => _tickPlayer.resume(),
        );

        await Future.delayed(
          const Duration(milliseconds: 375),
          () => _tickPlayer.resume(),
        );

        await Future.delayed(
          const Duration(milliseconds: 375),
          () => _tickPlayer.resume(),
        );

        timer.cancel();

        _isActive = false;
      }

      if (timer.tick % 2 == 0) {
        await _tickPlayer.resume();
      } else {
        await _tockPlayer.resume();
      }

      currentTick = timer.tick;

      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();

    _isActive = false;

    notifyListeners();
  }
}
