import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isHint;
  final bool isPassword;
  final Widget? trailing;
  final bool readOnly;
  final String? heading;
  final String? instruction;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final IconData? leading;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.heading,
    this.instruction,
    this.leading,
    this.trailing,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.isHint = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading?.isNotEmpty ?? false) ...[
          Text(heading!),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          buildCounter:
              (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) => null,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          onTap: onTap,
          decoration: InputDecoration(
            isDense: true,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            filled: true,

            fillColor: Colors.white,
            prefixIcon: leading != null ? Icon(leading, size: 26) : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 48,
            ),
            suffixIcon: trailing,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 48,
            ),

            label: isHint
                ? null
                : Text(
                    label,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
            hint: isHint
                ? Text(
                    label,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  )
                : null,
          ),
        ),
        if (instruction?.isNotEmpty ?? false) ...[
          Text(instruction!),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
