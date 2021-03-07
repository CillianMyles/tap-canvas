import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tap_canvas/src/tap_canvas.dart';

/// An inherited widget which provides access to a stream of tapped offsets.
/// Included by default as part of [TapCanvas], and as such, is not intended
/// for external use.
@immutable
class TapOffsetProvider extends InheritedWidget {
  const TapOffsetProvider({
    required this.stream,
    required Widget child,
    Key? key,
  })  : assert(stream != null),
        assert(child != null),
        super(key: key, child: child);

  final Stream<Offset> stream;

  static TapOffsetProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TapOffsetProvider>();

  @override
  bool updateShouldNotify(TapOffsetProvider oldWidget) =>
      oldWidget.stream != stream;
}
