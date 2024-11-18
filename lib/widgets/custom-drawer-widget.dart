// ignore_for_file: must_be_immutable, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:app_banhang/screens/user-panel/tatCa-Order-Screen.dart';
import 'package:app_banhang/screens/user-panel/gioHang-Screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:app_banhang/widgets/custom-drawer-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth-ui/manHinhChoDangNhap.dart';
import '../screens/user-panel/chiTiet-SanPham-Screen.dart';
import 'custom-drawer-widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "DuongNguyen",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                subtitle: Text("version 1.0.1",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Color.fromARGB(255, 4, 148, 35),
                  child: Text("D",
                      style: TextStyle(color: AppConstant.appTextColor)),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Trang chủ",
                    style: TextStyle(color: AppConstant.appTextColor)),
                //subtitle: Text("version 1.0.1"),
                leading: Icon(Icons.home, color: AppConstant.appTextColor),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: ListTile(
            //     titleAlignment: ListTileTitleAlignment.center,
            //     title: Text("Products",
            //         style: TextStyle(color: AppConstant.appTextColor)),
            //     //subtitle: Text("version 1.0.1"),
            //     leading: Icon(Icons.production_quantity_limits,
            //         color: AppConstant.appTextColor),
            //     trailing:
            //         Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
            //   ),
            // ),
            Padding(
              
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () => Get.to(() =>
                          AllOrdersScreen()),
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Đơn hàng",
                    style: TextStyle(color: AppConstant.appTextColor)),
                //subtitle: Text("version 1.0.1"),
                leading:
                    Icon(Icons.shopping_bag, color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Liên hệ",
                    style: TextStyle(color: AppConstant.appTextColor)),
                //subtitle: Text("version 1.0.1"),
                leading: Icon(Icons.help, color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Đăng xuất",
                    style: TextStyle(color: AppConstant.appTextColor)),
                //subtitle: Text("version 1.0.1"),
                leading: Icon(Icons.logout, color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appScendoryColor,
      ),
    );
  }
}
