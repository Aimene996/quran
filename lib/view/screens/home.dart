import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../controller/quran_controller.dart';
import 'details.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  FetchController fetchController = Get.put(FetchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        centerTitle: true,
        title: const Text("Restful API - Dio"),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            fetchController.isScrollToDown.value
                ? fetchController.scrollListHandlerUp()
                : fetchController.scrollListHandlerDown();
          },
          child: fetchController.isScrollToDown.value
              ? const Icon(Icons.arrow_upward)
              : const Icon(Icons.arrow_downward),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Obx(
            () =>
            fetchController.isCheckInternet.value?
            fetchController.isLoading.value ? loading() : bodySection():
            internetChecker(),
          )),
    );
  }

  Widget bodySection() {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: () {
        return fetchController.getPosts();
      },
      child: ScrollablePositionedList.builder(
          itemScrollController: fetchController.itemScrollController,
          itemCount: fetchController.posts.length,
          itemBuilder: ((ctx, i) {
            return InkWell(
              onTap: () {
                Get.to(
                  Details(index: i),
                  transition: Transition.cupertino,
                );
              },
              child: Card(
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(fetchController.posts[i].id.toString()),
                    ),
                  ),
                  title: Text(fetchController.posts[i].title.toString()),
                  subtitle: Text(fetchController.posts[i].body.toString()),
                ),
              ),
            );
          })),
    );
  }

  Widget loading() {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Lottie.asset("assets/a.json"),
      ),
    );
  }

 Widget internetChecker() {
    return
   Center(
     child: Column(

       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         SizedBox(
           height: 150,
           width: 150,
           child: Lottie.asset("assets/b.json"),
         ),
         TextButton(

             onPressed: ()async {
               if(await InternetConnectionChecker().hasConnection == true){
                 fetchController.getPosts();
               }else{
                 Get.snackbar('Warnning', "Failled Internet", duration: const Duration(milliseconds: 1000));
               }

             }, child: const Text("Try Again"))
       ],
     ),
   );
 }
}

