import 'package:flutter/material.dart';

void main() {
  runApp(const F1QuizApp());
}

class F1QuizApp extends StatelessWidget {
  const F1QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F1 Quiz',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.red,
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedOption;

  final List<Map<String, Object>> questions = [
    {
      "question": "Quem tem mais títulos na F1?",
      "options": [
        "Ayrton Senna",
        "Lewis Hamilton",
        "Max Verstappen",
        "Alain Prost"
      ],
      "answer": 1
    },
    {
      "question": "Qual equipe é conhecida pelo carro vermelho?",
      "options": [
        "Mercedes",
        "Red Bull",
        "Ferrari",
        "McLaren"
      ],
      "answer": 2
    },
    {
      "question": "Qual piloto é brasileiro?",
      "options": [
        "Charles Leclerc",
        "Lando Norris",
        "Ayrton Senna",
        "Sebastian Vettel"
      ],
      "answer": 2
    },
    {
      "question": "Quem venceu o campeonato de 2023?",
      "options": [
        "Lewis Hamilton",
        "Max Verstappen",
        "Fernando Alonso",
        "Carlos Sainz"
      ],
      "answer": 1
    },
    {
      "question": "Quantas rodas tem um carro de F1?",
      "options": [
        "2",
        "4",
        "6",
        "8"
      ],
      "answer": 1
    },
  ];

  void nextQuestion() {
    if (selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Escolha uma resposta!")),
      );
      return;
    }

    if (selectedOption == questions[currentQuestion]["answer"]) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedOption = null;
      });
    } else {
      showResult();
    }
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Resultado Final 🏁"),
        content: Text(
          "Você acertou $score de ${questions.length}!",
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestion = 0;
                score = 0;
                selectedOption = null;
              });
            },
            child: const Text(
              "Reiniciar",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var current = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text("F1 Quiz 🏁"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pergunta ${currentQuestion + 1} de ${questions.length}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // CARD DA PERGUNTA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Text(
                current["question"] as String,
                style: const TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(height: 20),

            // OPÇÕES
            ...(current["options"] as List<String>).asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;

              return Card(
                color: Colors.grey[850],
                child: RadioListTile<int>(
                  title: Text(option),
                  value: index,
                  groupValue: selectedOption,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              );
            }),

            const Spacer(),

            // BOTÃO
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: nextQuestion,
                child: const Text(
                  "Próxima",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
