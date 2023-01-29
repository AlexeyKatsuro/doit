import 'package:flutter/material.dart';
import 'package:test_ui_utils/src/test_goldens_group.dart';

/// A convenient widget to put together several appearance variants(Scenarios) for one widget
/// on one golden image.
/// The scenarios will be align in a column relative to each other.
///
/// See example:
/// ```dart
///   void main() {
///     testGoldensDarkLight(
///       description: 'Text appearance test',
///       name: 'text_appearance',
///       surfaceHeight: 200,
///       builder: () {
///         final builder = ScenarioBuilder()
///           ..addScenario(
///             'Scenario: regular text',
///             const Text('Text'),
///           )
///           ..addScenario(
///             'Scenario: bold text',
///             const Text('Text', style: TextStyle(fontWeight: FontWeight.bold)),
///           );
///
///         return builder.build();
///       },
///     );
///   }
/// ```
/// See [testGoldensDarkLight].
class ScenarioBuilder {
  ScenarioBuilder({
    Alignment alignment = Alignment.center,
    ValueBuilder<TextStyle> labelTextStyle = defaultLabelStyle,
    EdgeInsets edgePadding = EdgeInsets.zero,
    this.wrapWithScrollView = false,
    this.spaceBetweenScenarios = 16,
    this.title,
  })  : _alignment = alignment,
        _labelTextStyle = labelTextStyle,
        _edgePadding = edgePadding;

  static TextStyle defaultLabelStyle(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final color = isDark ? Colors.white : Colors.black;
    // inherit is false to avoid dependency on parent theme.
    return TextStyle(inherit: false, fontSize: 14, fontFamily: "Roboto", color: color);
  }

  /// If not null, builder draw this text at the top of layout.
  ///
  /// Null by default.
  final String? title;

  /// If true layout will wrapped with [SingleChildScrollView].
  ///
  /// False by default.
  ///
  /// Case for if you have large layout without parent [ScrollView].
  final bool wrapWithScrollView;

  /// Padding around all layout.
  ///
  /// Zero by default.
  final EdgeInsets _edgePadding;

  /// Alignment for child inside image surface.
  ///
  /// Default is [Alignment.center]
  final Alignment _alignment;

  ///  The Text style for label of Scenario name text.
  ///
  /// Default is [Colors.white] for dark mode and [Colors.black] for light mode.
  ///
  /// Note: dark of light mode depend on [MediaQueryData.platformBrightness].
  final ValueBuilder<TextStyle> _labelTextStyle;

  /// List of tests [scenarios]  being run within ScenarioBuilder
  final List<Widget> _scenarios = [];

  /// Amount of vertical spacing between scenarios.
  ///
  /// 16px by default.
  final double spaceBetweenScenarios;

  /// Add widget into ScenarioBuilder
  void addScenario(String name, Widget widget) {
    _scenarios.add(Scenario(
      name: name,
      widget: widget,
      labelStyle: _labelTextStyle,
    ));
  }

  void addWidget(Widget widget) {
    _scenarios.add(widget);
  }

  /// Build a list of [scenarios]  with a given layout and theme
  Widget build() {
    final divider = SizedBox(height: spaceBetweenScenarios);
    List<Widget> children = [];

    for (int index = 0; index < _scenarios.length; index++) {
      final child = _scenarios[index];
      final next = index + 1 < _scenarios.length ? _scenarios[index + 1] : null;
      children.add(child);
      if (next != null) {
        children.add(divider);
      }
    }

    if (title != null) {
      children = [
        Builder(builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  title!,
                  style: _labelTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }),
        ...children,
      ];
    }

    final layout = Padding(
      padding: _edgePadding,
      child: Align(
        alignment: _alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
    if (wrapWithScrollView) return SingleChildScrollView(child: layout);
    return layout;
  }
}

class Scenario extends StatelessWidget {
  const Scenario({
    Key? key,
    required this.name,
    required this.widget,
    required this.labelStyle,
  }) : super(key: key);

  final String name;
  final Widget widget;
  final ValueBuilder<TextStyle> labelStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (name.isNotEmpty) ...[
          Text(name, style: labelStyle(context)),
          const SizedBox(height: 8),
        ],
        widget,
      ],
    );
  }
}
