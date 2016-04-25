//
//  DetailViewController.swift
//  Diary (home work)
//
//  Created by Admin on 21.04.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//
import UIKit
import CoreData

enum Weather: Int {
    case Sun = 0
    case Rain
    case Cloud
}

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    
    var masterViewController: MasterViewController!
    var currentNote: DiaryNote?
    var managedObjectContext: NSManagedObjectContext? = nil
    
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField?.delegate = self
        self.textView?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "New Note"
        
        if let currentNote: DiaryNote = self.currentNote {
            self.navigationItem.title = currentNote.titleDateFormat()
            self.textField.text = currentNote.title
            self.textView.text = currentNote.text
            self.segmentedControll.selectedSegmentIndex = (currentNote.weatherState?.integerValue)!
            self.setBackgroundImageAndText(self.segmentedControll.selectedSegmentIndex)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //Create new note only if we have title
        if self.textField.hasText() {
            self.saveDiaryNote()
        }
    }
    
    //MARK: - Save objects
    
    func saveDiaryNote() {
        if self.currentNote == nil {
            self.currentNote = NSEntityDescription.insertNewObjectForEntityForName("DiaryNote", inManagedObjectContext: self.managedObjectContext!) as? DiaryNote
            self.currentNote?.setValue(NSDate(), forKey: "creationDate")
        }
        
        if let note = self.currentNote {
            note.setValue(self.textField.text, forKey: "title")
            note.setValue(self.textView.text, forKey: "text")
            note.setValue(NSNumber(integer: self.segmentedControll.selectedSegmentIndex), forKey: "weatherState")
            
            do {
                try self.managedObjectContext!.save()
            } catch {
                fatalError("Unable to save context with error: \(error)")
            }
        }
    }
    
    //MARK: - Configure View
    
    func setBackgroundImageAndText(index: Int) {
        if index == 0 {
            self.textField.textColor = UIColor.blueColor()
            self.textView.textColor = UIColor.blueColor()
            self.segmentedControll.tintColor = UIColor.blueColor()
            self.separatorView.backgroundColor = UIColor.blueColor()
            self.backgroundImageView.image = UIImage(named: "bg-sunny")
        }else if index == 1 {
            self.textField.textColor = UIColor.blackColor()
            self.textView.textColor = UIColor.blackColor()
            self.segmentedControll.tintColor = UIColor.blackColor()
            self.separatorView.backgroundColor = UIColor.blackColor()
            self.backgroundImageView.image = UIImage(named: "bg-rainy")
        }else if index == 2 {
            self.textField.textColor = UIColor.whiteColor()
            self.textView.textColor = UIColor.whiteColor()
            self.segmentedControll.tintColor = UIColor.whiteColor()
            self.separatorView.backgroundColor = UIColor.whiteColor()
            self.backgroundImageView.image = UIImage(named: "bg-cloudy")
        }
    }
    
    //MARK: - Actions
    
    @IBAction func segmentControllChangedValue(sender: AnyObject) {
        self.setBackgroundImageAndText(self.segmentedControll.selectedSegmentIndex)
    }
    
    //MARK: - Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let inputTextView = self.textView {
            inputTextView.becomeFirstResponder()
        }
        
        return true
    }
    
    //MARK: - Text View Delegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            if let inputTextView = self.textView {
                inputTextView.resignFirstResponder()
            }
        }
        
        return true
    }
    
    
}
