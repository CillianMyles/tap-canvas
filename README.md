# DEPRECATED

**_This package is no longer maintained._** 

TapCanvas was originally added because Flutter did not provide a way to detect taps outside of a widget. 
This has since been [added to Flutter](https://github.com/flutter/flutter/pull/107262) in the form of `TapRegion`.

The core use case of TapCanvas was to dismiss focus for text fields on desktop and web, when the user tapped/clicked outside of them. 
Both Material and Cupertino text fields, now provide this behaviour out of the box, which you can override if you wish to change.

This package is now rendered pointless by the Flutter framework.

<br>

---

# 🚰 TapCanvas

Detect taps outside the currently defined widget and provide a callback when taps occur.

[![codecov](https://codecov.io/gh/CillianMyles/tap-canvas/branch/main/graph/badge.svg?token=B0QHI0452L)](https://codecov.io/gh/CillianMyles/tap-canvas)
[![pub package](https://img.shields.io/pub/v/tap_canvas.svg?color=success)](https://pub.dartlang.org/packages/tap_canvas)

## Example

### Define the area within which you care about taps

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: TapCanvas(
      child: MyHomeWidget(),
    ),
  );
}
```

### Now your widgets can react when the user taps outside them

```dart
class TapOutsideAwareWidget extends StatelessWidget {
  const TapOutsideAwareWidget({super.key});

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
