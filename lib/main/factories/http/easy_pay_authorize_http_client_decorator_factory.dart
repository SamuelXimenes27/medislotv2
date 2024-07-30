import '../../../data/http/http_client.dart';
import '../../decorators/decorators.dart';
import '../factories.dart';

HttpClient makeAuthorizeHttpClientDecoratorFactory() => EasyPayAuthorizeHttpClientDecorator(
      accountId: makeEasyPayAccountId(),
      apiKey: makeEasyPayApiKey(),
      decorate: makeHttpAdapter(),
    );
