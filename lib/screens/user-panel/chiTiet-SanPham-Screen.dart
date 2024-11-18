// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, non_constant_identifier_names

import 'package:app_banhang/controllers/danhGia_controller.dart';
import 'package:app_banhang/models/cart-model.dart';
import 'package:app_banhang/models/product-model.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/review_model.dart';
import 'gioHang-Screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});
  
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    CalculateProductRatingController calculateProductRatingController = Get.put(
        CalculateProductRatingController(widget.productModel.productId));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'Chi tiết sản phẩm',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 60,
              ),
              CarouselSlider(
                  items: widget.productModel.productImages
                      .map(
                        (imageUrls) => ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: imageUrls,
                            fit: BoxFit.cover,
                            width: Get.width - 10,
                            placeholder: (context, url) => ColoredBox(
                              color: Colors.white,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      aspectRatio: 2.5,
                      viewportFraction: 1)),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.productModel.productName),
                                Icon(Icons.favorite_outline)
                              ],
                            )),
                      ),

                      //reviews
                      //reviews
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Obx(() => RatingBar.builder(
                                  glow: false,
                                  ignoreGestures: true,
                                  initialRating:
                                      calculateProductRatingController
                                          .averageRating.value,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (value) {},
                                )),
                          ),
                          Obx(() => Text(
                                calculateProductRatingController
                                    .averageRating.value
                                    .toStringAsFixed(1),
                                style: TextStyle(fontSize: 16),
                              )),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child:
                                Text("Giá: " + widget.productModel.fullPrice)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text("Mô tả: " +
                                widget.productModel.productDescription)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text("Danh mục: " +
                                widget.productModel.categoryName.toString())),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //       alignment: Alignment.topLeft,
                      //       child: Text(
                      //           "categoryID: " + widget.productModel.categoryId)),

                      // ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                child: Container(
                                  width: Get.width / 3.0,
                                  height: Get.height / 16,
                                  decoration: BoxDecoration(
                                    color: AppConstant.appScendoryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: TextButton.icon(
                                    label: Text(
                                      "Tin nhắn",
                                      style: TextStyle(
                                          color: AppConstant.appTextColor),
                                    ),
                                    onPressed: () {
                                      //_googleSignInController.signInWithGoogle();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Material(
                                child: Container(
                                  width: Get.width / 3.0,
                                  height: Get.height / 16,
                                  decoration: BoxDecoration(
                                    color: AppConstant.appScendoryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: TextButton.icon(
                                    label: Text(
                                      "Thêm giỏ hàng",
                                      style: TextStyle(
                                          color: AppConstant.appTextColor),
                                    ),
                                    onPressed: () async {
                                      await checkProductExistence(
                                          uId: user!.uid);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              //reviews
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.productModel.productId)
                      .collection('review')
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: Get.height / 5,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No reviews found!"),
                      );
                    }

                    if (snapshot.data != null) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          ReviewModel reviewModel = ReviewModel(
                            customerName: data['customerName'],
                            customerPhone: data['customerPhone'],
                            customerDeviceToken: data['customerDeviceToken'],
                            customerId: data['customerId'],
                            feedback: data['feedback'],
                            rating: data['rating'],
                            createdAt: data['createdAt'],
                          );
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(reviewModel.customerName[0]),
                              ),
                              title: Text(
                                reviewModel.customerName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(reviewModel.feedback),
                              trailing: Text(reviewModel.rating),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }

  //thêm giỏ hàng
  Future<void> checkProductExistence(
      {required String uId, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });

      print("exists!");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });
      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice));
      await documentReference.set(cartModel.toMap());

      print("added");
    }
  }
}
