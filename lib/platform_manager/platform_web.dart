import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

class PlatformManager {
  Future<Uint8List?> thumbnailDataWeb({
    required Uint8List videoBytes,
    num quality = 100,
  }) async {
    var thumbnailBytes = Uint8List(0);
    try {
      final blob = html.Blob([videoBytes], 'video/mp4');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final videoElement = html.VideoElement()
        ..src = url
        ..autoplay = false
        ..controls = false
        ..muted = true
        ..style.display = 'none';

      await videoElement.play();
      return Future.delayed(
        const Duration(seconds: 1),
        () async {
          videoElement.pause();
          final canvas = html.CanvasElement(
            width: videoElement.videoWidth,
            height: videoElement.videoHeight,
          );
          final context = canvas.context2D;
          context.drawImage(videoElement, 0, 0);
          final thumbnailUrl = canvas.toDataUrl('image/jpeg', quality);
          html.Url.revokeObjectUrl(url);

          // Convert data URL to bytes
          final byteString = thumbnailUrl.split(',').last;
          final bytes = base64.decode(byteString);
          thumbnailBytes = Uint8List.fromList(bytes);
          return thumbnailBytes;
        },
      );
    } catch (e) {
      throw Exception('Please Provide Valid Video Bytes as Uint8List: $e');
    }
  }
}
