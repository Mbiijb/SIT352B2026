import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/givingController.dart';
import 'package:flutter_application_1/models/giving_model.dart';
import 'package:flutter_application_1/views/financial_report.dart';
import 'package:get/get.dart';

class GivingHistory extends StatelessWidget {
  const GivingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final GivingController controller = Get.find<GivingController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Giving History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            // Summary Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildSummaryCard(
                    "TOTAL CONTRIBUTED",
                    controller.totalContributed.value,
                    Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildSummaryCard(
                    "${DateTime.now().year} YEAR TO DATE",
                    controller.ytdContributed.value,
                    Colors.green,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Get.to(() => const FinancialReport()),
                      child: const Text(
                        "View Reports",
                        style: TextStyle(
                          color: primarycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.history.isEmpty
                  ? const Center(child: Text("No transactions found."))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.history.length,
                      itemBuilder: (context, index) {
                        final item = controller.history[index];
                        return _buildTransactionItem(item);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.back(),
        backgroundColor: primarycolor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCard(String label, double amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "KSh ${amount.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(GivingRecord item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primarycolor.withOpacity(0.1),
          child: const Icon(Icons.volunteer_activism, color: primarycolor),
        ),
        title: Text(
          item.category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.description, style: const TextStyle(fontSize: 12)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "+KSh ${item.amount.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              item.status.toUpperCase(),
              style: const TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
