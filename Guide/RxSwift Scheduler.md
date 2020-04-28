# RxSwift Schedulers 调度器 

### 1，基本介绍

（1）调度器（**Schedulers**）是 **RxSwift** 实现多线程的核心模块，它主要用于控制任务在哪个线程或队列运行。

（2）**RxSwift** 内置了如下几种 **Scheduler**：

- **CurrentThreadScheduler**：表示当前线程 **Scheduler**。（默认使用这个）
- **MainScheduler**：表示主线程。如果我们需要执行一些和 **UI** 相关的任务，就需要切换到该 **Scheduler** 运行。
- **SerialDispatchQueueScheduler**：封装了 **GCD** 的串行队列。如果我们需要执行一些串行任务，可以切换到这个 **Scheduler** 运行。
- **ConcurrentDispatchQueueScheduler**：封装了 **GCD** 的并行队列。如果我们需要执行一些并发任务，可以切换到这个 **Scheduler** 运行。
- **OperationQueueScheduler**：封装了 **NSOperationQueue**。




### 2，使用样例

这里以请求网络数据并显示为例。我们在后台发起网络请求，然后解析数据，最后在主线程刷新页面。

[![原文:Swift - RxSwift的使用详解20（调度器、subscribeOn、observeOn）](https://www.hangge.com/blog_uploads/201801/2018012217254954213.png)](https://www.hangge.com/blog/cache/detail_1940.html#)



过去我们使用 **GCD** 来实现，代码大概是这样的：

```swift
//现在后台获取数据
DispatchQueue.global(qos: .userInitiated).async {
    let data = try? Data(contentsOf: url)
    //再到主线程显示结果
    DispatchQueue.main.async {
        self.data = data
    }
}
```


如果使用 **RxSwift** 来实现，代码大概是这样的：

```swift
 let data = Observable.of(1,2,3,4,5).map { i in
            print(Thread.current)
            print(i)
        }
        data.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance).subscribe(onNext: { e in
                print(Thread.current)
                print(e)
            }).disposed(by: disposebag)

```

```swift
<NSThread: 0x6000014e5740>{number = 6, name = (null)}
1
<NSThread: 0x6000014e5740>{number = 6, name = (null)}
2
<NSThread: 0x6000014e5740>{number = 6, name = (null)}
3
<NSThread: 0x6000014e5740>{number = 6, name = (null)}
4
<NSThread: 0x6000014e5740>{number = 6, name = (null)}
5
<NSThread: 0x60000149ecc0>{number = 1, name = main}
()
<NSThread: 0x60000149ecc0>{number = 1, name = main}
()
<NSThread: 0x60000149ecc0>{number = 1, name = main}
()
<NSThread: 0x60000149ecc0>{number = 1, name = main}
()
<NSThread: 0x60000149ecc0>{number = 1, name = main}
()
```

若将subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated) 改为subscribeOn(MainScheduler.instance)

```swift
<NSThread: 0x60000320ec80>{number = 1, name = main}
1
<NSThread: 0x60000320ec80>{number = 1, name = main}
()
<NSThread: 0x60000320ec80>{number = 1, name = main}
2
<NSThread: 0x60000320ec80>{number = 1, name = main}
()
<NSThread: 0x60000320ec80>{number = 1, name = main}
3
<NSThread: 0x60000320ec80>{number = 1, name = main}
()
<NSThread: 0x60000320ec80>{number = 1, name = main}
4
<NSThread: 0x60000320ec80>{number = 1, name = main}
()
<NSThread: 0x60000320ec80>{number = 1, name = main}
5
<NSThread: 0x60000320ec80>{number = 1, name = main}
()
```



### 3，subscribeOn 与 observeOn 区别

（1）**subscribeOn()**

- 该方法决定数据序列的构建函数在哪个 **Scheduler** 上运行。
- 比如上面样例，由于获取数据、解析数据需要花费一段时间的时间，所以通过 **subscribeOn** 将其切换到后台 **Scheduler** 来执行。这样可以避免主线程被阻塞。

（2）**observeOn()**

- 该方法决定在哪个 **Scheduler** 上监听这个数据序列。
- 比如上面样例，我们获取并解析完毕数据后又通过 **observeOn** 方法切换到主线程来监听并且处理结果。

