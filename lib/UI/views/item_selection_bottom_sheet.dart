import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme_colors.dart';

class ItemSelectionBottomSheet extends StatefulWidget {
  final List<String> generatedItems;
  final Function(List<String>) onItemsSelected;

  const ItemSelectionBottomSheet({
    super.key,
    required this.generatedItems,
    required this.onItemsSelected,
  });

  @override
  State<ItemSelectionBottomSheet> createState() =>
      _ItemSelectionBottomSheetState();
}

class _ItemSelectionBottomSheetState extends State<ItemSelectionBottomSheet> {
  final List<String> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.checklist,
                  color: colors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Generated Items',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: colors.secondary,
                  ),
                ),
              ],
            ),
          ),

          // Selection Counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${_selectedItems.length} of ${widget.generatedItems.length} items selected',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.secondary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed:
                      _selectedItems.length == widget.generatedItems.length
                          ? _deselectAll
                          : _selectAll,
                  child: Text(
                    _selectedItems.length == widget.generatedItems.length
                        ? 'Deselect All'
                        : 'Select All',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Items List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: widget.generatedItems.length,
              itemBuilder: (context, index) {
                final item = widget.generatedItems[index];
                final isSelected = _selectedItems.contains(item);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.success.withOpacity(0.1)
                        : colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? colors.success
                          : colors.secondary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Checkbox(
                      value: isSelected,
                      onChanged: (value) => _toggleItem(item),
                      activeColor: colors.success,
                      checkColor: Colors.white,
                    ),
                    title: Text(
                      item,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isSelected
                            ? colors.primary
                            : theme.textTheme.bodyLarge?.color,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    onTap: () => _toggleItem(item),
                  ),
                );
              },
            ),
          ),

          // Submit Button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedItems.isNotEmpty
                      ? colors.success
                      : colors.secondary.withOpacity(0.3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _selectedItems.isNotEmpty ? _submitSelection : null,
                child: Text(
                  'Submit Selection (${_selectedItems.length})',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleItem(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
        Get.snackbar(
          'Removed',
          '$item removed from selection',
          backgroundColor: AppColors.of(Get.context!).secondary,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _selectedItems.add(item);
        Get.snackbar(
          'Added',
          '$item added to selection',
          backgroundColor: AppColors.of(Get.context!).success,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedItems.clear();
      _selectedItems.addAll(widget.generatedItems);
    });
    Get.snackbar(
      'Success',
      'All ${widget.generatedItems.length} items selected!',
      backgroundColor: AppColors.of(Get.context!).success,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );
  }

  void _deselectAll() {
    setState(() {
      _selectedItems.clear();
    });
    Get.snackbar(
      'Cleared',
      'All items deselected',
      backgroundColor: AppColors.of(Get.context!).secondary,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.TOP,
    );
  }

  void _submitSelection() {
    if (_selectedItems.isNotEmpty) {
      widget.onItemsSelected(_selectedItems);
      // Don't call Get.back() here - let the navigation handle it
      Get.snackbar(
        'Success',
        '${_selectedItems.length} items selected!',
        backgroundColor: AppColors.of(Get.context!).success,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please select at least one item',
        backgroundColor: AppColors.of(Get.context!).error,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
