import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/home_screen/home_screen.dart';
import 'package:ecomarce_seller_app/views/messages_screen/message_screen.dart';
import 'package:ecomarce_seller_app/views/orders_screen/orders_screen.dart';
import 'package:ecomarce_seller_app/views/products_screen/products_screen.dart';
import 'package:ecomarce_seller_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../widgets/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      HomeScreen(),
      MessageScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen()
    ];
    var bottomNavbar = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            color: darkGrey,
            width: 24,
          ),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icChat2,
            color: darkGrey,
            width: 24,
          ),
          label: messages),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts2,
            color: darkGrey,
            width: 24,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders2,
            color: darkGrey,
            width: 24,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            color: darkGrey,
            width: 24,
          ),
          label: settings),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          items: bottomNavbar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        ),
      ),
      body: Column(
        children: [
          Obx(() =>
              Expanded(child: navScreens.elementAt(controller.navIndex.value)))
        ],
      ),
    );
  }
}
