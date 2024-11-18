import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/product-model.dart';
import 'chiTiet-SanPham-Screen.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel?> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Xóa văn bản tìm kiếm
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Đóng tìm kiếm
      },
    );
  }
//////////////////////TÌM KIẾM////////////////
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('products')
          .where('productName', isGreaterThanOrEqualTo: query)
          .where('productName', isLessThanOrEqualTo: query + '\uf8ff') // Tìm kiếm gần đúng
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Không tìm thấy sản phẩm nào.'));
        }

        final products = snapshot.data!.docs.map((doc) {
          return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.productName),
              subtitle: Text(product.productDescription),
              onTap: () {
                // Điều hướng đến trang chi tiết sản phẩm
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(productModel: product),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }


//////////////////////////ĐỀ XUẤT////////////////////
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Nhập tên sản phẩm để tìm kiếm.'));
    }

    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('products')
          .where('productName', isGreaterThanOrEqualTo: query)
          .where('productName', isLessThanOrEqualTo: query + '\uf8ff') // Gợi ý gần đúng
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Không có gợi ý.'));
        }

        final products = snapshot.data!.docs.map((doc) {
          return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.productName),
              subtitle: Text(product.productDescription),
              onTap: () {
                query = product.productName; // Điền tên sản phẩm vào ô tìm kiếm
                showResults(context); // Hiển thị kết quả
              },
            );
          },
        );
      },
    );
  }
}
