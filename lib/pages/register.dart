import 'package:appdarivery_jj/pages/register_rider.dart';
import 'package:appdarivery_jj/pages/register_sender.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/img3.jpg', // ใส่ path ของรูปภาพที่ต้องการ
              height: 50, // ขนาดความสูงของรูปภาพ
            ),
            SizedBox(width: 10), // ระยะห่างระหว่างรูปภาพกับข้อความ
            const Text(
              'สมัครสมาชิก',
              style: TextStyle(color: Colors.pink),
            ),
          ],
        ),
        backgroundColor: Colors.white, // เปลี่ยนพื้นหลัง AppBar ถ้าต้องการ
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(90, 0, 50, 0),
            child: Text(
              'โปรดเลือกประเภทผู้ใช้งาน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          UserTypeButton(
            label: 'ผู้ใช้ทั่วไป',
            imagePath: 'assets/images/img223.jpg', // ใส่ path ของรูป
            onPressed: () {
              // ย้ายไปที่หน้า RegisterSender
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterSender()),
              );
            },
          ),
          SizedBox(height: 20),
          UserTypeButton(
            label: 'ไรเดอร์',
            imagePath: 'assets/images/img219.jpg', // ใส่ path ของรูป
            onPressed: () {
              // ย้ายไปที่หน้า RegisterRider
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterRider()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UserTypeButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const UserTypeButton({
    required this.label,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        backgroundColor: Colors.pink.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            height: 50, // ขนาดของรูป
          ),
          SizedBox(width: 20),
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.pink),
          ),
        ],
      ),
    );
  }
}
