import 'dart:math' as math;

extension ListExt<T> on List<T> {
  /// Pads this string on the right if it is shorter than [length].
  ///
  /// Returns a new list that appends [padding] after this list
  /// one time for each position the length is less than [length].
  ///
  /// If [length] is already smaller than or equal to `this.length`,
  /// no padding is added. A negative `width` is treated as zero.
  ///
  /// If [mutate] is false new instance of list will be created,
  /// otherwise previous list will returned.
  ///
  /// Example:
  /// ```dart
  ///   ['1','2'].padRight(4, '-'); //-> ['1','2', '-', '-']
  ///
  ///   ['1','2'].padRight(2, '-'); //-> ['1','2']
  ///
  ///   ['1','2'].padRight(1 '-'); //-> ['1','2']
  /// ```
  List<T> padRight(int length, T padding, {bool mutate = false}) {
    final int diff = math.max(math.max(length, 0) - this.length, 0);
    if (diff == 0) return this;
    if (mutate) {
      for (int i = 0; i < diff; i++) {
        add(padding);
      }
      return this;
    }
    return [
      ...this,
      for (int i = 0; i < diff; i++) padding,
    ];
  }
}