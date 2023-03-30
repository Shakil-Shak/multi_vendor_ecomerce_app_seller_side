import 'dart:io';

import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/profile_controller.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../widgets/bg_widgget.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: fontGrey,
          backgroundColor: white,
          title: boldText(text: editProfile, size: 18.0, color: fontGrey),
          actions: [
            controller.isloading.value
                ? loadingIndecator()
                : IconButton(
                    onPressed: () async {
                      controller.isloading(true);
                      if (controller.nameController.text.isNotEmpty) {
                        // img check
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uplodeProfileImage();
                        } else {
                          controller.profileImgLink =
                              controller.snapshotData['imageUrl'];
                        }

                        // password chk
                        if (controller.snapshotData['password'] ==
                            controller.oldpasswordController.text) {
                          await controller.changeAuthPassword(
                              email: controller.snapshotData['email'],
                              password: controller.oldpasswordController.text,
                              newpassword:
                                  controller.newpasswordController.text);

                          await controller.updateProfile(
                              imgUrl: controller.profileImgLink,
                              name: controller.nameController.text,
                              password: controller.newpasswordController.text);
                          VxToast.show(context, msg: "Upated");
                          Get.back();
                        } else if (controller
                                .oldpasswordController.text.isEmptyOrNull &&
                            controller
                                .newpasswordController.text.isEmptyOrNull) {
                          await controller.updateProfile(
                              imgUrl: controller.profileImgLink,
                              name: controller.nameController.text,
                              password: controller.snapshotData['password']);
                          VxToast.show(context, msg: "Upated");
                          Get.back();
                        } else {
                          VxToast.show(context, msg: "Error occured");
                          controller.isloading(false);
                        }
                      } else {
                        VxToast.show(context, msg: "Name cant be empty");
                        controller.isloading(false);
                      }
                    },
                    icon: const Icon(
                      Icons.save,
                      color: fontGrey,
                    )),
          ],
        ),
        body: bgWidget(
          child: Column(
            children: [
              20.heightBox,
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: normalText(text: changeImage, color: purpleColor)),
              10.heightBox,
              const Divider(
                color: fontGrey,
              ),
              Column(
                children: [
                  10.heightBox,
                  customTextField(
                      label: name,
                      hint: nameHint,
                      controller: controller.nameController),
                  10.heightBox,
                  customTextField(
                      label: password,
                      hint: passwordHint,
                      controller: controller.oldpasswordController),
                  10.heightBox,
                  customTextField(
                      label: confirmPass,
                      hint: passwordHint,
                      controller: controller.newpasswordController),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerRight,
                      child: boldText(
                          text: "Change your password", color: purpleColor)),
                ],
              )
                  .box
                  .white
                  .padding(EdgeInsets.all(12.0))
                  .margin(EdgeInsets.symmetric(horizontal: 8.0))
                  .shadowLg
                  .roundedSM
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
