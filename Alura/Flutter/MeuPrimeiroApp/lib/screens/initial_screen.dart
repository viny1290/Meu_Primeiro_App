import 'package:flutter/material.dart';
import 'package:meu_primeiro_app/data/task_inherited.dart';
import 'package:meu_primeiro_app/screens/form_screen.dart';
import '../components/tasks.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Flutter: Primeiros Passos',
            style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
            Icons.add_task,
            color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color.fromARGB(255, 208, 221, 237),
        child: ListView(
          children: TaskInherited.of(context).taskList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen()));
        },
        backgroundColor: Colors.blue[100],
        child: const Icon(Icons.add),
      ),
    );
  }
}