
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_state.dart';
import 'package:itdata/services/network_providers_service.dart';

class NetworkProvidersCubit extends Cubit<NetworkProvidersState>{
  NetworkProvidersCubit(): super(NetworkProvidersState.initial());
  loadNetworkProviders() async {
    final networkProviders = await NetworkProvidersService().loadNetworkProviders();
    emit(state.copyWith(networkProviders: networkProviders));
  }
  setNetworkProviders(Map<String, dynamic> networkProviders){
    emit(state.copyWith(networkProviders: networkProviders));
  }
  reset() {
    emit(NetworkProvidersState.initial());
  }
}