import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/categories/screen_income_categories.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

class ExpenseCategory extends StatefulWidget {
  const ExpenseCategory({Key? key}) : super(key: key);

  @override
  State<ExpenseCategory> createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
  late Box<Categories> categories;
  late Box<Transactions> transactions;
  @override
  void initState() {
    categories = Hive.box<Categories>(categoryBox);
    transactions = Hive.box<Transactions>(transactionBox);
    super.initState();
  }

  bool duplicateorNot(List<Categories> list, String value) {
    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].category.trim() == value.trim()) {
        count++;
      }
    }
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redTheme,
        title: const Text('Expense Category'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: categories.listenable(),
        builder: (context, Box<Categories> categoriesVal, _) {
          List<Categories> catgoriesList =
              type(categoriesVal.values.toList())[1];
          return catgoriesList.isEmpty
              ? const Center(child: Text('Add some Categories'))
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: mediaQueryWidth * 0.01,
                          right: mediaQueryWidth * 0.01),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(catgoriesList[index].category),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  categoryAddPopup(
                                      context, catgoriesList[index].key);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Warning!',
                                          style: TextStyle(color: redTheme),
                                        ),
                                        content: const Text(
                                            'Do you want to delete?'),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              List<Transactions>
                                                  transactionsList =
                                                  transactions.values.toList();
                                              List<Categories> categoriesList =
                                                  categories.values.toList();
                                              for (int i = 0;
                                                  i < transactions.length;
                                                  i++) {
                                                if (transactionsList[i]
                                                        .categoryType
                                                        .category ==
                                                    categoriesList[index]
                                                        .category) {
                                                  transactionsList[i].delete();
                                                }
                                              }
                                              categories.delete(
                                                  catgoriesList[index].key);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'NO',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox.shrink();
                  },
                  itemCount: catgoriesList.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryAddPopup(context, null);
        },
        backgroundColor: redTheme,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> categoryAddPopup(BuildContext context, int? key) async {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    controller.text = key != null ? categories.get(key)!.category : "";

    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: key == null
              ? const Text('Add Category')
              : const Text('Update Category'),
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.02, right: mediaQueryWidth * 0.02),
              child: Form(
                key: formKey,
                child: TextFormField(
                  cursorColor: redTheme,
                  controller: controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 241, 241, 241),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return "Add a Category";
                    }
                    return null;
                  },
                ),
              ),
            ),
            VerticalSpace(height: mediaQueryHeight * 0.01),
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.2, right: mediaQueryWidth * 0.2),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(mediaQueryWidth * 0.05, mediaQueryHeight * 0.05),
                  ),
                  backgroundColor: MaterialStateProperty.all(redTheme),
                ),
                child: key == null ? const Text('Add') : const Text('Update'),
                onPressed: () {
                  List<Categories> categoriesList = categories.values.toList();
                  if (formKey.currentState!.validate() &&
                      duplicateorNot(categoriesList, controller.text)) {
                    if (controller.text != '') {
                      Categories newCategory =
                          Categories(category: controller.text, type: false);

                      if (key == null) {
                        categories.add(newCategory);
                      } else {
                        categories.put(key, newCategory);
                      }
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
