import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('BMI Calculator'),
            leading: Icon(Icons.calculate), // Changed IconButton to Icon
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.male), // Changed icon to male icon
                  text: 'MALE', // Changed text to uppercase
                ),
                Tab(
                  icon: Icon(Icons.female), // Changed icon to female icon
                  text: 'FEMALE', // Changed text to uppercase
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BMICalculator(),
              BMICalculator(),
            ],
          ),
        ),
      ),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: weightController,
            maxLength: 8,
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              icon: Icon(Icons.fitness_center),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: heightController,
            maxLength: 8,
            decoration: InputDecoration(
              labelText: 'Height (cm)',
              icon: Icon(Icons.height),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              double w = double.tryParse(weightController.text) ?? 0;
              double h = double.tryParse(heightController.text) ?? 0;
              if (h != 0) {
                setState(() {
                  result = (w / ((h * h) / 10000));
                });
                // Navigate to ResultPage and pass the result
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(result: result),
                  ),
                );
              } else {
                setState(() {
                  result = 0;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Calculate',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
class ResultPage extends StatelessWidget {
  final double result;
  late String resultName;

  ResultPage({Key? key, required this.result}) : super(key: key) {
    // Assigning resultName based on BMI result
    if (result < 16) {
      resultName = 'Severe undernourishment';
    } else if (result >= 16 && result < 16.9) {
      resultName = 'Severe undernourishment';
    } else if (result >= 17 && result < 18.4) {
      resultName = 'Slight undernourishment';
    } else if (result >= 18.5 && result < 24.9) {
      resultName = 'Normal nutrition state';
    } else if (result >= 25 && result < 29.9) {
      resultName = 'Overweight';
    } else if (result >= 30 && result < 39.9) {
      resultName = 'Obesity';
    } else {
      resultName = 'Morbid obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result: ${result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your Status: $resultName',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
