import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/mixin/drawer_viwe_mixin.dart';
import 'package:hipocapp/feature/drawer/view/widget/toggle_button.dart';
import 'package:hipocapp/product/state/base/base_state.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends BaseState<DrawerView> with DrawerViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => drawerViewModel,
      child: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF7B1E3A),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToggleButton(),
                    Text(
                      'Menü',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.school),
              title: Text('Tıp'),
              children: [
                ListTile(title: Text('Temel Tıp'), onTap: () {}),
                ListTile(title: Text('Dahili Tıp'), onTap: () {}),
                ListTile(title: Text('Cerrahi Tıp'), onTap: () {}),
                ListTile(title: Text('Pratisyen'), onTap: () {}),
                ListTile(title: Text('Diş Hekimliği'), onTap: () {}),
                ListTile(title: Text('Eczacılık'), onTap: () {}),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.settings),
              title: Text('Kültür ve Sanat'),
              children: [
                ListTile(title: Text('Müzik'), onTap: () {}),
                ListTile(title: Text('Edebiyat'), onTap: () {}),
                ListTile(title: Text('Sinema ve Tiyatro'), onTap: () {}),
                ListTile(title: Text('Dil'), onTap: () {}),
                ListTile(title: Text('Kitap Dergi ve Gazetecilik'), onTap: () {}),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Bilim'),
              children: [
                ListTile(title: Text('Mühendislik - Mimari'), onTap: () {}),
                ListTile(title: Text('Matematik Fizik'), onTap: () {}),
                ListTile(title: Text('Kimya - Biyoloji'), onTap: () {}),
                ListTile(title: Text('Dil Tarhi Coğrafya'), onTap: () {}),
                ListTile(title: Text('Eğitim Psikoloji Felsefe'), onTap: () {}),
                ListTile(title: Text('Ekonomi Hukuk'), onTap: () {}),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.person),
              title: Text('Öğrenci'),
              children: [
                ListTile(title: Text('Üniversiteler ve Bölümler'), onTap: () {}),
                ListTile(title: Text('Denklikler vev Geçişler'), onTap: () {}),
                ListTile(title: Text('Genel Konular'), onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
