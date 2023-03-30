import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/auth_controller.dart';
import 'package:ecomarce_seller_app/controllers/profile_controller.dart';
import 'package:ecomarce_seller_app/views/auth_screen/login_screen.dart';
import 'package:ecomarce_seller_app/views/messages_screen/message_screen.dart';
import 'package:ecomarce_seller_app/views/orders_screen/orders_screen.dart';
import 'package:ecomarce_seller_app/views/products_screen/products_screen.dart';
import 'package:ecomarce_seller_app/views/profile_screen/edit_profile_screen.dart';
import 'package:ecomarce_seller_app/views/shop_screen/shop_settings_screen.dart';
import 'package:ecomarce_seller_app/views/widgets/bg_widgget.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../services/store_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: white,
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 18.0, color: fontGrey),
          actions: [
            IconButton(
                onPressed: () async {
                  await Get.find<AuthController>().signoutMethod(context);
                  Get.offAll(() => const LoginScreen());
                },
                icon: const Icon(
                  Icons.logout,
                  color: fontGrey,
                )),
          ],
        ),
        body: bgWidget(
          child: FutureBuilder(
            future: StoreSrevices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndecator());
              } else {
                controller.snapshotData = snapshot.data!.docs[0];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      15.heightBox,
                      ListTile(
                        leading: controller.snapshotData['imageUrl'] == ''
                            ? Image.asset(
                                imgProduct,
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                controller.snapshotData['imageUrl'],
                                width: 100,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        // leading: Image.asset(imgProduct)
                        //     .box
                        //     .roundedFull
                        //     .clip(Clip.antiAlias)
                        //     .make(),
                        title: boldText(
                            text: "${controller.snapshotData['vendor_name']}",
                            size: 16.0),
                        subtitle: normalText(
                            text: "${controller.snapshotData['email']}"),
                        trailing: IconButton(
                            onPressed: () {
                              Get.to(() => EditProfileScreen(
                                    username:
                                        controller.snapshotData['vendor_name'],
                                  ));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: white,
                            )),
                      )
                          .box
                          .color(purpleColor)
                          .padding(EdgeInsets.symmetric(vertical: 12.0))
                          .roundedLg
                          .make(),
                      const Divider(
                        color: fontGrey,
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: List.generate(
                              profileButtonsIcons.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(
                                                () => const ProductsScreen());
                                            break;
                                          case 1:
                                            Get.to(() => const OrdersScreen());
                                            break;

                                          case 2:
                                            Get.to(() => const MessageScreen());
                                            break;
                                          case 3:
                                            Get.to(() =>  ShopSettigs(
                                              shopName: controller.snapshotData['shop_name'],
                                              shopAddress: controller.snapshotData['shop_address'],
                                              shopMobile: controller.snapshotData['shop_mobile'],
                                              shopWebsite: controller.snapshotData['shop_website'],
                                              shopDesc: controller.snapshotData['shop_desc'],
                                            ));
                                            break;
                                        }
                                      },
                                      leading: Image.asset(
                                        profileButtonsIcons[index],
                                      ),
                                      title: normalText(
                                          text: profileButtonsTitles[index],
                                          size: 16.0,
                                          color: purpleColor),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: purpleColor,
                                      ),
                                    ),
                                  )),
                        ).box.white.roundedSM.shadowLg.make(),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
