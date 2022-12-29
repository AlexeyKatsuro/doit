import 'package:flutter/rendering.dart';

extension MergeBoxDecorationExt on BoxDecoration {
  BoxDecoration merge(BoxDecoration? other) {
    if (other == null) return this;
    // Can't have a border radius if you're a circle.
    final borderRadius =
        other.shape != BoxShape.circle ? other.borderRadius ?? this.borderRadius : null;
    return BoxDecoration(
      color: other.color ?? color,
      image: other.image ?? image,
      border: other.border ?? border,
      borderRadius: borderRadius,
      boxShadow: other.boxShadow ?? boxShadow,
      gradient: other.gradient ?? gradient,
      backgroundBlendMode: other.backgroundBlendMode ?? backgroundBlendMode,
      shape: other.shape,
    );
  }

  BoxDecoration mergeTo(BoxDecoration? other) {
    if (other == null) return this;
    return other.merge(this);
  }
}

BoxDecoration? mergeBoxDecorations(BoxDecoration? a, BoxDecoration? b) => a?.merge(b) ?? b;
