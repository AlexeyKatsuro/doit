import 'package:flutter/material.dart';

extension MergeInputDecorationExt on InputDecoration {
  InputDecoration merge(InputDecoration? other) {
    if (other == null) return this;
    return copyWith(
      icon: other.icon,
      iconColor: other.iconColor,
      label: other.label,
      labelText: other.labelText,
      labelStyle: other.labelStyle,
      floatingLabelStyle: other.floatingLabelStyle,
      helperText: other.helperText,
      helperStyle: other.helperStyle,
      helperMaxLines: other.helperMaxLines,
      hintText: other.hintText,
      hintStyle: other.hintStyle,
      hintTextDirection: other.hintTextDirection,
      hintMaxLines: other.hintMaxLines,
      errorText: other.errorText,
      errorStyle: other.errorStyle,
      errorMaxLines: other.errorMaxLines,
      floatingLabelBehavior: other.floatingLabelBehavior,
      floatingLabelAlignment: other.floatingLabelAlignment,
      isCollapsed: other.isCollapsed,
      isDense: other.isDense,
      contentPadding: other.contentPadding,
      prefixIcon: other.prefixIcon,
      prefix: other.prefix,
      prefixText: other.prefixText,
      prefixIconConstraints: other.prefixIconConstraints,
      prefixStyle: other.prefixStyle,
      prefixIconColor: other.prefixIconColor,
      suffixIcon: other.suffixIcon,
      suffix: other.suffix,
      suffixText: other.suffixText,
      suffixStyle: other.suffixStyle,
      suffixIconColor: other.suffixIconColor,
      suffixIconConstraints: other.suffixIconConstraints,
      counter: other.counter,
      counterText: other.counterText,
      counterStyle: other.counterStyle,
      filled: other.filled,
      fillColor: other.fillColor,
      focusColor: other.focusColor,
      hoverColor: other.hoverColor,
      errorBorder: other.errorBorder,
      focusedBorder: other.focusedBorder,
      focusedErrorBorder: other.focusedErrorBorder,
      disabledBorder: other.disabledBorder,
      enabledBorder: other.enabledBorder,
      border: other.border,
      enabled: other.enabled,
      semanticCounterText: other.semanticCounterText,
      alignLabelWithHint: other.alignLabelWithHint,
      constraints: other.constraints,
    );
  }

  InputDecoration mergeTo(InputDecoration? other) {
    if (other == null) return this;
    return other.merge(this);
  }
}

InputDecoration? mergeInputDecoration(InputDecoration? a, InputDecoration? b) => a?.merge(b) ?? b;
