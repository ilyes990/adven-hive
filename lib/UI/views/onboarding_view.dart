import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes.dart';
import '../../main.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController();
  int currentPage = 0;

  List<OnboardingData> get onboardingData {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final colorScheme = theme.colorScheme;

    return [
      OnboardingData(
        title: "Plan Your Adventure",
        description:
            "Tell us about your upcoming adventure - type, difficulty, weather, and group size.",
        image: "assets/illustrations/hiking illustration.png",
        color: colorScheme.primary,
      ),
      OnboardingData(
        title: "AI-Powered Suggestions",
        description:
            "Our smart AI generates personalized equipment checklists based on your adventure details.",
        image: "assets/illustrations/camping.png",
        color: colorScheme.secondary,
      ),
      OnboardingData(
        title: "Pack with Confidence",
        description:
            "Select items from AI suggestions, create your final checklist, and never forget essential gear again.",
        image: "assets/illustrations/biking.png",
        color: customColors.success,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.login),
                  child: Text(
                    'Skip',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Adventure Image
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              onboardingData[index].image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: onboardingData[index]
                                        .color
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: onboardingData[index].color,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    _getFallbackIcon(index),
                                    size: 80,
                                    color: onboardingData[index].color,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Title
                        Text(
                          onboardingData[index].title,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Text(
                          onboardingData[index].description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicator and navigation
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicators
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: currentPage == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? colorScheme.primary
                              : theme.textTheme.bodySmall?.color
                                  ?.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                        // Last page - go to login
                        Get.offAllNamed(AppRoutes.login);
                      } else {
                        // Next page
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      currentPage == onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFallbackIcon(int index) {
    switch (index) {
      case 0:
        return Icons.hiking;
      case 1:
        return Icons.cabin;
      case 2:
        return Icons.directions_bike;
      default:
        return Icons.explore;
    }
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
}
