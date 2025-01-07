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
  });

  @override
  Widget build(BuildContext context) {
    final Color verdeLima = Color(0xFFA5CD39);
    final Color grisFondo = Color(0xFFF5F5F5);
    final Color grisOscuro = Color(0xFF333333);
    final Color negro = Color(0xFF000000);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: verdeLima,
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
                  labelStyle: const TextStyle(
                    color: Color(0xFFA5CD39),
                    fontSize: 18,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                  errorText: state.errorText,
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold, // Negrita
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
