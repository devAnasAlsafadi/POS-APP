import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/main_bottom_nav.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/main_mobile_app_bar.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/main_side_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/features/orders/presentation/blocs/orders_bloc/orders_bloc.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../reservations/presentation/blocs/reservations_bloc.dart';
import '../../blocs/floor_map_bloc.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final MainScreenController _controller = MainScreenController();

  @override
  void initState() {
    super.initState();
    _controller.onUpdate = () => setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<ReservationsBloc>()..add(GetTodayReservationsEvent()),
          ),
          BlocProvider(
            create: (context) => sl<FloorMapBloc>()..add(const FetchTablesEvent()),
          ),
          BlocProvider(
            create: (context) => sl<OrdersBloc>(),
          ),
        ],
        child: LayoutBuilder(builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 800;
          return Row(
            children: [
              if (isTablet) MainSideBar(controller: _controller, onUpdate: () => setState(() {}),),
              Expanded(
                child: Scaffold(
                 appBar: !isTablet ? MainMobileAppBar(onAlertsTap: () => setState(()=> _controller.selectedIndex = 2),) : null,
                  body: IndexedStack(
                    index: _controller.selectedIndex,
                    children: _controller.screens,
                  ),
                  bottomNavigationBar: !isTablet ? MainBottomNav(currentIndex: _controller.currentMobileIndex, onTap: (index) => _controller.onMobileTap(index, () => setState(() {})) ,) : null,
                )
              ),
            ],
          );
        },),
      ),
    );
  }





}
