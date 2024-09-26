// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/foundation.dart';
import 'package:flutter_video_thumbnail_plus/platform_manager/platform_mobile.dart'
    if (dart.library.html) 'package:flutter_video_thumbnail_plus/platform_manager/platform_web.dart'
    as platform;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_video_thumbnail_plus_platform_interface.dart';

/// A web implementation of the FlutterVideoThumbnailPlusPlatform of the FlutterVideoThumbnailPlus plugin.
class FlutterVideoThumbnailPlusWeb extends FlutterVideoThumbnailPlusPlatform {
  /// Constructs a FlutterVideoThumbnailPlusWeb
  FlutterVideoThumbnailPlusWeb();

  static void registerWith(Registrar registrar) {
    FlutterVideoThumbnailPlusPlatform.instance = FlutterVideoThumbnailPlusWeb();
  }

  @override
  Future<Uint8List?> thumbnailDataWeb({
    required Uint8List videoBytes,
    num quality = 100,
  }) async {
    return await platform.PlatformManager().thumbnailDataWeb(
      videoBytes: videoBytes,
      quality: quality,
    );
  }
}
