import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_api/apiController/todo_controller.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoController todoController = Get.put(TodoController());
  TextEditingController taskController = TextEditingController();
  TextEditingController editingController = TextEditingController();
var editdata;


  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: s.width * 0.25,
            right: s.width * 0.25,
            bottom: s.height * 0.015,
            top: s.height * 0.012),
        child: InkWell(
          onTap: () {
            AddNewData(teskName: "Add New Task");
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: s.width * 0.12, top: 3, bottom: 3),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add New",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All list of todo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Obx(() => Column(
                        children: todoController.todoList
                            .map(
                              (e) =>


                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: s.width*0.07,
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: s.width*0.52,
                                                child: Text(
                                                  e.title.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: s.width*0.3,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      EditNewData(
                                                        controller:e.title ,
                                                          id: e.id,


                                                          teskName: "Edit Task");
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                    color: Colors.white),
                                                IconButton(
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                          title: "Delete Task",
                                                          content: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "Do You Went to Delete"),
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child: Text(
                                                                          "No")),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        todoController.DeleteListData(e.id.toString());
                                                                        Get.back();
                                                                          },
                                                                      child: Text(
                                                                          "Yes")),
                                                                ],
                                                              )
                                                            ],
                                                          ));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                            .toList(),
                      ));
                }),
          )
        ],
      ),
    );
  }

  void AddNewData({
    teskName,
  }) {
    Get.defaultDialog(
        title: teskName,
        content: Column(
          children: [
            TextFormField(
              controller: taskController,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("cancel")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      todoController.postListData(taskController.text);
                      print(taskController.text.toString());
                      taskController.clear();
                      Get.back();
                    },
                    child: Text("Save")),
              ],
            )
          ],
        ));
  }
  void EditNewData({
    teskName,
    controller,
    id,
  }) {

    Get.defaultDialog(
        title: teskName,
        content: Column(
          children: [
            TextFormField(
             initialValue: controller,
              onChanged: (v){
                editdata=v;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("cancel")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                 todoController.EditListData(editdata, id);
                      taskController.clear();
                      Get.back();
                      print(id.toString());
                    },
                    child: Text("Save")),
              ],
            )
          ],
        ));
  }
}
