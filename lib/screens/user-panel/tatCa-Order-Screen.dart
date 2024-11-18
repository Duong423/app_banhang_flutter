// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import '/models/order-model.dart';
import '/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/giaGioHang-controller.dart';
import 'chiTietSanPhamOrder.dart';
import 'them-DanhGia-Screen.dart';
//import 'add_reviews_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'Đơn hàng',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              child: Text("No products found!"),
            );
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    //documentid: productData['documentid'],
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: double.parse(
                        productData['productTotalPrice'].toString()),
                    customerId: productData['customerId'],
                    status: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken'],
                  );

                  //calculate price
                  productPriceController.fetchProductPrice();
                  // return Card(
                  //   elevation: 5,
                  //   color: AppConstant.appTextColor,
                  //   child: ListTile(
                  //     leading: CircleAvatar(
                  //       backgroundColor: AppConstant.appMainColor,
                  //       backgroundImage:
                  //           NetworkImage(orderModel.productImages[0]),
                  //     ),
                  //     title: Text(orderModel.productName),
                  //     subtitle: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Text(orderModel.productTotalPrice.toString()),
                  //         SizedBox(
                  //           width: 10.0,
                  //         ),
                  //         orderModel.status != true
                  //             ? Text(
                  //                 "Pending..",
                  //                 style: TextStyle(color: Colors.green),
                  //               )
                  //             : Text(
                  //                 "Deliverd",
                  //                 style: TextStyle(color: Colors.red),
                  //               )
                  //       ],
                  //     ),
                  //     trailing: orderModel.status == true
                  //         ? ElevatedButton(
                  //             onPressed: () => Get.to(
                  //               () => AddReviewScreen(
                  //                 orderModel: orderModel,
                  //               ),
                  //             ),
                  //             child: Text("Review"),
                  //           )
                  //         : SizedBox.shrink(),
                  //   ),
                  // );
                  return SwipeActionCell(
                      key: ObjectKey(orderModel.productId),
                      trailingActions: [
                        SwipeAction(
                          title: "Xóa",
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          onTap: (CompletionHandler handler) async {
                            try {
                              //String documentId = orderModel.documentid;
                              await FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc(user!.uid)
                                  .collection('confirmOrders')
                                  .doc(orderModel.productId)
                                  .delete();

                              setState(() {
                                // Cập nhật lại danh sách đơn hàng của bạn sau khi xóa
                                snapshot.data!.docs.removeWhere((doc) =>
                                    doc['productId'] == orderModel.productId);
                              });
                              print("Deleted successfully");
                              handler(true); // Xác nhận hoàn tất hành động vuốt
                            } catch (e) {
                              print("Error deleting order: $e");
                              handler(
                                  false); // Thông báo lỗi nếu xóa không thành công
                            }
                          },
                        )
                      ],
                      child: GestureDetector(
                        onTap: () {
                          // Điều hướng đến trang chi tiết sản phẩm đã order và truyền dữ liệu orderModel
                          Get.to(() =>
                              CheckSingleOrderScreen(orderModel: orderModel, docId: '',));
                        },
                        child: Card(
                          elevation: 5,
                          color: AppConstant.appTextColor,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppConstant.appMainColor,
                              backgroundImage:
                                  NetworkImage(orderModel.productImages[0]),
                            ),
                            title: Text(orderModel.productName),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(orderModel.productTotalPrice.toString()),
                                SizedBox(width: 10.0),
                                orderModel.status != true
                                    ? Text(
                                        "Chờ xác nhận",
                                        style: TextStyle(color: Color.fromARGB(255, 239, 183, 69)),
                                      )
                                    : Text(
                                        "Đã xác nhận",
                                        style: TextStyle( color: Colors.green),
                                      ),
                              ],
                            ),
                            trailing: orderModel.status == true
                                ? ElevatedButton(
                                    onPressed: () => Get.to(
                                      () => AddReviewScreen(
                                        orderModel: orderModel,
                                      ),
                                    ),
                                    child: Text("Review"),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                      ));
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
