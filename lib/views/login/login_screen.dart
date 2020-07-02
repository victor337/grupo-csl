import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/login/login_controller.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/views/login/components/custom_form_field.dart';
import 'package:transparent_image/transparent_image.dart';



class LoginScreen extends StatelessWidget {

  final FocusNode focusLogin = FocusNode();
  final FocusNode focusPass = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height -
           AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Color(0xff196ca1),
                Color(0xff48c2e7),
              ]
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'http://www.carroesofalimpo.com.br/img/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                ],
              ),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (loginController){
                  return CustomFormField(
                    focusNode: focusLogin,
                    onChanged: (login){
                      loginController.setlogin(login);
                    },
                    hintText: 'Seu login',
                    onFieldSubmitted: (text){
                      focusLogin.unfocus();
                      FocusScope.of(context).requestFocus(focusPass);
                    },
                    textInputAction: TextInputAction.next,
                    keyBoardType: TextInputType.emailAddress,
                    iconData: Icons.email
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                ],
              ),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (loginController){
                  return CustomFormField(
                    focusNode: focusPass,
                    onChanged: (pass){
                      loginController.setPass(pass);
                    },
                    hintText: 'Sua senha',
                    onFieldSubmitted: (text){
                      focusPass.unfocus();
                    },
                    textInputAction: TextInputAction.done,
                    keyBoardType: TextInputType.emailAddress,
                    iconData: Icons.lock
                  );
                },
              ),
              const SizedBox(height: 20,),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (loginController){
                  return GetBuilder<UserController>(
                    init: UserController(),
                    builder: (userController){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor: Colors.grey,
                          onPressed: loginController.isValid ?(){

                          } : null,
                          child: userController.isLoading ?
                          const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ) :  Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10) ,
                            child: const Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}