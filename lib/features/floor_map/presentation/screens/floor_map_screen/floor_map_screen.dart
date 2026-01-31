import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/blocs/floor_map_bloc.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/floor_map_header.dart';
import '../../widgets/table_card.dart';

class FloorMapScreen extends StatefulWidget {
  final MainScreenController mainController;
  const FloorMapScreen({super.key, required this.mainController});
  @override
  State<FloorMapScreen> createState() => _FloorMapScreenState();
}

class _FloorMapScreenState extends State<FloorMapScreen> {

  @override
  void initState() {
    super.initState();
    context.read<FloorMapBloc>().add(GetTablesEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const FloorMapHeader(),
            Expanded(
              child: BlocBuilder<FloorMapBloc, FloorMapState>(
                builder: (context, state) {
                  if (state is FloorMapLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FloorMapLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveBreakpoints.of(context).isMobile ? 2 : 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                      ),
                      itemCount: state.tables.length,
                      itemBuilder: (context, index) {
                        return TableCard(table: state.tables[index],controller: widget.mainController, update: () => widget.mainController.refreshApp());
                      },
                    );
                  } else {
                    return const Center(child: Text("Error loading tables", style: TextStyle(color: Colors.white)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
