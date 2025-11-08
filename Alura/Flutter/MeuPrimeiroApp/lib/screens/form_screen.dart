// Importa o pacote principal do Flutter para construir a interface do usuário.
import 'package:flutter/material.dart';
import 'package:meu_primeiro_app/data/task_inherited.dart';

// Cria um StatefulWidget, que é um widget que pode ter seu estado alterado.
// Ideal para formulários, animações ou qualquer tela que precise ser redesenhada.
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

// A classe de estado para FormScreen, onde a lógica e as variáveis de estado são gerenciadas.
class _FormScreenState extends State<FormScreen> {
  // Controladores para os campos de texto. Eles permitem acessar e manipular o texto.
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  // Uma chave global que identifica unicamente o widget Form.
  // É usada para validar o formulário.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // O widget Form atua como um contêiner para agrupar e validar
    // vários campos de formulário (TextFormField).
    return Form(
      key: _formKey,
      child: Scaffold(
        // Barra de aplicativo no topo da tela.
        appBar: AppBar(
          title: const Text(
            'Nova Tarefa',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        // Corpo principal da tela.
        body: Center(
          // Garante que o conteúdo seja rolável se a tela for pequena (evita overflow).
          child: SingleChildScrollView(
            child: Container(
              // Define um tamanho fixo para o contêiner do formulário.
              height: 650,
              width: 375,
              // Decoração para estilizar o contêiner.
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              // Organiza os widgets filhos em uma coluna vertical.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribui o espaço verticalmente.
                crossAxisAlignment: CrossAxisAlignment.center,   // Centraliza os itens horizontalmente.
                children: [
                  // Campo de texto para o nome da tarefa.
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // Função de validação para o campo.
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira o nome da Tarefa'; // Mensagem de erro se o campo estiver vazio.
                        }
                        return null; // Retorna null se a validação passar.
                      },
                      controller: nameController, // Associa o controlador ao campo.
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  // Campo de texto para a dificuldade da tarefa.
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // Validador para garantir que a dificuldade seja um número entre 1 e 5.
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) > 5 ||
                            int.parse(value) < 1) {
                          return 'Insira a dificuldade da Tarefa entre 1 e 5';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number, // Define o teclado para numérico.
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
                  // Campo de texto para a URL da imagem.
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Insira uma URL válida da Tarefa';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url, // Define o teclado para URLs.
                      // A função onChanged é chamada toda vez que o texto muda.
                      onChanged: (text) {
                        // setState() reconstrói o widget para atualizar a pré-visualização da imagem.
                        setState(() {});
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
                  // Contêiner para a pré-visualização da imagem.
                  Container(
                    height: 125,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    // ClipRRect corta os cantos da imagem para que ela se ajuste ao borderRadius do Container.
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Tenta carregar a imagem da URL fornecida no imageController.
                      child: Image.network(
                        imageController.text,
                        fit: BoxFit.cover, // Cobre todo o espaço do contêiner.
                        // O errorBuilder é chamado se a URL for inválida ou a imagem não puder ser carregada.
                        errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                            ) {
                          // Exibe uma imagem local como placeholder em caso de erro.
                          return Image.asset('assets/images/nophoto.png');
                        },
                      ),
                    ),
                  ),
                  // Botão para submeter o formulário.
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      textStyle: WidgetStateProperty.all(
                        TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Verifica se todos os validadores do formulário retornam null.
                      if (_formKey.currentState!.validate()) {
                        // Se for válido, cria a tarefa.
                        TaskInherited.of(context).newTask(nameController.text, imageController.text, int.parse(difficultyController.text));

                        // Mostra uma mensagem de sucesso na parte inferior da tela.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tarefa adicionada com sucesso!'),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
