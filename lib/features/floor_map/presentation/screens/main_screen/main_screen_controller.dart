import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/features/products/presentation/screens/create_order_screen/create_order_screen.dart';

import 'package:pos_wiz_tech/features/floor_map/domain/entities/table_entity.dart';
import '../alerts_screen/alerts_screen.dart';
import '../floor_map_screen/floor_map_screen.dart';
import '../orders_screen/orders_screen.dart';
import '../settings_screen/settings_screen.dart';

class MainScreenController {
  int selectedIndex = 0;
  TableEntity? selectedTable;
  VoidCallback? onUpdate;

  List<Widget> get screens => [
    FloorMapScreen(mainController: this),
    const OrdersScreen(),
    const AlertsScreen(),
    const SettingsScreen(),
    selectedTable != null 
        ? CreateOrderScreen(
            key: ValueKey(selectedTable!.id),
            table: selectedTable!
          ) 
        : const Center(child: Text("No table selected")),
  ];


  void goToOrderDetails(TableEntity table, Function update) {
    selectedTable = table;
    selectedIndex = 4;
    if(onUpdate != null) onUpdate!();
  }
  void refreshApp() {
    if(onUpdate != null) onUpdate!();
  }


  void onMobileTap(int index, Function update) {
    List<int> mobileIndices = [0, 1, 3];
    selectedIndex = mobileIndices[index];
    update();
  }


  void onSideBarTap(int index, Function update) {
    if (index != -1) {
      selectedIndex = index;
      update();
    }
  }


  int get currentMobileIndex {
    List<int> mobileIndices = [0, 1, 3];
    return mobileIndices.contains(selectedIndex)
        ? mobileIndices.indexOf(selectedIndex)
        : 0;
  }




}