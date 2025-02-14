import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../entities/donation_entity.dart';
import '../repository/donation_repository.dart';

class DonateUseCase extends Usecase<DonationEntity, DonationEntity> {
  @override
  Future<DonationEntity> call({DonationEntity? params}) async {
    return await sl<DonationRepository>().donate(entity: params!);
  }
}
