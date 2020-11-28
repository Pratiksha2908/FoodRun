import 'package:firebase_database/firebase_database.dart';

class PostService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  PostService(this.post);

  deletePost() {
    _databaseReference = database.reference().child('${post['key']}');
    _databaseReference.remove();
  }
}