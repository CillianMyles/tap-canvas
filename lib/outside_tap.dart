library outside_tap;

import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
  final StreamController<Offset> _tapOffsetStreamController =
      StreamController<Offset>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tapOffsetStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TapOffsetProvider(
        stream: _tapOffsetStreamController.stream,
        child: LayoutBuilder(
          builder: (c, viewportConstraints) => ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: viewportConstraints.maxWidth,
              maxHeight: viewportConstraints.maxHeight,
            ),
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                print('event -> $event'); // TODO: remove
              },
              onPointerUp: (event) {
                print('event -> $event'); // TODO: remove
                _tapOffsetStreamController.add(event.position);
              },
              onPointerSignal: (event) {
                print('event -> $event'); // TODO: remove
              },
              onPointerMove: (event) {
                print('event -> $event'); // TODO: remove
              },
              onPointerHover: (event) {
                //print('event -> $event'); // TODO: remove
              },
              child: TapDetectorWidget(
                child: widget.child,
              ),
            ),
          ),
        ),
      );
}

@immutable
class TapOffsetProvider extends InheritedWidget {
  const TapOffsetProvider({
    @required this.stream,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(stream != null),
        super(key: key, child: child);

  final Stream<Offset> stream;

  static TapOffsetProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TapOffsetProvider>();

  @override
  bool updateShouldNotify(TapOffsetProvider oldWidget) =>
      oldWidget.stream != stream;
}

class TapDetectorWidget extends StatelessWidget {
  const TapDetectorWidget({
    @required this.child,
    Key key,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(child: child);
}

class TapOutsideDetectorWidget extends StatefulWidget {
  const TapOutsideDetectorWidget({
    @required this.onOutsideTapped,
    @required this.child,
    Key key,
  })  : assert(child != null),
        super(key: key);

  final VoidCallback onOutsideTapped;
  final Widget child;

  @override
  _TapOutsideDetectorWidgetState createState() =>
      _TapOutsideDetectorWidgetState();
}

class _TapOutsideDetectorWidgetState extends State<TapOutsideDetectorWidget> {
  StreamSubscription<Offset> _tapOffsetSubscription;

  @override
  void dispose() {
    _tapOffsetSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tapOffsetSubscription ??=
        TapOffsetProvider?.of(context)?.stream?.listen(_handleTap);
  }

  void _handleTap(Offset position) {
    if (mounted) {
      final box = context.findRenderObject() as RenderBox;
      final localPosition = box.globalToLocal(position);

      if (!box.paintBounds.contains(localPosition)) {
        widget.onOutsideTapped();
      }
    }
  }

  @override
  Widget build(BuildContext context) => Container(child: widget.child);
}
