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
            // ignore: sized_box_for_whitespace
            child: Container(
              key: outsideKey,
              height: 200,
              width: 200,
              child: Center(
                child: TapOutsideDetectorWidget(
                  onTappedOutside: onTappedOutside,
                  onTappedInside: onTappedInside,
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    key: insideKey,
                    height: 50,
                    width: 50,
                  ),
                ),
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
    });
  });
}
