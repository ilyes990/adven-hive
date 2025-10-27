import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/model/adventure_model.dart';
import '../../core/theme_colors.dart';
import '../controller/adventure_storage_controller.dart';
import 'checklist_view.dart';

class AdventureSummaryView extends StatelessWidget {
  final AdventureModel adventure;
  final List<String> selectedItems;

  const AdventureSummaryView({
    super.key,
    required this.adventure,
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    print('AdventureSummaryView build called');
    print('Adventure: ${adventure.toJson()}');
    print('Selected items: $selectedItems');

    final theme = Theme.of(context);
    final colors = AppColors.of(context);
    final storageController = Get.find<AdventureStorageController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          'Adventure Summary',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adventure Header
            _buildAdventureHeader(theme, colors),
            const SizedBox(height: 24),

            // Adventure Details
            _buildAdventureDetails(theme, colors),
            const SizedBox(height: 24),

            // Selected Items Preview
            _buildItemsPreview(theme, colors),
            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(theme, colors, storageController),
          ],
        ),
      ),
    );
  }

  Widget _buildAdventureHeader(ThemeData theme, AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.surfaceVariant.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getAdventureIcon(adventure.type),
                color: colors.primary,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  adventure.generatedName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to save your adventure!',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdventureDetails(ThemeData theme, AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adventure Details',
            style: theme.textTheme.titleLarge?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Type', adventure.type, theme, colors),
          _buildDetailRow(
              'Members', '${adventure.members} people', theme, colors),
          _buildDetailRow('Difficulty', adventure.difficulty, theme, colors),
          _buildDetailRow(
              'Distance', '${adventure.distance} km', theme, colors),
          _buildDetailRow('Weather', adventure.weather, theme, colors),
          if (adventure.challenge.isNotEmpty)
            _buildDetailRow('Challenge', adventure.challenge, theme, colors),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      String label, String value, ThemeData theme, AppColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.surfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsPreview(ThemeData theme, AppColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Selected Items',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${selectedItems.length} items',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Show first 3 items with "and X more" if there are more
          if (selectedItems.isNotEmpty) ...[
            ...selectedItems.take(3).map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: colors.success,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            if (selectedItems.length > 3)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'and ${selectedItems.length - 3} more items...',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.surfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ] else
            Text(
              'No items selected',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.surfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme, AppColors colors,
      AdventureStorageController storageController) {
    return Column(
      children: [
        // Save Adventure Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _saveAdventure(storageController),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Obx(() => storageController.isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Save to My Adventures',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
          ),
        ),

        const SizedBox(height: 12),

        // View Checklist Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _viewChecklist(),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'View Full Checklist',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Edit Adventure Button
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Edit Adventure',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.surfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getAdventureIcon(String type) {
    switch (type.toLowerCase()) {
      case 'hiking':
        return Icons.hiking;
      case 'camping':
        return Icons.cabin;
      case 'bikepacking':
        return Icons.pedal_bike;
      case 'roadtrip':
        return Icons.directions_car;
      default:
        return Icons.explore;
    }
  }

  Future<void> _saveAdventure(
      AdventureStorageController storageController) async {
    try {
      // Create adventure with selected items
      final adventureWithItems = adventure.copyWith(
        selectedItems: selectedItems,
        status: 'active',
      );

      final success = await storageController.saveAdventure(adventureWithItems);

      if (success) {
        Get.snackbar(
          'Success!',
          'Adventure saved to My Adventures',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

        // Navigate to checklist view
        Get.offAll(() => const ChecklistView());
      } else {
        Get.snackbar(
          'Error',
          'Failed to save adventure',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error saving adventure: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _viewChecklist() {
    print('_viewChecklist called');
    print('Original adventure selectedItems: ${adventure.selectedItems}');
    print('Passed selectedItems: $selectedItems');

    // Create adventure with selected items
    final adventureWithItems = adventure.copyWith(
      selectedItems: selectedItems,
    );

    print(
        'Adventure with items selectedItems: ${adventureWithItems.selectedItems}');

    // Set the current adventure in the checklist controller
    final checklistController = Get.find<ChecklistController>();
    checklistController.setCurrentAdventure(adventureWithItems);

    // Navigate to checklist view
    Get.to(() => const ChecklistView());
  }
}
