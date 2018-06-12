//
//  ViewController.swift
//  Search Engine Switcher
//
//  Created by Ray on 2018/6/12.
//  Copyright © 2018 Ray. All rights reserved.
//

import Cocoa
import SafariServices

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }

    @IBAction func openSafariPreference(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.rayps.Search-Engine-Switcher.Search-Engine-Switcher-Extension")
    }

}

