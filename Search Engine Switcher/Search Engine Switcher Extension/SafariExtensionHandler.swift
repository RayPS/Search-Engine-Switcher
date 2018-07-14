//
//  SafariExtensionHandler.swift
//  Search Engine Switcher Extension
//
//  Created by Ray on 2018/6/12.
//  Copyright © 2018 Ray. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
//        page.getPropertiesWithCompletionHandler { props in
//        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
//        NSLog("The extension's toolbar item was clicked")
        window.getActivePage{ (tab, page, props) in
            let url = props?.url
            let isGoogle = url?.host?.range(of: "google") != nil

            let queryKey = isGoogle ? "q" : "wd"
            let keyword = (url?.queryParameters?[queryKey] ?? "").urlParameterEncode()

            let switchedUrlString = isGoogle ? "https://baidu.com/s?wd=\(keyword)" : "https://google.com/search?q=\(keyword)"
            page?.dispatchMessageToScript(withName: "switch", userInfo: ["switchedUrlString": switchedUrlString])
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        window.getActivePage{ (tab, page, props) in
            let url = props?.url
            let isGoogle = url?.host?.range(of: "google") != nil
            let isBaidu = url?.host?.range(of: "baidu") != nil

            if (isGoogle || isBaidu) {
                let icon = isGoogle ? "toolbar-icon-baidu.pdf" : "toolbar-icon-google.pdf"
                window.setToolbarItemImage(resourceName: icon)
                validationHandler(true, "")
            } else {
                window.setToolbarItemImage(resourceName: "toolbar-icon.pdf")
                validationHandler(false, "")
            }
        }


    }

}

extension SFSafariWindow {

    func getActivePage(_ completion: @escaping ((SFSafariTab?, SFSafariPage?, SFSafariPageProperties?) -> Void)) {
        self.getActiveTab { tab in
            tab?.getActivePage(completionHandler: { page in
                page?.getPropertiesWithCompletionHandler({ props in
                    completion(tab, page, props)
                })
            })
        }
    }

    func setToolbarItemImage(resourceName: String) {
        self.getToolbarItem { (item) in
            item?.setImage(NSImage(imageLiteralResourceName: resourceName))
        }
    }
}


extension URL {

    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }

        return parameters
    }
}


extension String {
    func urlParameterEncode() -> String {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: ".-_")
        return self.addingPercentEncoding(withAllowedCharacters: allowed)!
    }
}
