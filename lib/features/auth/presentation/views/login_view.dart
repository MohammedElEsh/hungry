import 'package:flutter/material.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';
import 'package:gap/gap.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();





    final sizeConfig = SizeConfig(context);



    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 0.05),
            child: Form(

              key: formKey,


              child: Column(
                children: [
                  Gap(sizeConfig.height * 0.15),
                  Text(
                    "HUNGRY?",
                    style: AppTextStyles.displayLarge
                  ),
                  Text(
                    "Welcome Back, Discover The Fast Food",
                    style: AppTextStyles.titleMedium
                  ),


                  Gap(sizeConfig.height * 0.08),

                  CustomTextField(
                      controller: emailController,
                      hintText: 'Email Address',
                      isPassword: false,
                  ),

                  Gap(sizeConfig.height * 0.02),

                  CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                  ),

                  Gap(sizeConfig.height * 0.10),

                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showSuccessBanner(context, 'Form is valid');
                      } else {
                        showErrorBanner(context, 'Form is invalid');
                      }
                    },
                  ),




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

