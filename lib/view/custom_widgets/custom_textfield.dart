

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextStyle? textStyle;
  final String? title;
  final String? helperText;
  final String? subtitle;
  final String? hint;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final int? maxLines;
  final bool expands;
  final bool readOnly;
  final void Function()? onTap;
  final double fontSize;
  final double maxHeight;
  final EdgeInsets? padding;
  final double? maxWidth;
  final TextInputAction? textInputAction;
  final void Function()? onSubmitted;
  final VoidCallback? onEditingComplete;
  final double? height;
  final double? width;
  final Color? textFieldBakcgroundColor;
  final Color? titleColor;
  final double? titleFontSize;
  final String? Function(String?)? validator;
  final String? Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool? obscureText;

  const CustomTextField({
    Key? key,
    this.title,
    this.subtitle,
    this.hint,
    this.suffixIcon,
    this.controller,
    this.inputType,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly = false,
    this.onTap,
    this.fontSize = 14,
    this.maxHeight = 250,
    this.padding,
    this.maxWidth ,
    this.textInputAction,
    this.onSubmitted,
    this.height,
    this.width, 
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.helperText,
    this.textStyle,
    this.textFieldBakcgroundColor,
    this.titleColor,
    this.titleFontSize,
    this.obscureText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth ?? double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if(title != null) Text(
                title!,
                style: TextStyle(
                  fontSize: titleFontSize ?? 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              if(subtitle != null) ...[
                SizedBox.square(dimension: 5,),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ],
          ),
                SizedBox.square(dimension: 5,),
          Flexible(
            child: Container(
              height: height,
              width: width,
              child: TextFormField(
                validator: validator,
                controller: controller,obscureText: obscureText ?? false,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500
                ),
                keyboardType: inputType,
                onSaved: onSaved,
                textInputAction: textInputAction,
                onEditingComplete: onSubmitted,
                maxLines: maxLines,
                expands: expands,
                readOnly: readOnly,
                onTap: onTap,
                decoration: InputDecoration(
                  helperText: helperText,
                  isDense: true,
                  filled: true,
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    color: Colors.grey
                  ),
                  suffixIcon: suffixIcon != null ? Icon(
                    suffixIcon,
                    size: 20,
                  ) : null,
                  contentPadding: padding ?? const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}