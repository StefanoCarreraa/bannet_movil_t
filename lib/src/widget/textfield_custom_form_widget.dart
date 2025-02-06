import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextfieldcustomFormWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final bool readOnly;
  final int? min;
  final int? max;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? fondoColor;
  final Color? labelColor;
  final Color? textColor;
  final FontWeight? labelFontWeight;

  const TextfieldcustomFormWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.readOnly = false,
    this.min,
    this.max,
    this.validator,
    this.borderColor,
    this.fondoColor,
    this.labelColor,
    this.textColor,
    this.labelFontWeight,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: fondoColor ?? Colors.white,
        border: Border.all(
          color: borderColor ?? AppColors.verdeLima,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: FormField<String>(
        validator: validator,
        initialValue: controller.text,
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                minLines: min,
                maxLines: max,
                controller: controller,
                readOnly: readOnly,
                onChanged: (value) {
                  state.didChange(value);
                  if (onChanged != null) onChanged!(value);
                  state.validate();
                },
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: labelColor ?? AppColors.verdeLima,
                    fontSize: 18,
                    fontWeight: labelFontWeight ?? FontWeight.w600,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: labelFontWeight ?? FontWeight.w600,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                  errorText: state.errorText,
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: labelFontWeight ?? FontWeight.w600,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
