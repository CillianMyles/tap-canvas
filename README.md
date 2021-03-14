# 🚰 TapCanvas

Detect taps outside the currently defined widget and provide a callback when taps occur.

[![codecov](https://codecov.io/gh/CillianMyles/tap-canvas/branch/main/graph/badge.svg?token=B0QHI0452L)](https://codecov.io/gh/CillianMyles/tap-canvas)

## Example

```dart
class TapOutsideAwareWidget extends StatelessWidget {
  const TapOutsideAwareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TapOutsideDetectorWidget(
    onTappedOutside: () {
      print('OUTSIDE TAPPED');
    },
    onTappedInside: () {
      print('INSIDE TAPPED');
    },
    child: MyWidgetThatCaresAboutTaps(),
  );
}
```
