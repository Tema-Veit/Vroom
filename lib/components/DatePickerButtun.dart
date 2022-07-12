import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final TextEditingController _controller;

  DatePickerField({
    Key? key,
    required this.label,
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
      mouseCursor: MaterialStateMouseCursor.clickable,
      onTap: () async {
        // Remove focus from the field.
        FocusScope.of(context).requestFocus(FocusNode());

        var selectedValue = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day + 14));

        if (selectedValue != null) {
          _controller.text =
              "${selectedValue.day}.${selectedValue.month}.${selectedValue.year}";
        }
      },
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
