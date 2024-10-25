import 'package:flutter/material.dart';
import 'dart:io'; // สำหรับจัดการไฟล์
import 'package:image_picker/image_picker.dart'; // ใช้ image_picker ในการเลือกภาพ

class RegisterRider extends StatefulWidget {
  const RegisterRider({super.key});

  @override
  State<RegisterRider> createState() => _RegisterRiderState();
}

class _RegisterRiderState extends State<RegisterRider> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;

  String _username = '';
  String _phoneNumber = '';
  String _carRegistration = '';
  String _password = '';
  String _confirmPassword = '';

  // ฟังก์ชันสำหรับเลือกรูปภาพ
  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิกไรเดอร์'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // รูปภาพโปรไฟล์
              Center(
                child: GestureDetector(
                  onTap: _pickImage, // เรียกฟังก์ชันเลือกรูป
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(File(_profileImage!.path))
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ช่องชื่อผู้ใช้
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อผู้ใช้'),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // ช่องเบอร์โทรศัพท์
              TextFormField(
                decoration: const InputDecoration(labelText: 'เบอร์โทร'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // ช่องหมายเลขทะเบียนรถ
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'หมายเลขทะเบียนรถ'),
                onChanged: (value) {
                  setState(() {
                    _carRegistration = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // ช่องรหัสผ่าน
              TextFormField(
                decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // ช่องยืนยันรหัสผ่าน
              TextFormField(
                decoration: const InputDecoration(labelText: 'ยืนยันรหัสผ่าน'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // ปุ่มสมัครสมาชิก
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // การส่งข้อมูล
                  }
                },
                child: const Text('สมัครสมาชิก'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
