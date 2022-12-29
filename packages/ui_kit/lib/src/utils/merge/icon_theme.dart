import 'package:flutter/widgets.dart';

extension MergeIconThemeDataExt on IconThemeData {
  IconThemeData mergeTo(IconThemeData? other) {
    if (other == null) return this;
    return other.merge(this);
  }
}

IconThemeData? mergeIconThemeData(IconThemeData? a, IconThemeData? b) => a?.merge(b) ?? b;
