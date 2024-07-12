import 'package:expense_tracker/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/blocs/get_category_bloc/get_categories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_repository/expense_repository.dart';

import 'category_creation.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // DateTime selectedDate = DateTime.now();
  late Expense expense;
  bool isLoading = false;


  @override
  void initState() {
    dateController.text = DateFormat('EEE, d/MMMM/y').format(DateTime.now());
    super.initState();
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if(state is CreateCategorySuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateCategoryLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
            if(state is GetCategoriesSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
      
                    /// Heading
                    const Text(
                      "Add Expense",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
      
      
                    /// Expense textformfield
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: expenseController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue.shade100,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
      
      
      
                    /// Category textformfield
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: categoryController,
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
      
                            /// dynamic color
                            fillColor: expense.category == CategoryModel.empty 
                                ? Colors.white 
                                : Color(expense.category.color),
                            hintText: "Category",
      
                            /// dynamic icon
                            prefixIcon: expense.category == CategoryModel.empty
                                ? const Icon(
                                  FontAwesomeIcons.list,
                                  size: 16,
                                  color: Colors.black,
                            ) :
                            // Image(
                            //       width: 5,
                            //       height: 5,
                            //       image: AssetImage("assets/${expense.category.icon}.png"),
                            // ),
                            Image.asset("assets/${expense.category.icon}.png", scale: 15,),
      
                            /// Add a new Category
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var newCategory = await getCategoryCreation(context);
                                print(newCategory);
                                setState(() {
                                  state.categories.insert(0, newCategory);
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              // borderSide: BorderSide.none,
                            )),
                      ),
                    ),
      
                    /// Expanded container
                    Container(
                      // height: 200,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, int i) {
                                    // final item = state.categories[i];
                                    return Card(
                                      color: Colors.white,
      
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            expense.category = state.categories[i];
                                            categoryController.text = expense.category.name;                                        });
                                        },
                                        /// image
                                        leading: Image(
                                          width: 35,
                                          image: AssetImage(
                                              "assets/${state.categories[i]
                                                  .icon}.png"),
                                        ),
                                        //// don't understand why its not taking the scale
                                        // leading: Image.asset("assets/food.png", scale: 2,),
      
                                        /// title
                                        // title: Text(item.name, style: const TextStyle(color: Colors.black),),
                                        title: Text(state.categories[i].name,
                                          style: const TextStyle(
                                              color: Colors.black),),
      
                                        // tileColor: const Color(0xff1d7146),
                                        tileColor: Color(
                                            state.categories[i].color),
      
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                                  },
                        ),
                      ),
                    ),
      
                    const SizedBox(
                      height: 16,
                    ),
      
      
                    /// Date textformfield
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextFormField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: expense.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                  const Duration(days: 365)));
      
                          if (newDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat("EEE, d/MMMM/y").format(newDate);
                              // selectedDate = newDate;
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Date",
                            prefixIcon: const Icon(
                              FontAwesomeIcons.clock,
                              size: 16,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
      
      
                    /// Save Button
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: kToolbarHeight,
                      child: isLoading
                        ? const Center(
                          child: CircularProgressIndicator(),
                      )
                        : TextButton(
                        onPressed: () {
                          setState(() {
                            expense.amount = int.parse(expenseController.text);
                          });
      
                          context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                          Navigator.pop(context);
                        },
      
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
      
                  ],
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator());
            }
            },
          ),
        ),
      ),
    );
  }
}
