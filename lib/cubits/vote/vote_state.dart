import 'package:equatable/equatable.dart';

enum VoteStatus { initial, submitting, success, failure }

class VoteState extends Equatable {
  final Set<int> selectedBoxes;
  final String voterName;
  final VoteStatus status;
  final String? error;

  const VoteState({
    this.selectedBoxes = const {},
    this.voterName = '',
    this.status = VoteStatus.initial,
    this.error,
  });

  bool get canSubmit =>
      status != VoteStatus.submitting &&
          voterName.isNotEmpty &&
          selectedBoxes.length == 2;

  VoteState copyWith({
    Set<int>? selectedBoxes,
    String? voterName,
    VoteStatus? status,
    String? error,
  }) {
    return VoteState(
      selectedBoxes: selectedBoxes ?? this.selectedBoxes,
      voterName: voterName ?? this.voterName,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [selectedBoxes, voterName, status, error];
}