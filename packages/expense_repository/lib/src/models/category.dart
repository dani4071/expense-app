
import '../entities/category_entity.dart';


class CategoryModel {

  String categoryId;
  String name;
  int totalExpense;
  String icon;
  int color;


  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.totalExpense,
    required this.icon,
    required this.color,
});


  static final empty = CategoryModel(
      categoryId: "",
      name: "",
      totalExpense: 0,
      icon: "",
      color: 0
  );


  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      totalExpense: totalExpense,
      icon: icon,
      color: color,
    );
  }



  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
        categoryId: entity.categoryId,
        name: entity.name,
        totalExpense: entity.totalExpense,
        icon: entity.icon,
        color: entity.color,
    );
  }

}