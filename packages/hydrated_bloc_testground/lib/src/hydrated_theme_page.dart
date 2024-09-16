import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc_testground/hydrated_bloc_testground.dart';

class HydratedThemePage extends StatelessWidget {
  const HydratedThemePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: Icon(Icons.dark_mode_outlined),
            onPressed: () {
              context.read<HydratedThemeBloc>().add(DarkThemeSelectedEvent());
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.light_mode_outlined),
            onPressed: () {
              context.read<HydratedThemeBloc>().add(LightThemeSelectedEvent());
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
          FloatingActionButton(
            child: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hydrated Theme'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Hydrated Theme Page'),
              SizedBox(height: 20),
              Text(DateTime.now().toIso8601String()),
              BlocBuilder<HydratedThemeBloc, HydratedThemeState>(
                builder: (context, state) {
                  if (state is ThemeChanged) {
                    return Text('Theme: ${state.themeData.brightness}');
                  }
                  return Text('Theme: Light');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
