import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/products_screen/products_details.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../services/store_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bg_widgget.dart';
import '../widgets/dashboard_button.dart';
import '../widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
          stream: StoreSrevices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndecator();
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return StreamBuilder(
                  stream: StoreSrevices.getOrders(currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndecator();
                    } else {
                      var orderdata = snapshot.data!.docs;
                      return bgWidget(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  dashboardButton(
                                      context: context,
                                      title: products,
                                      count: "${data.length}",
                                      icon: icProducts),
                                  dashboardButton(
                                      context: context,
                                      title: orders,
                                      count: "${orderdata.length}",
                                      icon: icOrders),
                                ],
                              ),
                              20.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  dashboardButton(
                                      context: context,
                                      title: rating,
                                      count: "0",
                                      icon: icStar),
                                  dashboardButton(
                                      context: context,
                                      title: totalSales,
                                      count: "0",
                                      icon: icSales),
                                ],
                              ),
                              10.heightBox,
                              const Divider(),
                              10.heightBox,
                              boldText(
                                  text: popular, color: fontGrey, size: 16.0),
                              20.heightBox,
                              ListView(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: List.generate(
                                    data.length,
                                    (index) =>
                                        data[index]['p_wishlist'].length == 0
                                            ? const SizedBox()
                                            : ListTile(
                                                onTap: () {
                                                  Get.to(() => ProductDetails(
                                                        data: data[index],
                                                      ));
                                                },
                                                leading: Image.network(
                                                  data[index]['p_imgs'][0],
                                                  width: 100,
                                                  height: 150,
                                                  fit: BoxFit.contain,
                                                ),
                                                title: boldText(
                                                    text:
                                                        "${data[index]['p_name']}",
                                                    color: white),
                                                subtitle: VxRating(
                                                  isSelectable: false,
                                                  value: double.parse(
                                                      data[index]['p_rating']),
                                                  onRatingUpdate: (value) {},
                                                  normalColor: textfieldGrey,
                                                  selectionColor: golden,
                                                  count: 5,
                                                  size: 15,
                                                  maxRating: 5,
                                                ),
                                                trailing: normalText(
                                                    text:
                                                        "\$${data[index]['p_price']}",
                                                    color: white),
                                              )),
                              ).box.color(purpleColor).roundedSM.make()
                            ],
                          ),
                        ),
                      );
                    }
                  });
            }
          },
        ));
  }
}
