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
          colorSchemeSeed: const Color(0xFF4F46E5),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
