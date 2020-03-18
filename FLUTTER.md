一、Stream
1、在Dart库中，有两种实现异步编程的方式（Future和Stream），使用它们只需要在代码中引入dart:async即可。
为了控制Stream，我们通常可以使用StreamController来进行管理；
为了向Stream中插入数据，StreamController提供了类型为StreamSink的属性sink作为入口；
StreamController提供stream属性作为数据的出口。

2、Stream可以传输什么？
任何东西都可以！包括简单的值，事件，对象，集合，map，error或者其他的Stream，任何类型的数据都可以使用Stream来传输。


二、Bloc设计模式
BLoC 是独立处理业务逻辑，网络数据请求等等逻辑的一个模块，通过流的 Sinks, Streams 发布监听业务处理后的数据结果，其只关心业务处理。
每个bloc负责页面数据处理、事件处理
一个页面可能有多个bloc