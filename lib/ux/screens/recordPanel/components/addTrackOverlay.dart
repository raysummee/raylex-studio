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
          width: 225,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(MediaQuery.of(context).size.width - 225 - 8, (offset.dy - MediaQuery.of(context).size.height)*animation.value.clamp(0, 1)),
            child: Opacity(
              opacity: (animation.value*animation.value).clamp(0, 1),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10
                      )
                    ],
                    borderRadius: BorderRadius.circular(18)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Import",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        indent: 8,
                        endIndent: 8,
                        thickness: 1,
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Empty",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}