import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_canvas/src/tap_offset_provider.dart';

void main() {
  group('$TapOffsetProvider', () {
    Stream<Offset> createStream(int index) => Stream.value(
          Offset(
            index.toDouble(),
            index.toDouble(),
          ),
        );

    testWidgets('notifies dependents', (tester) async {
      final streams = [0, 1].map(createStream).toList(growable: false);
      final log = <TapOffsetProvider>[];

      final builder = Builder(builder: (context) {
        log.add(
          context.dependOnInheritedWidgetOfExactType<TapOffsetProvider>()!,
        );
        return Container();
      });

      final first = TapOffsetProvider(stream: streams[0], child: builder);
      await tester.pumpWidget(first);

      expect(log, equals(<TapOffsetProvider>[first]));

      final second = TapOffsetProvider(stream: streams[0], child: builder);
      await tester.pumpWidget(second);

      expect(log, equals(<TapOffsetProvider>[first]));

      final third = TapOffsetProvider(stream: streams[1], child: builder);
      await tester.pumpWidget(third);

      expect(log, equals(<TapOffsetProvider>[first, third]));
    });
  });
}
