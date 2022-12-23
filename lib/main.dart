import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restroapiproject/model.dart';
import 'package:restroapiproject/response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectValue = 'All';
  final res = Responses();
  List<Model> data = [];
  List<Model> alltrue = [];
  List<Model> allfalse = [];
  final item = [
    'All',
    'true',
    'false',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    data = await res.fetchData();

    alltrue = data.where((element) => element.completed).toList();

    allfalse = data.where((element) => !element.completed).toList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          DropdownButton(
            hint: const Text('Select'),
            value: selectValue,
            items: item.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectValue = value!;
              });
            },
          ),
          Expanded(
            child: Column(
              children: [
                if (selectValue == 'true')
                  Expanded(
                    child: ListView.builder(
                      itemCount: alltrue.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(alltrue[index].id.toString()),
                          title: Text(alltrue[index].title),
                          trailing: Text(alltrue[index].completed.toString()),
                        );
                      },
                    ),
                  )
                else if (selectValue == 'false')
                  Expanded(
                    child: ListView.builder(
                      itemCount: allfalse.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(allfalse[index].id.toString()),
                          title: Text(allfalse[index].title),
                          trailing: Text(allfalse[index].completed.toString()),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(data[index].id.toString()),
                          title: Text(data[index].title),
                          trailing: Text(data[index].completed.toString()),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
