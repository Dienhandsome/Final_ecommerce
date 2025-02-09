
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blue,
  outlinedButtonTheme: OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: Colors.blue,
                              side: const BorderSide(
                                color: Colors.blue,
                                width: 1.7,
                            
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Độ bo góc 10
                              ),
                              backgroundColor: Colors.blue
                                  .withOpacity(0.38),
  )
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,// kiểu viền cho trường nhập liệu khi nó không có lỗi
    errorBorder: outlineInputBorder, // kiểu viền cho trường nhập liệu khi nó có lỗi.
    enabledBorder: outlineInputBorder, //trường nhập liệu khi nó được kích hoạt nhưng không được tập trung nhập sai ô
    prefixIconColor: Colors.blue,
    suffixIconColor: Colors.grey,
    focusedBorder: outlineInputBorder, // nhập đúng ô
    disabledBorder: outlineInputBorder, //trường nhập liệu khi nó bị vô hiệu hóa.(không thể tương tác và koong thể thay đổi dữ liệu mà chỉ được xem)
    ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      disabledBackgroundColor: Colors.grey,
      textStyle: const TextStyle(
        fontSize: 18.0,
      ),
      disabledForegroundColor: Colors.grey,
     ),
    ),
    canvasColor: Colors.blue, //canvasColor thường được sử dụng để thiết lập màu nền cho các phần tử như Scaffold, Drawer, BottomNavigationBar,
    appBarTheme:  const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black)
    )
);


 OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  // dùng để tái sử dụng nhiều lần dễ dàng hơn khi gọi nó
       borderSide: BorderSide(
        color: Colors.grey,
       ),
    );