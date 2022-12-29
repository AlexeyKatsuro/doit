import 'package:flutter/material.dart';

T lerpBinary<T>(T a, T b, double t) {
  return t < 0.5 ? a : b;
}

T lerpBinaryNotNull<T extends Object>(T? a, T? b, double t) {
  if (a == null && b == null) {
    throw ArgumentError('At least one value, a or b must not be null');
  }
  if (a == null) return b as T;
  if (b == null) return a;
  return t < 0.5 ? a : b;
}

typedef LerpFunction<T> = T Function(T, T, double);

/// Linearly interpolate between two generic MaterialStateProperty.
MaterialStateProperty<T?>? lerpProperties<T>(MaterialStateProperty<T>? a,
    MaterialStateProperty<T>? b, double t, T? Function(T?, T?, double) lerpFunction) {
  // Avoid creating a LerpProperties object for a common case.
  if (a == null && b == null) {
    return null;
  }
  return LerpProperties<T>(a, b, t, lerpFunction);
}

class LerpProperties<T> implements MaterialStateProperty<T?> {
  const LerpProperties(this.a, this.b, this.t, this.lerpFunction);

  final MaterialStateProperty<T>? a;
  final MaterialStateProperty<T>? b;
  final double t;
  final LerpFunction<T?> lerpFunction;

  @override
  T? resolve(Set<MaterialState> states) {
    final T? resolvedA = a?.resolve(states);
    final T? resolvedB = b?.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t);
  }
}

MaterialStateProperty<BorderSide?>? lerpSides(
  MaterialStateProperty<BorderSide?>? a,
  MaterialStateProperty<BorderSide?>? b,
  double t,
) {
  return lerpProperties<BorderSide?>(a, b, t, lerpBorderSize);
}

MaterialStateProperty<OutlinedBorder?>? lerpShapes(
  MaterialStateProperty<OutlinedBorder?>? a,
  MaterialStateProperty<OutlinedBorder?>? b,
  double t,
) {
  return lerpProperties<OutlinedBorder?>(a, b, t, lerpOutlineBorder);
}

// Remove when this will closed https://github.com/flutter/flutter/issues/60555
OutlinedBorder? lerpOutlineBorder(OutlinedBorder? a, OutlinedBorder? b, double t) {
  if (a == null && b == null) {
    return null;
  }
  return ShapeBorder.lerp(a, b, t) as OutlinedBorder?;
}

// Special case because BorderSide.lerp() doesn't support null arguments
BorderSide? lerpBorderSize(BorderSide? a, BorderSide? b, double t) {
  if (a == null && b == null) {
    return null;
  }
  if (a == null) {
    return BorderSide.lerp(BorderSide(width: 0, color: b!.color.withAlpha(0)), b, t);
  }
  if (b == null) {
    return BorderSide.lerp(a, BorderSide(width: 0, color: a.color.withAlpha(0)), t);
  }
  return BorderSide.lerp(a, b, t);
}
