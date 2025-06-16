import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_state.dart';

class NetworkProvidersCubit extends Cubit<NetworkProvidersState>{
  NetworkProvidersCubit(): super(NetworkProvidersState.initial());
  setNetworkProviders(List<String> networkProviders){
    emit(state.copyWith(networkProviders: networkProviders));
  }
}