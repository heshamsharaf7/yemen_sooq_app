import 'package:cloud_firestore/cloud_firestore.dart';

class BatchWriter {
  BatchWriter._();

  static BatchWriter batchWriter = BatchWriter._();
  WriteBatch? writeBatch;

  initBatchWriter() {
    writeBatch = FirebaseFirestore.instance.batch();
  }

  commit() async {
    try {
      await writeBatch!.commit();
      writeBatch = FirebaseFirestore.instance.batch();
    } catch (ex) {
      print(ex.toString());
    }
  }
}
