# Flutter Video Thumbnail Plus

A Flutter plugin for generating thumbnails from video files and byte arrays.

[![pub package](https://img.shields.io/pub/v/flutter_video_thumbnail_plus.svg)](https://pub.dev/packages/flutter_video_thumbnail_plus)
&nbsp;
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/rahulsaryam285/flutter_video_thumbnail_plus?tab=MIT-1-ov-file)
&nbsp; [![Example](https://img.shields.io/badge/Example-Ex-success)](https://pub.dev/packages/flutter_video_thumbnail_plus/example)

## Overview

This plugin provides a simple and efficient way to generate thumbnails from video files and byte arrays. It supports various image formats, including PNG, JPG, and WebP, and allows for customization of the thumbnail's size, quality, and timestamp.

## Features

- Generate thumbnails from video files and byte arrays (`Uint8List`)
- Support for PNG, JPG, and WebP image formats
- Customizable thumbnail size, quality, and timestamp
- Platform-specific implementations for optimal performance and compatibility
- Get thumbnail as a file path or `Uint8List`.

## Usage

### Add the plugin to your Flutter project

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_video_thumbnail_plus: ^1.0.1
```

Then, run `flutter pub get` to install the plugin.

## Generate a thumbnail from a video file

```dart
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';

Future<void> main() async {
  final videoPath = 'path/to/video.mp4';
  final thumbnailPath = 'path/to/thumbnail.png';

  final result = await FlutterVideoThumbnailPlus.thumbnailFile(
    video: videoPath,
    thumbnailPath: thumbnailPath,
    imageFormat: ImageFormat.png,
    maxHeight: 100,
    maxWidth: 100,
    timeMs: 1000,
    quality: 10,
  );

  if (result != null) {
    print('Thumbnail generated successfully: $result');
  } else {
    print('Failed to generate thumbnail');
  }
}
```

## Generate a thumbnail from a video byte array (Web only)

```dart
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';

Future<void> main() async {
  final videoBytes = Uint8List.fromList([/* video byte array */]);

  final result = await FlutterVideoThumbnailPlus.thumbnailDataWeb(
    videoBytes: videoBytes,
    quality: 100,
  );

  if (result != null) {
    print('Thumbnail generated successfully: $result');
  } else {
    print('Failed to generate thumbnail');
  }
}
```

## API Documentation

- `FlutterVideoThumbnailPlus.thumbnailFile`: Generates a thumbnail from a video file and saves it to a file.
- `FlutterVideoThumbnailPlus.thumbnailData`: Generates a thumbnail from a video file and returns the thumbnail data as a Uint8List.
- `FlutterVideoThumbnailPlus.thumbnailDataWeb`: Generates a thumbnail from a video byte array and returns the thumbnail data as a Uint8List (Web only).

## Example Use Cases

- Generating thumbnails for video playback in a Flutter app
- Creating a video gallery with thumbnails
- Sharing video thumbnails on social media

## Advanced usage

See the [example app](https://github.com/rahulsaryam285/flutter_video_thumbnail_plus) for a complete usage example.

## Author

**Rahul Saryam** ||
**Rajkumar Gahane**

<a href="https://github.com/rahulsaryam285/flutter_video_thumbnail_plus/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=rahulsaryam285/flutter_video_thumbnail_plus" />
</a>

## Support this project

Please ⭐️ this repository if this project helped you!

If you find any bugs or issues while using the plugin, please register an issues on GitHub. You can also contact us at rahulsaryam285@gmail.com and rajkumargahane2001@gmail.com.

## Contributing

Contributions are welcome! If you'd like to contribute to this plugin, please fork the repository and submit a pull request.
