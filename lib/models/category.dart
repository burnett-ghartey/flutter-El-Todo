class Category {
  var id;
  var name;
  var description;

  categoryMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;

    return map;
  }
}
