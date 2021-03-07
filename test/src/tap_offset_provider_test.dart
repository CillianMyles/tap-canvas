import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_canvas/src/tap_offset_provider.dart';

void main() {
  group('$TapOffsetProvider', () {
    group('when an instance is created', () {
      group('and stream is passed as null', () {
        test('then an assertion error is thrown', () {
          expect(
            () => TapOffsetProvider(
              stream: null!,
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
              child: null!,
            ),
            throwsAssertionError,
          );
        });
      });
    });
  });
}
