import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_video_thumbnail_plus/enum.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus_method_channel.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class ExtendsPlatform extends FlutterVideoThumbnailPlusPlatform
    with MockPlatformInterfaceMixin {}

class BaseOnlyPlatform extends FlutterVideoThumbnailPlusPlatform
    with MockPlatformInterfaceMixin {}

class ImplementsPlatform implements FlutterVideoThumbnailPlusPlatform {
  @override
  Future<Uint8List?> thumbnailData({
    required String video,
    Map<String, String>? headers,
    ImageFormat imageFormat = ImageFormat.png,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) async =>
      null;

  @override
  Future<Uint8List?> thumbnailDataWeb({
    required Uint8List videoBytes,
    num quality = 100,
  }) async =>
      null;

  @override
  Future<String?> thumbnailFile({
    required String video,
    Map<String, String>? headers,
    String? thumbnailPath,
    ImageFormat imageFormat = ImageFormat.png,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) async =>
      null;
}

void main() {
  test('default instance is method channel implementation', () {
    expect(
      FlutterVideoThumbnailPlusPlatform.instance,
      isA<MethodChannelFlutterVideoThumbnailPlus>(),
    );
  });

  test('allows setting a proper platform implementation', () {
    final original = FlutterVideoThumbnailPlusPlatform.instance;
    final platform = ExtendsPlatform();

    FlutterVideoThumbnailPlusPlatform.instance = platform;

    expect(FlutterVideoThumbnailPlusPlatform.instance, same(platform));
    FlutterVideoThumbnailPlusPlatform.instance = original;
  });

  test('rejects implementations that do not extend base class', () {
    expect(
      () => FlutterVideoThumbnailPlusPlatform.instance = ImplementsPlatform(),
      throwsA(isA<AssertionError>()),
    );
  });

  group('default methods', () {
    late BaseOnlyPlatform baseOnlyPlatform;

    setUp(() {
      baseOnlyPlatform = BaseOnlyPlatform();
    });

    test('thumbnailFile throws UnimplementedError', () async {
      await expectLater(
        () => baseOnlyPlatform.thumbnailFile(video: '/video.mp4'),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('thumbnailData throws UnimplementedError', () async {
      await expectLater(
        () => baseOnlyPlatform.thumbnailData(video: '/video.mp4'),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('thumbnailDataWeb throws UnimplementedError', () async {
      await expectLater(
        () => baseOnlyPlatform.thumbnailDataWeb(
          videoBytes: Uint8List.fromList(<int>[1, 2, 3]),
        ),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
