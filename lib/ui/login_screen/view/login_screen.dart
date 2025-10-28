// import 'package:get/get.dart';
// import 'package:handy/custom/progress_indicator/progress_dialog.dart';
// import 'package:handy/ui/login_screen/controller/login_screen_controller.dart';
// import 'package:handy/ui/login_screen/widget/login_screen_widget.dart';
// import 'package:handy/utils/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:handy/utils/constant.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryAppColor1,
//       body: GetBuilder<LoginScreenController>(
//         id: Constant.idCheckCustomer,
//         builder: (logic) {
//           return ProgressDialog(
//             // inAsyncCall: logic.isLoading,
//             child: const LoginAddInfoView(),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/login_screen/controller/login_screen_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final LoginScreenController controller = Get.put(LoginScreenController());

    return Scaffold(
      backgroundColor: AppColors.primaryAppColor1,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email TextField
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!controller.isEmailValid(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password TextField
                GetBuilder<LoginScreenController>(
                  id: Constant.idCheckCustomer,
                  builder: (_) {
                    return TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(controller.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: controller.onClickObscure,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => controller.onLogInClick(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAppColor2,
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
