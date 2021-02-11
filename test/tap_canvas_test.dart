import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_canvas/src/tap_canvas.dart';
import 'package:tap_canvas/src/tap_offset_provider.dart';
import 'package:tap_canvas/src/tap_outside_detector_widget.dart';

void main() {
  group('$TapCanvas', () {
    group('when an instance is created', () {
      group('and child is passed as null', () {
        test('then an assertion error is thrown', () {
          expect(() => TapCanvas(child: null), throwsAssertionError);
        });
      });
    });
  });

  group('$TapOffsetProvider', () {
    group('when an instance is created', () {
      group('and stream is passed as null', () {
        test('then an assertion error is thrown', () {
          expect(
            () => TapOffsetProvider(
              stream: null,
              child: Container(),
            ),
            throwsAssertionError,
          );
        });
      });

      group('and child is passed as null', () {
        test('then an assertion error is thrown', () {
          expect(
            () => TapOffsetProvider(
              stream: const Stream.empty(),
              child: null,
            ),
            throwsAssertionError,
          );
        });
      });
    });
  });

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
