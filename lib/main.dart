import 'package:expense_tracker/screens/views/home/bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/views/home/home_screen.dart';
import 'package:expense_tracker/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "dev project",
    options: const FirebaseOptions(
        apiKey: "key",
        appId: "com.example.expense_tracker",
        messagingSenderId: "messageId",
        projectId: "projectId",
      storageBucket: "storagebucket",
    ),
  );
  Bloc.observer = SimpleBlocObserver();


  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: const Color(0xFF00B2E7),
          secondary: const Color(0xFFE064F7),
          tertiary: const Color(0xFFFF8D6C),
        )
      ),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          FirebaseExpenseRepo()
        )..add(GetExpenses()),
          child: const homeScreen()),
    );
  }
}