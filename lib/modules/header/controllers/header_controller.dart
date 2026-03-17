import 'package:get/get.dart';

class HeaderController extends GetxController {
  final List<String> headerTitles = const [
    "Home",
    "Monetization",
    "Solutions",
    "Media Hub",
    "Company",
    "Swift TV",
    "Contact Us",
  ];

  RxInt selectedIndex = 0.obs;

  void changeIndex(int newIndex) {
    if (newIndex == 5) {
      return;
    }
    selectedIndex.value = newIndex;
  }

  void updateIndexFromRoute(String location) {
    if (location.startsWith('/monetization')) {
      selectedIndex.value = 1;
    } else if (location.startsWith('/solutions')) {
      selectedIndex.value = 2;
    } else if (location.startsWith('/media-hub') ||
        location.startsWith('/blogs') ||
        location.startsWith('/newsroom') ||
        location.startsWith('/gallery')) {
      selectedIndex.value = 3;
    } else if (location.startsWith('/company') ||
        location.startsWith('/careers')) {
      selectedIndex.value = 4;
    } else if (location.startsWith('/contact-us')) {
      selectedIndex.value = 6;
    } else {
      selectedIndex.value = 0;
    }
  }
}
