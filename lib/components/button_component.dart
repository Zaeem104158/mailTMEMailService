import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/style.dart';

class ButtonComponent extends StatelessWidget {
  final String? text;
  final String font;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsets padding;
  final EdgeInsets stylePadding;
  final bool isLocalAssetSvg;
  final bool isTranslate;
  final String? prefixImageUrl;
  final Icon? prefixIcon;
  final Size? minimumSize;
  final Color? buttonColor;
  final BorderSide? borderSide;
  final double? elevation;
  final double borderRadius;
  final FontWeight? fontWeight;
  final double? prefixIconWidth;
  final VoidCallback? onPressed;
  final Color borderColor;

  const ButtonComponent({
    Key? key,
    this.text,
    this.borderSide,
    this.prefixIcon,
    this.prefixImageUrl,
    this.elevation = 0.8,
    this.font = latoFont,
    this.borderRadius = 100,
    this.isTranslate = true,
    required this.onPressed,
    this.prefixIconWidth = 30,
    this.minimumSize = Size.zero,
    this.isLocalAssetSvg = false,
    this.width = double.infinity,
    this.textColor = Colors.white,
    this.buttonColor = kPrimaryColor,
    this.fontWeight = mediumFontWeight,
    this.fontSize = buttonTextFontSize,
    this.borderColor = kPrimaryColor,
    this.padding = const EdgeInsets.fromLTRB(
      48,
      24,
      48,
      24,
    ),
    this.stylePadding = const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 11.5,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        child: (prefixImageUrl != null || prefixIcon != null)
            ? ElevatedButton.icon(
                icon: _getPrefixIcon(),
                label: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    isTranslate ? text ?? "" : text ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: textColor,
                  backgroundColor: buttonColor,
                  elevation: elevation,
                  shape: borderSide != null
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          side: borderSide!,
                        )
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                  padding: stylePadding,
                  textStyle: GoogleFonts.getFont(
                    font,
                    fontWeight: fontWeight,
                    color: textColor,
                    fontSize: fontSize,
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: textColor,
                  backgroundColor: buttonColor,
                  elevation: elevation,
                  minimumSize: minimumSize,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  padding: stylePadding,
                  textStyle: GoogleFonts.getFont(
                    font,
                    fontWeight: fontWeight,
                    color: textColor,
                    fontSize: fontSize,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    isTranslate ? text ?? "" : text ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _getPrefixIcon() {
    if (prefixIcon != null) {
      return prefixIcon!;
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          right: 16,
        ),
        child: isLocalAssetSvg
            ? Image.asset(
                prefixImageUrl!,
                width: prefixIconWidth,
              )
            : Image.asset(
                prefixImageUrl!,
                width: prefixIconWidth,
              ),
      );
    }
  }
}
