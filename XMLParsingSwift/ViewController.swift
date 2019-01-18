//
//  ViewController.swift
//  XMLParsingSwift
//
//  Created by MACOS on 6/17/17.
//  Copyright © 2017 MACOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tbl: UITableView!
    
    
    var strcntent = "";
    
    var arr = Array<Array<String>>()
    
    var brr  = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tbl.rowHeight=UITableViewAutomaticDimension;
        //tbl.estimatedRowHeight = 300;
        
        let url = URL(string:"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20cricket.news%20%20where%20region%3D%22in%22&diagnostics=true&env=store%3A%2F%2F0TxIGQMQbObzvU4Apia0V0");
        
        do
        {
            let dt = try Data(contentsOf: url!);
            
            let xml = XMLParser(data: dt);
            xml.delegate = self;
            
            xml.parse();
        }
        catch
        {
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //XML Parsing Methods
    func parserDidStartDocument(_ parser: XMLParser) {
        
        arr.removeAll();
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        
        if elementName == "item"
        {
            brr.removeAll();
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        strcntent = string;
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        
        if elementName == "author" || elementName == "link" || elementName == "pubDate" || elementName == "title" || elementName == "description" || elementName == "thumburl"
        {
            brr.append(strcntent);
        }
        else if elementName == "item"
        {
            arr.append(brr);
            
            brr.removeAll();
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        print(arr);
    }

    //TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        
        var temp = Array<String>();
        temp  = arr[indexPath.section]
        
        cell.textLabel?.text =  temp[indexPath.row];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "News";
    }
}

