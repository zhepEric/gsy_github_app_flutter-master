/**
 * Created by guoshuyu
 * Date: 2018-08-16
 *
 * EventBus事件源，跟JAVA中实体类类似
 */

class HttpErrorEvent {
  final int code;

  final String message;

  HttpErrorEvent(this.code, this.message);
}
