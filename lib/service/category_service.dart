import 'package:eltodo/models/category.dart';
import 'package:eltodo/repositories/repository.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.save('categories', category.categoryMap());
  }

  getCategory() async {
    return await _repository.getAll('categories');
  }

  getCategoryById(categoryId) async {
    return await _repository.getById('categories', categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.update('categories', category.categoryMap());
  }

   deleteCategory(categoryId) async {
    return await _repository.delete('categories', categoryId);
  }
}
