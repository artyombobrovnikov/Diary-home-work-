//
//  SettingViewController.swift
//  Diary (home work)
//
//  Created by Admin on 21.04.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//


import UIKit

enum DateSettings: Int {
    case ShortStyle = 0
    case LongStyle
}

class SettingsViewController: UITableViewController {
    
    var currentDateSettings: DateSettings?
    var settingsDelegate: SettingsDelegate?
    var selectedIndexPath: NSIndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentDateSettings = DateSettings(rawValue: NSUserDefaults.standardUserDefaults().integerForKey("dateSettings"))
        self.selectedIndexPath = NSIndexPath(forRow: currentDateSettings!.rawValue, inSection: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let cell = tableView.cellForRowAtIndexPath(self.selectedIndexPath!)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date Format Settings"
        } else {
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingCell")
        indexPath.row == 0 ? (cell?.textLabel?.text = "Date Only") : (cell?.textLabel?.text = "Date And Time")
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.selectedIndexPath?.row != indexPath.row {
            let previousCheckedCell = tableView.cellForRowAtIndexPath(self.selectedIndexPath!)
            previousCheckedCell?.accessoryType = UITableViewCellAccessoryType.None
            
            let currentCheckedCell = tableView.cellForRowAtIndexPath(indexPath)
            currentCheckedCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            self.selectedIndexPath = indexPath
            self.currentDateSettings = DateSettings(rawValue: indexPath.row)
        }
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        if let settingsDelegate = self.settingsDelegate {
            settingsDelegate.didChooseDateSettings(self.currentDateSettings)
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(self.currentDateSettings!.rawValue, forKey: "dateSettings")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
