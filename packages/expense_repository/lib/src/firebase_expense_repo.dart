import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';


class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection = FirebaseFirestore.instance.collection("categories");
  final expenseCollection = FirebaseFirestore.instance.collection("expense");

  @override
  Future<void> createCategory(CategoryModel category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future<List<CategoryModel>> getCategory() async {
    try {
      return await categoryCollection
          .get().then((value) => value.docs.map((e) =>
          CategoryModel.fromEntity(CategoryEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }




  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      return await expenseCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}