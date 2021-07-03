import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AddTrackOverlay{
  static OverlayEntry createOverlayEntry({
    required BuildContext context, 
    required LayerLink layerLink, 
    required AnimationController animation,
    required VoidCallback onTopTap,
    required VoidCallback onBottomTap
  }) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset(0, -15));
    print(offset.dy+size.height);
    return OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: animation,
        builder:(context, child) =>  Positioned(
          width: 225,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
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
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: onTopTap,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Import",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        indent: 8,
                        endIndent: 8,
                        thickness: 1,
                        height: 1,
                      ),
                      CupertinoButton(
                        onPressed: onBottomTap,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom:  8),
                          child: Text(
                            "Empty",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
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