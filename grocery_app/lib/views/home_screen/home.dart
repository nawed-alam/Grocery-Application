import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/controler/home_controler.dart';
import 'package:grocery_app/views/Cart_screen/cart_screen.dart';
import 'package:grocery_app/views/Profile/profile_screen.dart';
import 'package:grocery_app/views/home_screen/home_screen.dart';
import 'package:grocery_app/widget_common/exit_dialog.dart';

import '../Categories/categories_screen.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeControler());
    var navbarItem =[
      BottomNavigationBarItem(icon:Image.asset(icHome,width: 26,),label: home),
      BottomNavigationBarItem(icon:Image.asset(icCategories,width: 26,),label: categories),
      BottomNavigationBarItem(icon:Image.asset(icCart,width: 26,),label: cart),
      BottomNavigationBarItem(icon:Image.asset(icProfile,width: 26,),label: account),
    ];
    var navBody =[
      const HomeScreen(),
     const CategoriesScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
          Obx(()=>
              Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value), 
              ),
            ),
          ],
        ),
        bottomNavigationBar:Obx(()=> BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value){
              controller.currentNavIndex.value=value;
            },
            ),
            ),
      ),
    );
  }
}