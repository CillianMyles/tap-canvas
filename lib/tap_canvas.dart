library tap_canvas;

import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// [TapCanvas] represents the area on which taps are tracked, in order to
/// determine taps outside widgets like [TapOutsideDetectorWidget]. In
/// general it makes sense to put this widget as high up the widget tree as
/// possible, but it could be added anywhere above [TapOutsideDetectorWidget],
/// such that it could lower the area of "taps outside" tracking.

class TapCanvas extends StatefulWidget {
  const TapCanvas({
    @required this.child,
    Key key,
  }) : super(key: key);

  final Widget child;

  @override
  _TapCanvasState createState() => _TapCanvasState();
}

class _TapCanvasState extends State<TapCanvas> {
  final StreamController<Offset> _tapOffsetController =
      StreamController<Offset>.broadcast();

  @override
  void dispose() {
    _tapOffsetController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TapOffsetStreamProvider(
        stream: _tapOffsetController.stream,
        child: LayoutBuilder(
          builder: (c, viewportConstraints) => ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: viewportConstraints.maxWidth,
              maxHeight: viewportConstraints.maxHeight,
            ),
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerUp: (event) {
                _tapOffsetController.add(event.position);
              },
              child: widget.child,
            ),
          ),
        ),
      );
}

@immutable
class TapOffsetStreamProvider extends InheritedWidget {
  const TapOffsetStreamProvider({
    @required this.stream,
    @required Widget child,
    Key key,
  })  : assert(stream != null),
        assert(child != null),
        super(key: key, child: child);

  final Stream<Offset> stream;

  static TapOffsetStreamProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TapOffsetStreamProvider>();

  @override
  bool updateShouldNotify(TapOffsetStreamProvider oldWidget) =>
      oldWidget.stream != stream;
}

class TapOutsideDetectorWidget extends StatefulWidget {
  const TapOutsideDetectorWidget({
    @required this.child,
    @required this.onTappedOutside,
    this.onTappedInside,
    Key key,
  })  : assert(child != null),
        assert(onTappedOutside != null),
        super(key: key);

  final Widget child;
  final VoidCallback onTappedOutside;
  final VoidCallback onTappedInside;

  @override
  _TapOutsideDetectorWidgetState createState() =>
      _TapOutsideDetectorWidgetState();
}

class _TapOutsideDetectorWidgetState extends State<TapOutsideDetectorWidget> {
  StreamSubscription<Offset> _tapOffsetSubscription;

  @override
  void dispose() {
    _tapOffsetSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tapOffsetSubscription ??=
        TapOffsetStreamProvider?.of(context)?.stream?.listen(_handleTap);
  }

  void _handleTap(Offset position) {
    if (mounted) {
      final box = context.findRenderObject() as RenderBox;
      final localPosition = box.globalToLocal(position);

      box.paintBounds.contains(localPosition)
          ? widget.onTappedInside?.call()
          : widget.onTappedOutside();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
