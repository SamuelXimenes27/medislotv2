import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetFeaturedClinic makeGetFeaturedClinics() => RemoteGetFeaturedClinic(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('clinics?featured=1'),
    );
