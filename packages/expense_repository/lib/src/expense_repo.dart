import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {

  Future<void> createCategory(CategoryModel category);

  Future<List<CategoryModel>> getCategory();

  Future<void> createExpense(Expense expense);

  Future<List<Expense>> getExpenses();
}