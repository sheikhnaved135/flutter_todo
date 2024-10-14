import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> todoList = [];
  var todoController = TextEditingController();
  num id = 3;

  handleAddTodo() {
    if (todoController.text.toString().trim() == '') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please type something'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok')),
              ],
            );
          });
      return;
    }
    id++;
    todoList.insert(0, {
      'id': id.toString(),
      'name': todoController.text.toString(),
      'editable': false
    });
    setState(() {});
    todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightGreenAccent,
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 190, 241, 132), // Light green at the top
          Color.fromARGB(255, 137, 239, 141), // Second green
          Color.fromARGB(255, 54, 179, 126), // Teal green
          Color.fromARGB(255, 25, 148, 110),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter a todo',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        handleAddTodo();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(
                                255, 190, 241, 132), // Light green at the top
                            const Color.fromARGB(255, 137, 239, 141),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.5)),
                  child: todoList.isEmpty
                      ? const Center(
                          child: Text(
                            'No todos found',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.builder(
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            var item = todoList[index];
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(width: 0.2)),
                                height: 70,
                                margin: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: item['editable']
                                          ? Container(
                                              width: 200,
                                              child: TextField(
                                                controller: todoController,
                                                decoration: InputDecoration(
                                                    hintText: item['name']),
                                              ),
                                            )
                                          : Container(
                                              width: 200,
                                              child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    Text(
                                                      item['name'].toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ]),
                                            ),
                                    ),
                                    Row(
                                      children: [
                                        item['editable']
                                            ? IconButton(
                                                onPressed: () {
                                                  if (todoController.text
                                                          .toString()
                                                          .trim() ==
                                                      '') {
                                                    return;
                                                  }
                                                  item['name'] = todoController
                                                      .text
                                                      .toString();
                                                  item['editable'] = false;
                                                  setState(() {
                                                    todoController.clear();
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  size: 32,
                                                ))
                                            : IconButton(
                                                onPressed: () {
                                                  todoList.forEach((ele) =>
                                                      ele['editable'] = false);
                                                  var result = todoList
                                                      .firstWhere((element) =>
                                                          element['id'] ==
                                                          item['id']);
                                                  result['editable'] = true;
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.edit)),
                                        item['editable']
                                            ? IconButton(
                                                onPressed: () {
                                                  todoList.forEach((ele) =>
                                                      ele['editable'] = false);
                                                  setState(() {
                                                    todoController.clear();
                                                  });
                                                },
                                                icon: Icon(Icons.cancel))
                                            : IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    todoList.removeWhere(
                                                        (element) =>
                                                            element['id'] ==
                                                            item['id']);
                                                  });
                                                },
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
