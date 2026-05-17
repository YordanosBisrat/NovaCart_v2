import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product/product_bloc.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'presentation/screens/home_screen.dart';
import 'bloc/product/product_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final dataSource = ProductRemoteDataSource(dioClient);

    return BlocProvider(
      create: (_) => ProductBloc(dataSource)..add(LoadProducts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NovaCart v2',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF4F46E5),
          scaffoldBackgroundColor: const Color(0xFFF8F7FC),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          chipTheme: const ChipThemeData(backgroundColor: Color(0xFFF0F1FF)),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
