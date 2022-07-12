import 'package:flutter/material.dart';
import 'package:vroom/components/list_picker_dialog.dart';

class ListPickerField extends StatelessWidget {
  final String label;
  final List<String> items;
  final TextEditingController? controller;
  late final String? initialValue;
  final TextEditingController _controller;

  ListPickerField({
    Key? key,
    required this.label,
    required this.items,
    this.controller,
    this.initialValue,
  })  : assert(
          controller == null || initialValue == null,
          'Cannot provide both initialValue and controller.',
        ),
        _controller = controller ?? TextEditingController(text: initialValue),
        super(key: key);

  String get value => _controller.text;
  bool get empty => _controller.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: _controller,
      onTap: () async {
        // Remove focus from the field.
        FocusScope.of(context).requestFocus(FocusNode());

        String? selectedValue = await showDialog(
          context: context,
          builder: (context) => ListPickerDialog(
            label: label,
            items: items,
          ),
        );

        if (selectedValue != null) {
          _controller.text = selectedValue;
        }
      },
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
