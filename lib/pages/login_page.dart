import 'package:ec_com_admin_01/auth/authservice.dart';
import 'package:ec_com_admin_01/pages/launcher_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  static const String routeName ='/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errMsg ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.email),
                labelText: 'Email Address'
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Provide a valid email address';
                }
              },
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.email),
                labelText: 'Password (at least 6 charechters)'
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Provide a valid password';
                }
              },
            ),
              ElevatedButton(
                  onPressed: _authenticate,
                  child:  const Text('Login as admin'),
              ),
              Row(
                children: [
                  Text('Forgot password', style: const TextStyle(fontSize: 18, color: Colors.red),),
                  TextButton(
                    onPressed: (){
                      resetpassword();
                    },
                    child:  const Text('Click Here'),
                  ),
                ],
              ),
              Text(_errMsg, style: const TextStyle(fontSize: 18, color: Colors.red),)
          ],
        ),
        ),
      ),
    );
  }

  void _authenticate() async {
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'Please Wait');
      final email = _emailController.text;
      final password = _passwordController.text;
       try {
         final status = await AuthService.login(email, password);
         EasyLoading.dismiss();
         if (status){
           if(mounted){
             Navigator.pushReplacementNamed(context, LauncherPage.routeName);
           }
         }else {
           await AuthService.logout();
           setState(() {
             _errMsg = 'This email address in not registered as admin';
           });
         }
       } on FirebaseAuthException catch (error) {
         EasyLoading.dismiss();
         setState(() {
           _errMsg = error.message!;
         });
       }
    }
  }

  void resetpassword() async {
    AuthService.forgotPassword(_emailController.text);
    setState(() {
      _errMsg = 'Email has sent';
    });
  }
}
