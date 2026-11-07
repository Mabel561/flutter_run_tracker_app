// ignore_for_file: unused_import, use_build_context_synchronously, non_constant_identifier_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/runtp.dart';
import 'package:flutter_run_tracker_app/services/supabase_sevice.dart';
import 'package:image_picker/image_picker.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUIState();
}

class _AddRunUIState extends State<AddRunUi> {
  //ส่วนของโค้ดที่เกี่ยวการเปิดกล่้องเปิดเเกโลรี่
  Uint8List? imageBytes; //ตัวแปรเก็บรูปภาพที่เลือกจากกล้องหรือเเกลอรี่
  XFile? imageFile;

  // เมธอดเปิดกล้อง
  Future<void> SelectImageFromCamera() async {
    imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (imageFile != null) {
      final byte = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = byte;
      });
    }
  }

  // เปิดเเกลอรี่
  Future<void> SelectImageFromGallery() async {
    imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (imageFile != null) {
      final byte = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = byte;
      });
    }
  }

  //-------------------------------------------------
  // ตัวเเปรสำหรับเก็บตำเเหน่งไฟล์ที่อัปโหลด
  String? imageUrl = "";
  // สร้าง text field controller สำหรับเก็บค่าที่กรอกใน text field
  TextEditingController runWhereController = TextEditingController();
  TextEditingController runPersonController = TextEditingController();
  TextEditingController rundistanceController = TextEditingController();

  Future<void> uploadAndSaveData() async {
    // save ข้อมูลลง table
    // validate ว่าผู้ใช้กรอกครบมั้ย
    if (runWhereController.text.isEmpty ||
        runPersonController.text.isEmpty ||
        rundistanceController.text.isEmpty) {
      // แจ้งให้ทราบว่าให้กรอกข้อมูลให้ครบถ้วนด้วย SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'กรุณากรอกข้อมูลให้ครบถ้วน',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final distance = int.tryParse(rundistanceController.text);
    if (distance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'กรุณากรอกระยะทางเป็นตัวเลข',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      if (imageFile != null) {
        imageUrl = await SupabaseService().uploadImageFile(imageFile!);
      }

      run runData = run(
        runWhere: runWhereController.text,
        runPerson: runPersonController.text,
        runDistance: distance,
        runImageUrl: imageUrl ?? "",
      );
      await SupabaseService().insertRunData(runData);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'บันทึกข้อมูลสำเร็จ',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 62, 255, 3),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'บันทึกข้อมูลไม่สำเร็จ: $error',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ appBar
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 1, 80),
        title: Text(
          'Run Tracker (เพิ่ม)',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      // ส่วนของ body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            top: 50,
            bottom: 50,
            left: 45,
            right: 45,
          ),
          child: Center(
            child: Column(
              children: [
                imageBytes == null
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            SelectImageFromCamera();
                          });
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: MediaQuery.of(context).size.width * 0.50,
                          color: Colors.grey,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            SelectImageFromGallery();
                          });
                        },
                        child: Image.memory(
                          imageBytes!,
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.height * 0.30,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งที่ไหน',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: runWhereController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'เช่น สวนสาธารณะ, สนามกีฬา หรือ อื่นๆ',
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งกับใคร',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: runPersonController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'เช่น เพื่อน 3 คน, แฟน หรือ อื่นๆ',
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะทาง (กิโลเมตร)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: rundistanceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'เช่น 1, 5, 11 หรือ อื่นๆ',
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: uploadAndSaveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text('บันทึกข้อมูล'),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text('ยกเลิก'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
