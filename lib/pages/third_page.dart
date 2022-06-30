import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stroktrail/base_widgets/LoadingWidget.dart';

class ThirdWidget extends StatefulWidget {
  const ThirdWidget({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  State<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  double scale = 1;
  double rotation = 0;

  double prevRotation = 0;
  double prevScale = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      onScaleUpdate: (s) {
        setState(
          () {
            scale = prevScale + s.scale;
            rotation = prevRotation + s.rotation;
          },
        );
      },
      onScaleEnd: (s) {
        prevScale = scale - 1;
        prevRotation = rotation;
      },
      child: Transform.rotate(
        angle: rotation,
        child: Transform.scale(
          scale: scale,
          child: Hero(
            tag: widget.imageUrl,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              maxWidthDiskCache: 1920,
              maxHeightDiskCache: 1080,
              placeholder: (context, url) => loadingWidget,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
