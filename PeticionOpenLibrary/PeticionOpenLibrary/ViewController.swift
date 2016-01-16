//
//  ViewController.swift
//  PeticionOpenLibrary
//
//  Created by Andres Sanchez Delgado on 14/01/16.
//  Copyright © 2016 Israel Durán Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var textViewInformacion: UITextView!
    
    @IBAction func actionISBN(sender: AnyObject)
    {
        self.resignFirstResponder()
        textViewInformacion.text = sincrono(txtISBN.text!)
    }
    
    func sincrono(ISBN : String) -> String
    {
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + ISBN;
        let url = NSURL(string: urls)
        let datos : NSData? = NSData(contentsOfURL: url!)
        let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        return texto as! String
    }
    
    func asincrono(ISBN: String)->String
    {
        //let ISBN = "978-84-376-0494-7"
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + ISBN
        let url = NSURL(string: urls)
        let sesion = NSURLSession.sharedSession()
        var texto : NSString = ""
        let bloque = {
            (datos: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
            texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)!
        }
        
        let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
        print("antes o despues")
        
        return texto as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //print(asincrono("978-84-376-0494-7"))
        //textViewInfo.text = "Hola"
        print(sincrono("978-84-376-0494-7"))
        //textViewInfo.text = sincrono("978-84-376-0494-7")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

