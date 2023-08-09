import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:archive/archive_io.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerTest extends StatelessWidget {
  const FilePickerTest({super.key});

  void chooseFile() async {
    try {
      List<PlatformFile>? _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['zip']
      ))?.files;
      if(_paths != null && _paths.isNotEmpty) {
        var status = await Permission.storage.status;
        if(status.isGranted) {
          final inputStream = InputFileStream(_paths[0].path as String);
          final archive = ZipDecoder().decodeBuffer(inputStream);
          extractArchiveToDisk(archive, '/storage/emulated/0/export_test');
          // todo 提示
        }
      }
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print(e.toString());
    }

    // /storage/emulated/0/documents
    // String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    // if (selectedDirectory != null) {
    //   print('11111111111111');
    //   print(selectedDirectory);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => {
          chooseFile()
        },
        child: const Text('file'),
      ),
    );
  }
}