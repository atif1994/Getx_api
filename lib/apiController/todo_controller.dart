import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_api/model/Todo_model.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  var todoList = RxList<TodoModel>();

  @override
  void onInit() {
    super.onInit();
    getListData();
  }

  Future<RxList<TodoModel>> getListData() async {
    final response = await http.get(
      Uri.parse("https://6475809ce607ba4797dbf4ea.mockapi.io/listdata"),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        todoList.add(TodoModel.fromJson(index));
      }
      return todoList;
    } else {
      return todoList;
    }
  }

  //post Getx Api
  Future<void> postListData(title) async {
    final response = await http.post(
        Uri.parse("https://6475809ce607ba4797dbf4ea.mockapi.io/listdata"),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({'title': title}));
    if (response.statusCode == 201) {
      todoList.clear();
      getListData();
      print(response.body.toString());

    }
    else{
      print("loading data");
    }
  }
  Future<void> EditListData(title,id) async {
    final response = await http.put(
        Uri.parse("https://6475809ce607ba4797dbf4ea.mockapi.io/listdata?id=$id&title=$title"),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({'title': title,
        "id":id}));
    if (response.statusCode == 201) {
      todoList.clear();
      getListData();
      print(response.body.toString());
      print("Edit successfulluy");

    }
    else{
      print("loading data error");
    }
  }
  Future<void> DeleteListData(id) async {
    final response = await http.delete(
        Uri.parse("https://6475809ce607ba4797dbf4ea.mockapi.io/listdata/$id"));

    if (response.statusCode == 200) {
      todoList.clear();
      getListData();
      print(response.body.toString());
      print("Delete successfulluy");

    }
    else{
      print("loading data error");
    }
  }
}
