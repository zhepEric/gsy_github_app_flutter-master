import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/widget/gsy_tabs.dart' as GSYTab;

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class GSYTabBarWidget extends StatefulWidget {
  final TabType type;

  final bool resizeToAvoidBottomPadding;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget bottomBar;

  final List<Widget> footerButtons;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onDoublePress;
  final ValueChanged<int> onSinglePress;

  GSYTabBarWidget({
    Key key,
    this.type = TabType.top,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.bottomBar,
    this.onDoublePress,
    this.onSinglePress,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomPadding = true,
    this.footerButtons,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _GSYTabBarState createState() => new _GSYTabBarState();
}
///要使用 TabController，比如混入一个 SingleTickerProviderStateMixin
class _GSYTabBarState extends State<GSYTabBarWidget>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  TabController _tabController;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _navigationPageChanged(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    _tabController.animateTo(index);
    widget.onPageChanged?.call(index);
  }

  _navigationTapClick(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    widget.onPageChanged?.call(index);

    ///不想要动画
    ///每个 Tabbar 点击时，通过pageController.jumpTo 跳转页面，每个页面需要跳转坐标为：当前屏幕大小乘以索引 index 。
    _pageController.jumpTo(MediaQuery.of(context).size.width * index);
    widget.onSinglePress?.call(index);
  }

  _navigationDoubleTapClick(index) {
    _navigationTapClick(index);
    widget.onDoublePress?.call(index);
  }

  ///底部tab是放在了 Scaffold 的 bottomNavigationBar 中。
  ///顶部tab是放在 AppBar 的 bottom 中，也就是标题栏之下。
  @override
  Widget build(BuildContext context) {
    if (widget.type == TabType.top) {
      ///顶部tab bar
      return new Scaffold(
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        floatingActionButton:
            SafeArea(child: widget.floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: widget.footerButtons,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          //顶部导航栏放在bottom属性
          bottom: new TabBar(
              controller: _tabController,
              tabs: widget.tabItems,
              indicatorColor: widget.indicatorColor,
              onTap: _navigationTapClick),
        ),
        body: new PageView(
          controller: _pageController,
          children: widget.tabViews,
          onPageChanged: _navigationPageChanged,
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }

    ///底部tab bar
    return new Scaffold(
        drawer: widget.drawer,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
        ),
        body: new PageView(
          controller: _pageController,
          children: widget.tabViews,
          onPageChanged: _navigationPageChanged,
        ),
        bottomNavigationBar: new Material(
          //为了适配主题风格，包一层Material实现风格套用
          color: Theme.of(context).primaryColor, //底部导航栏主题颜色
          //SafeArea能很好的解决刘海，不规则屏幕的显示问题。
          child: new SafeArea(
            child: new GSYTab.TabBar(
              //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
              controller: _tabController,
              //配置控制器
              tabs: widget.tabItems,
              indicatorColor: widget.indicatorColor,//tab标签的下划线颜色
              onDoubleTap: _navigationDoubleTapClick,
              onTap: _navigationTapClick,
            ),
          ),
        ));
  }
}

enum TabType { top, bottom }
