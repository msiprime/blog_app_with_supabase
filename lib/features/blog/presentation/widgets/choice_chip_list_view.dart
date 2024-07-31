import 'package:flutter/material.dart';

class FilterChipListView extends StatelessWidget {
  final List<String> chipLabels;
  final ValueNotifier<Set<String>> selectedLabelsNotifier;
  final ValueChanged<Set<String>> onSelected;
  final Color selectedColor;
  final Color selectedBorderColor;
  final Color unSelectedBorderColor;
  final Color? unselectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final double borderRadius;
  final double spacing;
  final bool showCheckmark;
  final Widget? avatar;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final ShapeBorder avatarShapeBorder;

  const FilterChipListView({
    super.key,
    required this.chipLabels,
    required this.selectedLabelsNotifier,
    required this.onSelected,
    this.selectedBorderColor = Colors.transparent,
    this.unSelectedBorderColor = const Color.fromRGBO(52, 51, 67, 1),
    this.selectedColor = const Color.fromRGBO(187, 63, 221, 1),
    this.unselectedColor,
    this.selectedTextStyle = const TextStyle(fontSize: 15),
    this.unselectedTextStyle = const TextStyle(fontSize: 15),
    this.borderRadius = 10.0,
    this.spacing = 10.0,
    this.showCheckmark = false,
    this.avatar,
    this.padding,
    this.visualDensity,
    this.avatarShapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ValueListenableBuilder<Set<String>>(
        valueListenable: selectedLabelsNotifier,
        builder: (context, selectedLabels, child) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: chipLabels.length,
            itemBuilder: (context, index) {
              final String label = chipLabels[index];
              final bool isSelected = selectedLabels.contains(label);
              return FilterChip(
                selectedColor: Colors.red,
                color: WidgetStatePropertyAll(
                  isSelected ? selectedColor : unselectedColor,
                ),
                elevation: 0,
                onSelected: (value) {
                  final newSelectedLabels = Set<String>.from(selectedLabels);
                  if (value) {
                    newSelectedLabels.add(label);
                  } else {
                    newSelectedLabels.remove(label);
                  }
                  selectedLabelsNotifier.value = newSelectedLabels;
                  onSelected(newSelectedLabels);
                },
                selected: isSelected,
                backgroundColor: isSelected ? selectedColor : unselectedColor,
                padding: padding,
                avatar: avatar,
                visualDensity: visualDensity,
                side: BorderSide(
                  color:
                      isSelected ? selectedBorderColor : unSelectedBorderColor,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isSelected
                        ? selectedBorderColor
                        : unSelectedBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                labelStyle:
                    isSelected ? selectedTextStyle : unselectedTextStyle,
                showCheckmark: showCheckmark,
                label: Text(label),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: spacing),
          );
        },
      ),
    );
  }
}
