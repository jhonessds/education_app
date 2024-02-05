import 'package:demo/core/common/actions/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.onTap,
    this.onTapOutside,
    this.onChange,
    this.keyboardType,
    this.formatter,
    this.maxlines,
    this.readOnly = false,
    this.withBorder = true,
    this.autoFocus = false,
    this.unfocus = false,
    this.floatingLabel,
    this.disabled = false,
    this.filled = true,
    this.fontSize = 18,
    this.mgLeft = 0,
    this.mgRight = 0,
    this.mgBottom = 0,
    this.mgTop = 0,
    this.pdLeft = 0,
    this.pdRight = 0,
    this.pdBottom = 0,
    this.pdTop = 0,
    this.borderRadius = 15,
    this.contentPaddingV = 0,
    this.contentPaddingH = 20,
    this.borderWidth = 1,
    this.width = double.infinity,
    this.fillColor,
    this.fontColor,
    this.borderColor = Colors.grey,
    this.labelColor,
    this.labelTextSize = 14,
    this.labelFontWeight,
    this.maxLength,
    this.sufixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.hintStyle,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final void Function()? onTapOutside;
  final List<TextInputFormatter>? formatter;
  final FloatingLabelBehavior? floatingLabel;
  final AutovalidateMode autovalidateMode;
  final TextInputType? keyboardType;
  final FontWeight? labelFontWeight;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? labelText;
  final double fontSize;
  final double mgLeft;
  final double mgRight;
  final double mgBottom;
  final double mgTop;
  final double pdLeft;
  final double pdRight;
  final double pdBottom;
  final double pdTop;
  final double borderRadius;
  final double borderWidth;
  final double contentPaddingV;
  final double contentPaddingH;
  final double width;
  final double labelTextSize;
  final bool readOnly;
  final bool filled;
  final bool withBorder;
  final bool disabled;
  final bool autoFocus;
  final bool obscureText;
  final bool unfocus;
  final int? maxlines;
  final int? maxLength;
  final Color? fontColor;
  final Color? fillColor;
  final Color borderColor;
  final Color? labelColor;
  final Widget? sufixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final borderSide = withBorder
        ? BorderSide(width: borderWidth, color: borderColor)
        : BorderSide.none;

    final border = OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );

    return Container(
      width: width,
      padding: EdgeInsets.only(
        left: pdLeft,
        right: pdRight,
        bottom: pdBottom,
        top: pdTop,
      ),
      margin: EdgeInsets.only(
        left: mgLeft,
        right: mgRight,
        bottom: mgBottom,
        top: mgTop,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: labelTextSize,
            fontWeight: labelFontWeight,
            color: labelColor,
          ),
          errorStyle: const TextStyle(height: 0.1, fontSize: 10),
          hintText: hintText,
          filled: filled,
          floatingLabelBehavior: floatingLabel,
          contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingH,
            vertical: contentPaddingV,
          ),
          hintStyle: hintStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
          fillColor: disabled ? null : fillColor,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: border.borderSide.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        onTapOutside: (_) {
          if (unfocus) {
            FocusScope.of(context).unfocus();
          }

          onTapOutside?.call();
        },
        controller: controller,
        validator: validator,
        autovalidateMode: autovalidateMode,
        inputFormatters: formatter,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
        ),
        keyboardType: keyboardType,
        textAlign: textAlign,
        autofocus: autoFocus,
        readOnly: readOnly,
        obscureText: obscureText,
        onTap: onTap,
        onChanged: onChange,
        maxLines: maxlines,
        maxLength: maxLength,
      ),
    );
  }
}

class InputValidator {
  static String confirmPasswordText = '';
  static String passwordText = '';
  static String emailText = '';
  static String name = '';

  static String? Function(String? t) emptyCheck(String msg) {
    return (t) {
      if (t == null || t.isEmpty) return msg;
      return null;
    };
  }

  static String? Function(String? t) emptyCheckLength(String msg, int lenght) {
    return (t) {
      if (t == null || t.isEmpty) return msg;
      if (t.length < lenght) return 'no mínimo $lenght caracteres';
      return null;
    };
  }

  static String? emailValidator(String? t) {
    if (t == null || t.isEmpty) return translation().provideAEmail;
    if (!RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    ).hasMatch(t)) return translation().invalidEmail;
    return null;
  }

  static String? passValidator(String? t) {
    if (t == null || t.isEmpty) return translation().enterAPassword;
    if (t.length < 8) {
      return translation().minimumEightCharacters;
    }
    return null;
  }

  static String? mobileValidator(String? t) {
    if (t == null || t.trim().isEmpty) {
      return translation().provideAPhoneNumber;
    }
    final temp = t.trim().replaceAll(RegExp('[^a-zA-Z0-9]'), '');
    if (temp.length < 11) return translation().invalidNumber;
    return null;
  }

  static String? phoneValidator(String? t) {
    if (t == null || t.trim().isEmpty) return null;
    final temp = t.trim().replaceAll(RegExp('[^a-zA-Z0-9]'), '');
    if (temp.length < 10) return translation().invalidNumber;
    return null;
  }
}
