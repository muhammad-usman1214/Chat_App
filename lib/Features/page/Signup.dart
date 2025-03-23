import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chart/Features/page/Login_page.dart';
import 'package:group_chart/Features/components/toastmsg.dart';
import 'package:group_chart/Features/authservices/authservices.dart';
import '../widget/roundbutton.dart';
import '../widget/EmailTextfield.dart';
import '../widget/HeaderWidget.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  void Register(BuildContext context) async {
    final _authservices = AuthServices();
    await FirebaseAuth.instance.setLanguageCode("en");
    // Check if the form is valid
    if (!_formkey.currentState!.validate()) {
      return;
    }

    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String username = _usernameController.text.trim();
    String phone = _phoneNumberController.text.trim();

    try {
      await _authservices.signUpwithEmailandPassword(
          email,password,username,phone
          );
      Utils.ToastMsg('Signup successful!');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login_Sceen()));
    } catch (e) {
      Utils.ToastMsg(e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    obsecurePassword.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  headerWidget(title: 'SignUp', context: context),
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(),
                        color: Colors.grey.shade300,
                      ),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Elon Musk',
                        labelText: 'User Name',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter UserName';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  emailTextField(
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    keyType: TextInputType.text,
                    context: context,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: obsecurePassword,
                      builder: (context, value, child) {
                        return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.all(),
                            color: Colors.grey.shade300,
                          ),
                          child: TextFormField(
                              controller: _passwordController,
                              obscureText: obsecurePassword.value,
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  labelText: 'Password',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      obsecurePassword.value =
                                          !obsecurePassword.value;
                                    },
                                    child: Icon(
                                      obsecurePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility,
                                    ),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              }),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(),
                      color: Colors.grey.shade300,
                    ),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: '+974-677777',
                        labelText: 'Telephone',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                      ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter PhoneNumber';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundButton2(
                      title: 'SignUp',
                      onTap: () {
                        Register(context);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("If you have an account?"),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login_Sceen()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
