import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/order_controller.dart';
import 'package:ecomarce_seller_app/views/widgets/our_button.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/text_style.dart';
import 'components/order_place.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
          title: boldText(text: ordersDetail, size: 16.0, color: fontGrey),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
                color: purpleColor,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docID: widget.data.id);
                },
                title: "Confirm Order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Column(
                children: [
                  // order delivery

                  Visibility(
                    visible: controller.confirmed.value,
                    child: Column(
                      children: [
                        boldText(
                            text: "Order status:", color: fontGrey, size: 16.0),
                        SwitchListTile(
                            title: boldText(text: "Placed", color: fontGrey),
                            activeColor: purpleColor,
                            value: true,
                            onChanged: (value) {}),
                        SwitchListTile(
                            title: boldText(text: "Confirmed", color: fontGrey),
                            activeColor: purpleColor,
                            value: controller.confirmed.value,
                            onChanged: (value) {
                              controller.confirmed.value = value;
                            }),
                        SwitchListTile(
                            title:
                                boldText(text: "on Delivery", color: fontGrey),
                            activeColor: purpleColor,
                            value: controller.onDelivery.value,
                            onChanged: (value) {
                              controller.onDelivery.value = value;
                              controller.changeStatus(
                                  title: "order_on_delivery",
                                  status: value,
                                  docID: widget.data.id);
                            }),
                        SwitchListTile(
                            title: boldText(text: "Delivered", color: fontGrey),
                            activeColor: purpleColor,
                            value: controller.delivered.value,
                            onChanged: (value) {
                              controller.delivered.value = value;
                              controller.changeStatus(
                                  title: "order_delivered",
                                  status: value,
                                  docID: widget.data.id);
                            }),
                      ],
                    )
                        .box
                        .padding(EdgeInsets.all(8))
                        .outerShadowLg
                        .white
                        .border(color: lightGrey)
                        .roundedSM
                        .make(),
                  ),

                  // order details
                  orderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlaceDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format(widget.data['order_date'].toDate()),
                      // d1: DateTime.now(),
                      d2: "${widget.data['payment_method']},",
                      title1: "Order Date",
                      title2: "Payment Method"),
                  orderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "Shipping Address".text.fontFamily(semibold).make(),
                            boldText(
                                text: "Sipping Address", color: purpleColor),
                            "${widget.data['order_by_name']}".text.make(),
                            "${widget.data['order_by_email']}".text.make(),
                            "${widget.data['order_by_address']}".text.make(),
                            "${widget.data['order_by_city']}".text.make(),
                            "${widget.data['order_by_state']}".text.make(),
                            "${widget.data['order_by_phone']}".text.make(),
                            "${widget.data['order_by_postalcode']}".text.make(),
                            20.heightBox,
                            SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boldText(
                                      text: "Total amount", color: purpleColor),
                                  boldText(
                                      text: "\$${widget.data['total_amount']}",
                                      color: red,
                                      size: 16.0),
                                  // "Total Amount".text.fontFamily(semibold).make(),
                                  // "${data['total_amount']}"
                                  //     .text
                                  //     .color(redColor)
                                  //     .fontFamily(semibold)
                                  //     .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
                  .box
                  .outerShadowLg
                  .white
                  .border(color: lightGrey)
                  .roundedSM
                  .make(),
              const Divider(),
              10.heightBox,
              boldText(text: "Ordered Product", color: fontGrey, size: 16.0),
              // "Ordered Product"
              //     .text
              //     .size(16)
              //     .color(darkFontGrey)
              //     .fontFamily(semibold)
              //     .makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(controller.orders.length, (index) {
                  return ListTile(
                      leading: Image.network(
                        "${controller.orders[index]['img']}",
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      title: "${controller.orders[index]['title']}".text.make(),
                      subtitle: Row(
                        children: [
                          "${controller.orders[index]['qty']}x".text.make(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      Color(controller.orders[index]['color']),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              width: 30,
                              height: 20,
                              // color: Color(data['orders'][index]['color']),
                            ),
                          ),
                        ],
                      ),
                      trailing: "\$${controller.orders[index]['tprice']}"
                          .text
                          .color(purpleColor)
                          .make());
                  // Row(
                  //   children: [
                  //     Image.network(
                  //       "${controller.orders[index]['img']}",
                  //       width: 100,
                  //       fit: BoxFit.contain
                  //       ,
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           orderPlaceDetails(
                  //               title1: "${controller.orders[index]['title']}",
                  //               title2: "Price",
                  //               d1: "${controller.orders[index]['qty']}x",
                  //               d2: "\$${controller.orders[index]['tprice']}"),
                  //           Padding(
                  //             padding:
                  //                 const EdgeInsets.symmetric(horizontal: 16),
                  //             child: Container(
                  //               width: 30,
                  //               height: 20,
                  //               color: Color(controller.orders[index]['color']),
                  //             ),
                  //           ),
                  //           const Divider()
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // );
                }).toList(),
              )
                  .box
                  .outerShadowLg
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ]),
          ),
        ),
      ),
    );
  }
}
