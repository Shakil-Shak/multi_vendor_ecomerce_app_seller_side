import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/orders_screen/order_details.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../controllers/order_controller.dart';
import '../../services/store_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/text_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    return Scaffold(
        appBar: appbarWidget(orders),
        body: StreamBuilder(
          stream: StoreSrevices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndecator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(data: data[index]));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: boldText(
                            text: "${data[index]['order_code']}", color: red),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: fontGrey,
                                ),
                                5.widthBox,
                                normalText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  color: fontGrey,
                                ),
                                5.widthBox,
                                boldText(text: unpaid, color: fontGrey),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "\$${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                ),
              );
            }
          },
        ));
  }
}
