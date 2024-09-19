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
  final bool isenableNumberPad;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final String? errorText;
  final ValueNotifier<bool> _obscureTextNotifier;

  AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.isObscureText = false,
    required this.controller,
    this.validator,
    this.errorText,
    this.prefixIcon,
    this.suffixIconVisible,
    this.suffixIconHidden,
    this.isenableNumberPad = false,
  }) : _obscureTextNotifier = ValueNotifier(isObscureText);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.white : Colors.black;
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, obscureText, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  labelText!,
                  style: TextStyle(
                    color: isDarkMode
                        ? AppTheme.secondaryPaleColor
                        : AppTheme.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppTheme.secondaryPaleColor,
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
                        child: SvgPicture.asset(
                          prefixIcon!,
                          colorFilter:
                              ColorFilter.mode(baseColor, BlendMode.srcIn),
                        ),
                      )
                    : null,
                suffixIcon: isObscureText
                    ? IconButton(
                        icon: obscureText
                            ? SvgPicture.asset(
                                suffixIconHidden ?? '',
                                colorFilter: ColorFilter.mode(
                                    baseColor, BlendMode.srcIn),
                              )
                            : SvgPicture.asset(
                                suffixIconVisible ?? '',
                                colorFilter: ColorFilter.mode(
                                    baseColor, BlendMode.srcIn),
                              ),
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
              autovalidateMode: AutovalidateMode.disabled,
              keyboardType:
                  isenableNumberPad ? TextInputType.number : TextInputType.text,
            ),
          ],
        );
      },
    );
  }
}
