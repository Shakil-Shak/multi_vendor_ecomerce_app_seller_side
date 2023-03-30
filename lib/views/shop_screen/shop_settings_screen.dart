import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/profile_controller.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/text_style.dart';

class ShopSettigs extends StatefulWidget {
  String? shopName;
  String? shopAddress;
  String? shopMobile;
  String? shopWebsite;
  String? shopDesc;
  ShopSettigs(
      {super.key,
      this.shopName,
      this.shopAddress,
      this.shopMobile,
      this.shopWebsite,
      this.shopDesc});

  @override
  State<ShopSettigs> createState() => _ShopSettigsState();
}

class _ShopSettigsState extends State<ShopSettigs> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.shopNameController.text = widget.shopName!;
    controller.shopAddressController.text = widget.shopAddress!;
    controller.shopMobileController.text = widget.shopMobile!;
    controller.shopWebsiteController.text = widget.shopWebsite!;
    controller.shopDescController.text = widget.shopDesc!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: purpleColor,
            ),
          ),
          title: boldText(text: shopSettings, size: 18.0, color: purpleColor),
          actions: [
            controller.isloading.value
                ? loadingIndecator()
                : IconButton(
                    onPressed: () async {
                      controller.isloading(true);
                      if (controller.shopNameController.text.isNotEmpty &&
                          controller.shopAddressController.text.isNotEmpty &&
                          controller.shopMobileController.text.isNotEmpty &&
                          controller.shopWebsiteController.text.isNotEmpty &&
                          controller.shopDescController.text.isNotEmpty) {
                        await controller.updateShop(
                          shopname: controller.shopNameController.text,
                          shopaddress: controller.shopAddressController.text,
                          shopmobile: controller.shopMobileController.text,
                          shopwebsite: controller.shopWebsiteController.text,
                          shopdesc: controller.shopDescController.text,
                        );
                        VxToast.show(context, msg: "Updated");
                        controller.shopNameController.text = "";
                        controller.shopAddressController.text = "";
                        controller.shopMobileController.text = "";
                        controller.shopWebsiteController.text = "";
                        controller.shopDescController.text = "";
                        Get.back();
                      } else {
                        VxToast.show(context, msg: "Feild cant be empty");
                      }
                    },
                    icon: const Icon(Icons.save, color: purpleColor)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                customTextField(
                    label: shopname,
                    hint: nameHint,
                    controller: controller.shopNameController),
                10.heightBox,
                customTextField(
                    label: address,
                    hint: shopAddressHint,
                    controller: controller.shopAddressController),
                10.heightBox,
                customTextField(
                    label: mobile,
                    hint: shopMobileHint,
                    controller: controller.shopMobileController),
                10.heightBox,
                customTextField(
                    label: website,
                    hint: shopWebsiteHint,
                    controller: controller.shopWebsiteController),
                10.heightBox,
                customTextField(
                    isDecs: true,
                    label: description,
                    hint: shopDescHint,
                    controller: controller.shopDescController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
