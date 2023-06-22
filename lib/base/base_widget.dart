import 'package:flutter/material.dart';
import 'package:new_spaper/base/base_viewnodel.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  const BaseWidget({super.key, 
    required this.builder, 
    required this.viewModel, 
    this.onViewModelReady
  });

  final Widget Function(
    BuildContext context, T viewModel,
    Widget? child
  ) builder;

  final T viewModel;

  final Function(T? viewModel)? onViewModelReady;

  @override
  State<BaseWidget<T>> createState() => _BaseWidgetState<T>();

}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {

  T? viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    if(widget.onViewModelReady != null){
      widget.onViewModelReady!(viewModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => viewModel!..setContext(context),
      child: Consumer<T>(
        builder: widget.builder
      ),
    );
  }
}