import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// A class to play ticking sounds at regular intervals
///
class Ticker with ChangeNotifier {
  final _tickPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop)
    ..setSourceAsset('tick.wav');

  final _tockPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop)
    ..setSourceAsset('tock.wav');

  Timer? _timer;

  bool _isActive = false;

  /// number of seconds between ticks
  ///
  var timeBWTicks = 0;

  /// total number of minutes for which to play the ticking sounds
  ///
  var totalTime = 0;

  /// total number of ticks to be played
  ///
  var totalTicks = 0;

  /// the number of ticks that have been played
  ///
  var completeTicks = 0;

  /// weather the `Ticker` is currently playing sound or not
  ///
  bool get isActive => _isActive;

  /// setup the `Ticker` to play ticking sounds to the wanted parameters
  ///
  void set({required int timeBetweenTicks, required int totalTickingMinutes}) {
    timeBWTicks = timeBetweenTicks;
    totalTime = totalTickingMinutes;

    totalTicks = Duration(minutes: totalTickingMinutes).inSeconds ~/ timeBetweenTicks;
    completeTicks = 0;

    notifyListeners();
  }

  /// start the ticking sounds
  ///
  void start() {
    _isActive = true;

    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: timeBWTicks), (timer) async {
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

      completeTicks = timer.tick;

      notifyListeners();
    });
  }

  /// stop the ticking sounds before the pre-configured duration
  ///
  void stop() {
    _timer?.cancel();

    _isActive = false;

    notifyListeners();
  }
}
