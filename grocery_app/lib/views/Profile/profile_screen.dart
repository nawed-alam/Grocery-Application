import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/consts/list.dart';
import 'package:grocery_app/controler/auth_controller.dart';
import 'package:grocery_app/controler/profile_controller.dart';
import 'package:grocery_app/services/firestore_services.dart';
import 'package:grocery_app/views/Orders_Screen/orders_screen.dart';
import 'package:grocery_app/views/Profile/components/details_cart.dart';
import 'package:grocery_app/views/Profile/edit_profile_screen.dart';
import 'package:grocery_app/views/Wishlist_Screen/wishlist_screen.dart';
import 'package:grocery_app/views/auth_screen/login_screen.dart';
import 'package:grocery_app/views/chat_screen/messaging_screen.dart';
import 'package:grocery_app/widget_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(stream: FirestoreServices.getUser(currentUser!.uid), 
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
         

       if(!snapshot.hasData ||snapshot.data!.docs.isEmpty){
        print(currentUser!.uid);
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(redColor),
          ),
          );
       }
      else{
        var data = snapshot.data!.docs[0];
        //print(data);
         return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Edit profile button
                InkWell(
                  onTap: () {
                     controller.namecontroller.text  =data['name'];
                    Get.to(() => EditProfileScreen(data: data,));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.edit, color: whiteColor),
                    
                  ),
                ),
                Row(
                  children: [

                    data['imageUrl'] == '' ?
                    Image.asset(
                      imgProfile,
                      width: 95,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make():
                     Image.network(
                      data['imageUrl'],
                      width: 95,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}".text.fontFamily(semibold).white.make(),
                          5.heightBox,
                          "${data['email']}".text.white.make(),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: whiteColor,
                        ),
                      ),
                      onPressed: () async {
                        await Get.put(AuthController()).signoutMethod(context);
                        Get.offAll(() => const LoginScreen());
                      },
                      child: "Log out".text.fontFamily(semibold).white.make(),
                    )
                  ],
                ),
                20.heightBox,

                FutureBuilder(future: FirestoreServices.getCounts(), 
        builder: (BuildContext context, AsyncSnapshot snapshot) { 
       if(!snapshot.hasData){
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(redColor),
          ),
          );
       }else{
        var countData = snapshot.data;
          return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DetailsCard(
                      count: countData[0].toString(),
                      title: "In your Cart",
                      width: context.screenWidth / 3.4,
                    ),
                    DetailsCard(
                      count: countData[1].toString(),
                      title: "In your wishlist",
                      width: context.screenWidth / 3.4,
                    ),
                    DetailsCard(
                      count: countData[2].toString(),
                      title: "Your Orders",
                      width: context.screenWidth / 3.4,
                    ),
                  ],
                );
       }
        }
       ),      
                40.heightBox,
                // Button Sections
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap:(){
                        switch(index){
                          case 0 : Get.to(()=>const OrdersScreen());
                          break;
                          case 1 : Get.to(()=>const WishlistScreen());
                          break;
                          case 2 : Get.to(()=>const MessageScreen());
                          break;
                        }
                      } ,
                      leading: Image.asset(
                        profileButtonIcons[index],
                        width: 25,
                      ),
                      title: profileButtonList[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonList.length,
                )
                    .box.shadowSm.rounded.padding(
                        const EdgeInsets.symmetric(horizontal: 16))
                    .white
                    .make(),
              ],
            ),
          ),
        );
       }
        } 
        )
        ),
    );
  }
}