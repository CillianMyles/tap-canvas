import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tap_canvas/src/tap_canvas.dart';
import 'package:tap_canvas/src/tap_outside_detector_widget.dart';

import 'mocks.dart';

void main() {
  group('$TapOutsideDetectorWidget', () {
    const outsideKey = Key('outside');
    const insideKey = Key('inside');

    late Function0Mock<void> onTappedOutside;
    late Function0Mock<void> onTappedInside;

    Widget createWidget({
      required VoidCallback onTappedOutside,
      VoidCallback? onTappedInside,
    }) =>
        Material(
          child: TapCanvas(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                children: [
                  const SizedBox(
                    key: outsideKey,
                    height: 100,
                    width: 200,
                  ),
                  TapOutsideDetectorWidget(
                    onTappedOutside: onTappedOutside,
                    onTappedInside: onTappedInside,
                    child: const SizedBox(
                      key: insideKey,
                      height: 100,
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    setUp(() {
      onTappedOutside = Function0Mock();
      onTappedInside = Function0Mock();
    });

    group('when callbacks for outside and inside taps are provided', () {
      setUpUI((tester) async {
        await tester.pumpWidget(createWidget(
          onTappedOutside: onTappedOutside,
          onTappedInside: onTappedInside,
        ));
        await tester.pump();
      });

      testUI('then no callbacks have yet been invoked', (tester) async {
        verifyNever(() => onTappedInside());
        verifyNever(() => onTappedOutside());
      });

      group('and INSIDE the tap detector widget is tapped', () {
        setUpUI((tester) async {
          await tester.tap(find.byKey(insideKey));
          await tester.pump();
        });

        testUI('then the correct callback in invoked', (tester) async {
          verify(() => onTappedInside()).called(1);
          verifyNever(() => onTappedOutside());
        });
      });

      group('and OUTSIDE the tap detector widget is tapped', () {
        setUpUI((tester) async {
          await tester.tap(find.byKey(outsideKey));
          await tester.pump();
        });

        testUI('then the correct callback in invoked', (tester) async {
          verify(() => onTappedOutside()).called(1);
          verifyNever(() => onTappedInside());
        });
      });
    });
  });
}
