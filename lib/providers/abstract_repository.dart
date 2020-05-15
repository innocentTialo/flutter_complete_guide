import 'package:shared_preferences/shared_preferences.dart';

import '../models/abstract_dto.dart';
import '../models/abstract_summary.dart';
import './api_endpoints.dart';
import './shared_preference_constants.dart';

abstract class AbstractRepository<D extends AbstractDto,  S extends AbstractSummaryDto> {
  final ApiEndpoints apiEndpoint = ApiEndpoints();

  Future<String> getAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AUTHENTICATION_TOKEN_KEY);
  }

  Future<bool> setValue(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  Future<S> create(D dto) async {
    final String _createPath = '/${getControllerName()}';
    final responseJson = await apiEndpoint.post(await getAuthToken(), _createPath, dto.toJson());
    return toSummaryDto(responseJson);
  }

  Future<S> register(D dto) async {
    final String _createPath = '/${getControllerName()}';
    final responseJson = await apiEndpoint.post(await getAuthToken(), _createPath, dto.toJson());
    return toSummaryDto(responseJson);
  }

  Future<S> delete(int id) async {
    assert(id != null);
    String _deletePath = '/${getControllerName()}';
    final responseJson = await apiEndpoint.delete(await getAuthToken(), _deletePath + "/$id");
    return toSummaryDto(responseJson);
  }

  Future<S> update(D dto) async {
    String _updatePath = '/${getControllerName()}';
    final responseJson = await apiEndpoint.put(await getAuthToken(), _updatePath, dto.toJson());
    return toSummaryDto(responseJson);
  }

  Future<S> getById(int id) async {
    assert(id != null);
    final String _findByIdPath = '/${getControllerName()}/detail/';
    final responseJson = await apiEndpoint.get(await getAuthToken(), _findByIdPath + "$id");
    return toSummaryDto(responseJson);
  }

  Future<S> getByLogin(String login) async {
    assert(login != null);
    final String _findByIdPath = '/${getControllerName()}/detail/';
    final responseJson = await apiEndpoint.get(await getAuthToken(), _findByIdPath + "$login");
    return toSummaryDto(responseJson);
  }

  String getControllerName();

  S toSummaryDto(String json);
}
