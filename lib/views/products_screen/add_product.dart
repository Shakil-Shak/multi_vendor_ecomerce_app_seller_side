import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/products_controller.dart';
import 'package:ecomarce_seller_app/views/products_screen/components/product_images.dart';
import 'package:ecomarce_seller_app/views/widgets/custom_textfield.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/bg_widgget.dart';
import '../widgets/text_style.dart';
import 'components/product_dropdown.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
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
          title: boldText(text: "Add Product", size: 16.0, color: purpleColor),
          actions: [
            controller.islaoding.value
                ? loadingIndecator()
                : TextButton(
                    onPressed: () async {
                      controller.islaoding(true);
                      if (controller.pnameController.text.isNotEmpty &&
                          controller.pdescController.text.isNotEmpty &&
                          controller.ppriceController.text.isNotEmpty &&
                          controller.pquantityController.text.isNotEmpty &&
                          controller.pImagesList.isNotEmpty &&
                          controller.categoryvalue.isNotEmpty &&
                          controller.subcategoryvalue.isNotEmpty) {
                        await controller.uplodeImages();
                        await controller.uplodeProduct(context);
                        controller.pnameController.text = "";
                        controller.pdescController.text = "";
                        controller.ppriceController.text = "";
                        controller.pquantityController.text = "";
                        controller.pImagesLinks.clear();
                        controller.pImagesList = RxList<dynamic>.generate(3, (index) => null);
                        controller.categoryvalue("");
                        controller.subcategoryvalue("");
                        controller.islaoding(false);
                        Get.back();
                      } else {
                        controller.islaoding(false);
                        VxToast.show(context, msg: "Please fill all feild");
                      }
                    },
                    child: boldText(text: "save", color: purpleColor))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "Name",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "Description",
                    label: "Product Description",
                    isDecs: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "Price",
                    label: "Product price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "Quantity",
                    label: "Product quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(color: white),
                normalText(text: "Choice product images", color: purpleColor),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                width: 100,
                              ).onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                boldText(
                    text: "First image will  be your display image",
                    color: purpleColor),
                10.heightBox,
                const Divider(color: fontGrey),
                normalText(text: "Choice product Color", color: purpleColor),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        colorList.length,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(colorList[index])
                                    .roundedFull
                                    .size(70, 70)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: white,
                                      )
                                    : const SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
