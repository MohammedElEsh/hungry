import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';
import 'package:gap/gap.dart';

import '../widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();



    final sizeConfig = SizeConfig(context);



    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 0.05),
            child: Column(
              children: [
                Gap(sizeConfig.height * 0.15),
                Text(
                  "HUNGRY?",
                  style: Styles.heading
                ),
                Gap(sizeConfig.height * 0.001),
                Text(
                  "Welcome Back, Discover The Fast Food",
                  style: Styles.text14
                ),


                Gap(sizeConfig.height * 0.08),

                custom_text_field(
                    controller: emailController,
                    hintText: 'Email Address',
                    isPassword: false,
                ),

                Gap(sizeConfig.height * 0.02),

                custom_text_field(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

