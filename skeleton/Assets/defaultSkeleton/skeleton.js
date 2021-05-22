
function setupWebViewJavascriptBridge(callback) {
    // console.log("注册bridge");
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}

function connectWebViewJavascriptBridge (callback) { 
    if (window.WebViewJavascriptBridge) {
          callback(WebViewJavascriptBridge)
    } else {
          document.addEventListener(
              'WebViewJavascriptBridgeReady'
               , function() {
                    callback(WebViewJavascriptBridge)
               },
               false
          );
    }
}

function isIOS(){
    var agent = navigator.userAgent.toLowerCase();
    var iphone = agent.indexOf("iphone");
    var ipad = agent.indexOf("ipad");
    if(iphone != -1 || ipad != -1){
        return true
    }
    return false;
}

function resigsterJSB(bridge){
    // bridge.registerHandler('JS Echo', function(data, responseCallback) {
    //     console.log("JS Echo called with:", data)
    //     responseCallback(data)
    // })

    //客户端已经注册好一个名为“ObjC Echo”的方法，H5直接进行调用（方法名也为“ObjC Echo”）就行，调用的时候可以传客户端需要的参数
    // bridge.callHandler('ObjC Echo', {'key':'value'}, function responseCallback(responseData) {
    //     console.log("JS received response:", responseData)
    // })
}

function sendMsg(action ,data, callback){
    console.log("调用sendMsg")
    window.WebViewJavascriptBridge.callHandler(action,data,function responseCallback(responseData){
        console.log(responseCallback)
        console.log(callback)
        if (callback) {callback(responseData)}
    })
}

window.onload = function(){
    console.log("onload")
    if (isIOS()){
        setupWebViewJavascriptBridge(resigsterJSB)
    }
    else{
        connectWebViewJavascriptBridge(resigsterJSB)
    }
}

window.globle = {}
window.globle.sendMsg = sendMsg
 

