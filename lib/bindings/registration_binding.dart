import 'package:chat_app/controllers/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegistrationController());
  }

}