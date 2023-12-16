import 'dart:developer';
import 'package:fluttertest/model/reciepe_model.dart';
import 'package:get/get.dart';
import '../app_service.dart';

class StateController extends GetxController {
  RxBool loading = true.obs;
  RxList<ReciepeModel> productList = <ReciepeModel>[].obs;

  RxList<ReciepeModel> filteredRecipes = <ReciepeModel>[].obs;

  @override
  void onInit() {
    getGroceryProduct();
    super.onInit();
  }

  void getGroceryProduct() {
    loading.value = true;
    AppService.getInstance.getProduct().then((value) {
      productList.assignAll(value);
      log("getx value $value");
      loading.value = false;
    }).onError((error, stackTrace) {
      loading.value = false;
      log("getx error $error");
    });
  }

  void filterRecipesByTitle(String title) {
    filteredRecipes.clear();
    filteredRecipes.addAll(
      productList.where(
        (recipe) => recipe.title!.toLowerCase().contains(title.toLowerCase()),
      ),
    );
    update();
  }
}
