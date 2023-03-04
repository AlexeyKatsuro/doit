extension RequireNotNullExt<T extends Object> on T? {
  /// Just a shortcut for [ArgumentError.checkNotNull].
  ///
  /// The benefit of this function over the simple `!` operator (Casting away nullability) that
  /// this method will throw an error, which signals to developer about the incompleteness of the data.
  ///
  /// While, Null Pointer Exception from `!` operator, won't be clear whether this is a data error or code error during processing this data.
  T requireNotNull([String? name]) => ArgumentError.checkNotNull(this, name);
}
