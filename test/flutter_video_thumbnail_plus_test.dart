import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FakePlatform extends FlutterVideoThumbnailPlusPlatform
    with MockPlatformInterfaceMixin {
  String? fileResult = '/tmp/file.png';
  Uint8List? dataResult = Uint8List.fromList(<int>[9, 8, 7]);

  Map<String, dynamic>? lastFileArgs;
  Map<String, dynamic>? lastDataArgs;

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
  }) async {
    lastFileArgs = <String, dynamic>{
      'video': video,
      'headers': headers,
      'thumbnailPath': thumbnailPath,
      'imageFormat': imageFormat,
      'maxHeight': maxHeight,
      'maxWidth': maxWidth,
      'timeMs': timeMs,
      'quality': quality,
    };
    return fileResult;
  }

  @override
  Future<Uint8List?> thumbnailData({
    required String video,
    Map<String, String>? headers,
    ImageFormat imageFormat = ImageFormat.png,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) async {
    lastDataArgs = <String, dynamic>{
      'video': video,
      'headers': headers,
      'imageFormat': imageFormat,
      'maxHeight': maxHeight,
      'maxWidth': maxWidth,
      'timeMs': timeMs,
      'quality': quality,
    };
    return dataResult;
  }
}

void main() {
  late FlutterVideoThumbnailPlusPlatform originalInstance;
  late FakePlatform fakePlatform;

  setUp(() {
    originalInstance = FlutterVideoThumbnailPlusPlatform.instance;
    fakePlatform = FakePlatform();
    FlutterVideoThumbnailPlusPlatform.instance = fakePlatform;
  });

  tearDown(() {
    FlutterVideoThumbnailPlusPlatform.instance = originalInstance;
  });

  test('thumbnailFile forwards all arguments to platform instance', () async {
    final headers = <String, String>{'Authorization': 'token'};

    final result = await FlutterVideoThumbnailPlus.thumbnailFile(
      video: '/video.mp4',
      headers: headers,
      thumbnailPath: '/tmp/output.jpg',
      imageFormat: ImageFormat.webp,
      maxHeight: 720,
      maxWidth: 1280,
      timeMs: 2222,
      quality: 95,
    );

    expect(result, '/tmp/file.png');
    expect(fakePlatform.lastFileArgs, <String, dynamic>{
      'video': '/video.mp4',
      'headers': headers,
      'thumbnailPath': '/tmp/output.jpg',
      'imageFormat': ImageFormat.webp,
      'maxHeight': 720,
      'maxWidth': 1280,
      'timeMs': 2222,
      'quality': 95,
    });
  });

  test('thumbnailData forwards all arguments to platform instance', () async {
    final headers = <String, String>{'X-Test': '1'};

    final result = await FlutterVideoThumbnailPlus.thumbnailData(
      video: '/video.mov',
      headers: headers,
      imageFormat: ImageFormat.jpeg,
      maxHeight: 240,
      maxWidth: 320,
      timeMs: 1000,
      quality: 80,
    );

    expect(result, Uint8List.fromList(<int>[9, 8, 7]));
    expect(fakePlatform.lastDataArgs, <String, dynamic>{
      'video': '/video.mov',
      'headers': headers,
      'imageFormat': ImageFormat.jpeg,
      'maxHeight': 240,
      'maxWidth': 320,
      'timeMs': 1000,
      'quality': 80,
    });
  });

  test('thumbnailDataWeb throws on non-web runtime', () async {
    await expectLater(
      () => FlutterVideoThumbnailPlus.thumbnailDataWeb(
        videoBytes: Uint8List.fromList(<int>[1, 2, 3]),
      ),
      throwsA(isA<UnimplementedError>()),
    );
  });
}
