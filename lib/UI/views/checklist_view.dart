import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme_colors.dart';
import '../../core/routes.dart';
import '../../core/adventure_model.dart';
import '../controller/adventure_storage_controller.dart';

class ChecklistController extends GetxController {
  final selectedItems = <String>[].obs;
  final packedItems = <String>[].obs;
  final currentAdventure = Rxn<AdventureModel>();

  void setSelectedItems(List<String> items) {
    selectedItems.value = items;
  }

  void setCurrentAdventure(AdventureModel adventure) {
    print('Setting current adventure: ${adventure.toJson()}');
    print('Selected items: ${adventure.selectedItems}');

    currentAdventure.value = adventure;
    selectedItems.value = adventure.selectedItems;

    // Initialize packed items from adventure
    packedItems.value = adventure.packedItems.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    print('Controller selectedItems: ${selectedItems.value}');
    print('Controller packedItems: ${packedItems.value}');
  }

  void togglePackedStatus(String item) {
    if (packedItems.contains(item)) {
      packedItems.remove(item);
      Get.snackbar(
        'Unpacked',
        '$item marked as unpacked',
        backgroundColor: AppColors.of(Get.context!).secondary,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      packedItems.add(item);
      Get.snackbar(
        'Packed',
        '$item marked as packed',
        backgroundColor: AppColors.of(Get.context!).success,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );

      // Check if all items are packed
      if (packedItems.length == selectedItems.length &&
          selectedItems.isNotEmpty) {
        _showCompletionDialog();
      }
    }

    // Save changes to storage if we have a current adventure
    _savePackedStatus();
  }

  void _savePackedStatus() {
    if (currentAdventure.value != null) {
      final storageController = Get.find<AdventureStorageController>();

      // Create updated packed items map
      final updatedPackedItems = <String, bool>{};
      for (final item in selectedItems) {
        updatedPackedItems[item] = packedItems.contains(item);
      }

      // Update adventure with new packed status
      final updatedAdventure = currentAdventure.value!.copyWith(
        packedItems: updatedPackedItems,
        status:
            packedItems.length == selectedItems.length ? 'completed' : 'active',
      );

      // Save to storage
      storageController.updateAdventure(updatedAdventure);
    }
  }

  void _showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.of(Get.context!).success,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text('Adventure Ready!'),
          ],
        ),
        content:
            const Text('All items packed! You\'re ready for your adventure!'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void clearChecklist() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Checklist'),
        content: const Text(
            'Are you sure you want to clear your current checklist?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              selectedItems.clear();
              packedItems.clear();
              Get.back();
              Get.offAllNamed('/home');
              Get.snackbar(
                'Cleared',
                'Checklist cleared successfully',
                backgroundColor: AppColors.of(Get.context!).secondary,
                colorText: Colors.white,
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void startNewAdventure() {
    Get.dialog(
      AlertDialog(
        title: const Text('Start New Adventure'),
        content: const Text(
            'Are you sure you want to start a new adventure? This will clear your current checklist.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              selectedItems.clear();
              packedItems.clear();
              Get.back();
              Get.offAllNamed('/adventure-details');
              Get.snackbar(
                'New Adventure',
                'Starting new adventure...',
                backgroundColor: AppColors.of(Get.context!).success,
                colorText: Colors.white,
              );
            },
            child: const Text('Start New'),
          ),
        ],
      ),
    );
  }
}

class ChecklistView extends GetView<ChecklistController> {
  const ChecklistView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          'Your Adventure Checklist',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.clearChecklist,
            icon: Icon(Icons.clear, color: colors.secondary),
            tooltip: 'Clear Checklist',
          ),
        ],
      ),
      body: Obx(() {
        print(
            'ChecklistView build - selectedItems: ${controller.selectedItems.value}');
        print(
            'ChecklistView build - packedItems: ${controller.packedItems.value}');

        // If no items, try to get them from current adventure
        if (controller.selectedItems.isEmpty &&
            controller.currentAdventure.value != null) {
          print(
              'No selected items, but have current adventure, setting items...');
          controller.selectedItems.value =
              controller.currentAdventure.value!.selectedItems;
        }

        if (controller.selectedItems.isEmpty) {
          print('Showing empty state - no selected items');
          return _buildEmptyState();
        }

        return Column(
          children: [
            _buildProgressHeader(),
            Expanded(
              child: _buildItemsList(),
            ),
            _buildActionButtons(),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    final theme = Get.theme;
    final colors = AppColors.of(Get.context!);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.checklist_outlined,
                  size: 80,
                  color: colors.secondary,
                ),
                const SizedBox(height: 20),
                Text(
                  'No Checklist Yet',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Start by creating an adventure to generate your checklist',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed('/adventure-details'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.success,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Start New Adventure'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    final theme = Get.theme;
    final colors = AppColors.of(Get.context!);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: colors.success,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Packing Progress',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Obx(() => Text(
                    '${controller.packedItems.length}/${controller.selectedItems.length}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() => LinearProgressIndicator(
                value: controller.selectedItems.isEmpty
                    ? 0
                    : controller.packedItems.length /
                        controller.selectedItems.length,
                backgroundColor: colors.secondary.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(colors.success),
              )),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    final theme = Get.theme;
    final colors = AppColors.of(Get.context!);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: controller.selectedItems.length,
      itemBuilder: (context, index) {
        final item = controller.selectedItems[index];
        final isPacked = controller.packedItems.contains(item);

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isPacked ? colors.success.withOpacity(0.1) : colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isPacked ? colors.success : colors.secondary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Checkbox(
              value: isPacked,
              onChanged: (value) => controller.togglePackedStatus(item),
              activeColor: colors.success,
              checkColor: Colors.white,
            ),
            title: Text(
              item,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isPacked
                    ? colors.primary
                    : theme.textTheme.bodyLarge?.color,
                fontWeight: isPacked ? FontWeight.w600 : FontWeight.normal,
                decoration: isPacked ? TextDecoration.lineThrough : null,
              ),
            ),
            onTap: () => controller.togglePackedStatus(item),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    final colors = AppColors.of(Get.context!);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.secondary,
                side: BorderSide(color: colors.secondary),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Edit Selection'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.startNewAdventure,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('New Adventure'),
            ),
          ),
        ],
      ),
    );
  }
}
