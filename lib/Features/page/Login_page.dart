import 'package:flutter/material.dart';
import 'package:group_chart/Features/page/Signup.dart';
import 'package:group_chart/Features/components/toastmsg.dart';
import 'package:group_chart/Features/authservices/authservices.dart';
import 'package:group_chart/Features/widget/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen.dart';
import '../widget/EmailTextfield.dart';
import '../widget/HeaderWidget.dart';

class Login_Sceen extends StatefulWidget {
  const Login_Sceen({super.key});

  @override
  State<Login_Sceen> createState() => _Login_SceenState();
}

class _Login_SceenState extends State<Login_Sceen> {
  ValueNotifier<bool> obsecurePassword=ValueNotifier<bool>(true);
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  FirebaseAuth _auth =FirebaseAuth.instance;
   bool loading=false;

  void login()async{

    final _authservices=AuthServices();
    try{
      await _authservices.loginWithEmailandPassword(
          _emailController.text.toString(),
          _passwordController.text.toString());
      Utils.ToastMsg('login successful!');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home_Scrren()));
    } catch (e) {
      Utils.ToastMsg(e.toString());
    }

  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    obsecurePassword.dispose();
    super.dispose();
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(vertical: 22,horizontal: 20),
        child:Column(
          children: [
            Form(
              child: Column(
                children: [
                  headerWidget(
                      title: 'Login',
                      context: context),
                  emailTextField(
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    keyType:TextInputType.text,
                    context: context,
                  ),
                  SizedBox(height: 20,),
                  ValueListenableBuilder(
                      valueListenable: obsecurePassword,
                      builder: (context,value,child){
                        return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*1,
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
                                  onTap: (){
                                    obsecurePassword.value=!obsecurePassword.value;
                                  },
                                  child: Icon(
                                    obsecurePassword.value?Icons.visibility_off_outlined:Icons.visibility,
                                  ),
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                        );
                      }),
                  SizedBox(height: 20,),
                  RoundButton2(
                      title: 'Login',
                      onTap: (){
                        login();
                      }),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Text("If  dont have an account?"),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_Up()));
                        },
                        child: Text('SignUp',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.blue)),
                      )
                    ],
                  )
                ],

              ),
                )
          ],
        )

        ),
    );
  }
}
