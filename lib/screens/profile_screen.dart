import 'package:flutter/material.dart';
import 'tabs_screen.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        backgroundColor: Colors.pink,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                const Positioned(
                  top: 80,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white, 
                      child: Icon(Icons.person, size: 60, color: Colors.pink),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Text(
              'المهندسة حنان',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              'IT Student | University of Taiz',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
           
            buildProfileOption(Icons.email, 'البريد الإلكتروني', 'hanan@example.com'),
            buildProfileOption(Icons.phone, 'رقم الهاتف', '+967 7xx xxx xxx'),
            buildProfileOption(Icons.location_on, 'الموقع', 'تعز، اليمن'),
            buildProfileOption(Icons.settings, 'الإعدادات', 'تعديل بيانات الحساب'),
            
            const SizedBox(height: 20),
            
           

           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
            onPressed: () {
      
      Navigator.of(context).popUntil((route) => route.isFirst);
      
      
ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('تم تسجيل الخروج بنجاح', textAlign: TextAlign.right),
      backgroundColor: Colors.pink,
      duration: Duration(seconds: 1),
    ),
  );

  
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => TabsScreen()),
    (route) => false,
  );;
    },
    icon: const Icon(Icons.logout),
    label: const Text('تسجيل الخروج'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  
  Widget buildProfileOption(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.pink),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}