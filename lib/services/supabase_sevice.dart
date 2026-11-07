// ignore_for_file: unused_import

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_run_tracker_app/models/runtp.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<String> uploadImageFile(XFile xfile) async {
    final newFileName = '${DateTime.now().millisecondsSinceEpoch}_${xfile.name}';

    await supabase.storage.from('run_bk').uploadBinary(
      newFileName,
      await xfile.readAsBytes(),
      fileOptions: FileOptions(contentType: xfile.mimeType),
    );

    return supabase.storage.from('run_bk').getPublicUrl(newFileName);

  }

  Future<void> insertRunData(run runData) async {
    await supabase.from('run_tp').insert(runData.toJson());
  }
}