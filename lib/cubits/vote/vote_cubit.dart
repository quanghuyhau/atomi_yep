import 'package:atomi_yep/main.dart';
import 'package:atomi_yep/repository/vote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'vote_state.dart';

class VoteCubit extends Cubit<VoteState> {
  final VoteRepository _voteRepository;

  VoteCubit(this._voteRepository) : super(VoteState());

  void updateVoterName(String name) {
    emit(state.copyWith(voterName: name));
  }

  void updateVoterCode(String code) {
    userCodeSave = code;
  }

  void toggleBox(int index) {
    final selectedBoxes = Set<int>.from(state.selectedBoxes);

    if (selectedBoxes.contains(index)) {
      selectedBoxes.remove(index);
    } else if (selectedBoxes.length < 2) {
      selectedBoxes.add(index);
    }

    emit(state.copyWith(selectedBoxes: selectedBoxes));
  }

  Future<void> submitVote(String eventId) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: VoteStatus.submitting));

    try {
      await _voteRepository.submitVote(
        eventId: eventId,
        voterName: userCodeSave,
        // voterName: state.voterName,
        selectedBoxes: state.selectedBoxes.toList(),
      );

      emit(state.copyWith(status: VoteStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: VoteStatus.failure,
        error: e.toString(),
      ));
    }
  }

  void reset() {
    emit(VoteState());
  }
}