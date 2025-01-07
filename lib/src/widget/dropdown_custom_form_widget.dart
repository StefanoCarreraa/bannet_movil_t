import 'package:flutter/material.dart';

class DropdowncustomFormWidget<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final String Function(T) itemLabel;
  final bool enabled;
  final String? Function(T?)? validator;
  final GlobalKey<FormFieldState>? formFieldKey;

  const DropdowncustomFormWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemLabel,
    this.enabled = true,
    this.validator,
    this.formFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveValue = items.contains(value) ? value : null;

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
      child: DropdownButtonFormField<T>(
        key: formFieldKey,
        value: effectiveValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? verdeLima : Colors.grey,
            fontSize: 18,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        dropdownColor: Colors.white,
        hint: Text(
          hint,
          style: TextStyle(
            color: enabled
                ? Colors.black.withOpacity(0.7)
                : Colors.grey.withOpacity(0.5),
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: enabled ? Colors.black : Colors.grey,
        ),
        style: TextStyle(
          color: enabled ? Colors.black : Colors.grey,
          fontSize: 18,
        ),
        items: enabled
            ? items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabel(item)),
                );
              }).toList()
            : null,
        onChanged: enabled
            ? (T? newValue) {
                if (formFieldKey?.currentState?.validate() ?? false) {
                  // Solo cambia el valor si la validación fue exitosa
                  onChanged(newValue);
                }
              }
            : null,
        validator: validator, // El mensaje se actualizará automáticamente
      ),
    );
  }
}
