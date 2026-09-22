import 'package:flutter/material.dart';
import 'package:tgm/core/widgets/app_loader.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.scaleDown,
    this.borderRadius,
    this.placeholder,
    this.semanticLabel,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final String? semanticLabel;

  bool get _isNetwork =>
      imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

  Widget get _placeholder => placeholder ?? const Center(child: AppLoader());

  /// Loader size scaled to the image's footprint so it doesn't dwarf small
  /// thumbnails, capped so it doesn't dominate large hero images either.
  double get _loaderSize {
    final candidates = [width, height].whereType<double>();
    if (candidates.isEmpty) return 36;
    return candidates.reduce((a, b) => a < b ? a : b).clamp(20, 48);
  }

  @override
  Widget build(BuildContext context) {
    // Plain network image, no caching layer. CachedNetworkImage was unreliable
    // on Flutter web (broken images after navigation / blob URL revocation).
    Widget image = _isNetwork
        ? Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            // frameBuilder is the reliable loading gate: on Flutter Web with
            // the CanvasKit renderer, Image.network never emits chunk events,
            // so loadingBuilder's `loadingProgress` stays null for the whole
            // download and the placeholder below never showed. frameBuilder
            // instead fires as soon as a frame has (or hasn't) decoded,
            // independent of chunk-event support.
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) return child;
              return SizedBox(
                width: width,
                height: height,
                child: placeholder != null
                    ? _placeholder
                    : AppImageLoader(size: _loaderSize),
              );
            },
            // Layered on top for the (platform-dependent) case where real
            // download progress is available, upgrading the indeterminate
            // spinner above to a percentage ring.
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null || placeholder != null) {
                return child;
              }
              final total = loadingProgress.expectedTotalBytes;
              final progress = total != null && total > 0
                  ? loadingProgress.cumulativeBytesLoaded / total
                  : null;
              if (progress == null) return child;
              return SizedBox(
                width: width,
                height: height,
                child: AppImageLoader(progress: progress, size: _loaderSize),
              );
            },
            errorBuilder: (context, error, stackTrace) => _errorWidget(),
          )
        : Image.asset(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _errorWidget(),
          );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    if (semanticLabel != null) {
      image = Semantics(label: semanticLabel, image: true, child: image);
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
