import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Nova Tarefa',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 650,
            width: 375,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: difficultyController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Dificuldade',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    onChanged: (text){
                      setState(() {

                      });
                    },
                    controller: imageController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Imagem',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  height: 125,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.blue),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageController.text,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                        return Image.asset('assets/images/nophoto.png');
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  onPressed: (){
                    print(nameController.text);
                    print(int.parse(difficultyController.text));
                    print(imageController.text);
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
