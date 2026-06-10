import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_isLogin) {
          // محاولة تسجيل الدخول
          await _auth.signInWithEmailAndPassword(
            email: _userEmail.trim(),
            password: _userPassword.trim(),
          );
        } else {
          // محاولة إنشاء حساب جديد
          await _auth.createUserWithEmailAndPassword(
            email: _userEmail.trim(),
            password: _userPassword.trim(),
          );
        }
      } on FirebaseAuthException catch (error) {
        // التقاط أخطاء الفايربيس بدقة وفحص كود الخطأ لمعرفة العطل الحقيقي
        print("Firebase Auth Error Code: ${error.code}");
        String message = 'خطأ من الفايربيس: ${error.message}';

        if (error.code == 'user-not-found' || error.code == 'wrong-password') {
          message = 'بيانات الدخول غير صحيحة أو الحساب غير موجود.';
        } else if (error.code == 'email-already-in-use') {
          message = 'هذا البريد الإلكتروني مستخدم بالفعل.';
        } else if (error.code == 'invalid-email') {
          message = 'صيغة البريد الإلكتروني غير صحيحة.';
        } else if (error.code == 'weak-password') {
          message = 'كلمة المرور ضعيفة جداً، يرجى إدخال ٦ أحرف أو أكثر.';
        } else if (error.code == 'operation-not-allowed') {
          message = 'تسجيل الدخول بالبريد الإلكتروني غير مفعّل في الفايربيس.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      } catch (error) {
        // التقاط أي أخطاء عامة أخرى (مثل كاش المتصفح أو حظر الشبكة)
        print("General Error: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("خطأ عام: ${error.toString()}"),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) => (value == null || !value.contains('@')) ? 'يرجى إدخال بريد إلكتروني صحيح' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                    onSaved: (value) => _userEmail = value!,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) => (value == null || value.length < 6) ? 'كلمة المرور يجب أن لا تقل عن ٦ أحرف' : null,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'كلمة المرور'),
                    onSaved: (value) => _userPassword = value!,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitAuthForm,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: Text(_isLogin ? 'دخول' : 'إنشاء الحساب', style: const TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(_isLogin ? 'إنشاء حساب جديد للمتجر' : 'أمتلك حساباً بالفعل'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}