import 'package:final_ecommerce/models/product_models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Trang làm chi tiết các mặt hàng chuyển qua "homme.dart"
class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1; // gán giá trị mặc định lần đầu =1 trong details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {}, icon: Icon(Icons.shopping_cart),
            //tạo ra Icon shopping cart chuyển qua theme để thiết kế màu ...
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.singleProduct.image,
              height: 400,
              width: 600,
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // làm khoảng cách giữa
              children: [
                Text(
                  widget.singleProduct.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        //setState() được sử dụng để cập nhật trạng thái của widget
                        widget.singleProduct.isFavouraite = !widget
                            .singleProduct
                            .isFavouraite; //isFavouraite của đối tượng singleProduct được đảo ngược
                      });
                    },
                    icon: Icon(widget.singleProduct.isFavouraite
                        ? Icons.favorite
                        : Icons.favorite_border)), // icon trái tim
              ],
            ),
            Text(widget.singleProduct.description), // mô tả lấy từ cơ sở
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    if (qty >= 1) {
                      setState(() {
                        qty--; // nếu đúng thì  thì nó sẽ giảm giá trị của qty đi 1 và cập nhật lại giao diện của ứng dụng.
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: 
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.remove),
                  ),
                ),
                const SizedBox(
                  width: 6.0, // làm cách 2 icon
                ),
                Text(
                  qty.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 6.0, // làm cách 2 icon
                ),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  // HIỆU ỨNG VIỀN
                  onPressed: () {},
                  child: const Text("ADD TO CART"),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Đặt giá trị border radius là 0 để có góc vuông
                      ),
                    ),
                    child: const Text("BUY"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
