import '../../../../data/data.dart';
import '../../../../domain/domain.dart';
import '../../http/http.dart';

CreateCheckoutPaymentUsecase makeCreateCheckoutPaymentUsecaseFactory() => EasypayCreateCheckoutPayment(
      httpClient: makeAuthorizeHttpClientDecoratorFactory(),
      url: makeEasypayApiUrlDev('checkout'),
    );
