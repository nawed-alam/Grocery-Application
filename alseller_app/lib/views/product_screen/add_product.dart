import 'package:alseller_app/const/const.dart';
import 'package:alseller_app/controller/products_controller.dart';
import 'package:alseller_app/views/product_screen/components/product_dropdown.dart';
import 'package:alseller_app/views/product_screen/components/product_images.dart';
import 'package:alseller_app/widgets/costum_textform_feild.dart';
import 'package:alseller_app/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(() =>  Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Add product", color: white, size: 16.0),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: white)),
          actions: [ controller.isloading.value ? const  CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(red),
                              ) :
            TextButton(
                onPressed: () async{
                  await controller.uploadImages();
                  await controller.uploadProducts(context);
                  Get.back();
                }, child: boldText(text: save, color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg.Ata",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg.Ata",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "eg.\$100 ",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "eg.20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                boldText(text: "Choose product Images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pimagesList[index] != null
                            ? Image.file(
                                controller.pimagesList[index],
                                width: 100,
                              ).onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your dispaly image",
                    color: lightGrey),
                const Divider(
                  color: white,
                ),
                10.heightBox,
                boldText(text: "Choose product quantity"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(Vx.randomPrimaryColor)
                                    .roundedFull
                                    .size(65, 65)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: white,
                                      )
                                    : const SizedBox(),
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
