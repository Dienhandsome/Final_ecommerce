import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/models/category_model/category_model.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/screens/product_details/product_details.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoanding = false;
  void getCategoryList() async {
    setState(() {
      isLoanding = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    //gọi vào Firestore để lấy danh sách các sản phẩm từ một danh mục cụ thể và sau đó sử dụng danh sách đó để hiển thị thông tin trong giao diện người dùng.
    productModelList.shuffle();
    setState(() {
      isLoanding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoanding
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
            child: Column(
                children: [
                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: TopTitles(subtitle: "", title: widget.categoryModel.name),
                   ),
                  
                  productModelList.isEmpty
                      ? Center(
                          child: Text("Best Products is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 8.0, right: 8.0),
                          child: GridView.builder(
                            padding: EdgeInsets
                                .zero, //  không có bất kỳ khoảng trống nào xung quanh nó.
                            // kéo dưới phần best pro gần nó hơn
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Ngăn cuộn tự động của GridView
                            itemCount: productModelList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing:
                                  20, // chỉnh khoảng cách giữa các productModel
                              crossAxisSpacing:
                                  18, // chỉnh khoảng cách giữa các productModel
                              childAspectRatio:
                                  0.9, //chiều rộng của mỗi mục con sẽ là 80% chiều cao của nó
                              crossAxisCount:
                                  2, // chỉnh product 2 sản phẩm nằm trên dòng
                            ),
                            itemBuilder: (ctx, index) {
                              // Lấy ra đối tượng ProductModel từ danh sách bestProducts
                              ProductModel singleProduct =
                                  productModelList[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 39, 155, 249)
                                      .withOpacity(
                                          0.5), //chỉnh độ đạm nhạc của màu nền
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Độ bo góc 10.0
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Độ bo góc 10.0 cho hình ảnh
                                      child: Image.network(
                                        singleProduct.image,
                                        height: 70,
                                        width: 120, // kích thước ảnh product
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      singleProduct.name,
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Price: \$${singleProduct.price}"),
                                    //Price: $ hiện thị gái trị sản phẩm
                                    // ${singleProduct.price}: Đây là một biểu thức nội suy (interpolation) của Dart
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 140,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // Hành động khi nhấn nút mua
                                          Routes.instance.push(
                                              widget: ProductDetails(
                                                  singleProduct: singleProduct),
                                              context: context);
                                        },
                                        child: const Text(
                                          "Buy",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
          ),
    );
  }
}
