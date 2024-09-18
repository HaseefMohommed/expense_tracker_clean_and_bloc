import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';

class AppDropDown<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Function(T) onSelect;
  final String Function(T) itemAsString;

  const AppDropDown({
    super.key,
    required this.items,
    required this.onSelect,
    required this.title,
    required this.itemAsString,
  });

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  late T _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSelectDialog(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: AppTheme.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.buttonBorderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.itemAsString(_selectedItem),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showSelectDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      color: AppTheme.buttonBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final isSelected = item == _selectedItem;
                      return ListTile(
                        title: Text(
                          widget.itemAsString(item),
                          style: isSelected
                              ? const TextStyle(
                                  color: AppTheme.primaryColor,
                                )
                              : null,
                        ),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: AppTheme.primaryColor,
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedItem = item;
                          });
                          widget.onSelect(item);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}