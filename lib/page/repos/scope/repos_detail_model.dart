import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/model/Repository.dart';
import 'package:gsy_github_app_flutter/model/RepositoryQL.dart';
import 'package:scoped_model/scoped_model.dart';

import '../repository_detail_page.dart';
///model_scope 状态管理
///仓库详情数据实体，包含有当前index，仓库数据，分支等等
///2、在Scoped中，Model是一个只包含与状态相关信息的单位。我们应该把状态数据与操作数据的方法抽象出来封装到Model中。
///由于Model必须继承至Model类，所以它就具有了侵入性。
class ReposDetailModel extends Model {

  //重写ScopedModel.of
  static ReposDetailModel of(BuildContext context) =>
      ScopedModel.of<ReposDetailModel>(context);

  final String userName;
  final String reposName;

  ReposDetailModel({this.userName, this.reposName});

  int _currentIndex = 0;

  String _currentBranch = "master";

  RepositoryQL _repository;

  BottomStatusModel _bottomModel;

  List<Widget> _footerButtons;

  List<String> _branchList;

  RepositoryQL get repository => _repository;

  ///#################################################///

  set repository(RepositoryQL data) {
    _repository = data;
    ///采用了观察者模式，
    notifyListeners();//状态发生改变时调用该方法更新
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int data) {
    _currentIndex = data;
    notifyListeners();
  }

  String get currentBranch => _currentBranch;

  set currentBranch(String data) {
    _currentBranch = data;
    notifyListeners();
  }

  BottomStatusModel get bottomModel => _bottomModel;

  set bottomModel(BottomStatusModel data) {
    _bottomModel = data;
    notifyListeners();
  }

  List<Widget> get footerButtons => _footerButtons;

  set footerButtons(List<Widget> data) {
    _footerButtons = data;
    notifyListeners();
  }

  List<String> get branchList => _branchList;

  set branchList(List<String> data) {
    _branchList = data;
    notifyListeners();
  }

  ///#################################################///

  ///获取网络端仓库的star等状态
  getReposStatus(List<Widget> getBottomWidget()) async {
    String watchText =
        repository.isSubscription == "SUBSCRIBED" ? "UnWatch" : "Watch";
    String starText = repository.isStared ? "UnStar" : "Star";
    IconData watchIcon = repository.isSubscription == "SUBSCRIBED"
        ? GSYICons.REPOS_ITEM_WATCHED
        : GSYICons.REPOS_ITEM_WATCH;
    IconData starIcon = repository.isStared
        ? GSYICons.REPOS_ITEM_STARED
        : GSYICons.REPOS_ITEM_STAR;
    BottomStatusModel model =
        new BottomStatusModel(watchText, starText, watchIcon, starIcon);
    bottomModel = model;
    footerButtons = getBottomWidget();
  }

  ///获取分支数据
  getBranchList() async {
    var result = await ReposDao.getBranchesDao(userName, reposName);
    if (result != null && result.result) {
      branchList = result.data;
    }
  }
}
