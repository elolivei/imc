import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //retira a tarja indicando que está em debug
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplicação Responsiva'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variaveis usadas na montagem da tela
  final List<String> rotuloBotao = [
    "7",
    "8",
    "9",
    "Enter",
    "4",
    "5",
    "6",
    ".",
    "1",
    "2",
    "3",
    "0"
  ];
  final List<double> valorBotao = [
    7.0,
    8.0,
    9.0,
    -1,
    4.0,
    5.0,
    6.0,
    -2,
    1.0,
    2.0,
    3.0,
    0.0
  ];
  final List<String> rotuloLabel = ["Peso", "Altura", "IMC"];
  final List<String> estado = [
    'assets/images/magro.png',
    'assets/images/normal.png',
    'assets/images/gordo.png'
  ];
  // indice que diz a imagem que será exibida
  int _estadoIndex = 1;

  //Lista com os valores que serão exibidos em Peso,Altura e IMC
  List<double> valor = [0.1, 0.2, 0.3];

// Função chamada quando qualquer botão for botaoAcionado
// O indice do botão acionado é retornado.
// Essa função altera os valores que são atualizados na montagem de tela
  void botaoAcionado(int index) {
    setState(() {
      valor[0] = valorBotao[index];
      _estadoIndex++;
      _estadoIndex = _estadoIndex > 2 ? 0 : _estadoIndex;
    });
  }

//ontagem da tela
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // obtem o layout da area disponível
      builder: (context, constraints) {
        return SingleChildScrollView(
          // cria uma tela rolavel
          child: Column(
            children: [
              Image.asset(
                estado[_estadoIndex],
                width: constraints.maxWidth *
                    0.2, // obtem informações do LayoutBuilder
                height: constraints.maxHeight * 0.3,
                //fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(
                    8.0), //define que os filhos terão bordas
                child: Column(
                  children: List.generate(3, (index) {
                    //gera uma lista de widgets
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(rotuloLabel[index]),
                          ),
                          Expanded(
                            child: Text(
                              (valor[index]).toString(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        botaoAcionado(index);
                      },
                      child: Text(rotuloBotao[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
