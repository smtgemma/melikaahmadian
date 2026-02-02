import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import '../controllers/mover_selected_account_controller.dart';

class MoverSelectedAccountView extends GetView<MoverSelectedAccountController> {
  const MoverSelectedAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Selected Bank Account",
                style: textStyle.titleLarge,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.payoutMethod.value == null) {
                  return  Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,));
                }

                if (controller.errorMessage.isNotEmpty && controller.payoutMethod.value == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                        SizedBox(height: 16.h),
                        Text(
                          controller.errorMessage.value,
                          style: textStyle.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: controller.fetchPayoutMethod,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.payoutMethod.value == null) {
                  return const Center(child: Text('No payout method found'));
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshPayoutMethod,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(
                          context,
                          icon: Icons.flag,
                          title: 'Country',
                          value: controller.payoutMethod.value?.country ?? "country",
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoCard(
                          context,
                          icon: Icons.payment,
                          title: 'Method Type',
                          value: controller.payoutMethod.value!.methodType,
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoCard(
                          context,
                          icon: Icons.email,
                          title: 'Email',
                          value: controller.payoutMethod.value!.details.email,
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoCard(
                          context,
                          icon: Icons.help_outline,
                          title: 'Security Question',
                          value: controller.payoutMethod.value!.details.securityQuestion,
                        ),
                        SizedBox(height: 24.h),
                        _buildStatusCard(context),
                        SizedBox(height: 24.h),
                        AppButton(titel: "Change Account",onPress: (){Get.toNamed(Routes.MOVER_ACCOUNT);},),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                );

              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
      }) {
    var textStyle = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: textStyle.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    final payout = controller.payoutMethod.value!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Status',
            style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildStatusChip(
                context,
                label: payout.isVerified ? 'Verified' : 'Not Verified',
                color: payout.isVerified ? Colors.green : Colors.orange,
              ),
              SizedBox(width: 8.w),
              _buildStatusChip(
                context,
                label: payout.isActive ? 'Active' : 'Inactive',
                color: payout.isActive ? Colors.blue : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, {required String label, required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}