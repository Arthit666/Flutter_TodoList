// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      title: 'My Todo List',
      home: TodoBody(),
    );
  }
}

class TodoBody extends StatefulWidget {
  const TodoBody({Key? key}) : super(key: key);

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  List<String> todo = [];
  TextEditingController input = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo.add('Sample todo..');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todo List')),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text('Add Todo List'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter the Todo',
                        ),
                        controller: input,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            todo.add(input.text);
                            input.clear();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          input.clear();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget getListView() {
    return ListView.builder(
      itemCount: todo.length,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key: Key(todo[index]),
            onDismissed: (DismissDirection direction) {
              setState(() {
                todo.removeAt(index);
              });
            },
            child: Card(
              margin: EdgeInsets.all(6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  trailing: Wrap(
                    spacing: -10,
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              input.text = todo[index];
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: const Text('Edit Todo'),
                                content: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                      controller: input,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      }),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          todo[index] = input.text;
                                          input.clear();
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        input.clear();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        color: Colors.blue,
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            todo.removeAt(index);
                          });
                        },
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  title: Text(
                    '${todo[index]}',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
