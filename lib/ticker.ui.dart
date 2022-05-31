import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticker/ticker.model.dart';
import 'package:ticker/support.gen.dart';

class TickerDisplay extends StatelessWidget {
  const TickerDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Ticker>(
      builder: (context, ticker, child) {
        var secsPerWordReader = TextEditingController();
        var totalMinutesReader = TextEditingController();

        if (!ticker.isActive) {
          return Center(
            child: SizedBox(
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: secsPerWordReader,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'number of seconds per word'),
                  ),
                  TextField(
                    controller: totalMinutesReader,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'total writing minutes'),
                  ),
                  TextButton(
                    onPressed: () {
                      ticker.set(
                        secondsPerWord: int.parse(secsPerWordReader.text),
                        totalMinutes: int.parse(totalMinutesReader.text),
                      );

                      ticker.start();
                    },
                    child: const Text('start'),
                  )
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => ticker.stop(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${ticker.currentTick}/${ticker.totalTicks} W',
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text(
                    formatTime(
                      Duration(seconds: ticker.currentTick * ticker.timePerTick),
                    ),
                  ),
                  const Text(' '),
                  const Text('Tap here to stop'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
