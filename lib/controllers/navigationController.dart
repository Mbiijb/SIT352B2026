import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var isBottomBarVisible = true.obs; // Tracks if the nav bar is hidden

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void setBottomBarVisibility(bool visible) {
    isBottomBarVisible.value = visible;
  }
}
