import 'package:ecomarce_seller_app/const/const.dart';

Widget normalText({text, color = Colors.white, size = 14.0}) {
  return "$text"
      .text
      .color(color)
      .size(size)
      .overflow(TextOverflow.ellipsis)
      .make();
}

Widget boldText({text, color = Colors.white, size = 14.0}) {
  return "$text".text.semiBold.color(color).size(size).make();
}
