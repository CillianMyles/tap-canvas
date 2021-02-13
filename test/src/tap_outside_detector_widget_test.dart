import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_canvas/src/tap_outside_detector_widget.dart';

void main() {
  group('$TapOutsideDetectorWidget', () {
    group('when an instance is created', () {
      group('and onTappedOutside is passed as null', () {
        test('then an assertion error is thrown', () {
          expect(
            () => TapOutsideDetectorWidget(
              onTappedOutside: null,
              child: Container(),
            ),
            throwsAssertionError,
          );
        });
      });

      group('and child is passed as null', () {
        test('then an assertion error is thrown', () {
          expect(
            () => TapOutsideDetectorWidget(
              onTappedOutside: () => {},
              child: null,
            ),
            throwsAssertionError,
          );
        });
      });
    });
  });
}
