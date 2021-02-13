import 'package:flutter_test/flutter_test.dart';
import 'package:tap_canvas/src/tap_canvas.dart';

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
}
