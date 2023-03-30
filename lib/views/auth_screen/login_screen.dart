import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/auth_controller.dart';
import 'package:ecomarce_seller_app/views/home_screen/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../widgets/loading_indicator.dart';
import '../widgets/our_button.dart';
import '../widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0, color: purpleColor),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 80,
                    height: 80,
                  )
                      .box
                      .white
                      .border(color: white)
                      .rounded
                      .padding(EdgeInsets.all(8))
                      .make(),
                  20.widthBox,
                  boldText(text: appname, size: 20.0)
                ],
              )
                  .box
                  .color(purpleColor)
                  .roundedLg
                  .padding(EdgeInsets.all(12.0))
                  .make(),
              50.heightBox,
              normalText(text: loginTo, size: 18.0, color: purpleColor),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: purpleColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: purpleColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: purpleColor)),
                          hintText: emailHint),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: purpleColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: purpleColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: purpleColor)),
                          hintText: password),
                    ),
                    5.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: forgotPassword, color: purpleColor)),
                    ),
                    30.heightBox,
                    SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isloading.value
                            ? loadingIndecator()
                            : ourButton(
                                title: login,
                                onPress: () async {
                                  controller.isloading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loginSuccess);
                                      controller.isloading(false);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isloading(false);
                                    }
                                  });
                                })),
                  ],
                )
                    .box
                    .color(textfieldGrey)
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .outerShadowLg
                    .make(),
              ),
              10.heightBox,
              Center(
                child: normalText(text: anyProblem, color: purpleColor),
              ),
              const Spacer(),
              Center(
                child: boldText(text: credit),
              ),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
