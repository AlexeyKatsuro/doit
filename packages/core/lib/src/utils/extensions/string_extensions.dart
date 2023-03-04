extension StringExt on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}
