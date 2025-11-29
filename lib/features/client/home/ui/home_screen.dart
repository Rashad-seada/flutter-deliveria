import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:delveria/features/client/home/ui/widgets/header_section.dart';
import 'package:delveria/features/client/home/ui/widgets/scrollable_content.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,  this.lat,  this.long});
  final  double ? lat, long;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                HeaderSection(themeState: state, lat: widget.lat??0,
                 long: widget.long??0,),
                BlocBuilder<SlidersCubit, SlidersState>(
                  builder: (context, sliderState) {
                    return ScrollableContent(
                      lat: widget.lat ?? 0,
                      long: widget.long ?? 0,
                      themeState: state,
                      cubit: context.read<SlidersCubit>(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
