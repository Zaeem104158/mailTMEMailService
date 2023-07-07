import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/style.dart';

class PasswordTextFormFieldComponent extends StatefulWidget {
  final String? hint;
  final String? label;
  final TextInputAction? textInputAction;
  final Function(String? value) onChanged;

  final double? fontSize;
  final Color textFontColor;
  final String font;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final bool isFullValidate;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final InputBorder? inputDecorationBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const PasswordTextFormFieldComponent({
    Key? key,
    this.hint,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChanged,
    this.isFullValidate = true,
    this.fontSize = textSmallFontSize,
    this.font = latoFont,
    this.fontWeight = mediumFontWeight,
    this.textFontColor = kTextColor,
    this.prefixIconColor = kPrimaryColor,
    this.textInputAction = TextInputAction.done,
    this.inputDecorationBorder,
    this.floatingLabelBehavior,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DefaultPasswordTextFieldState createState() =>
      _DefaultPasswordTextFieldState();
}

class _DefaultPasswordTextFieldState
    extends State<PasswordTextFormFieldComponent> {
  bool _fieldVisibility = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Form(
        key: _formKey,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              widget.onChanged(value);
            } else {
              widget.onChanged(null);
            }
          },
          validator: (value) {
            var hintText = widget.hint ?? "";

            if (value == null || value.trim().isEmpty) {
              //return hintText + "empty_field_warning".tr();
            } else if (widget.isFullValidate) {
              if (value.length <= 7) {
                return "${hintText}max_length_warning";
              } else if (value.contains(" ")) {
                return "${hintText}can_not_contain_white_space";
              } else if (!passwordValidation(value)) {
                return "${hintText}special_char_warning";
              }
            }

            return null;
          },
          style: GoogleFonts.getFont(
            widget.font,
            fontWeight: widget.fontWeight,
            color: widget.textFontColor,
            fontSize: widget.fontSize,
          ),
          obscureText: _fieldVisibility,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hint ?? "",
            hintStyle: const TextStyle(
                color: kDisabledTextColor,
                fontFamily: latoFont,
                fontSize: textSmallFontSize),
            labelText: widget.label ?? "",
            labelStyle: const TextStyle(
                color: kTextColor,
                fontFamily: latoFont,
                fontSize: textSmallFontSize,
                fontWeight: FontWeight.normal),
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(6.0),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
            floatingLabelBehavior: widget.floatingLabelBehavior,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints:
                const BoxConstraints(minHeight: 16, minWidth: 48),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 16,
              minWidth: 48,
            ),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _fieldVisibility = !_fieldVisibility;
                  });
                },
                child: _fieldVisibility
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility)),
          ),
        ),
      ),
    );
  }

  bool passwordValidation(String password) {
    final digitReg = RegExp("[0-9]");
    final specialReg = RegExp("[!@#\$%&*()_+=|<>?{}\\[\\]~-]");

    final digitMatch = digitReg.hasMatch(password);
    final specialMatch = specialReg.hasMatch(password);
    return digitMatch && specialMatch;
  }
}
