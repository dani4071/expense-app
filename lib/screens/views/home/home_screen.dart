import 'dart:math';
import 'package:expense_tracker/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/blocs/get_category_bloc/get_categories_bloc.dart';
import 'package:expense_tracker/screens/add%20expense/views/add_expense.dart';
import 'package:expense_tracker/screens/views/home/bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/views/home/main_screen.dart';
import 'package:expense_tracker/screens/views/statistics/stat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_repository/expense_repository.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if(state is GetExpensesSuccess) {
          return Scaffold(
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 3,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.graph_square_fill),
                      label: "Stats",
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                 Expense? newExpense = await Navigator.push(context, MaterialPageRoute<Expense>(builder: (context){
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => CreateCategoryBloc(
                            FirebaseExpenseRepo(),
                          ),
                        ),

                        BlocProvider(
                          create: (context) => GetCategoriesBloc(FirebaseExpenseRepo())..add(GetCategories()),
                        ),

                        BlocProvider(
                          create: (context) => CreateExpenseBloc(FirebaseExpenseRepo()),
                        ),

                      ], child: const AddExpenseScreen(),
                    );
                  }
                  ),
                 );

                 if(newExpense != null) {
                   setState(() {
                     state.expenses.insert(0, newExpense);
                   });
                 }
                },
                shape: const CircleBorder(),
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.tertiary,
                          ],
                          transform: const GradientRotation(pi / 4),
                        )),
                    child: const Icon(CupertinoIcons.add)),
              ),
              body: index == 0 ? mainScreen(expenses: state.expenses,) : const statScreen());
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}
