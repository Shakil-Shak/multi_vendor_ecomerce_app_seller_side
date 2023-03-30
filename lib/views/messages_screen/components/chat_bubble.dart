import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

import '../../../const/const.dart';

Widget chatBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? purpleColor : fontGrey,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(white.withOpacity(0.5)).make()
        ],
      ),
    ),
  );
}
