import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/products_controller.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
            child: DropdownButton(
      hint: normalText(text: "$hint", color: purpleColor),
      value: dropvalue.value == '' ? null : dropvalue.value,
      isExpanded: true,
      items: list.map((e) {
        return DropdownMenuItem(
          child: e.toString().text.make(),
          value: e,
        );
      }).toList(),
      onChanged: (value) {
        if (hint == "Category") {
          controller.subcategoryvalue.value = '';
          controller.populateSubcategory(value.toString());
        }
        dropvalue.value = value.toString();
      },
    ))
        .box
        .white
        .padding(EdgeInsets.symmetric(horizontal: 8))
        .roundedSM
        .border(color: purpleColor)
        .make(),
  );
}
