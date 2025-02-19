import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/src/packages/custom_image/custom_mem_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// It will provide to image caching and image loading from network
final class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.size,
    this.emptyWidget,
    this.loadingWidget,
    this.boxFit = BoxFit.cover,
    this.memCache = const CustomMemCache(height: 200, width: 200),
  });

  /// Image load source address
  final String? imageUrl;

  /// When image is not available then it will show empty widget
  final Widget? emptyWidget;

  /// When image is loading then it will show loading widget
  final Widget? loadingWidget;

  /// Default vaule is [CustomMemCache(height:200, width:200)]
  final CustomMemCache memCache;

  /// Default value is [Boxfit.cover]
  final BoxFit boxFit;

  /// Image Size
  final Size? size;
  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null || url.isEmpty) return emptyWidget ?? const SizedBox();
    return CachedNetworkImage(
      imageUrl: url,
      memCacheHeight: memCache.height,
      fit: boxFit,
      width: size?.width,
      height: size?.height,
      errorListener: (value) {
        if (kDebugMode) debugPrint('Error: $value');
      },
      progressIndicatorBuilder: (context, url, progress) {
        return loadingWidget ??
            const Center(
              child: CircularProgressIndicator(),
            );
      },
      memCacheWidth: memCache.width,
      errorWidget: (context, url, error) {
        return emptyWidget ?? const SizedBox();
      },
    );
  }
}
