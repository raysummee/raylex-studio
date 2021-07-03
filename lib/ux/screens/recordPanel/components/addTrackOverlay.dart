import 'package:flutter/material.dart';

abstract class AddTrackOverlay{
  static OverlayEntry createOverlayEntry(BuildContext context, LayerLink _layerLink, AnimationController animation) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset(0, -10));
    print(offset.dy+size.height);
    return OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: animation,
        builder:(context, child) =>  Positioned(
          width: 100,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(MediaQuery.of(context).size.width - 100 - 8, (offset.dy - MediaQuery.of(context).size.height)*animation.value.clamp(0, 1)),
            child: Opacity(
              opacity: (animation.value*animation.value).clamp(0, 1),
              child: Material(
                elevation: 4.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text('Syria'),
                    ),
                    ListTile(
                      title: Text('Lebanon'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}