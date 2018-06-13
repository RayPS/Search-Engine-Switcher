document.addEventListener('DOMContentLoaded', function(event) {
    // safari.extension.dispatchMessage("DOMContentLoaded");
    safari.self.addEventListener('message', messageHandler, false);

    function messageHandler (event) {
        if (event.name == 'switch') {
            location.href = event.message.switchedUrlString;
        }
    }

});
