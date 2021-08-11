import 'package:eltodo/models/category.dart';
import 'package:eltodo/screens/categories_screen.dart';
import 'package:eltodo/screens/home_screen.dart';
import 'package:eltodo/screens/todos_by_category.dart';
import 'package:eltodo/service/category_service.dart';
import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<ListTile> _categoryList = [];
  CategoryService categoryService = CategoryService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }

  getCategories() async {
    
    var categories = await categoryService.getCategory();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(ListTile(title: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TodoByCategory(category['name'])));
          },
          child: Text(category['name']))));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("El ToDo"),
            accountEmail: Text("Category & Priority Based ToDo App"),
            currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.filter_list, color: Colors.white))),
            decoration: BoxDecoration(color: Colors.red),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
          ListTile(
            title: Text("Categories"),
            leading: Icon(Icons.view_list),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoriesScreen())),
          ),
          Divider(color: Colors.black45),
          Column(
            children: _categoryList
          )
        ]),
      ),
    );
  }
}
