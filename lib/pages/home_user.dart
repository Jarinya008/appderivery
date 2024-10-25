import 'dart:developer';
import 'package:appdarivery_jj/pages/add_derivery.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  int selectedIndex = 0;

  // Sample order data
  final Map<String, String> orderData = {
    'name': 'คุณจุ๊บแจง',
    'phone': '0833789123',
    'item': 'กะเพราหมูสับ',
    'quantity': '1 กล่อง',
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'จัดส่งสินค้า',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 226, 238),
          elevation: 0,
        ),
        floatingActionButton: Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDeliveryPage(),
                ),
              );
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.pink,
              size: 30,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: 'ของที่จัดส่ง',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2),
              label: 'ของที่ต้องรับ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'โปรไฟล์',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.pink,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
              log(selectedIndex.toString());
            });
          },
        ),
        body: Container(
          color: const Color.fromARGB(255, 255, 252, 225),
          child: Column(
            children: [
              // Order status card
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderData['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                orderData['phone']!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text(
                            'โอเดอร์รับสินค้าแล้ว',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Image.asset(
                            'assets/food.png', // You'll need to add this image
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(Icons.fastfood),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderData['item']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                orderData['quantity']!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'รายละเอียด',
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
