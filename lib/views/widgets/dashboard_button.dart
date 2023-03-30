import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';

Widget dashboardButton({context, title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Column(
        children: [
          5.heightBox,
          Image.asset(
            icon,
            width: 50,
          ),
          10.heightBox,
          boldText(text: title, size: 16.0, color: fontGrey),
        ],
      )
          .box
          .color(Colors.white)
          .rounded
          .shadowLg
          .size(size.width * 0.4, 120)
          .padding(EdgeInsets.all(8))
          .make(),
      Positioned.fill(
        bottom: 20,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [boldText(text: count, size: 20.0, color: white)],
          )
              .box
              .color(purpleColor)
              .shadowLg
              .roundedLg
              .size(size.width * 0.3, 40)
              .make(),
        ),
      ),
    ],
  ).box.height(160).make();
}
