//
//  TypeTableViewController.swift
//  FinalMiniProject(@WhatApp)
//
//  Created by Keith Wong on 7/30/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import UIKit

class TypeViewController: UITableViewController
{
    var type = ["Coffee Shop","Bar","Restaurant"]
    var selectedIndex: Int?
    var selectedType: String?
    {
        didSet
        {
            if let selectedType = selectedType,
                let index = type.index(of: selectedType)
            {
                selectedIndex = index
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    //Mark: TableView setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return type.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        cell.textLabel?.text = type[indexPath.row]
        if indexPath.row == selectedIndex
        {
            cell.accessoryType = .checkmark
        } else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let index = selectedIndex
        {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        selectedType = type[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "SaveType",
        let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) else
        {
            return
        }
        let index = indexPath.row
        selectedType = type[index]
    }
}
