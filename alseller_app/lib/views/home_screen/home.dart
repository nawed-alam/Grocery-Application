import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/home_controller.dart';
import 'package:alseller_app/views/home_screen/home_screen.dart';
import 'package:alseller_app/views/order_screen/order_screen.dart';
import 'package:alseller_app/views/product_screen/product_screen.dart';
import 'package:alseller_app/views/profile_screen/profile_screen.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      HomeScreen(),
      ProductScreen(),
      OrderScreen(),
      ProfileScreen(),
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            color: darkGrey,
            width: 24,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrder,
            color: darkGrey,
            width: 24,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSetting,
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
              backgroundColor: white,
              currentIndex: controller.navIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: purpleColor,
              unselectedItemColor: darkGrey,
              items: bottomNavbar),
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: navScreens.elementAt(controller.navIndex.value),
              )
            ],
          ),
        ));
  }
}
