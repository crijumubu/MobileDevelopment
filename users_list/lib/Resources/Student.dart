class Student{

  String _name;
  String _degree;
  double _grade;
  String _image;

  Student(String name, String degree, double grade, String image) : _name = name, _degree = degree, _grade = grade, _image = image;

  String get getName{
    return _name;
  }

  String get getDegree{
    return _degree;
  }

  double get getGrade{
    return _grade;
  }

  String get getImage{
    return _image;
  }
}