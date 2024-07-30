import '../../../../data/data.dart';
import '../../../../domain/domain.dart';
import '../../http/http.dart';

CreateSinglePaymentUsecase makeCreateSinglePaymentUsecaseFactory() => EasypayCreateSinglePayment(
      httpClient: makeAuthorizeHttpClientDecoratorFactory(),
      url: makeEasypayApiUrlDev('single'),
    );
