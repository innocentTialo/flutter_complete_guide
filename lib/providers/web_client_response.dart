class WebClientResponse<T> {
  Status status;
  T data;
  String message;

  WebClientResponse.loading(this.message) : status = Status.LOADING;

  WebClientResponse.completed(this.data) : status = Status.COMPLETED;

  WebClientResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
