import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tap_canvas/src/tap_offset_provider.dart';

/// Wrap any widget you would like to get a callback when outside that widget
/// has been tapped.
///
/// A concrete example of this could be a [Text] field which should dismiss
/// focus and text input when something outside of it is interacted with.
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
        TapOffsetProvider?.of(context)?.stream?.listen(_handleTap);
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
