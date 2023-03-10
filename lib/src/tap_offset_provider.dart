import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tap_canvas/src/tap_canvas.dart';

/// An inherited widget which provides access to a stream of tapped offsets.
/// Included by default as part of [TapCanvas], and as such, is not intended
/// for external use.
class TapOffsetProvider extends InheritedWidget {
  const TapOffsetProvider({
    super.key,
    required super.child,
    required this.stream,
  });

  final Stream<Offset> stream;

  static TapOffsetProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TapOffsetProvider>();

  @override
  bool updateShouldNotify(TapOffsetProvider oldWidget) =>
      oldWidget.stream != stream;
}
