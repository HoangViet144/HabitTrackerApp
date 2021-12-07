// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
    goalList: (json['goalList']).map((e) => Goal.fromJson(e)).toList()

    // goalList: (json['goalList'] as List<Goal>)?.map((e) => Goal.fromJson(e as Map<String, Goal>))
    //         .toList() ??
    //     const <Goal>[],
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'goalList': instance.goalList,
    };
