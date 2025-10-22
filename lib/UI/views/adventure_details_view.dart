import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../core/adventure_model.dart';
import '../../core/adventure_repo_implmnt.dart';
import '../../shared/locator.dart';
import '../../core/theme_colors.dart';
import 'item_selection_bottom_sheet.dart';
import 'checklist_view.dart';
import 'adventure_summary_view.dart';

class AdventureDetailsController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();

  // Reactive variables
  final currentPage = 0.obs;
  final adventureType = ''.obs;
  final members = ''.obs;
  final difficulty = ''.obs;
  final distance = ''.obs;
  final challenge = ''.obs;
  final weather = ''.obs;
  final isLoading = false.obs;
  final generatedItems = <String>[].obs;
  final selectedItems = <String>[].obs;

  // Repository
  AdventureRepository? _repository;
  AppColors? _colors;

  @override
  void onInit() {
    super.onInit();
    // Initialize repository immediately
    _initializeRepository();
  }

  void _initializeRepository() {
    try {
      _repository = Get.find<AdventureRepository>();
    } catch (e) {
      print('Error initializing repository from GetX: $e');
      // Fallback: create repository directly
      _repository = AdventureRepositoryImpl();
    }
  }

  // Get colors safely
  AppColors get colors {
    if (_colors == null) {
      _colors = AppColors.of(Get.context!);
    }
    return _colors!;
  }

  // Adventure types with icons
  final List<Map<String, String>> adventureTypes = [
    {'label': 'Hiking', 'icon': 'assets/icons/hiking.png'},
    {'label': 'Camping', 'icon': 'assets/icons/camping.png'},
    {'label': 'BikePacking', 'icon': 'assets/icons/bikepacking.png'},
    {'label': 'RoadTrip', 'icon': 'assets/icons/roadtrip.png'},
  ];

  final List<Map<String, String>> weatherConditions = [
    {'label': 'Sunny', 'icon': 'assets/icons/sunny.png'},
    {'label': 'Rainy', 'icon': 'assets/icons/rain.png'},
    {'label': 'Snowy', 'icon': 'assets/icons/snow.png'},
    {'label': 'Mixed/Unpredictable', 'icon': 'assets/icons/weather.png'},
  ];

  final List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];

  void nextPage() {
    if (currentPage.value < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void setAdventureType(String? type) {
    adventureType.value = type ?? '';
  }

  void setMembers(String value) {
    members.value = value;
  }

  void setDifficulty(String? value) {
    difficulty.value = value ?? '';
  }

  void setDistance(String value) {
    distance.value = value;
  }

  void setChallenge(String value) {
    challenge.value = value;
  }

  void setWeather(String? condition) {
    weather.value = condition ?? '';
  }

  bool get isFormValid {
    return adventureType.value.isNotEmpty &&
        members.value.isNotEmpty &&
        difficulty.value.isNotEmpty &&
        distance.value.isNotEmpty &&
        challenge.value.isNotEmpty &&
        weather.value.isNotEmpty;
  }

  Future<void> generateItems() async {
    if (_formKey.currentState!.validate() && isFormValid) {
      isLoading.value = true;

      try {
        // Check if repository is initialized
        if (_repository == null) {
          throw Exception('Repository not initialized');
        }

        // Create AdventureModel from form data
        final adventureModel = AdventureModel(
          type: adventureType.value,
          members: members.value,
          difficulty: difficulty.value,
          distance: distance.value,
          challenge: challenge.value,
          weather: weather.value,
        );

        print('Form Data: ${adventureModel.toJson()}');

        // Call AI repository
        final response = await _repository!.generateItems(adventureModel);

        print('AI Response: $response');

        // Parse the response into individual items
        final items = _parseGeneratedItems(response);
        generatedItems.value = items;

        print('Parsed Items: $items');

        // Show success message
        Get.snackbar(
          'Success!',
          'AI generated ${items.length} items for your adventure!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: colors.success,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Show bottom sheet with generated items
        _showItemSelectionBottomSheet();
      } catch (e) {
        print('Error in generateItems: $e');
        // Show error message
        Get.snackbar(
          'Error',
          'Failed to generate items. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: colors.error,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      print('Form validation failed. Form data:');
      print('Type: ${adventureType.value}');
      print('Members: ${members.value}');
      print('Difficulty: ${difficulty.value}');
      print('Distance: ${distance.value}');
      print('Challenge: ${challenge.value}');
      print('Weather: ${weather.value}');

      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: colors.error,
        colorText: Colors.white,
      );
    }
  }

  List<String> _parseGeneratedItems(String response) {
    // Remove common prefixes and clean the response
    String cleanResponse = response;

    // Remove common prefixes
    final prefixes = [
      'here is a list of essential items of',
      'here are the essential items for',
      'essential items for',
      'items needed for',
    ];

    for (final prefix in prefixes) {
      if (cleanResponse.toLowerCase().contains(prefix.toLowerCase())) {
        cleanResponse = cleanResponse
            .substring(
                cleanResponse.toLowerCase().indexOf(prefix.toLowerCase()) +
                    prefix.length)
            .trim();
      }
    }

    // Split by common separators and clean
    final separators = [' - ', ', ', ' and ', ' & '];
    List<String> items = [cleanResponse];

    for (final separator in separators) {
      items = items.expand((item) => item.split(separator)).toList();
    }

    // Clean and filter items
    return items
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty && item.length > 2)
        .toList();
  }

  void _showItemSelectionBottomSheet() {
    Get.bottomSheet(
      ItemSelectionBottomSheet(
        generatedItems: generatedItems,
        onItemsSelected: (selectedItems) {
          print('Items selected: $selectedItems');
          this.selectedItems.value = selectedItems;

          // Create adventure model from current form data
          final adventureModel = AdventureModel(
            type: adventureType.value,
            members: members.value,
            difficulty: difficulty.value,
            distance: distance.value,
            challenge: challenge.value,
            weather: weather.value,
          );

          print('Created adventure model: ${adventureModel.toJson()}');

          // Close the bottom sheet first
          Get.back();

          // Navigate to adventure summary view
          print('Navigating to AdventureSummaryView...');
          Get.to(() => AdventureSummaryView(
                adventure: adventureModel,
                selectedItems: selectedItems,
              ));
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}

class AdventureDetailsView extends GetView<AdventureDetailsController> {
  const AdventureDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFAF7F0), // very light beige
              Color(0xFFFEFDF9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Form Content
              Expanded(
                child: Form(
                  key: controller._formKey,
                  child: PageView(
                    controller: controller._pageController,
                    onPageChanged: (page) {
                      controller.currentPage.value = page;
                    },
                    children: [
                      _buildFirstPage(),
                      _buildSecondPage(),
                    ],
                  ),
                ),
              ),

              // Navigation and Generate Button
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Get.theme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Text(
            'Seraidi, Annaba',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: theme.textTheme.titleLarge?.color),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    final theme = Get.theme;
    final customColors = CustomColors.of(Get.context!);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with text and illustration
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Row(
              children: [
                // Left side - Welcome text
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plan Your\nAdventure',
                        style: TextStyle(
                          color: theme.textTheme.headlineLarge?.color,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Let\'s create the perfect\nequipment checklist for you',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color
                              ?.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                // Right side - Illustration
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/illustrations/lets_go_adventure.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Text(
            'What type of adventure?',
            style: TextStyle(
              color: theme.textTheme.headlineMedium?.color,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Adventure Type Selection as structured grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemCount: controller.adventureTypes.length,
            itemBuilder: (context, index) {
              final type = controller.adventureTypes[index];
              return Obx(() {
                final isSelected =
                    controller.adventureType.value == type['label'];
                return _selectionTile(
                  label: type['label']!,
                  icon: type['icon']!,
                  isSelected: isSelected,
                  onTap: () => controller
                      .setAdventureType(isSelected ? null : type['label']),
                );
              });
            },
          ),

          const SizedBox(height: 28),

          // Number of Members
          Text(
            'Number of Members',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color?.withOpacity(0.9),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => TextFormField(
                initialValue: controller.members.value,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.85),
                  labelText: 'Enter number of members',
                  labelStyle: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.3) ??
                            Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: customColors.success, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: controller.setMembers,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of members';
                  }
                  return null;
                },
              )),

          const SizedBox(height: 24),

          // Difficulty Level
          Text(
            'Difficulty Level',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.difficulty.value.isEmpty
                    ? null
                    : controller.difficulty.value,
                dropdownColor: theme.colorScheme.surface,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.85),
                  labelText: 'Select difficulty level',
                  labelStyle: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: customColors.success, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: theme.textTheme.bodyMedium?.color),
                items: controller.difficultyLevels
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level,
                              style: TextStyle(
                                  color: theme.textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.w400)),
                        ))
                    .toList(),
                onChanged: controller.setDifficulty,
                validator: (value) {
                  if (value == null) {
                    return 'Please select difficulty level';
                  }
                  return null;
                },
              )),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    final theme = Get.theme;
    final customColors = CustomColors.of(Get.context!);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'How far are you planning to\ntravel/walk?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.textTheme.headlineMedium?.color,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Distance
          Obx(() => TextFormField(
                initialValue: controller.distance.value,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.85),
                  labelText: 'Distance With Km',
                  labelStyle: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: customColors.success, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: controller.setDistance,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter distance';
                  }
                  return null;
                },
              )),

          const SizedBox(height: 24),

          // Challenge
          Text(
            'Do you have any specific requirements or challenges?',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => TextFormField(
                initialValue: controller.challenge.value,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.85),
                  labelText: 'Describe challenges',
                  labelStyle: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.2) ??
                            Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: customColors.success, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: controller.setChallenge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe any challenges';
                  }
                  return null;
                },
              )),

          const SizedBox(height: 28),

          // Weather Condition
          Text(
            'Expected weather condition',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Weather conditions as structured grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.0,
            ),
            itemCount: controller.weatherConditions.length,
            itemBuilder: (context, index) {
              final condition = controller.weatherConditions[index];
              return Obx(() {
                final isSelected =
                    controller.weather.value == condition['label'];
                return _selectionTile(
                  label: condition['label']!,
                  icon: condition['icon']!,
                  isSelected: isSelected,
                  onTap: () => controller
                      .setWeather(isSelected ? null : condition['label']),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    final theme = Get.theme;
    final customColors = CustomColors.of(Get.context!);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Page indicator
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == 0
                          ? customColors.success
                          : theme.textTheme.bodyMedium?.color?.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == 1
                          ? customColors.success
                          : theme.textTheme.bodyMedium?.color?.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),

          // Generate/Next Button
          Obx(() => SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : (controller.currentPage.value == 0
                          ? controller.nextPage
                          : controller.generateItems),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          controller.currentPage.value == 0
                              ? 'Next →'
                              : 'Start generating ⚡',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              )),
        ],
      ),
    );
  }

  // Reusable selection tile for a cleaner iOS-like appearance
  Widget _selectionTile({
    required String label,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
    double? width,
  }) {
    final theme = Get.theme;
    final customColors = CustomColors.of(Get.context!);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFDFF4D2) // pastel green when selected
              : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? customColors.success
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon.isNotEmpty)
              Image.asset(
                icon,
                height: 28,
                width: 28,
                fit: BoxFit.contain,
              ),
            if (icon.isNotEmpty && label.isNotEmpty) const SizedBox(height: 8),
            if (label.isNotEmpty)
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
