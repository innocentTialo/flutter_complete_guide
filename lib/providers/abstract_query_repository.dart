import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/abstract_summary.dart';
import '../models/criteria.dart';
import './abstract_repository.dart';

abstract class AbstractQueryRepository<S extends AbstractSummaryDto> extends AbstractRepository {
  Future<List<S>> searchAll(CriteriaDto criteria) async {
    final String _searchPath = '/${getControllerName()}/search-all';
    return _doSearchAll(_searchPath, criteria);
  }

  Future<List<S>> search(CriteriaDto criteria) async {
    final String _searchPath = '/${getControllerName()}/search';
    return _doSearch(_searchPath, criteria);
  }

  Future<int> count(CriteriaDto criteria) async {
    final String _searchPath = '/${getControllerName()}/count';
    return _doCount(_searchPath, criteria);
  }

  Future<List<S>> _doSearchAll(String _searchPath, CriteriaDto criteria) async {
    final Response responseJson = await apiEndpoint.postDynamic(
        await getAuthToken(), _searchPath, criteria.toJson());
    return _convertToSummaryDto(responseJson);
  }

  Future<List<S>> _convertToSummaryDto(Response responseJson) async {
    return (responseJson.data.map((jsonValue) => toSummaryDto(json.encode(jsonValue))).toList()).cast<
        S>();
  }

  Future<List<S>> _doSearch(String _searchPath, CriteriaDto criteria) async {
    final responseJson = await apiEndpoint.postDynamic(
        await getAuthToken(), _searchPath, criteria.toJson());
    return _convertToSummaryDto(responseJson);
  }

  Future<int> _doCount(String _searchPath, CriteriaDto criteria) async {
    final responseJson = await apiEndpoint.post(
        await getAuthToken(), _searchPath, criteria.toJson());
    return int.parse(responseJson);
  }

}
