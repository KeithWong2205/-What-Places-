//
//  SampleTableViewController.swift
//  FinalMiniProject(@WhatApp)
//
//  Created by Keith Wong on 7/31/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import UIKit
import os.log


class VenueTableViewController: UITableViewController, UISearchBarDelegate
{
    @IBOutlet weak var searchBar: UISearchBar!
    var venues = [Venue]()
    var updated = [Venue]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let SaveVenues = LoadVenue()
        {
            updated += SaveVenues
        } else
        {
            loadSamples()
        }
        tableView.reloadData()
        setupSearchBar()
    }
    
    //Mark: Private function, loadind sample venues
    private func loadSamples()
    {
        let sample1 = UIImage(named: "Sample1")
        let sample2 = UIImage(named: "Sample2")
        let sample3 = UIImage(named: "Sample3")
        guard let venue1 = Venue(userid: "Kiet01", venue: "Coffee House", type: "Coffee Shop", photo: sample1, rate: 3, food: "Buns", serv: "Good", cost: "Cheap") else
        {
            fatalError("Unable to initialize")
        }
        guard let venue2 = Venue(userid: "Kiet01", venue: "Highland", type: "Coffee Shop", photo: sample2, rate: 5, food: "Bread", serv: "Good", cost: "cheap") else
        {
            fatalError("Unable to initialize")
        }
        guard let venue3 = Venue(userid: "Kiet01", venue: "Marukame Udon", type: "Restaurant", photo: sample3, rate: 5, food: "Udon", serv: "Excellent", cost: "Fair") else
        {
            fatalError("Unable to initialize")
        }
        venues += [venue1,venue2,venue3]
        updated = venues
    }
    private func setupSearchBar()
    {
        searchBar.delegate = self
    }
    
    private func SaveVenues()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(updated, toFile: Venue.ArchiveURL.path)
        if isSuccessfulSave
        {
            os_log("Save Successful", log: OSLog.default, type: .debug)
        } else
        {
            os_log("Save Failed", log: OSLog.default, type: .error)
        }
    }
    
    private func LoadVenue() -> [Venue]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Venue.ArchiveURL.path) as? [Venue]
    }
    
    
    //Mark: TableView Setup
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return updated.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "VenueTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VenueTableViewCell else
        {
            fatalError("Invalid dequeued cell")
        }
        let venue = updated[indexPath.row]
        
        cell.nameLabel.text = venue.venue
        cell.photoImage.image = venue.photo
        cell.rating.rating = venue.rate
        return cell
    }
    
    //Mark: Segue
    @IBAction func unwindtoList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? VenueViewController,
        let vens = sourceViewController.Venues
        {
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                updated[selectedIndexPath.row] = vens
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else
            {
                let newIndexPath = IndexPath(row: updated.count, section: 0)
                updated.append(vens)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            SaveVenues()
        }
    }
    //Mark: SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        guard !searchText.isEmpty else
        {
            updated = venues
            tableView.reloadData()
            return
        }
        updated = venues.filter({ venue -> Bool in
            venue.venue.contains(searchText)
        })
        tableView.reloadData()
    }
    //Mark: Edit Venue Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddVenue":
            os_log("Adding new venues", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let VenueDetailViewController = segue.destination as? VenueViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedVenueCell = sender as? VenueTableViewCell else
            {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedVenueCell) else
            {
                fatalError("Selected cell is not displayed")
            }
            let selectedVenue = updated[indexPath.row]
            VenueDetailViewController.Venues = selectedVenue
        default:
            fatalError("Unexpected Segue Identifier: \(segue.identifier)")
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            updated.remove(at: indexPath.row)
            SaveVenues()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
    


