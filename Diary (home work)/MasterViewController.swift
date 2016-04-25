//
//  ViewController.swift
//  Diary (home work)
//
//  Created by Admin on 21.04.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, SettingsDelegate {



var notes: [DiaryNote] = [DiaryNote]()
var dateSettings: DateSettings = DateSettings.ShortStyle
var managedObjectContext: NSManagedObjectContext? = nil

//MARK: - View Controller Lifecycle

override func viewDidLoad() {
    super.viewDidLoad()
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    let settings = NSUserDefaults.standardUserDefaults().integerForKey("dateSettings")
    self.dateSettings = DateSettings(rawValue: settings)!
    
    self.setUpDiaryNotes()
}

//MARK: Table View

override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
}

override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.notes.count
}

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let diaryCell = tableView.dequeueReusableCellWithIdentifier("diaryNoteCell") as! DiaryNoteCell
    let diaryNote = self.notes[indexPath.row]
    var dateString: String = ""
    
    switch self.dateSettings {
    case .ShortStyle :
        dateString = diaryNote.shortDateFormat()
    case .LongStyle:
        dateString = diaryNote.longDateFormat()
 
    }
    
    diaryCell.titleLabel?.text = diaryNote.title
    diaryCell.timeLabel?.text = dateString
    
    let weatherState = diaryNote.weatherState!.integerValue
    
    switch weatherState {
    case 0:
        diaryCell.weatherImageView?.image = UIImage(named: "SunnyIcon")
    case 1:
        diaryCell.weatherImageView?.image = UIImage(named: "RainIcon")
    case 2:
        diaryCell.weatherImageView?.image = UIImage(named: "CloudyIcon")
    default:()
    }
    return diaryCell
    }



//MARK: - Segue

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        let detailController = segue.destinationViewController as! DetailViewController
        detailController.masterViewController = self
        detailController.managedObjectContext = self.managedObjectContext
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            detailController.currentNote = self.notes[indexPath.row]
        }
    }
}

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            notes.removeAtIndex(indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    
    
//MARK: - Actions



    @IBAction func plusButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("showDetail", sender: self)

    }

    
    
    
    @IBAction func settingButtonKliked(sender: AnyObject) {

    
    
    
    
    let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("settingsNavController") as! UINavigationController
    let settingsController = navigationController.topViewController as! SettingsViewController
    settingsController.settingsDelegate = self
    settingsController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
    settingsController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
    
    presentViewController(navigationController, animated: true, completion: nil)
}

//MARK: - Settings Delegate

func didChooseDateSettings(dateSettings: DateSettings?) {
    if let settings = dateSettings {
        self.dateSettings = settings
    }
    self.tableView.reloadData()
}

//MARK: - Fetching objects

    func setUpDiaryNotes() {
        let managedObjectContext = self.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DiaryNote")
        
        do {
            let fetchedNotes = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [DiaryNote]
            self.notes = fetchedNotes
        } catch {
            fatalError("Fetch request error: \(error)")
        }
        
        notes.sortInPlace({(note1: DiaryNote, note2: DiaryNote) -> Bool
            in return ((note1.valueForKey("creationDate") as! NSDate).compare(note2.valueForKey("creationDate") as! NSDate) == NSComparisonResult.OrderedDescending)})
        
        self.tableView.reloadData()
        
        print("Number of objects = \(self.notes.count)")
        print("Weather settings = \(self.dateSettings)")
    }
}

