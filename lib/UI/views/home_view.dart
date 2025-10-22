import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes.dart';
import '../../main.dart';
import '../../core/theme_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Hiking',
    'Camping',
    'Biking',
    'Rafting'
  ];

  final List<RecommendedAdventure> recommendations = [
    RecommendedAdventure(
      title: "Mountain Hiking",
      location: "Rocky Mountains, USA",
      rating: 4.8,
      image: "assets/image1.jpg",
      type: "Hiking",
    ),
    RecommendedAdventure(
      title: "Forest Camping",
      location: "Yellowstone Park",
      rating: 4.6,
      image: "assets/image2.jpg",
      type: "Camping",
    ),
    RecommendedAdventure(
      title: "River Rafting",
      location: "Colorado River",
      rating: 4.9,
      image: "assets/image3.jpg",
      type: "Rafting",
    ),
    RecommendedAdventure(
      title: "Mountain Biking",
      location: "Alpine Trails",
      rating: 4.7,
      image: "assets/image4.jpg",
      type: "Biking",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final colorScheme = theme.colorScheme;
    final colors = AppColors.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: colors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome,', style: theme.textTheme.bodyMedium),
                      Text('Adventure Explorer',
                          style: theme.textTheme.titleLarge),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Motivational text
            Text(
              "Let's explore nature,",
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colors.primary,
              ),
            ),
            Text(
              "plan your adventure",
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colors.secondary,
              ),
            ),

            const SizedBox(height: 24),

            // Search bar
            Container(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search adventure destinations',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colors.primary,
                  ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.success,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;

                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor: colors.surface,
                      selectedColor: colors.success.withOpacity(0.2),
                      checkmarkColor: colors.success,
                      labelStyle: theme.textTheme.labelLarge?.copyWith(
                        color: isSelected
                            ? colors.success
                            : theme.textTheme.bodyMedium?.color,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? colors.success
                              : theme.textTheme.bodySmall?.color
                                      ?.withOpacity(0.3) ??
                                  Colors.grey,
                        ),
                      ),
                      elevation: 0,
                      pressElevation: 0,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Quick Action Card
            Card(
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.adventureDetails),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.secondary, colors.secondaryContainer],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Plan New Adventure',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Get AI-powered equipment suggestions',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: colors.success.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/illustrations, pics/hiking illustration.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: colors.success.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: colors.success,
                                  size: 28,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // My Adventures section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Adventures',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colors.primary,
                    )),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.success,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Empty state for adventures
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.explore_outlined,
                      size: 48,
                      color: colors.secondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No adventures yet',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start planning your first adventure!',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            // Recommended section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recommended',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colors.primary,
                    )),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.success,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Recommended adventures grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:
                    0.75, // Adjusted from 0.85 to give more height
              ),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                if (index >= 2) return const SizedBox.shrink();
                final adventure = recommendations[index];

                return Card(
                  elevation: 4,
                  shadowColor: colors.primary.withOpacity(0.2),
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.adventureDetails),
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Adventure Image
                        Container(
                          height: 100, // Reduced from 120 to save space
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              adventure.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        _getTypeColor(adventure.type, context)
                                            .withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _getTypeIcon(adventure.type),
                                      size: 32,
                                      color: _getTypeColor(
                                          adventure.type, context),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.all(10), // Reduced from 12
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  adventure.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14, // Slightly smaller font
                                    color: colors.primary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3), // Reduced from 4
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 12, // Reduced from 14
                                      color: colors.secondary,
                                    ),
                                    const SizedBox(width: 3), // Reduced from 4
                                    Expanded(
                                      child: Text(
                                        adventure.location,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          fontSize: 11, // Smaller font
                                          color: colors.secondary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6), // Reduced from 8
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14, // Reduced from 16
                                      color: colors.warning,
                                    ),
                                    const SizedBox(width: 3), // Reduced from 4
                                    Text(
                                      adventure.rating.toString(),
                                      style:
                                          theme.textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11, // Smaller font
                                        color: colors.warning,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Hiking':
        return Icons.hiking;
      case 'Camping':
        return Icons.cabin;
      case 'Biking':
        return Icons.directions_bike;
      case 'Rafting':
        return Icons.kayaking;
      default:
        return Icons.explore;
    }
  }

  Color _getTypeColor(String type, BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);

    switch (type) {
      case 'Hiking':
        return customColors.success;
      case 'Camping':
        return customColors.warning;
      case 'Biking':
        return theme.colorScheme.primary;
      case 'Rafting':
        return theme.colorScheme.secondary;
      default:
        return theme.textTheme.bodyMedium?.color ?? Colors.grey;
    }
  }
}

class RecommendedAdventure {
  final String title;
  final String location;
  final double rating;
  final String image;
  final String type;

  RecommendedAdventure({
    required this.title,
    required this.location,
    required this.rating,
    required this.image,
    required this.type,
  });
}
