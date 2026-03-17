import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.scaleDown,
    this.borderRadius,
    this.placeholder,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, value) =>
          placeholder ??
          Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          ),
      errorWidget: (context, errorString, errorObject) => _errorWidget(),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _errorWidget() {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: Colors.grey.shade200,
      child: const Icon(Icons.broken_image, size: 32),
    );
  }
}
