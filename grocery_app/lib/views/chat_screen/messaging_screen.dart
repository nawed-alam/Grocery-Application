

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/services/firestore_services.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body:"Messaging Feature Comming soon!".text.color(darkFontGrey).fontFamily(bold).makeCentered(),

    );
  }
}