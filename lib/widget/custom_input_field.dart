import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscure,
          style: TextStyle(color: AppColors.cPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cSecondary,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: AppColors.cPrimary),
            prefixIcon: widget.prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(color: AppColors.cPrimary, size: 22),
                    child: widget.prefixIcon!,
                  )
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.cPrimary,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
