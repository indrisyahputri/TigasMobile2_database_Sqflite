import 'package:indrisyahputri_2018020764/TaskModel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indri Syahputri',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DAFTAR BELANJAAN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  List<TaskModel> tasks = [];

  TaskModel currentTask;

  final TodoHelper _todoHelper = TodoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          TextField(
            controller: textController,
          ),
          FlatButton(
            child: Text("Input Belanjaan"),
            onPressed: () {
              currentTask = TaskModel(belanja: textController.text);
              _todoHelper.insertTask(currentTask);
            },
            color: Colors.blue,
            textColor: Colors.white,
          ),
          FlatButton(
            child: Text("tampil Daftar Belanjaan"),
            onPressed: () async {
              List<TaskModel> list = await _todoHelper.getAllTask();

              setState(() {
                tasks = list;
              });
            },
            color: Colors.red,
            textColor: Colors.white,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${tasks[index].id}"),
                  title: Text("${tasks[index].belanja}"),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    ));
  }
}
