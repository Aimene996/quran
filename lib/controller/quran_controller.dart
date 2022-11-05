import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quaran/services/new_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../model/quran_class.dart';

class FetchController extends GetxController {
  RxList<PostModal> posts = RxList();
  RxBool isLoading = true.obs;
  RxBool isCheckInternet = true.obs;
  RxBool isScrollToDown = true.obs;

  var url = "https://jsonplaceholder.typicode.com/posts";
  var itemScrollController = ItemScrollController();

  getPosts() async {
    checkerInternet();
    isLoading = true.obs;
    var response = await DioService().getMethod(url);
    if (response.statusCode == 200) {
      response.data.forEach(
        (e) {
          posts.add(PostModal.fromJson(e));
        },
      );
      isLoading.value = false;
    }
  }

  checkerInternet() async {
    isCheckInternet.value = await InternetConnectionChecker().hasConnection;
  }
  scrollListHandlerDown(){
        itemScrollController.scrollTo(
        index: posts.length-4, duration:const Duration(milliseconds: 2000),
        curve:Curves.fastOutSlowIn,

        );
        isScrollToDown.value=true;

  }
  scrollListHandlerUp(){
    itemScrollController.scrollTo(
      index: 0, duration:const Duration(milliseconds: 2000),
      curve:Curves.fastOutSlowIn,

    );
    isScrollToDown.value=false;

  }

  @override
  void onInit() {
    checkerInternet();
    getPosts();
    super.onInit();
  }
}
