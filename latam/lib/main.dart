import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordCarousel(),
    );
  }
}

class PasswordCarousel extends StatefulWidget {
  @override
  _PasswordCarouselState createState() => _PasswordCarouselState();
}

class _PasswordCarouselState extends State<PasswordCarousel> {
  final List<String> names = ['Alice', 'Bruno', 'Lobianco', 'Eva'];
  final List<String> airplanes = ['Boeing 777', 'Airbus A380', 'Boeing 737', 'Airbus A350'];
  String currentName = '';
  String currentPassword = '';
  String currentAirplane = '';
  int randomFlightNumber = 0;
  String currentDestination = '';
  String currentBoardingTime = '';
  String currentArrivalTime = '';

  late Timer timer;

  @override
  void initState() {
    super.initState();
    generateRandomCredentials();
    timer = Timer.periodic(const Duration(seconds: 6), (Timer t) {
      setState(() {
        generateRandomCredentials();
      });
    });
  }

  void generateRandomCredentials() {
    final random = Random();
    currentName = names[random.nextInt(names.length)];
    currentPassword = String.fromCharCode(random.nextInt(26) + 65) +
        random.nextInt(10).toString() +
        random.nextInt(10).toString() +
        random.nextInt(10).toString();

    randomFlightNumber = random.nextInt(1000);
    currentAirplane = airplanes[random.nextInt(airplanes.length)];

    // Adiciona informações específicas para cada nome
    if (currentName == 'Alice') {
      currentDestination = 'Sydney - Austrália';
      currentBoardingTime = '19/11/23 - 02:00';
      currentArrivalTime = '19/11/23 - 23:00';
    } else if (currentName == 'Bruno') {
      currentDestination = 'London - Inglaterra';
      currentBoardingTime = '22/11/23 - 14:00';
      currentArrivalTime = '23/11/23 - 02:00';
    } else if (currentName == 'Lobianco') {
      currentDestination = 'Burgas - Bulgária';
      currentBoardingTime = '22/11/23 - 23:00';
      currentArrivalTime = '23/11/23 - 13:00';
    } else if (currentName == 'Eva') {
      currentDestination = 'Salvador - Bahia';
      currentBoardingTime = '22/11/23 - 08:00';
      currentArrivalTime = '22/11/23 - 10:30';
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/latamBack.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border.all(color: Color.fromARGB(255, 121, 61, 129)),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PAINEL LATAM',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Informações do Avião
                  Icon(Icons.airplanemode_active, size: 40, color: Colors.purple),
                  SizedBox(height: 10),
                  Text(
                    '$currentAirplane',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20), // Espaçamento entre as informações do avião e do passageiro
                  // Informações do Passageiro
                  Icon(Icons.person, size: 40),
                  SizedBox(height: 10),
                  Text(
                    '$currentName',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flight, size: 20),
                      SizedBox(width: 5),
                      Text(
                        'Voo: $randomFlightNumber',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Senha: $currentPassword',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // Informações do Destino
                  Text(
                    '$currentDestination',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Embarque: $currentBoardingTime',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Chegada: $currentArrivalTime',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
