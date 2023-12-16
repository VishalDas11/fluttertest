import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:fluttertest/model/reciepe_model.dart';

class AppService {
  static AppService? _instance;
  static AppService get getInstance => _instance ??= AppService();

  var apiKey = '4c92eaa998f64af1bf648b1ff1d21c7d';

  Future<List<ReciepeModel>> getProduct() async {
    List<ReciepeModel> recipeList = [];
    return Dio().get(
      'https://api.spoonacular.com/recipes/complexSearch',
      queryParameters: {'apiKey': apiKey},
    ).then((value) {
      var data = value.data['results'];
      for (var i = 0; i < data.length; i++) {
        recipeList.add(ReciepeModel.fromJson(data[i]));
      }
      log("reciepeList: $recipeList");
      return recipeList;
    }).onError((error, stackTrace) {
      log("Error $error");
      return recipeList;
    });
  }
}
