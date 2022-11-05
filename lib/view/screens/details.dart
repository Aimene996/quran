import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quaran/controller/quran_controller.dart';

class Details extends StatelessWidget {
   Details({required this.index, Key? key}) : super(key: key);
  FetchController fetchController=Get.find<FetchController>();

int  index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: const Text("Details"),
        ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(fetchController.posts[index].id.toString()),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(fetchController.posts[index].title.toUpperCase(),textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(fetchController.posts[index].body,textAlign: TextAlign.center,),
            ),





          ],),
      )
    );
  }
}
