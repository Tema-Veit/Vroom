import 'package:flutter/material.dart';

class ListPickerDialog extends StatefulWidget {
  final String label;
  final List<String> items;
  final double width;
  final double height;

  const ListPickerDialog({
    Key? key,
    required this.label,
    required this.items,
    this.width = 320.0,
    this.height = 450.0,
  })  : _scrollableHeight = (height - 100.0),
        super(key: key);

  final double? _scrollableHeight;

  @override
  State<ListPickerDialog> createState() => _ListPickerDialogState();
}

class _ListPickerDialogState extends State<ListPickerDialog> {
  late List<String> searchList = widget.items;

  void _onSearchChanged(String value) {
    value = value.toLowerCase().trim();
    setState(() {
      searchList = widget.items
          .where((item) => item.toLowerCase().contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(widget.label),
      content: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyText2,
                prefixIcon: const Icon(Icons.search, color: Colors.black45),
              ),
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchChanged,
            ),
            const Divider(),
            SizedBox(
              height: widget._scrollableHeight,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0.0),
                children: searchList.map((item) {
                  return ListTile(
                    title: Text(item),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    onTap: () => Navigator.of(context).pop(item),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
