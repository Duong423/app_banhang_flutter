// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:app_banhang/screens/auth-ui/manHinhChoDangNhap.dart';
import 'package:app_banhang/screens/user-panel/tatCa-DanhMuc-Screen.dart';
import 'package:app_banhang/screens/user-panel/tatCa-SanPhamGiamGia-Screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:app_banhang/widgets/tatCa-SanPham-widget.dart';
import 'package:app_banhang/widgets/banner-widget.dart';
import 'package:app_banhang/widgets/danhMuc-widget.dart';
import 'package:app_banhang/widgets/custom-drawer-widget.dart';
import 'package:app_banhang/widgets/heading-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widgets/giamGia-widget.dart';
import 'tatCa-SanPham-Screen.dart';
import 'gioHang-Screen.dart';
import 'timKiem.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConstant.appScendoryColor,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Mở màn hình tìm kiếm hoặc hiển thị một hộp tìm kiếm.
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search, // Icon tìm kiếm
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),
              Text(""),
              BannerWidget(),

              ///heading
              HeadingWidget(
                headingTitle: "Danh mục hàng",
                headingSubTitle: "Bấm 'xem thêm' để xem chi tiết",
                onTap: () => Get.to(() => AllCategoriesScreen()),
                buttonText: "Xem thêm >",
              ),

              CategoriesWidget(),

              HeadingWidget(
                headingTitle: "Giảm giá",
                headingSubTitle: "Bấm 'xem thêm' để xem chi tiết",
                onTap: () => Get.to(() => AllFlashSaleProductScreen()),
                buttonText: "Xem thêm >",
              ),

              FlashSaleWidget(),

              HeadingWidget(
                headingTitle: "Tất cả sản phẩm",
                headingSubTitle: "Bấm 'xem thêm' để xem chi tiết",
                onTap: () => Get.to(() => AllProductsScreen()),
                buttonText: "Xem thêm >",
              ),

              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
