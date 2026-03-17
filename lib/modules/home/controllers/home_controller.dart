import 'package:get/get.dart';

class HomeController extends GetxController{
  RxInt _carrouselIndex = 0.obs;

  int get index => _carrouselIndex.value;

  void changeIndex(int newIndex){
    _carrouselIndex(newIndex);
  }
}