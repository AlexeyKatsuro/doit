import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_goldens_group.dart';

class GoldensGroupConfig {
  const GoldensGroupConfig({
    this.autoHeight,
    this.surfaceSize,
    this.wrapper,
    this.background,
    this.foreground,
    this.alignment,
    this.brightnesses,
    this.debugPaintSizeEnabled,
    this.customPump,
    this.dateTime,
  });

  static const GoldensGroupConfig _configuration = GoldensGroupConfig();

  /// Applies a GoldenToolkitConfiguration to a block of code to effectively provide a scoped
  /// singleton. The configuration will apply to just the injected body function.
  ///
  /// In most cases, this can be applied in your flutter_test_config.dart to wrap every test in its own zone
  static T runWithConfig<T>(
    T Function() body, {
    required GoldensGroupConfig config,
  }) {
    return runZoned<T>(
      body,
      zoneValues: <dynamic, dynamic>{#test_ui_utils.config: config},
    );
  }

  /// reads the current configuration for based on the active zone, or else falls back to the global static state.
  static GoldensGroupConfig get config {
    return Zone.current[#test_ui_utils.config] as GoldensGroupConfig? ?? _configuration;
  }

  final bool? autoHeight;
  final Size? surfaceSize;
  final ThemeWrapper? wrapper;
  final ValueBuilder<Color?>? background;
  final ValueBuilder<Color?>? foreground;
  final Alignment? alignment;
  final Iterable<Brightness>? brightnesses;
  final bool? debugPaintSizeEnabled;
  final CustomPump? customPump;
  final DateTime? dateTime;

  GoldensGroupConfig mergeAll({
    bool? autoHeight,
    Size? surfaceSize,
    ThemeWrapper? wrapper,
    ValueBuilder<Color?>? background,
    ValueBuilder<Color?>? foreground,
    Alignment? alignment,
    Iterable<Brightness>? brightnesses,
    bool? debugPaintSizeEnabled,
    CustomPump? customPump,
    DateTime? dateTime,
  }) {
    return GoldensGroupConfig(
      autoHeight: autoHeight ?? this.autoHeight,
      surfaceSize: surfaceSize ?? this.surfaceSize,
      wrapper: wrapper ?? this.wrapper,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      alignment: alignment ?? this.alignment,
      brightnesses: brightnesses ?? this.brightnesses,
      debugPaintSizeEnabled: debugPaintSizeEnabled ?? this.debugPaintSizeEnabled,
      customPump: customPump ?? this.customPump,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  GoldensGroupConfig merge(GoldensGroupConfig? other) {
    if (other == null) return this;
    if (other is GoldensGroupConfigEffective) return other.mergeTo(this);
    return GoldensGroupConfig(
      autoHeight: other.autoHeight ?? autoHeight,
      surfaceSize: other.surfaceSize?.mergeTo(surfaceSize) ?? surfaceSize,
      wrapper: other.wrapper ?? wrapper,
      background: other.background ?? background,
      foreground: other.foreground ?? foreground,
      alignment: other.alignment ?? alignment,
      brightnesses: other.brightnesses ?? brightnesses,
      debugPaintSizeEnabled: other.debugPaintSizeEnabled ?? debugPaintSizeEnabled,
      customPump: other.customPump ?? customPump,
      dateTime: other.dateTime ?? dateTime,
    );
  }

  GoldensGroupConfig mergeTo(GoldensGroupConfig? parent) {
    if (parent == null) return this;
    return parent.merge(this);
  }
}

extension MergeSizeExt on Size {
  Size merge(Size? other) {
    if (other == null) return this;
    return Size(other.width.finiteOrNull ?? width, other.height.finiteOrNull ?? height);
  }

  Size mergeTo(Size? parent) {
    if (parent == null) return this;
    return parent.merge(this);
  }
}

extension on double {
  double? get finiteOrNull => isInfinite ? null : this;
}

class GoldensGroupConfigEffective extends GoldensGroupConfig {
  const GoldensGroupConfigEffective({
    required this.autoHeight,
    required this.surfaceSize,
    this.wrapper,
    required this.background,
    required this.foreground,
    required this.alignment,
    required this.brightnesses,
    required this.debugPaintSizeEnabled,
    this.customPump,
    this.dateTime,
  });

  @override
  final bool autoHeight;
  @override
  final Size surfaceSize;
  @override
  final ThemeWrapper? wrapper;
  @override
  final ValueBuilder<Color?> background;
  @override
  final ValueBuilder<Color?> foreground;
  @override
  final Alignment alignment;
  @override
  final Iterable<Brightness> brightnesses;
  @override
  final bool debugPaintSizeEnabled;
  @override
  final CustomPump? customPump;
  @override
  final DateTime? dateTime;

  @override
  GoldensGroupConfigEffective merge(GoldensGroupConfig? other) {
    if (other == null) return this;
    return GoldensGroupConfigEffective(
      autoHeight: other.autoHeight ?? autoHeight,
      surfaceSize: other.surfaceSize?.mergeTo(surfaceSize) ?? surfaceSize,
      wrapper: other.wrapper ?? wrapper,
      background: other.background ?? background,
      foreground: other.foreground ?? foreground,
      alignment: other.alignment ?? alignment,
      brightnesses: other.brightnesses ?? brightnesses,
      debugPaintSizeEnabled: other.debugPaintSizeEnabled ?? debugPaintSizeEnabled,
      customPump: other.customPump ?? customPump,
      dateTime: other.dateTime ?? dateTime,
    );
  }

  @override
  GoldensGroupConfigEffective mergeTo(GoldensGroupConfig? parent) {
    if (parent == null) return this;
    return GoldensGroupConfigEffective(
      autoHeight: autoHeight,
      surfaceSize: surfaceSize,
      wrapper: wrapper ?? parent.wrapper,
      background: background,
      foreground: foreground,
      alignment: alignment,
      brightnesses: brightnesses,
      debugPaintSizeEnabled: debugPaintSizeEnabled,
      customPump: customPump ?? parent.customPump,
      dateTime: dateTime ?? parent.dateTime,
    );
  }
}
