import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Allow you use full path of assets inside [Image.network] as url.
///
/// Usage example:
/// ```dart
/// setUpAll(() {
///   useAssetHttpClient();
/// });
///
/// ...
/// await tester.pumpWidgetBuilder(
///   Image.network('packages/${packageName}/assets/image_name.png'),
/// );
/// ...
///
/// ```
///
/// See also: [mockNetworkImagesFor].
void useAssetHttpClient({Map<String, String> urlToAssetPath = const {}}) {
  HttpOverrides.global = MockHttpOverrides(urlToAssetPath: urlToAssetPath);
}

class MockHttpOverrides extends HttpOverrides {
  MockHttpOverrides({Map<String, String> urlToAssetPath = const {}}) {
    if (_currentUrlToAssetPath == null && urlToAssetPath.isNotEmpty) {
      _globalUrlToAssetPath.addAll(urlToAssetPath);
    }
  }

  static final Map<String, String> _globalUrlToAssetPath = {};

  static Map<String, String> get _inheritedUrlToAssetPath {
    return {
      ..._globalUrlToAssetPath,
      ...?(Zone.current[#UrlToAssetPath] as Map<String, String>?),
    };
  }

  static Map<String, String>? get _currentUrlToAssetPath =>
      Zone.current[#UrlToAssetPath] as Map<String, String>?;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return MockHttpClient();
  }
}

/// Runs [body] in separate [Zone] with [MockHttpClient].
R mockNetworkImagesFor<R>(
  R Function() body, {
  Map<String, String> urlToAssetPath = const {},
}) {
  return runZoned(() {
    return HttpOverrides.runWithHttpOverrides(
        body, MockHttpOverrides(urlToAssetPath: urlToAssetPath));
  }, zoneValues: {
    #UrlToAssetPath: urlToAssetPath,
  });
}

class MockHttpClient implements HttpClient {
  Map<String, String> get urlToAssetPath => MockHttpOverrides._inheritedUrlToAssetPath;

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  bool autoUncompress = true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<HttpClientRequest> getUrl(Uri requestedUrl) async {
    final urlString = requestedUrl.toString();
    final intercepted = urlToAssetPath[urlString];
    if (intercepted == null && requestedUrl.host.isNotEmpty) {
      return MockHttpClientRequest(assetImage: _transparentImage);
    }

    final directory = '${Directory.current.path}/';
    final path = intercepted ?? requestedUrl.path.replaceFirst(directory, '');
    final assetImage = await rootBundle.load(path).then((data) {
      // ignore: unnecessary_cast
      return data.buffer.asInt8List() as List<int>;
    }).catchError((Object error, StackTrace stackTrace) {
      debugPrint('directory: $directory');
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stackTrace);
      return _transparentImage;
    });
    return MockHttpClientRequest(assetImage: assetImage);
  }
}

class MockHttpClientRequest implements HttpClientRequest {
  MockHttpClientRequest({required this.assetImage});

  final List<int> assetImage;

  @override
  HttpHeaders get headers => MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => MockHttpClientResponse(assetImage);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockHttpClientResponse implements HttpClientResponse {
  MockHttpClientResponse(this.asset);

  final List<int> asset;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  int get contentLength => asset.length;

  @override
  int get statusCode => HttpStatus.ok;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      Stream<List<int>>.value(asset).listen(
        onData,
        onDone: onDone,
        onError: onError,
        cancelOnError: cancelOnError,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockHttpHeaders implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const List<int> _transparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
];
