import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDataFetchingWidget extends StatefulWidget {
  @override
  _MyDataFetchingWidgetState createState() => _MyDataFetchingWidgetState();
}

class _MyDataFetchingWidgetState extends State<MyDataFetchingWidget> {
  List<Map<String, dynamic>> data = []; // Здесь будет
  // храниться полученная информация

  Future<void> fetchData() async {
    final response = await http.get(
      // Uri.parse('https://jsonplaceholder.typicode.com/users'),
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      // Если запрос успешен, преобразуйте ответ в JSON и обновите состояние виджета
      setState(() {
        data = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Вызов функции fetchData при инициализации виджета
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder Data'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['title']),
            subtitle: Text(data[index]['body']),
          );
        },
      ),
    );
  }
}
