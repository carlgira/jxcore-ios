# JXCore IOS

JXCore ios sample with no cordova.

**JXCoreIos:** Framework with jxcore native libs and objective c sources to initialize Jxcore. 

**JXCoreSample:** Simple ios app to test Jxcore fuctionality. 
- It has http server (implemented in Javascript) that can be started and stoped, with two buttons. 
- Shows the status of the sever in a TextView.
- More details of how Jxcore engine starts can bee seen in the logs.
- Defines some methods to comunication Java->Javascript and Javascript->Java.

#### Functions
- Register function that can be called from Javascript
```objc
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
         NSLog(@"Sever Started (Callback from JS!!)");
    } withName:@"serverStarted"];
```
- Call a registered function from Javascript. Using the JXCoreModule just use the function "callJavaFunction".
```javascript
     this.callJavaFunction("serverStarted");
```
- Register a Javascript function that can be called from ios. Adding registered functions to the method "registerJSFunction" into the jxcore_module.js
```javascript
    var startServerFunction = new JSFunction("JXCoreModule_startServer", function() {
            wsLocalServer.startServer();
            console.log("JXCoreModule_startServer method");
        } );
        
        return [startServerFunction];
```
- Call a registered Javascript function from objective-c.
```objc
    [JXcore callEventCallback:@"JXCoreModule_startServer" withJSON:@"{ }"];
```

#### Test
To test the project, install on your device the JXCoreSample. 

#### Installation in your own project
- Create a new objective-c Ios Project
- Include the framework JXCoreIos. (Project settings -> General -> Embedded binaries -> Add Other -> JXCoreIos)
- Configure Framework Search Paths with the location of the JXCoreIos. (Project Settings -> Build Settings -> Framework Search Paths -> $(PROJECT_DIR)/.. 
- Copy from the JXCoreSample the folder jxcore to your project. (The one with the files CDVJXcore.h and CDVJXcore.m). Add these files to the project using XCode.
- Copy also  from the JXCoreSample the folder www/jxcore with the file jxcore_modules.js. Add this file using Xcode and make sure that appers in the Project Settings -> Build Phases -> Copy bundle Resources
- Into your view controller add a property with the class CDVJXcore.
- Initialize that object and start the JXCore Engine.
```objc
    @property CDVJXcore* jxcore;
    ....
     _jxcore =  [[CDVJXcore alloc] init];
    [_jxcore pluginInitialize];
```
- Modify jxcore_module according your needs. That module must have two functions, the "init" and the "registerJSFunction".
- Use the CDVJXcore to register all the javascript functions and as interface to comunicate with the ios project.
- Put in www/jxcore folder all your jxcore (node js ) project.

See everything in the example.

**References**
[capsample]: https://github.com/jxcore/jxcore-ios-sample
 You can also see [https://github.com/jxcore/jxcore-ios-sample][capsample]


