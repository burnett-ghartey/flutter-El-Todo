import 'package:eltodo/models/category.dart';
import 'package:eltodo/screens/home_screen.dart';
import 'package:eltodo/service/category_service.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();
  List<Category> _categoryList = [];

  var _editCategoryName = TextEditingController();

  var _editCategoryDescription = TextEditingController();

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(_snackBar);
  }

  getAllCategories() async {
    _categoryList = [];
    var categories = await _categoryService.getCategory();
    categories.forEach((category) {
      setState(() {
        var model = Category();
        model.name = category['name'];
        model.id = category['id'];
        model.description = category['description'];
        _categoryList.add(model);
      });
    });
  }

  editCategoryById(BuildContext context, categoryId) async {
    category = await _categoryService.getCategoryById(categoryId);

    setState(() {
      _editCategoryName.text = category[0]['name'];
      _editCategoryDescription.text = category[0]['description'];
    });
    _editCategoryDialog(context);
  }

  _deleteCategoryDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            content: const Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                color: Colors.green,
                onPressed: () {},
                child:
                    const Text("cancel", style: TextStyle(color: Colors.white)),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () async {
                  await _categoryService.deleteCategory(categoryId);
                },
                child:
                    const Text("Delete", style: TextStyle(color: Colors.white)),
              )
            ],
          );
        });
  }

  _showFormInDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                FlatButton(
                  onPressed: () async {
                    _category.id;
                    _category.name = _categoryName.text;
                    _category.description = _categoryDescription.text;
                    var result = await _categoryService.saveCategory(_category);
                    if (result > 0) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
              title: const Text('Category Form'),
              content: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryName,
                    decoration: const InputDecoration(
                        labelText: "Category Name",
                        hintText: "Write Category Name"),
                  ),
                  TextField(
                    controller: _categoryDescription,
                    decoration: const InputDecoration(
                        labelText: "Category Description",
                        hintText: "Write Category Description"),
                  ),
                ],
              )));
        });
  }

  _editCategoryDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                FlatButton(
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editCategoryName.text;
                    _category.description = _editCategoryDescription.text;
                    var result =
                        await _categoryService.updateCategory(_category);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showSnackBar(const Text("updated"));
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
              title: const Text('Edit Category Form'),
              content: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryName,
                    decoration: const InputDecoration(
                        labelText: "Category Name",
                        hintText: "Write Category Name"),
                  ),
                  TextField(
                    controller: _editCategoryDescription,
                    decoration: const InputDecoration(
                        labelText: "Category Description",
                        hintText: "Write Category Description"),
                  ),
                ],
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          child: Icon(Icons.arrow_back, color: Colors.white),
          color: Colors.red,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: const Text("El ToDo"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      editCategoryById(context, _categoryList[index].id);
                    }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_categoryList[index].name),
                    IconButton(
                        onPressed: () {
                          _deleteCategoryDialog(
                              context, _categoryList[index].id);
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showFormInDialog(context);
          },
          child: const Icon(Icons.add)),
    );
  }
}
