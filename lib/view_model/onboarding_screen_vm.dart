import 'package:flutter/material.dart';
import 'package:jpshua/view_model/base_vm.dart';

class OnboardingVM extends BaseViewModel {
  PageController? tabController = PageController();
  int _pageIndex = 0;


  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
  void setPage(int page){
    if(tabController!.positions.isNotEmpty) {
      tabController!.jumpToPage(page);
    }
  }
}