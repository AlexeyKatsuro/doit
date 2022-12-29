import 'package:flutter/material.dart' show BorderSide;

BorderSide? mergeBorderSide(BorderSide? a, BorderSide? b) {
  if (a != null && b != null) {
    return BorderSide.merge(a, b);
  }
  return a ?? b;
}

extension MergeBorderSideExt on BorderSide {
  BorderSide merge(BorderSide? other) {
    if (other == null) return this;
    return BorderSide.merge(this, other);
  }

  BorderSide mergeTo(BorderSide? other) {
    if (other == null) return this;
    return BorderSide.merge(other, this);
  }
}
