//
//  Venue.swift
//  FinalMiniProject(@WhatApp)
//
//  Created by Keith Wong on 7/30/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import UIKit
import os.log

class Venue: NSObject, NSCoding
    
{
    //Mark: Declaration of element of an instance
    var userid: String
    var venue: String
    var type: String
    var photo: UIImage?
    var rate: Int
    var food: String
    var serv: String
    var cost: String
    
    
    //Generate Datapath
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("venues")
    
    //NSCodind PropertyKey
    struct PropertyKey {
        static let vuser = "user"
        static let vname = "name"
        static let vphoto = "photo"
        static let vrate = "rating"
        static let vtype = "type"
        static let vfood = "food"
        static let vserv = "serv"
        static let vcost = "cost"
    }
    
    
    //Global Initialization
    init?(userid:String, venue:String, type: String, photo: UIImage?, rate: Int, food: String, serv: String, cost: String)
    {
        if (venue.isEmpty && userid.isEmpty) || rate < 0
        {
            return nil
        }
        self.userid = userid
        self.venue = venue
        self.type = type
        self.photo = photo
        self.rate = rate
        self.food = food
        self.serv = serv
        self.cost = cost
    }
    
    
    //NSCoding to Encode and Decode Key for Venue Save
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(userid, forKey: PropertyKey.vuser)
        aCoder.encode(venue, forKey: PropertyKey.vname)
        aCoder.encode(photo, forKey: PropertyKey.vphoto)
        aCoder.encode(rate, forKey: PropertyKey.vrate)
        aCoder.encode(type, forKey: PropertyKey.vtype)
        aCoder.encode(serv, forKey: PropertyKey.vserv)
        aCoder.encode(food, forKey: PropertyKey.vfood)
        aCoder.encode(cost, forKey: PropertyKey.vcost)
    }
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let vusers = aDecoder.decodeObject(forKey: PropertyKey.vuser) as? String else
        {
            os_log("Unable to decode userid", log: OSLog.default, type: .debug)
            return nil
        }
        guard let vnames = aDecoder.decodeObject(forKey: PropertyKey.vname) as? String else
        {
            os_log("Unable to decode the name for a Venue object.", log: OSLog.default, type: .debug)
            return nil
        }
        let vtypes = aDecoder.decodeObject(forKey: PropertyKey.vtype) as! String
        let vphotos = aDecoder.decodeObject(forKey: PropertyKey.vphoto) as? UIImage
        let vrates = aDecoder.decodeInteger(forKey: PropertyKey.vrate)
        let vservs = aDecoder.decodeObject(forKey: PropertyKey.vserv) as! String
        let vfoods = aDecoder.decodeObject(forKey: PropertyKey.vfood) as! String
        let vcosts = aDecoder.decodeObject(forKey: PropertyKey.vcost) as! String
        self.init(userid: vusers, venue: vnames, type: vtypes, photo: vphotos, rate: vrates, food: vfoods, serv: vservs, cost: vcosts)
    }
}
