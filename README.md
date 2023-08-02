# BEP upload symlink warning reproducing case

For https://github.com/bazelbuild/bazel/issues/19151

1. Edit `.bazelrc` to point to valid `--bes_results_url`, `--bes_backend`, and `--remote_cache`.

   Note: this issue has been reproduced with a grpcs bes_backend and remote_cache.

2. `bazel clean && build :symlink`


Observed warnings with bazel 6.3.1:
```
 $ bazel build :symlink
INFO: Invocation ID: 66fa5172-4532-4822-b631-6f07848013ba
INFO: Starting clean (this may take a while). Consider using --async if the clean takes more than several minutes.
INFO: Invocation ID: 1651ee1b-8f2c-4c8b-a4fb-df80859cf9cb
INFO: Streaming build results to: <url>
INFO: Analyzed target //:symlink (4 packages loaded, 6 targets configured).
INFO: Found 1 target...
WARNING: Uploading BEP referenced local file /home/kteske/.cache/bazel/_bazel_kteske/020f4231a790243f1ddaeb9889e833df/execroot/__main__/bazel-out/k8-fastbuild/bin/the_symlink: /home/kteske/.cache/bazel/_bazel_kteske/020f4231a790243f1ddaeb9889e833df/execroot/__main__/bazel-out/k8-fastbuild/bin/the_symlink (No such file or directory)
java.io.FileNotFoundException: /home/kteske/.cache/bazel/_bazel_kteske/020f4231a790243f1ddaeb9889e833df/execroot/__main__/bazel-out/k8-fastbuild/bin/the_symlink (No such file or directory)
        at com.google.devtools.build.lib.unix.NativePosixFiles.stat(Native Method)
        at com.google.devtools.build.lib.unix.UnixFileSystem.statInternal(UnixFileSystem.java:210)
        at com.google.devtools.build.lib.unix.UnixFileSystem.stat(UnixFileSystem.java:200)
        at com.google.devtools.build.lib.unix.UnixFileSystem.getFileSize(UnixFileSystem.java:391)
        at com.google.devtools.build.lib.vfs.Path.getFileSize(Path.java:559)
        at com.google.devtools.build.lib.remote.util.DigestUtil.compute(DigestUtil.java:61)
        at com.google.devtools.build.lib.remote.ByteStreamBuildEventArtifactUploader.readPathMetadata(ByteStreamBuildEventArtifactUploader.java:194)
        at com.google.devtools.build.lib.remote.ByteStreamBuildEventArtifactUploader.lambda$upload$7(ByteStreamBuildEventArtifactUploader.java:336)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableMap$MapSubscriber.onNext(FlowableMap.java:64)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable$IteratorSubscription.fastPath(FlowableFromIterable.java:185)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable$BaseRangeSubscription.request(FlowableFromIterable.java:129)
        at io.reactivex.rxjava3.internal.subscribers.BasicFuseableSubscriber.request(BasicFuseableSubscriber.java:153)
        at io.reactivex.rxjava3.internal.jdk8.FlowableCollectWithCollectorSingle$CollectorSingleObserver.onSubscribe(FlowableCollectWithCollectorSingle.java:102)
        at io.reactivex.rxjava3.internal.subscribers.BasicFuseableSubscriber.onSubscribe(BasicFuseableSubscriber.java:67)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable.subscribe(FlowableFromIterable.java:69)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable.subscribeActual(FlowableFromIterable.java:47)
        at io.reactivex.rxjava3.core.Flowable.subscribe(Flowable.java:15917)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableMap.subscribeActual(FlowableMap.java:38)
        at io.reactivex.rxjava3.core.Flowable.subscribe(Flowable.java:15917)
        at io.reactivex.rxjava3.internal.jdk8.FlowableCollectWithCollectorSingle.subscribeActual(FlowableCollectWithCollectorSingle.java:71)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleFlatMap.subscribeActual(SingleFlatMap.java:37)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleFlatMap.subscribeActual(SingleFlatMap.java:37)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleMap.subscribeActual(SingleMap.java:35)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleUsing.subscribeActual(SingleUsing.java:83)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleSubscribeOn$SubscribeOnObserver.run(SingleSubscribeOn.java:89)
        at io.reactivex.rxjava3.internal.schedulers.ScheduledDirectTask.call(ScheduledDirectTask.java:38)
        at io.reactivex.rxjava3.internal.schedulers.ScheduledDirectTask.call(ScheduledDirectTask.java:25)
        at java.base/java.util.concurrent.FutureTask.run(Unknown Source)
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
        at java.base/java.lang.Thread.run(Unknown Source)
WARNING: Uploading BEP referenced local file /home/kteske/.cache/bazel/_bazel_kteske/020f4231a790243f1ddaeb9889e833df/execroot/__main__/bazel-out/k8-fastbuild/bin/the_symlink: /home/kteske/.cache/bazel/_bazel_kteske/020f4231a790243f1ddaeb9889e833df/execroot/__main__/bazel-out/k8-fastbuild/bin/the_symlink (No such file or directory)
java.io.FileNotFoundException: /home/kteske/.cache/bazel/_bazel_kteske/020f4231a790243f1ddaeb9889e833df/execroot/__main__/bazel-out/k8-fastbuild/bin/the_symlink (No such file or directory)
        at com.google.devtools.build.lib.unix.NativePosixFiles.stat(Native Method)
        at com.google.devtools.build.lib.unix.UnixFileSystem.statInternal(UnixFileSystem.java:210)
        at com.google.devtools.build.lib.unix.UnixFileSystem.stat(UnixFileSystem.java:200)
        at com.google.devtools.build.lib.unix.UnixFileSystem.getFileSize(UnixFileSystem.java:391)
        at com.google.devtools.build.lib.vfs.Path.getFileSize(Path.java:559)
        at com.google.devtools.build.lib.remote.util.DigestUtil.compute(DigestUtil.java:61)
        at com.google.devtools.build.lib.remote.ByteStreamBuildEventArtifactUploader.readPathMetadata(ByteStreamBuildEventArtifactUploader.java:194)
        at com.google.devtools.build.lib.remote.ByteStreamBuildEventArtifactUploader.lambda$upload$7(ByteStreamBuildEventArtifactUploader.java:336)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableMap$MapSubscriber.onNext(FlowableMap.java:64)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable$IteratorSubscription.fastPath(FlowableFromIterable.java:185)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable$BaseRangeSubscription.request(FlowableFromIterable.java:129)
        at io.reactivex.rxjava3.internal.subscribers.BasicFuseableSubscriber.request(BasicFuseableSubscriber.java:153)
        at io.reactivex.rxjava3.internal.jdk8.FlowableCollectWithCollectorSingle$CollectorSingleObserver.onSubscribe(FlowableCollectWithCollectorSingle.java:102)
        at io.reactivex.rxjava3.internal.subscribers.BasicFuseableSubscriber.onSubscribe(BasicFuseableSubscriber.java:67)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable.subscribe(FlowableFromIterable.java:69)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableFromIterable.subscribeActual(FlowableFromIterable.java:47)
        at io.reactivex.rxjava3.core.Flowable.subscribe(Flowable.java:15917)
        at io.reactivex.rxjava3.internal.operators.flowable.FlowableMap.subscribeActual(FlowableMap.java:38)
        at io.reactivex.rxjava3.core.Flowable.subscribe(Flowable.java:15917)
        at io.reactivex.rxjava3.internal.jdk8.FlowableCollectWithCollectorSingle.subscribeActual(FlowableCollectWithCollectorSingle.java:71)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleFlatMap.subscribeActual(SingleFlatMap.java:37)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleFlatMap.subscribeActual(SingleFlatMap.java:37)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleMap.subscribeActual(SingleMap.java:35)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleUsing.subscribeActual(SingleUsing.java:83)
        at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
        at io.reactivex.rxjava3.internal.operators.single.SingleSubscribeOn$SubscribeOnObserver.run(SingleSubscribeOn.java:89)
        at io.reactivex.rxjava3.internal.schedulers.ScheduledDirectTask.call(ScheduledDirectTask.java:38)
        at io.reactivex.rxjava3.internal.schedulers.ScheduledDirectTask.call(ScheduledDirectTask.java:25)
        at java.base/java.util.concurrent.FutureTask.run(Unknown Source)
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
        at java.base/java.lang.Thread.run(Unknown Source)
Target //:symlink up-to-date:
  bazel-bin/the_symlink
INFO: Elapsed time: 0.372s, Critical Path: 0.00s
INFO: 2 processes: 2 internal.
INFO: Streaming build results to: <url>
INFO: Build completed successfully, 2 total actions

```
