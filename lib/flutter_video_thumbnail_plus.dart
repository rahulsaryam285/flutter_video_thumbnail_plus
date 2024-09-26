import 'dart:typed_data';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus_mobile_platform.dart'
    if (dart.library.html) 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus_web.dart'
    as platform;
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus_platform_interface.dart';

class FlutterVideoThumbnailPlus {
  FlutterVideoThumbnailPlus._();

  static FlutterVideoThumbnailPlusPlatform get _instance =>
      FlutterVideoThumbnailPlusPlatform.instance;

  static Future<String?> thumbnailFile({
    required String video,
    Map<String, String>? headers,
    String? thumbnailPath,
    ImageFormat imageFormat = ImageFormat.png,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) async =>
      await _instance.thumbnailFile(
        video: video,
        thumbnailPath: thumbnailPath,
        headers: headers,
        imageFormat: imageFormat,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        quality: quality,
        timeMs: timeMs,
      );

  static Future<Uint8List?> thumbnailData({
    required String video,
    Map<String, String>? headers,
    ImageFormat imageFormat = ImageFormat.png,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) async =>
      await _instance.thumbnailData(
        video: video,
        headers: headers,
        imageFormat: imageFormat,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        quality: quality,
        timeMs: timeMs,
      );

  static Future<Uint8List?> thumbnailDataWeb({
    required Uint8List videoBytes,
    num quality = 100,
  }) async =>
      await platform.FlutterVideoThumbnailPlusWeb().thumbnailDataWeb(
        videoBytes: videoBytes,
        quality: quality,
      );
}
