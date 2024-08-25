import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:svg_flutter/svg.dart';

class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool isObscureText;
  final String? prefixIcon;
  final String? suffixIconVisible;
  final String? suffixIconHidden;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;
  final ValueNotifier<bool> _obscureTextNotifier;

  AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.isObscureText = false,
    required this.controller,
    this.validator,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
    this.suffixIconVisible,
    this.suffixIconHidden,
  }) : _obscureTextNotifier = ValueNotifier(isObscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, obscureText, child) {
        return TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppTheme.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppTheme.buttonBorderColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: AppTheme.primaryColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(prefixIcon!),
                  )
                : null,
            suffixIcon: isObscureText
                ? IconButton(
                    icon: obscureText
                        ? SvgPicture.asset(suffixIconHidden ?? '')
                        : SvgPicture.asset(suffixIconVisible ?? ''),
                    onPressed: () {
                      _obscureTextNotifier.value = !obscureText;
                    },
                  )
                : (suffixIconVisible != null
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(suffixIconVisible!),
                      )
                    : null),
            errorMaxLines: 2,
            errorText: errorText,
          ),
          obscureText: obscureText,
          validator: validator,
        );
      },
    );
  }
}
