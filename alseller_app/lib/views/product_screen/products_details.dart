import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductsDetails extends StatelessWidget {
  final dynamic data;
  const ProductsDetails({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}",color: fontGrey,size: 16.0),
         leading: IconButton(onPressed: (){
          Get.back();
        }
    , icon: const Icon(Icons.arrow_back,color: darkGrey,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      aspectRatio: 16/9,
                      itemCount: data['p_images'].length,
                       itemBuilder: (context,index){
    
                      return Image.network(
                        data['p_images'][index],width: double.infinity,
                        fit: BoxFit.cover,
                        );
                    }),
                     10.heightBox,
                    //title and details screen
                   // title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: "${data['p_name']}",color:fontGrey,size: 16.0 ),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),
                        10.widthBox,
                        normalText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0),
                      ],
                    ),
                    10.heightBox,
                    //rating 
                    VxRating(
                      // value: double.parse(data['p_rating,
                      value: 3.0,
                      onRatingUpdate: (value){
                      
                    },
                    normalColor: Colors.grey,
                    selectionColor:Colors.amber,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                   // stepInt: true,
                    ),
                    10.heightBox,
                    //"${String.fromCharCode(8377)} ${double.parse(data['p_price']).numCurrency}".text.color(redColor).fontFamily(bold).size(16).make(),
                    boldText(text: "${data['p_price']}",color: red,size: 18.0),
                  10.heightBox,
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: normalText(text: "Quantity",color: fontGrey,size: 16.0)),
                        normalText(text: "${data['p_quantity']} Items" ,color: fontGrey),
                    ],
                  )
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                   20.heightBox,
                   boldText(text: "Description",color: fontGrey),
                    //"Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    //"${data['p_description']}".text.color(darkFontGrey).make(),
                      normalText(text: "${data['p_description']}" ,color: fontGrey),
    
                  10.heightBox,

          ],
        ),
      ),
    );
  }
}