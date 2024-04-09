import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:final_ecommerce/models/category_model/category_model.dart';
import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:final_ecommerce/screens/auth_ui/category_view/category_view.dart';
import 'package:final_ecommerce/screens/product_details/product_details.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
   
  bool isLoanding = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList()async{
    setState(() {
      isLoanding = true;
    });
    categoriesList =  await FirebaseFirestoreHelper.instance.getCategories();
    productModelList =  await FirebaseFirestoreHelper.instance.getBestProducts();
   productModelList.shuffle();  
    setState(() {
      isLoanding = false;
          });
      }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoanding?Center(child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),) :SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 205.0,
                        top: 6), // Giảm giá trị top xuống 10 đơn vị
                    child: TopTitles(subtitle: "", title: "TĐ Ecommerce"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                       top: 0
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Search....",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 260.0),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
           categoriesList.isEmpty?Center(child: Text("Categories is empty"),
           ) : SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Đặt hướng cuộn là ngang
              child: Row(
                children: categoriesList
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0,
                              left:
                                  4.0), // Điều chỉnh khoảng cách giữa các phần tử
                          child: CupertinoButton( // là thiết kế giao diện gần như IOS
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Routes.instance.push(widget: CategoryView(categoryModel: e), context: context);
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 13.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), //độ bo góc của card là thành phần nằm dưới để tấm ảnh vô khuôn
                              ),
                              child: ClipRRect(
                                // Áp dụng độ bo góc cho ảnh
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(e.image
                                   // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 1.0,
                left: 2.0,
              ),
              child: SizedBox(
                height: 12.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 240.0),
              child: Text(
                "Best Product",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
           productModelList.isEmpty?Center(child: Text("Best Products is empty"),
           ):Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
              child: GridView.builder(
                padding: EdgeInsets
                    .zero, //  không có bất kỳ khoảng trống nào xung quanh nó.
                // kéo dưới phần best pro gần nó hơn
                shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(), // Ngăn cuộn tự động của GridView
                itemCount: productModelList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing:20, // chỉnh khoảng cách giữa các productModel
                  crossAxisSpacing: 18, // chỉnh khoảng cách giữa các productModel
                  childAspectRatio: 0.9, //chiều rộng của mỗi mục con sẽ là 80% chiều cao của nó
                  crossAxisCount: 2, // chỉnh product 2 sản phẩm nằm trên dòng
                ),
                itemBuilder: (ctx, index) {
                  // Lấy ra đối tượng ProductModel từ danh sách bestProducts
                  ProductModel singleProduct = productModelList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 39, 155, 249)
                          .withOpacity(0.5), //chỉnh độ đạm nhạc của màu nền
                      borderRadius:
                          BorderRadius.circular(10.0), // Độ bo góc 10.0
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
                              Routes.instance.push(widget: ProductDetails(singleProduct: singleProduct), context: context);
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
          const SizedBox(height: 12.0,),
          ],
        ),
      ),
    );
  }
}

// List<String> categoriesList = [
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRWlvZecWiUleGf5gmQGybdb5uJH39rl56mQ&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuATYwGWWlJsLlrkGcr9t_1exozfu_RDKYj6HVJbzNw2DW0Gb0tMk-sttAk2tMUZaDUSE&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaKgorUKxroGEo-lMcLiJj2gT76k5uINKJjQ&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTFw21efqheE9RtPvcmyIo3Gd6MXuKG8wRbA&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqAqmqMVYDQsZQzFuf3Kh6SRWzIB6wT7WOVw&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7156KJGgLP5_ph5fjotrL0de4PYfAS5AGFQ&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT05aiS9rQIGng4GTdba5QrTyD19ifmegJhJOhSry6eVPo_s9wcWfdtwRRScgv6rLyn810&usqp=CAU",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIFntj51xH5GZ2Vj4QhIDHfyK4HiqwZ8cwnQ&usqp=CAU"
// ];

// List<ProductModel> bestProducts = [
//   ProductModel(
//     image:
//         "https://vcdn.tikicdn.com/ts/tmp/e5/0b/da/886eb5f9849c728433540b87a9910a32.jpg",
//     id: "1",
//     name: "Ethernet Lan",
//     price: "20",
//     status: "pending",
//     description: "It's use quite ok. People should buy it?",
//     isFavouraite: false,
//   ),
//   ProductModel(
//     image:
//         "https://tse4.mm.bing.net/th?id=OIP._ne0oEcicAdTs5qxGbREFAHaFZ&pid=Api&P=0&h=180",
//     id: "3",
//     name: "Iphone 13",
//     price: "200",
//     status: "pending",
//     description: "Iphone this 13 looking lady.",
//     isFavouraite: false,
//   ),
//   ProductModel(
//     image:
//         "https://tse4.mm.bing.net/th?id=OIP.QX9o43DgoMsRcgRJn8XLAAHaC7&pid=Api&P=0&h=180",
//     id: "3",
//     name: "Keyboard",
//     price: "200",
//     status: "pending",
//     description: "Iphone this 13 looking lady.",
//     isFavouraite: false,
//   ),
//   ProductModel(
//     image:
//         "https://vcdn.tikicdn.com/ts/tmp/e5/0b/da/886eb5f9849c728433540b87a9910a32.jpg",
//     id: "1",
//     name: "Ethernet Lan",
//     price: "20",
//     status: "pending",
//     description: "It's use quite ok. People should buy it?",
//     isFavouraite: false,
//   ),
  
// ];
