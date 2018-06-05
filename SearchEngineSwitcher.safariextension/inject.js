safari.self.addEventListener("message", switchSearchEngine, false);

function switchSearchEngine (Event) {
    if (Event.name == "switchSearchEngine") {
        var keyword = ""
        var hostname = location.hostname
    
        if (hostname.indexOf("baidu") < 0){
            keyword = document.getElementsByName("q")[0].value
            location.href = "http://www.baidu.com/s?wd=" + keyword
        } else if (hostname.indexOf("google") < 0){
            keyword = document.getElementsByName("wd")[0].value
            location.href = "https://www.google.com/?&q=#q=" + keyword
        }
    }
}