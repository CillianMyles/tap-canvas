import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:tap_canvas/src/tap_offset_provider.dart';

/// Tests for inherited widgets inspired by:
/// https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/inherited_test.dart

void main() {
  group('$TapOffsetProvider', () {
    late Stream<Offset> streamOne;
    late Stream<Offset> streamTwo;
    late List<TapOffsetProvider> log;
    late Widget builder;

    Stream<Offset> createStream({required int index}) => Stream.value(
          Offset(
            index.toDouble(),
            index.toDouble(),
          ),
        );

    Widget createBuilder({required List<TapOffsetProvider> log}) =>
        Builder(builder: (context) {
          log.add(
            context.dependOnInheritedWidgetOfExactType<TapOffsetProvider>()!,
          );
          return Container();
        });

    TapOffsetProvider createWidget({
      required Stream<Offset> stream,
      required Widget child,
    }) =>
        TapOffsetProvider(stream: stream, child: child);

    setUpUI((tester) async {
      streamOne = createStream(index: 1);
      streamTwo = createStream(index: 2);
      log = <TapOffsetProvider>[];
      builder = createBuilder(log: log);
    });

    group('when a first instance is created', () {
      late TapOffsetProvider first;
      late TapOffsetProvider second;
      late TapOffsetProvider third;

      setUpUI((tester) async {
        first = createWidget(stream: streamOne, child: builder);
        await tester.pumpWidget(first);
        await tester.pump();
      });

      testUI('then the tap offset stream should be accessible by its children',
          (tester) async {
        expect(log, equals(<TapOffsetProvider>[first]));
      });

      group('and the widget is rebuilt, but with the same stream input', () {
        setUpUI((tester) async {
          second = createWidget(stream: streamOne, child: builder);
          await tester.pumpWidget(second);
          await tester.pump();
        });

        testUI('then the tap offset stream should be un-changed',
            (tester) async {
          expect(log, equals(<TapOffsetProvider>[first]));
        });
      });

      group('and the widget is rebuilt, with a new stream input', () {
        setUpUI((tester) async {
          third = createWidget(stream: streamTwo, child: builder);
          await tester.pumpWidget(third);
          await tester.pump();
        });

        testUI('then the tap offset stream should be updated', (tester) async {
          expect(log, equals(<TapOffsetProvider>[first, third]));
        });
      });
    });
  });
}
