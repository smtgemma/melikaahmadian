import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_privacy_policy_controller.dart';

class ProfilePrivacyPolicyView extends GetView<ProfilePrivacyPolicyController> {
  const ProfilePrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePrivacyPolicyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfilePrivacyPolicyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
