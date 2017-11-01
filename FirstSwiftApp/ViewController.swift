//
//  ViewController.swift
//  FirstSwiftApp
//
//  Created by Joshua Crotts on 10/31/17.
//  Copyright © 2017 FirstSwiftApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel! //Title Label
    
    var calculations = Queue()//Queue for the instructions/numbers/operations
    var number = "" //Number String pressed
    
    //Numeric Buttons Function
    @IBAction func touchButton(sender: UIButton){
        
        number = sender.currentTitle! //Gets the number that was just pressed
        self.outputLabel.text! += number //Adds the number as a sequence of digits until an operation is performed
        self.calculations.printQueue()
        number = self.outputLabel.text!
    }
    
    @IBAction func performOperation(sender: UIButton){
        self.outputLabel.text! = "" //Clears text
        self.calculations.enqueue(element: number) //Enqueues the number
        self.calculations.printQueue()
        var op = "" //Operation of calculation (+, -, *, /)
        
        //When the Queue's size is 3 or more, we need to remove the first number,
        //the operation, and the second number.
        if(self.calculations.size() >= 3 || sender.currentTitle! == "="){
            let num1 = Double(self.calculations.dequeue()!) //First number
            op = self.calculations.dequeue()! //Operation
            let num2 = Double(self.calculations.dequeue()!) //Second number
            var result = 0.0 //num1 (op) num2
            
            //Finds the correct operation to utilize, not very flexible
            //op is a string
            switch(op){
            case "+":
                result = num1! + num2!
            case "-":
                result = num1! - num2!
            case "*":
                result = num1! * num2!
            case "/":
                if(num2! == 0){
                    self.outputLabel.text = "DIV/0"
                    return
                }else{
                    result = num1! / num2!
                }
            default:
                result = 0
                
            }

            self.outputLabel.text = String(result)
            number = String(result) //We don't enqueue the result because the result is enqueued as soon as a new operation is performed in the first part of this method
            
        }
        
        //If the current operation is NOT an equals, we enqueue it
        if(sender.currentTitle! != "="){
            self.calculations.enqueue(element: sender.currentTitle!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Queue struct
    /*A Stack doesn't work because it works on a LIFO policy; if our stack was
     *{10, -, 3}, the result is -7 because 3 is removed first. We need FIFO
     */
    struct Queue{
        fileprivate var array: [String] = []
        
        mutating func enqueue(element: String){
            array.append(element)
        }
        
        mutating func dequeue() -> String?{
            return array.remove(at: 0)
        }
        
        nonmutating func size() -> Int{
            return array.count
        }
        
        nonmutating func printQueue(){
            for item in array {
                print(item)
            }
        }
    }


}

