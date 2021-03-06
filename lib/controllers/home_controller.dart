import 'dart:convert';

import 'package:get/get.dart';
import 'package:pattern_getx/model/post_model.dart';
import 'package:pattern_getx/service/http_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var items = [].obs;

  void apiPostList() async {
    isLoading.value = true;
    var response = await Network.GET(Network.API_LIST, {});
    if (response != null) {
      items.value =
          List<Post>.from(jsonDecode(response).map((x) => Post.fromJson(x)));
    } else {
      items.value = [];
    }
    isLoading.value = false;
  }
  
  void apiPostDelete(Post post)async{
    isLoading.value = true;
    var response = await Network.DELETE(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if(response!=null){
      apiPostList();
    }
    isLoading.value = false;
  }
}
