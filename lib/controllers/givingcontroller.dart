import 'package:get/get.dart';

class GivingController extends GetxController {
  var isRecurring = false.obs; // This handles the toggle logic
  var donationAmount = 10.0.obs;
  var isProcessing = false.obs;

  void toggleRecurring(bool value) {
    isRecurring.value = value;
  }

  void setAmount(double amount) {
    donationAmount.value = amount;
  }

  Future<void> submitDonation() async {
    isProcessing.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isProcessing.value = false;
    Get.snackbar("Success", "Thank you for your giving!");
  }
}
