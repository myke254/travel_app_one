import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCRUD<T> {
  final CollectionReference collection;

  FirestoreCRUD(this.collection);

  Future<T?> create(Map<String, dynamic> data) async {
    final doc = await collection.add(data);
    return fromMap(await doc.get());
  }

  Future<T?> read(String id) async {
    final doc = await collection.doc(id).get();
    return fromMap(doc);
  }

  Future<List<T?>> readList() async {
    final snapshot = await collection.get();
    
    return snapshot.docs.map((e) => fromMap(e)).toList();
  }

  Future<T?> update(Map<String, dynamic> data, String id) async {
    await collection.doc(id).update(data);
    return await read(id);
  }

  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }

  T? fromMap(DocumentSnapshot snapshot) => null;
}
