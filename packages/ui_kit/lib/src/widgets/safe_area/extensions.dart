extension NumExt<T extends num> on T {
  /// Ensures that this value lies in the specified range
  /// [minimumValue]..[maximumValue].
  T coerceIn(T minimumValue, [T? maximumValue]) {
    if (this < minimumValue) return minimumValue;
    if (maximumValue != null && this > maximumValue) return maximumValue;
    return this;
  }
}
