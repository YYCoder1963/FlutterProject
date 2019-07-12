import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_trip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  double _appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
    Future.delayed(Duration(milliseconds: 600),(){
      FlutterSplashScreen.hide();
    });
  }

  _onScroll(offset){
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
      print(_appBarAlpha);
    });
  }

  Future<Null> _handleRefresh() async {
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    }catch (e){
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Center(
                  child: NotificationListener(
                    onNotification: (scrollNotification){
                      if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child:_listView,
                  ),
                ),
              ),
            ),
            _appBar
          ],
        ),
      )
    );
  }

  Widget get _listView{
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
          child: LocalNav(localNavList: localNavList,),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: GridNav(
            gridNavModel: gridNavModel,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBoxModel: salesBoxModel,),
        ),
      ],
    );
  }

  Widget get _banner{
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context,int index){
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              NavigatorUtil.push(
                context,
                WebView(
                  url: model.url,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                )
              );
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget get _appBar {
    return Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000),Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 80.0,
              decoration: BoxDecoration(
                color: Color.fromARGB((_appBarAlpha*255).toInt(), 255, 255, 255),
              ),
              child: SearchBar(
                searchBarType: _appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                inputBoxClick: _jumpToSearch,
                speakClick: _jumpToSpeak,
                defaultText: 'search',
                leftButtonClick: (){},
              ),
            ),
          ),
          Container(
            height: _appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)],
            ),
          )
        ],
    );
  }

  _jumpToSearch() {
//    NavigatorUtil.push(
//      context,
//
//    )
  }

  _jumpToSpeak() {

  }
}