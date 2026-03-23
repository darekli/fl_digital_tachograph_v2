import 'package:fl_digital_tachograph_v2/time/change_time/change_time_01.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_02.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_03.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_04.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_05.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_06.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_07.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_08.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_09.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_10.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_11.dart';
import 'package:flutter/material.dart';

class ChangeTimeView extends StatefulWidget {
  const ChangeTimeView({super.key});

  @override
  State<ChangeTimeView> createState() => _ChangeTimeViewState();
}

class _ChangeTimeViewState extends State<ChangeTimeView> {
  DateTime _sharedUTC = DateTime.now();
  late String _sharedTimeZoneLabel;
  int _screen = 1;

  @override
  void initState() {
    super.initState();
    _sharedTimeZoneLabel = _buildUtcOffsetLabel(DateTime
        .now()
        .timeZoneOffset);
  }

  String _buildUtcOffsetLabel(Duration offset) {
    if (offset == Duration.zero) {
      return 'UTC';
    }

    final totalMinutes = offset.inMinutes;
    final sign = totalMinutes >= 0 ? '+' : '-';
    final absoluteMinutes = totalMinutes.abs();
    final hours = absoluteMinutes ~/ 60;
    final minutes = absoluteMinutes % 60;

    if (minutes == 0) {
      return 'UTC$sign$hours';
    }

    return 'UTC$sign$hours:${minutes.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44),
      appBar: AppBar(
        title: const Text('Change Time'),
        backgroundColor: const Color(0xFF0A1F44),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: _screen == 1
              ? ChangeTime01Widget(
                  externalTime: _sharedUTC,
                  timeZoneLabel: _sharedTimeZoneLabel,
                  useArrowAdjustIcons: true,
                  onArrowUpPressed: () {
                    setState(() {
                      _screen = 2;
                    });
                  },
                  onArrowDownPressed: () {
                    setState(() {
                      _screen = 1;
                    });
                  },
                  onStateChanged: (DateTime newTime, String newLabel) {
                    setState(() {
                      _sharedUTC = newTime;
                      _sharedTimeZoneLabel = newLabel;
                    });
                  },
                )
              : _screen == 2
                  ? ChangeTime02Widget(
                      externalTime: _sharedUTC,
                      timeZoneLabel: _sharedTimeZoneLabel,
                      useArrowAdjustIcons: true,
                      onArrowUpPressed: () {
                        setState(() {
                          _screen = 2;
                        });
                      },
                      onArrowDownPressed: () {
                        setState(() {
                          _screen = 1;
                        });
                      },
                      onOkPressed: () {
                        setState(() {
                          _screen = 3;
                        });
                      },
                      onStateChanged: (DateTime newTime, String newLabel) {
                        setState(() {
                          _sharedUTC = newTime;
                          _sharedTimeZoneLabel = newLabel;
                        });
                      },
                    )
                  : _screen == 3
                      ? ChangeTime03Widget(
                          externalTime: _sharedUTC,
                          timeZoneLabel: _sharedTimeZoneLabel,
                          useArrowAdjustIcons: true,
                          onArrowUpPressed: () {
                            setState(() {
                              _screen = 4;
                            });
                          },
                          onArrowDownPressed: () {
                            setState(() {
                              _screen = 2;
                            });
                          },
                          onOkPressed: () {
                            setState(() {
                              _screen = 3;
                            });
                          },
                          onStateChanged: (DateTime newTime, String newLabel) {
                            setState(() {
                              _sharedUTC = newTime;
                              _sharedTimeZoneLabel = newLabel;
                            });
                          },
                        )
                      : _screen == 4
                          ? ChangeTime04Widget(
                              externalTime: _sharedUTC,
                              timeZoneLabel: _sharedTimeZoneLabel,
                              useArrowAdjustIcons: true,
                              onArrowUpPressed: () {
                                setState(() {
                                  _screen = 5;
                                });
                              },
                              onArrowDownPressed: () {
                                setState(() {
                                  _screen = 3;
                                });
                              },
                              onOkPressed: () {
                                setState(() {
                                  _screen = 4;
                                });
                              },
                              onStateChanged: (DateTime newTime, String newLabel) {
                                setState(() {
                                  _sharedUTC = newTime;
                                  _sharedTimeZoneLabel = newLabel;
                                });
                              },
                            )
                          : _screen == 5
                              ? ChangeTime05Widget(
                                  externalTime: _sharedUTC,
                                  timeZoneLabel: _sharedTimeZoneLabel,
                                  useArrowAdjustIcons: true,
                                  onArrowUpPressed: () {
                                    setState(() {
                                      _screen = 5;
                                    });
                                  },
                                  onArrowDownPressed: () {
                                    setState(() {
                                      _screen = 4;
                                    });
                                  },
                                  onOkPressed: () {
                                    setState(() {
                                      _screen = 6;
                                    });
                                  },
                                  onStateChanged: (DateTime newTime, String newLabel) {
                                    setState(() {
                                      _sharedUTC = newTime;
                                      _sharedTimeZoneLabel = newLabel;
                                    });
                                  },
                                )
                              : _screen == 6
                                  ? ChangeTime06Widget(
                                      externalTime: _sharedUTC,
                                      timeZoneLabel: _sharedTimeZoneLabel,
                                      useArrowAdjustIcons: true,
                                      onArrowUpPressed: () {
                                        setState(() {
                                          _screen = 7;
                                        });
                                      },
                                      onArrowDownPressed: () {
                                        setState(() {
                                          _screen = 5;
                                        });
                                      },
                                      onOkPressed: () {
                                        setState(() {
                                          _screen = 6;
                                        });
                                      },
                                      onStateChanged: (DateTime newTime, String newLabel) {
                                        setState(() {
                                          _sharedUTC = newTime;
                                          _sharedTimeZoneLabel = newLabel;
                                        });
                                      },
                                    )
                                  : _screen == 7
                                      ? ChangeTime07Widget(
                                          externalTime: _sharedUTC,
                                          timeZoneLabel: _sharedTimeZoneLabel,
                                          useArrowAdjustIcons: true,
                                          onArrowUpPressed: () {
                                            setState(() {
                                              _screen = 8;
                                            });
                                          },
                                          onArrowDownPressed: () {
                                            setState(() {
                                              _screen = 6;
                                            });
                                          },
                                          onOkPressed: () {
                                            setState(() {
                                              _screen = 7;
                                            });
                                          },
                                          onStateChanged: (DateTime newTime, String newLabel) {
                                            setState(() {
                                              _sharedUTC = newTime;
                                              _sharedTimeZoneLabel = newLabel;
                                            });
                                          },
                                        )
                                      : _screen == 8
                                          ? ChangeTime08Widget(
                                              externalTime: _sharedUTC,
                                              timeZoneLabel: _sharedTimeZoneLabel,
                                              useArrowAdjustIcons: true,
                                              onArrowUpPressed: () {
                                                setState(() {
                                                  _screen = 9;
                                                });
                                              },
                                              onArrowDownPressed: () {
                                                setState(() {
                                                  _screen = 7;
                                                });
                                              },
                                              onOkPressed: () {
                                                setState(() {
                                                  _screen = 8;
                                                });
                                              },
                                              onStateChanged: (DateTime newTime, String newLabel) {
                                                setState(() {
                                                  _sharedUTC = newTime;
                                                  _sharedTimeZoneLabel = newLabel;
                                                });
                                              },
                                            )
                                          : _screen == 9
                                              ? ChangeTime09Widget(
                                                  externalTime: _sharedUTC,
                                                  timeZoneLabel: _sharedTimeZoneLabel,
                                                  useArrowAdjustIcons: true,
                                                  onArrowUpPressed: () {
                                                    setState(() {
                                                      _screen = 9;
                                                    });
                                                  },
                                                  onArrowDownPressed: () {
                                                    setState(() {
                                                      _screen = 8;
                                                    });
                                                  },
                                                  onOkPressed: () {
                                                    setState(() {
                                                      _screen = 10;
                                                    });
                                                  },
                                                  onStateChanged: (DateTime newTime, String newLabel) {
                                                    setState(() {
                                                      _sharedUTC = newTime;
                                                      _sharedTimeZoneLabel = newLabel;
                                                    });
                                                  },
                                                )
                                              : _screen == 10
                                                  ? ChangeTime10Widget(
                                                      externalTime: _sharedUTC,
                                                      timeZoneLabel: _sharedTimeZoneLabel,
                                                      useArrowAdjustIcons: true,
                                                      onArrowUpPressed: () {
                                                        setState(() {
                                                          _screen = 10;
                                                        });
                                                      },
                                                      onArrowDownPressed: () {
                                                        setState(() {
                                                          _screen = 9;
                                                        });
                                                      },
                                                      onOkPressed: () {
                                                        setState(() {
                                                          _screen = 11;
                                                        });
                                                      },
                                                      onStateChanged: (DateTime newTime, String newLabel) {
                                                        setState(() {
                                                          _sharedUTC = newTime;
                                                          _sharedTimeZoneLabel = newLabel;
                                                        });
                                                      },
                                                    )
                                                  : ChangeTime11Widget(
                                                      onAutoReturnToScreen9: () {
                                                        setState(() {
                                                          _screen = 9;
                                                        });
                                                      },
                                                    ),
        ),
      ),
    );
  }
}

