import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resource/app_text_styles.dart';
import '../space_box.dart';

class InputTextArea extends StatefulWidget {
  const InputTextArea({
    this.title,
    this.secondTitle,
    this.initialText,
    this.hintText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.textAlign,
    this.maxLength,
    this.obSecureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.isDanger = false,
    this.isCounterText = false,
    this.inputFormatters,
    this.textInputAction = TextInputAction.none,
    Key? key,
  }) : super(key: key);

  /// Title of text area
  final String? title;

  /// Second Title of text area
  final String? secondTitle;

  /// Initial of text area
  final String? initialText;

  /// Hint Text
  final String? hintText;

  /// Error Text
  final String? errorText;

  /// Controller
  final TextEditingController? controller;

  /// Text has been changed
  final ValueChanged<String>? onChanged;

  /// Text Align
  final TextAlign? textAlign;

  /// Max Length
  final int? maxLength;

  /// Secure Text - default false
  final bool obSecureText;

  /// TextCapitalization default `TextCapitalization.none`
  final TextCapitalization textCapitalization;

  /// Text Input Type for Key board
  final TextInputType? textInputType;

  /// Dangerous - Error Text
  final bool isDanger;

  /// Counter Text is enabled or not
  final bool isCounterText;

  ///
  final List<TextInputFormatter>? inputFormatters;

  /// Text Input Action
  final TextInputAction textInputAction;

  @override
  InputTextAreaState createState() => InputTextAreaState();
}

class InputTextAreaState extends State<InputTextArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  widget.title ?? '',
                  style: AppTextStyles.fontPoppinsRegular14
                      .copyWith(color: Colors.black26),
                ),
                if (widget.secondTitle != null)
                  Text(
                    widget.secondTitle ?? '',
                    style: AppTextStyles.fontPoppinsRegular14
                        .copyWith(color: Colors.black26),
                  ),
              ],
            ),
          ),
          const SpaceBox.height(5),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white54,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: TextFormField(
              onChanged: widget.onChanged,
              maxLength: widget.maxLength,
              obscureText: widget.obSecureText,
              maxLines: 1,
              obscuringCharacter: '●',
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                counterText: '',
              ),
              inputFormatters: widget.inputFormatters,
            ),
          ),
        )
      ],
    );
  }
}
