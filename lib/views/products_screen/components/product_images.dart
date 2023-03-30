import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(purpleColor)
      .size(20.0)
      .makeCentered()
      .box
      .color(textfieldGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
