import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';

extension FutureHandleError<T> on Future<T> {
  /* Future<T> handleErrors() async {
    try {
      return await this;
    } on DioError catch (error, stackTrace) {
      // Handle server error here
      if (error.type == DioErrorType.response) {
        String? message;
        var responseData = error.response?.data;
        if (responseData is Map) {
          message = responseData['error_message'] as String?;
        }
        return Error.throwWithStackTrace(UiMessage.text(message ?? error.message), stackTrace);
      }
      rethrow;
    } on AmplifyException catch (error, stackTrace) {
      return Error.throwWithStackTrace(UiMessage.text(error.message), stackTrace);
    } on PlatformException catch (error, stackTrace) {
      return Error.throwWithStackTrace(UiMessage.text(error.message), stackTrace);
    } on SmithyException catch (error, stackTrace) {
      return Error.throwWithStackTrace(UiMessage.text(error.message), stackTrace);
    } catch (error, stackTrace) {
      return Error.throwWithStackTrace(
        UiMessage.text(error.toString()),
        stackTrace,
      );
    }
  }*/
}

extension UiMessageExt on Object {
  UiMessage toUiMessage() {
    final error = this;
    if (error is BaseException && kDebugMode) return UiMessage.text(error.message ?? '$error');
    if (error is UiMessage) return error;
    if (error is AppLocalizationKeys) return UiMessage.key(error);
    if (error is String) return UiMessage.text(error);
    if (kDebugMode) return UiMessage.text(error.toString());
    return const UiMessage.key(AppLocalizationKeys.errorCommon);
  }
}
