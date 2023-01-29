/// Top level function with empty body. Used to provide fallback callback for Buttons
/// widget in tests to be able use const constructor.
///
/// Example:
///
/// ```dart
/// const AppButton(
///   child: Text('Button'),
///   onPressed: emptyOnPressed,
/// ),
/// ```
void emptyOnPressed() {}
