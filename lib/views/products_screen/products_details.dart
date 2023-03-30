import 'package:ecomarce_seller_app/const/const.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(text: "${data['p_name']}", size: 16.0, color: fontGrey),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data['p_imgs'].length,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                // product ame and description
                boldText(
                    text: "${data['p_name']}", color: fontGrey, size: 16.0),
                // title!.text
                //     .size(17)
                //     .color(darkFontGrey)
                //     .fontFamily(semibold)
                //     .make(),
                10.heightBox,

                Row(
                  children: [
                    boldText(
                        text: "${data['p_category']}",
                        color: fontGrey,
                        size: 16.0),
                    10.widthBox,
                    normalText(
                        text: "${data['p_subcategory']}",
                        color: fontGrey,
                        size: 16.0),
                  ],
                ),
                10.heightBox,
                VxRating(
                  isSelectable: false,
                  value: double.parse(data['p_rating']),
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: golden,
                  count: 5,
                  size: 25,
                  maxRating: 5,
                ),
                10.heightBox,
                boldText(text: "\$${data['p_price']}", color: red, size: 16.0),

                20.heightBox,
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Color: ".text.color(fontGrey).make(),
                        ),
                        Row(
                          children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      .color(Color(data['p_colors'][index])
                                          .withOpacity(1.0))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 6))
                                      .make()
                                      .onTap(() {
                                    // controller
                                    //     .changeColorIndex(index);
                                  })),
                        )
                      ],
                    ),
                    10.heightBox,
                    // quantity
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Quantity: ".text.color(fontGrey).make(),
                        ),
                        normalText(
                            text: "${data['p_quantity']} Items",
                            color: fontGrey)
                      ],
                    ),
                  ],
                ).box.white.padding(EdgeInsets.all(8)).make(),
                const Divider(),
                20.heightBox,
                "Description:".text.color(fontGrey).make(),
                10.heightBox,
                normalText(text: "${data['p_desc']}", color: fontGrey)
                // "${data['p_desc']}".text.color(darkFontGrey).make(),
              ],
            ),
          ),

          // "${data['p_price']}"
          //     .numCurrency
          //     .text
          //     .color(redColor)
          //     .fontFamily(bold)
          //     .size(18)
          //     .make(),

          10.heightBox,
        ],
      )),
    );
  }
}
