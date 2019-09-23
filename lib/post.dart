class Post {

  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  /*
  Avoid wrapping fields in getters and setters just to be "safe".dart(unnecessary_getters_setters)
  // Getters

  int get userId => _userId;
  int get id => _id;
  String get title => _title;
  String get body => _body;

  // Setters

  set userId(int value) {
    _userId = value;
  }

  set id(int value) {
    _id = value;
  }

  set title(String value) {
    _title = value;
  }

  set body(String value) {
    _body = value;
  }
  */

}