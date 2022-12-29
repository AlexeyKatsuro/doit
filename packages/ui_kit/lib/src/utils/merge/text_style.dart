import 'package:flutter/material.dart' show TextStyle;

TextStyle? mergeTextStyle(TextStyle? a, TextStyle? b) => a?.merge(b) ?? b;

extension MergeTextStyleExt on TextStyle {
  TextStyle mergeTo(TextStyle? other) {
    if (other == null) return this;
    return other.merge(this);
  }
}
