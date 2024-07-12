
import 'package:expense_tracker/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_repository/expense_repository.dart';


import 'package:flutter/cupertino.dart';

Future getCategoryCreation(BuildContext context) {


  List<String> myCategoriesIcons = [
    'ticket',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];

  return showDialog(
      context: context,
      builder: (ctx) {

        /// variables
        bool isExtended = false;
        String iconSelected = "";
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        bool isLoading = false;
        CategoryModel category = CategoryModel.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                listener: (context, state) {
                  if (state is CreateCategorySuccess) {
                    Navigator.pop(ctx, category);
                  } else if (state is CreateCategoryLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: AlertDialog(
                  title: const Center(
                      child: Text("Create a category")),
                  backgroundColor: Colors.blue.shade100,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// Name
                      SizedBox(
                        width:
                        MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
                          controller: categoryNameController,
                          onTap: () {
                            setState(() {
                              isExtended = false;
                            });
                          },
                          decoration: InputDecoration(
                              filled: true,
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: "Name",
                              prefixIcon: const Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      /// Icon
                      SizedBox(
                        width:
                        MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
                          // controller: dateController,
                          readOnly: true,
                          onTap: () {
                            setState(() {
                              isExtended = !isExtended;
                            });
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Icon",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.icons,
                                size: 16,
                                color: Colors.black,
                              ),
                              suffixIcon: isExtended
                                  ? const Icon(
                                FontAwesomeIcons
                                    .arrowUp,
                                size: 16,
                                color: Colors.black,
                              )
                                  : const Icon(
                                FontAwesomeIcons
                                    .chevronDown,
                                size: 16,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: isExtended
                                    ? const BorderRadius
                                    .vertical(
                                  top: Radius.circular(
                                      10),
                                )
                                    : BorderRadius.circular(
                                    12),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),

                      /// Extended container from icon
                      isExtended
                          ? Expanded(
                        child: Container(
                          // height: 200,
                          // height: MediaQuery.of(context).size.width/,
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
                            padding: const EdgeInsets.all(10.0),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemCount: myCategoriesIcons.length,
                              itemBuilder: (context, int i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      iconSelected = myCategoriesIcons[i];
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius
                                            .circular(12),
                                        border: Border.all(
                                            width: 3,
                                            color: iconSelected ==
                                                myCategoriesIcons[i] ?
                                            Colors.red
                                                : Colors.blue
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/${myCategoriesIcons[i]}.png",),
                                          fit: BoxFit.cover,
                                        ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                          : Container(),
                      const SizedBox(
                        height: 16,
                      ),

                      /// Color
                      SizedBox(
                        width:
                        MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx2) {
                                  return BlocProvider.value(
                                    value: context.read<
                                        CreateCategoryBloc>(),
                                    child: AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          /// color picker
                                          ColorPicker(
                                            pickerColor: Colors.white,
                                            onColorChanged: (value) {
                                              setState(() {
                                                categoryColor = value;
                                              });
                                            },
                                          ),

                                          /// save color button
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: kToolbarHeight,
                                            child: TextButton(
                                              onPressed: () {
                                                print(categoryColor);
                                                // categoryColor = value;
                                                Navigator.pop(ctx2);
                                              },
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(12))),
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
                                    ),
                                  );
                                }
                            );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              filled: true,
                              isDense: true,
                              fillColor: categoryColor,
                              hintText: "Color",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.paintbrush,
                                size: 16,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      /// Save button
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: kToolbarHeight,
                        child: isLoading == true
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : TextButton(
                          onPressed: () {
                            setState(() {
                              category.categoryId = Uuid().v1();
                              category.name = categoryNameController.text;
                              category.color = categoryColor.value;
                              category.icon = iconSelected;
                            });
                            context.read<CreateCategoryBloc>().add(
                                CreateCategory(category));

                            // Navigator.pop(context);
                            print(isLoading);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      12))),
                          child: const Text(
                            "Saveee",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        );
      });
}

