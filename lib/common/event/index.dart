

import 'package:event_bus/event_bus.dart';

/**
 * 其创建EventBus过程中，是通过StreamController.broadcast方法来实现事件总线的创建
 */
EventBus eventBus = new EventBus();