import 'criteria.dart';

class SearchQuery implements CriteriaDto {
  bool ascending;
  int numberOfItemsPerPage;
  int orgId;
  int pageIndex;
  String searchString;
  String sortBy;
  String sortDirection;
  int startIndex;
  int totalNumberOfItems;
  Map<String, dynamic> fieldFilters;

  SearchQuery({
    this.fieldFilters,
    this.ascending: true,
    this.numberOfItemsPerPage = 6,
    this.orgId,
    this.pageIndex,
    this.searchString,
    this.sortBy = 'ID',
    this.sortDirection = 'ASC',
    this.startIndex = 0,
    this.totalNumberOfItems = 100});

  factory SearchQuery.withDefaultValues({
    Map<String, dynamic> fieldFilters,
    int orgId,
    int pageIndex,
    String searchString}){
    return SearchQuery(
        totalNumberOfItems: 0,
        startIndex: 0,
        sortDirection: "ASC",
        sortBy: "ID",
        searchString: "D",
        pageIndex: 0,
        numberOfItemsPerPage: 5,
        ascending: true,
        fieldFilters: fieldFilters,
        orgId: orgId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ascending'] = this.ascending;
    data['numberOfItemsPerPage'] = this.numberOfItemsPerPage;
    data['orgId'] = this.orgId;
    data['pageIndex'] = this.pageIndex;
    data['searchString'] = this.searchString;
    data['sortBy'] = this.sortBy;
    data['sortDirection'] = this.sortDirection;
    data['startIndex'] = this.startIndex;
    data['totalNumberOfItems'] = this.totalNumberOfItems;
    data['fieldFilters'] = this.fieldFilters;
    return data;
  }
}