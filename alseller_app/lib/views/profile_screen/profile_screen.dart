import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/auth_controller.dart';
import 'package:alseller_app/controller/profile_controller.dart';
import 'package:alseller_app/services/store_services.dart';
import 'package:alseller_app/views/auth_screen/login_screen.dart';
import 'package:alseller_app/views/profile_screen/edit_profile_screen.dart';
import 'package:alseller_app/views/shop_settings/shop_setting_screen.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings,size: 16.0),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> EditProfileScreen(username: controller.snapshotData['vendor_name']));
            
          }, icon:const Icon(Icons.edit,color: white,),),
          TextButton(onPressed: ()async{
            await Get.find<AuthController>().signoutMethod(context);
            Get.offAll(()=> const LoginScreen());
          }, child: normalText(text: logout)),
        ],
      ),
       body: StreamBuilder(
        stream: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapsot ){
          if(!snapsot.hasData){
          return const  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(white),
                            );
          }
          else{
            controller.snapshotData = snapsot.data!.docs[0];
              print(snapsot.data!.docs[0]);
            return Column(
        children: [
          ListTile(
            leading:controller.snapshotData['imageUrl'] == '' ?
                    Image.asset(
                      imgProduct,
                      width: 95,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make():
                     Image.network(
                      controller.snapshotData['imageUrl'],
                      width: 95,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
            //  Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
            title: boldText(text: "${controller.snapshotData['vendor_name']}",
            ),
            subtitle: normalText(text: "${controller.snapshotData['email']}"),
          ),
          const Divider(),
          10.heightBox,
          Column(
            children: List.generate(profileButtonsIcons.length, (index) => ListTile(
              onTap: (){
                switch(index){
                  case 0:
                  Get.to(()=> const ShopSettings());
                  break;
                }
              },
                leading: Icon(profileButtonsIcons[index],color: white,),
                title: normalText(text: profileButtonsTitles[index]),
              )),
          )

        ],
      ) ;
          }
        }),
      
    );
  }
}