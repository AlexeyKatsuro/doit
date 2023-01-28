import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:ui_kit/src/utils/index.dart';

/// Custom wrapper over material textFiled for future extension.
///
/// See: [TextField].
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required String? text,
    this.focusNode,
    InputDecoration? decoration,
    this.keyboardType,
    this.textInputAction,
    TextCapitalization? textCapitalization,
    this.style,
    this.strutStyle,
    TextAlign? textAlign,
    this.textAlignVertical,
    this.textDirection,
    bool? readOnly,
    this.toolbarOptions,
    this.showCursor,
    bool? autofocus,
    String? obscuringCharacter,
    bool? obscureText,
    bool? autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    bool? enableSuggestions,
    this.maxLines = 1,
    this.minLines,
    bool? expands,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    double? cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    ui.BoxHeightStyle? selectionHeightStyle,
    ui.BoxWidthStyle? selectionWidthStyle,
    this.keyboardAppearance,
    EdgeInsets? scrollPadding,
    DragStartBehavior? dragStartBehavior,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    Iterable<String>? autofillHints,
    Clip? clipBehavior,
    this.restorationId,
    bool? scribbleEnabled,
    bool? enableIMEPersonalizedLearning,
  })  : text = text ?? '',
        decoration = decoration ?? const InputDecoration(),
        textCapitalization = textCapitalization ?? TextCapitalization.none,
        textAlign = textAlign ?? TextAlign.start,
        readOnly = readOnly ?? false,
        autofocus = autofocus ?? false,
        obscuringCharacter = obscuringCharacter ?? '•',
        obscureText = obscureText ?? false,
        autocorrect = autocorrect ?? true,
        enableSuggestions = enableSuggestions ?? true,
        expands = expands ?? false,
        cursorWidth = cursorWidth ?? 2.0,
        selectionHeightStyle = selectionHeightStyle ?? ui.BoxHeightStyle.tight,
        selectionWidthStyle = selectionWidthStyle ?? ui.BoxWidthStyle.tight,
        scrollPadding = scrollPadding ?? const EdgeInsets.all(20.0),
        dragStartBehavior = dragStartBehavior ?? DragStartBehavior.start,
        autofillHints = autofillHints ?? const <String>[],
        clipBehavior = clipBehavior ?? Clip.hardEdge,
        scribbleEnabled = scribbleEnabled ?? true,
        enableIMEPersonalizedLearning = enableIMEPersonalizedLearning ?? true;

  final String text;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final _controller = TextEditingController(text: widget.text);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.setTextIfNew(widget.text);
    // AnimatedSize need to animated size when errorMessage appears.
    return AnimatedSize(
      duration: kThemeAnimationDuration,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      child: TextField(
        controller: _controller,
        focusNode: widget.focusNode,
        decoration: widget.decoration,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        autofocus: widget.autofocus,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableSuggestions: widget.enableSuggestions,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        readOnly: widget.readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: widget.showCursor,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectionControls: widget.selectionControls,
        dragStartBehavior: widget.dragStartBehavior,
        onTap: widget.onTap,
        mouseCursor: widget.mouseCursor,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        autofillHints: widget.autofillHints,
        clipBehavior: widget.clipBehavior,
        restorationId: widget.restorationId,
        scribbleEnabled: widget.scribbleEnabled,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      ),
    );
  }
}
