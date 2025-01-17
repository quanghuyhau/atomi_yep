import 'package:atomi_yep/constant/app_color.dart';
import 'package:atomi_yep/constant/imageconstant.dart';
import 'package:atomi_yep/screens/home/even_list_tab.dart';
import 'package:flutter/material.dart';

final length = 3;
final lstTab = ['Đang Diễn Ra', 'Sắp Diễn Ra', 'Đã Kết Thúc'];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int _selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(
        length: length,
        vsync: this,
        animationDuration: const Duration(milliseconds: 10))
      ..addListener(() => setState(() {
            _selectedIndex = tabController.index;
          }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          width: double.infinity,
          height: double.infinity,
          Images.backgroundVintes,
          fit: BoxFit.fill,
        ),
        DefaultTabController(
          length: length,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: AppBar(
                // leading: IconButton(
                //   icon: Icon(
                //     Icons.arrow_back,
                //     color: Colors.white,
                //   ),
                //   onPressed: () {
                //     // Navigator.canPop(context);
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(builder: (_) => EnterInputName()),
                //     );
                //   },
                // ),
                backgroundColor: Colors.transparent,
                toolbarHeight: 100,
                title: const Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ),
                centerTitle: true,
                bottom: _tabBar(),
              ),
            ),
            body: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage(Images.backgroundHome), fit: BoxFit.fill),
              // ),
              child: TabBarView(
                controller: tabController,
                children: const [
                  EventListTab(status: 'active'),
                  EventListTab(status: 'pending'),
                  EventListTab(status: 'closed'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _tabBar() {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          tabController.index = index;
        });
      },
      tabAlignment: TabAlignment.start,
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      tabs: _buildTabs(),
    );
  }

  List<Widget> _buildTabs() {
    return lstTab
        .map((tab) => _tab(
              text: tab,
            ))
        .toList();
  }

  Widget _tab({
    required String text,
  }) {
    final isSelected = _selectedIndex == lstTab.indexWhere((a) => a == text);
    return Tab(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white,
          gradient: isSelected ? GradientUtils.primaryGradient : null,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}
