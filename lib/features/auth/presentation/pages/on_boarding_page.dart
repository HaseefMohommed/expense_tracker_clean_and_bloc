import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OnboardingPage extends StatefulWidget {
  static String routeName = '/onboardingPage';

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      imagePath: AssetsProvider.onBoardingOne,
      title: 'Note Down Expenses',
      description: 'Daily note your expenses to help manage money',
    ),
    OnboardingItem(
      imagePath: AssetsProvider.onBoardingTwo,
      title: 'Simple Money Management',
      description:
          'Get your notifications or alert when you do the over expenses',
    ),
    OnboardingItem(
      imagePath: AssetsProvider.onBoardingThree,
      title: 'Easy to Track and Analyze',
      description: 'Tracking your expense help make sure you don\'t overspend',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.primaryPadding),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(item.imagePath),
                            const SizedBox(height: 20),
                            Text(
                              item.title,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                item.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items.asMap().entries.map((entry) {
                return Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  child: SvgPicture.asset(
                    _currentIndex == entry.key
                        ? AssetsProvider.activeIndicator
                        : AssetsProvider.inactiveIndicator,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                name: "Let's Go",
                onPressed: () {
                  Navigator.pushNamed(context, SignInPage.routeName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String imagePath;
  final String title;
  final String description;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
