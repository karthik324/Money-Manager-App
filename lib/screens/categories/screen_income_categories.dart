import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

List<List<Categories>> type(List<Categories> list) {
  List<Categories> incomeList = [];
  List<Categories> expenseList = [];
  List<List<Categories>> categoriesList = [incomeList, expenseList];
  for (int i = 0; i < list.length; i++) {
    if (list[i].type == true) {
      incomeList.add(list[i]);
    } else {
      expenseList.add(list[i]);
    }
  }
  return categoriesList;
}

class IncomeCategory extends StatefulWidget {
  const IncomeCategory({Key? key}) : super(key: key);

  @override
  State<IncomeCategory> createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {
  late Box<Categories> categories;
  @override
  void initState() {
    categories = Hive.box<Categories>(categoryBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    // List<ExpenseCategories> category = box.values.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenTheme,
        title: const Text('Income Category'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: categories.listenable(),
          builder: (context, Box<Categories> categoriesVal, _) {
            List<Categories> categoriesList =
                type(categoriesVal.values.toList())[0];
            return categoriesList.isEmpty
                ? const Center(
                    child: Text('Add some Categories'),
                  )
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: mediaQueryWidth * 0.01,
                            right: mediaQueryWidth * 0.01),
                        child: Card(
                          child: ListTile(
                            title: Text(categoriesList[index].category),
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
                                        context, categoriesList[index].key);
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
                                          title: Text('Warning!',
                                              style:
                                                  TextStyle(color: redTheme)),
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
                                                  categories.delete(
                                                      categoriesList[index]
                                                          .key);
                                                  Navigator.pop(context);
                                                }),
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
                    itemCount: categoriesList.length);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryAddPopup(context, null);
        },
        backgroundColor: greenTheme,
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
                    cursorColor: greenTheme,
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
                    }),
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
                      backgroundColor: MaterialStateProperty.all(greenTheme)),
                  child: key == null ? const Text('Add') : const Text('Update'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (controller.text != '') {
                        Categories newCategory =
                            Categories(category: controller.text, type: true);
                        if (key == null) {
                          categories.add(newCategory);
                        } else {
                          categories.put(key, newCategory);
                        }
                        // print(newCategory);
                        Navigator.pop(context);
                      }
                    }
                  }),
            )
          ],
        );
      },
    );
  }
}
