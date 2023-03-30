import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/controllers/products_controller.dart';
import 'package:ecomarce_seller_app/services/store_services.dart';
import 'package:ecomarce_seller_app/views/products_screen/add_product.dart';
import 'package:ecomarce_seller_app/views/products_screen/products_details.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/text_style.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: purpleColor,
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => const AddProduct());
          },
          label: addProduct.text.color(white).make(),
          icon: const ImageIcon(AssetImage(icAddProduct)),
        ),
        appBar: appbarWidget(products),
        body: StreamBuilder(
          stream: StoreSrevices.getProducts(currentUser!.uid),
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
                    children: List.generate(
                        data.length,
                        (index) => ListTile(
                              onTap: () {
                                Get.to(() => ProductDetails(
                                      data: data[index],
                                    ));
                              },
                              leading: Image.network(
                                data[index]['p_imgs'][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                              title: boldText(
                                  text: "${data[index]['p_name']}",
                                  color: fontGrey),
                              subtitle: Row(
                                children: [
                                  normalText(
                                      text: "\$${data[index]['p_price']}",
                                      color: darkGrey),
                                  10.widthBox,
                                  boldText(
                                      text: data[index]['is_featured'] == true
                                          ? "Featured"
                                          : "",
                                      color: green)
                                ],
                              ),
                              trailing: VxPopupMenu(
                                  child: Icon(Icons.more_vert_rounded),
                                  menuBuilder: () => Column(
                                        children: List.generate(
                                            popupMenuTitles.length,
                                            (i) => Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        popupMenuIcons[i],
                                                        color: data[index][
                                                                        'featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? green
                                                            : darkGrey,
                                                      ),
                                                      10.widthBox,
                                                      normalText(
                                                          text: data[index][
                                                                          'featured_id'] ==
                                                                      currentUser!
                                                                          .uid &&
                                                                  i == 0
                                                              ? "Remove feature"
                                                              : popupMenuTitles[
                                                                  i],
                                                          color: darkGrey)
                                                    ],
                                                  ).onTap(() {
                                                    switch (i) {
                                                      case 0:
                                                        if (data[index][
                                                                'is_featured'] ==
                                                            true) {
                                                          controller
                                                              .removeFeatured(
                                                                  data[index]
                                                                      .id);
                                                          VxToast.show(context,
                                                              msg: "Removed");
                                                        } else {
                                                          controller
                                                              .addFeatured(
                                                                  data[index]
                                                                      .id);
                                                          VxToast.show(context,
                                                              msg: "Added");
                                                        }
                                                        break;
                                                      case 1:
                                                        break;
                                                      case 2:
                                                        controller
                                                            .removeProduct(
                                                                data[index].id);
                                                        VxToast.show(context,
                                                            msg:
                                                                "Product removed");
                                                        break;

                                                      default:
                                                    }
                                                  }),
                                                )),
                                      ).box.white.rounded.width(200).make(),
                                  clickType: VxClickType.singleClick),
                            )),
                  ),
                ),
              );
            }
          },
        ));
  }
}
