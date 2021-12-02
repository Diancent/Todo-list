import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      home: MyHomePage(
        title: 'Todo List',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TodoItem> todoList = <TodoItem>[];
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text(widget.title),
      ),
      body: ListView(
        children: List.generate(todoList.length, (index) {
          final item = todoList[index];
          return Dismissible(
            key: ObjectKey(todoList[index]),
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
              });
            },
            background: Container(
              color: Color.fromRGBO(236, 80, 96, 1),
            ),
            child: CheckboxListTile(
                value: item.checked,
                tristate: false,
                onChanged: (bool? value) {
                  var element = item.copyWith(checked: value == true);

                  setState(() => todoList[index] = element);
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green[800],
                title: Text(item.title)),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Додайте задачу до свого списку'),
                content: TextField(
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Введіть задачу'),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      addItemToList(textController.text);
                    },
                    child: Text('Add'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(236, 80, 96, 1)),
                      ))
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[800],
      ),
    );
  }

  void addItemToList(String title) {
    setState(() {
      todoList.add(TodoItem(title: title, checked: false));
    });

    textController.clear();
  }

  Widget buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }
}

class TodoItem {
  const TodoItem({
    required this.title,
    required this.checked,
  });

  final String title;
  final bool checked;

  TodoItem copyWith({String? title, bool? checked}) {
    return TodoItem(
      title: title ?? this.title,
      checked: checked ?? this.checked,
    );
  }
}
