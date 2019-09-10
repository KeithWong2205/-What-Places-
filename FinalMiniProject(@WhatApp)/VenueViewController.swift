//
//  ViewController.swift
//  FinalMiniProject(@WhatApp)
//
//  Created by Keith Wong on 7/26/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import UIKit
import os.log


// Class declaration
class VenueViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate



{
    //Mark1: Declarations of OUTLETS and ACTIONS from storyboard
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var VenueTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var costrate: UITextField!
    @IBOutlet weak var servrate: UITextField!
    @IBOutlet weak var foodrate: UITextField!
    @IBOutlet weak var Rating: RatingTool!
    @IBOutlet weak var typelabel: UILabel!
    var types: String? = "Coffee Shop"
    {
        didSet
        {
            typelabel.text = types
        }
    }
    var Venues: Venue?
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        let isPresentingInAddVensMode = presentingViewController is UINavigationController
        if isPresentingInAddVensMode
        {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController
        {
            owningNavigationController.popViewController(animated: true)
        } else
        {
            fatalError("The VenViewController is not in navigation")
        }
        
    }
    
    
    
    //View load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        IdTextField.delegate = self
        VenueTextField.delegate = self
        foodrate.delegate = self
        servrate.delegate = self
        costrate.delegate = self
        if let Vens = Venues
        {
            navigationItem.title = Vens.venue
            IdTextField.text = Vens.userid
            VenueTextField.text = Vens.venue
            photoImageView.image = Vens.photo
            Rating.rating = Vens.rate
            typelabel.text = Vens.type
            foodrate.text = Vens.food
            servrate.text = Vens.serv
            costrate.text = Vens.cost
        }
        updateButtonState()
    }
    
    
    
    //Resign textfield when user type on screen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    //IMGPicker for IMGView, take any image from photolibrary
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer)
    {
        IdTextField.resignFirstResponder()
        VenueTextField.resignFirstResponder()
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let selectedIMG = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else
        {
            fatalError("Expected, a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedIMG
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Mark: Get Segue from Type Selector
    @IBAction func unwindwithType(segue: UIStoryboardSegue)
    {
        if let TypeViewController = segue.source as? TypeViewController
        {
            let selectedType = TypeViewController.selectedType
            types = selectedType
        }
    }
    
    
    
    //Mark: Segue Send Back Venue Info to List
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === SaveButton else
        {
            os_log("The button wasn't pressed", log: OSLog.default, type: .debug)
            return
        }
        let users = IdTextField.text ?? ""
        let venues = VenueTextField.text ?? ""
        let type = types
        let photos = photoImageView.image
        let rating = Rating.rating
        let foods = foodrate.text ?? ""
        let servs = servrate.text ?? ""
        let costs = costrate.text ?? ""
        Venues = Venue(userid: users, venue: venues, type: types ?? "Coffee Shop", photo: photos, rate: rating, food: foods, serv: servs, cost: costs)
    }
    
    
    
    //Mark: Delegates
    func  textFieldDidBeginEditing(_ textField: UITextField)
    {
        SaveButton.isEnabled = false
    }
    private func updateButtonState()
    {
        let textA = IdTextField.text ?? ""
        let textB = VenueTextField.text ?? ""
        SaveButton.isEnabled = (!textA.isEmpty && !textB.isEmpty)
    
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonState()
        navigationItem.title = VenueTextField.text
    }
}
