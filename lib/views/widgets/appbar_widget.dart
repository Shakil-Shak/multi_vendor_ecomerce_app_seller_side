import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 18.0),
    actions: [
      Center(
        child: normalText(
            text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
            color: purpleColor,
            size: 18.0),
      ),
      10.widthBox,
    ],
  );
}
