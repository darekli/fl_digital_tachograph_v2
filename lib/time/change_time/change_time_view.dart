import 'dart:async';

import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
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
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_12.dart';
import 'package:flutter/material.dart';

class ChangeTimeView extends StatefulWidget {
  const ChangeTimeView({super.key});

  @override
  State<ChangeTimeView> createState() => _ChangeTimeViewState();
}

class _ChangeTimeViewState extends State<ChangeTimeView> {
  DateTime _sharedUTC = DateTime.now();
  late String _sharedTimeZoneLabel;
  DateTime? _screen10ManualTime;
  String? _screen10ManualLabel;
  DateTime? _screen12LockUntil;
  int _screen = 1;
  Timer? _autoToScreen12Timer;

  @override
  void initState() {
    super.initState();
    _sharedTimeZoneLabel = LanguageManager().formatUtcOffset(
      DateTime.now().timeZoneOffset,
    );
  }

  @override
  void dispose() {
    _autoToScreen12Timer?.cancel();
    super.dispose();
  }

  void _startAutoToScreen12Timer() {
    _autoToScreen12Timer?.cancel();
    _autoToScreen12Timer = Timer(const Duration(seconds: 3), () {
      if (!mounted || _screen != 9) {
        return;
      }

      setState(() {
        if (_screen10ManualTime != null) {
          _sharedUTC = _screen10ManualTime!;
        }
        if (_screen10ManualLabel != null) {
          _sharedTimeZoneLabel = _screen10ManualLabel!;
        }
        _screen12LockUntil = DateTime.now().add(const Duration(seconds: 6));
        _screen = 12;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44),
      appBar: AppBar(
        title: Text(language.changeTimeTitle),
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
                  blinkArrowUp: true,
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
                                                          _screen10ManualTime = newTime;
                                                          _screen10ManualLabel = newLabel;
                                                        });
                                                      },
                                                    )
                                                  : _screen == 11
                                                      ? ChangeTime11Widget(
                                                          onAutoReturnToScreen9: () {
                                                            setState(() {
                                                              _screen = 9;
                                                            });
                                                            _startAutoToScreen12Timer();
                                                          },
                                                        )
                                                      : ChangeTime12Widget(
                                                      externalTime: _sharedUTC,
                                                      timeZoneLabel: _sharedTimeZoneLabel,
                                                      useArrowAdjustIcons: true,
                                                      onArrowUpPressed: () {
                                                        setState(() {
                                                          _screen = 1;
                                                        });
                                                      },
                                                      onArrowDownPressed: () {
                                                        setState(() {
                                                          _screen = 12;
                                                        });
                                                      },
                                                      onStateChanged: (DateTime newTime, String newLabel) {
                                                        final lockUntil = _screen12LockUntil;
                                                        if (lockUntil != null && DateTime.now().isBefore(lockUntil)) {
                                                          return;
                                                        }

                                                        setState(() {
                                                          _screen12LockUntil = null;
                                                          _sharedUTC = newTime;
                                                          _sharedTimeZoneLabel = newLabel;
                                                        });
                                                      },
                                                    ),
        ),
      ),
    );
  }
}

