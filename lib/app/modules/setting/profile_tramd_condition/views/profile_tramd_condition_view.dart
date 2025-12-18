import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_tramd_condition_controller.dart';

class ProfileTramdConditionView
    extends GetView<ProfileTramdConditionController> {
  const ProfileTramdConditionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileTramdConditionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileTramdConditionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
