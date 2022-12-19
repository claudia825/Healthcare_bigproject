import 'package:flutter/material.dart';
import './signup.dart';
import './login.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // 햄버거 버튼으로 사이드바 만드는 코드
      child: ListView(
        // 리스트 뷰 통해서 넣어야 해
        padding: EdgeInsets.zero, // 이 코드 중요하다. 이거 없으면 상단 부분이 짤리게 나옴
        children: [
          UserAccountsDrawerHeader(
            // Drawer의 헤더쪽에 넣을 코드
            currentAccountPicture: CircleAvatar(
              // 헤더에 넣어줄 이미지
              backgroundImage: AssetImage('assets/profile.png'),
              backgroundColor: Colors.white,
            ),
            otherAccountsPictures: [ // 다른 유저의 사진
              CircleAvatar(
                backgroundImage: AssetImage('assets/puppy.png'),
                backgroundColor: Colors.white,
              ),
              // CircleAvatar(
              //   backgroundImage: AssetImage('assets/chef.png'),
              //   backgroundColor: Colors.white,
              // ),
            ],

            accountName: Text('bbanto'),
            // @require 로 필수 : 이름
            accountEmail: Text('testEmail@test.com'),
            // @require 로 필수 : 이메일
            onDetailsPressed: () {
              print('Header is clicked');
            },
            decoration: BoxDecoration(
              // 데코레이션이라고 해서 박스를 꾸미기
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  // 하단에만 적용하겠다.
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey[850]),
            onTap: () {
              print('settings is clicked');
            },
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.grey[850]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
            },
            title: Text('Log in'),
          )
        ],
      ),
    );
  }
}