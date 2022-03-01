import 'dart:async';

import 'package:flutter/material.dart';
import 'package:novo_financeiro_mock/loading_status.dart';
import 'package:novo_financeiro_mock/menu_view/contas_receber.dart';

import 'blue_background.dart';
import 'menu_view/contas_pagar.dart';
import 'menu_view/relatorio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static _MyHomePageState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyHomePageState>();
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  late final ValueNotifier<LoadingStatus> _viewStatus;
  late final ValueNotifier<int> _tabController;
  late final List<Widget> _tabView;

  @override
  void initState() {
    super.initState();
    _viewStatus = ValueNotifier<LoadingStatus>(LoadingStatus.completed);
    _tabController = ValueNotifier<int>(0);
    _tabView = [
      const ContasReceber(),
      const ContasPagar(),
      const Relatorio(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financeiro'),
        centerTitle: true,
        backgroundColor: const Color(0xff004883),
        elevation: 0,
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                setState(() {});
              },
            );
          }),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _tabController,
        builder: (_, selectedIndex, ___) => BottomNavigationBar(
          onTap: (index) async {
            // if(_viewStatus.value != LoadingStatus.loading) {
              _viewStatus.value = LoadingStatus.loading;
              await Future.delayed(const Duration(seconds: 1));
              _viewStatus.value = LoadingStatus.completed;
              _tabController.value = index > _tabView.length - 1 ? _tabController.value : index;
            // }
          },
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Receber',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              label: 'Pagar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Relatório',
            ),
          ],
        ),
      ),
      body: BackgroundWidget(
        color: const Color(0xff004883),
        hasBottomNavigationBar: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: _viewStatus,
            builder: (context, viewStatus, _) {
              if(_viewStatus.value == LoadingStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ValueListenableBuilder<int>(
                valueListenable: _tabController,
                builder: (context, index, _) {
                  return _tabView[index];
                },
              );
            }
          ),
        ),
      ),
    );
  }
}
