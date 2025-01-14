import 'package:atomi_yep/screens/home/even_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/event/event_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            toolbarHeight: 100,
            title: Text('Year End Party Atomi Digital',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Đang Diễn Ra'),
                Tab(text: 'Sắp Diễn Ra'),
                Tab(text: 'Đã Kết Thúc'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            EventListTab(status: 'active'),
            EventListTab(status: 'pending'),
            EventListTab(status: 'closed'),
          ],
        ),
      ),
    );
  }
}