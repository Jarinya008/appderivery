import 'dart:io';
import 'dart:developer'; // สำหรับใช้ฟังก์ชัน log
import 'package:appdarivery_jj/pages/home_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart'; // นำเข้า permission_handler

class RegisterSender extends StatefulWidget {
  const RegisterSender({super.key});

  @override
  State<RegisterSender> createState() => _RegisterSenderState();
}

class _RegisterSenderState extends State<RegisterSender> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _phone;
  String? _password;
  String? _confirmPassword;
  String? _address;
  XFile? _profileImage;
  Position? _currentPosition;
  GoogleMapController? _mapController;

  // ฟังก์ชันเลือกรูปภาพ
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  // ฟังก์ชันดึงตำแหน่ง GPS
  Future<void> _getCurrentLocation() async {
    // ตรวจสอบ permission
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // ถ้ายังไม่ได้ให้ permission จะร้องขอ
      if (await Permission.location.request().isGranted) {
        // ถ้าได้รับอนุญาตให้ดึงตำแหน่ง
        await _fetchLocation();
      } else {
        // แสดงข้อความแจ้งเตือนว่าต้องอนุญาต
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please enable location permissions')));
      }
    } else {
      // ถ้ามี permission แล้วให้ดึงตำแหน่ง
      await _fetchLocation();
    }
  }

  Future<void> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });

      // Log ค่า latitude และ longitude
      log('Current Location: Latitude = ${position.latitude}, Longitude = ${position.longitude}');
      print(
          'Current Location: Latitude = ${position.latitude}, Longitude = ${position.longitude}');

      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching location: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิกทั่วไป'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อผู้ใช้'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อผู้ใช้';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'เบอร์โทร'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกเบอร์โทร';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ที่อยู่'),
                onSaved: (value) {
                  _address = value;
                },
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  FilledButton(
                    onPressed: _getCurrentLocation,
                    child: const Text('Get Location'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: _currentPosition != null
                    ? GoogleMap(
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('currentLocation'),
                            position: LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                            ),
                          ),
                        },
                      )
                    : const Center(child: Text('กรุณากดปุ่มเพื่อดึงตำแหน่ง')),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่าน';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ยืนยันรหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณายืนยันรหัสผ่าน';
                  }
                  if (value != _password) {
                    return 'รหัสผ่านไม่ตรงกัน';
                  }
                  return null;
                },
                onSaved: (value) {
                  _confirmPassword = value;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Username: $_username');
                    print('Phone: $_phone');
                    print('Address: $_address');
                    print('Password: $_password');
                    print('Profile Image: $_profileImage');
                    print('Location: $_currentPosition');
                  }
                  login(context); // ส่ง context ไปที่ฟังก์ชัน login
                },
                child: const Text('สมัครสมาชิก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void login(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeUser(),
    ),
  );
}
