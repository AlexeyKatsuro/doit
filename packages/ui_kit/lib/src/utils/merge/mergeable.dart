typedef MergeFunction<T> = T Function(T, T);

/// An interface that provides method for merging(inherit) values of properties
/// from one object to another.
/// See also: [MergedMaterialProperty]
abstract class Mergeable<T> {
  /// Whether null values are replaced with their value from an parent object.
  ///
  /// If this is false, [merge] method should return [other] object without merging
  bool get inherit;

  /// If [inherit] is true then returns a copy of [T] where the null fields in [other]
  /// have replaced/merged the corresponding non-null fields from `this` object.
  ///
  /// In other words, `this` object is used to fill in unspecified (null) fields
  /// in [other].
  ///
  /// Example of implementation
  /// ```dart
  /// SomeThemeData merge(SomeThemeData? other) {
  ///     // common boilerplate if statements
  ///     if (other == null || this == other) return this;
  ///     if (!other.inherit) return other;
  ///     /* As `margin` and `color` are simple objects that cannot merge with each other,
  ///     they simply replaced. But `textStyle` and `decoration` have many internal properties,
  ///     so they should be merged.*/
  ///     return copyWith(
  ///       margin: other.margin,
  ///       color: other.color,
  ///       textStyle: other.textStyle?.mergeTo(textStyle),
  ///       decoration: other.decoration?.mergeTo(decoration),
  ///     );
  ///   }
  /// ```
  T merge(T? other);
}

/// Extension methods for class that extend Mergeable interface
extension MergeToExt<T extends Mergeable<T>> on T {
  /// This method is similar to the [Mergeable.merge], but receiver and method argument is swapped.
  /// `parent.merge(child)` equals to `child.mergeTo(parent)`.
  ///
  /// This method just syntactic sugar for this case:
  ///
  /// Without mergeTo
  /// ```dart
  /// return copyWith(
  ///   textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
  /// );
  /// ```
  ///
  /// With mergeTo
  /// ```dart
  /// return copyWith(
  ///   textStyle: other.textStyle?.mergeTo(textStyle),
  /// );
  /// ```
  T mergeTo(T? parent) {
    if (parent == null) return this;
    return parent.merge(this);
  }
}
