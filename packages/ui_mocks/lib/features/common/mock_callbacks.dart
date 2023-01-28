import 'dart:core';

import 'package:flutter/foundation.dart';


abstract class MockCallbacks {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    String name(Symbol s) => '$s'.replaceAll('Symbol', '');
    debugPrint('$runtimeType: ${name(invocation.memberName)}');

    if (invocation.namedArguments.isNotEmpty) {
      debugPrint(invocation.namedArguments.entries.map((e) => '${e.key}: ${e.value}').join('\n'));
    }
    if (invocation.positionalArguments.isNotEmpty) {
      debugPrint(invocation.positionalArguments.join('\n'));
    }
    return;
  }
}
