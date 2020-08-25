//
//  ViewController.swift
//  onPoint
//
//  Created by Jason Scott on 8/23/20.
//  Copyright © 2020 JTSApps. All rights reserved.
//

import UIKit

class mainVC: UIViewController {
 
    @IBOutlet weak var positiontableView: UITableView!
    @IBOutlet weak var employeeList: UITableView!
    
    var positions = ["Server", "Busser", "Runner", "Misc.", "Bartender", "Barback"]
    var employees = ["John", "Jacob", "Henry", "Adam", "Eve", "Jane Doe", "John Doe", "Thelma", "Louise", "Alvin", "Simon", "Theodore", "Hooey", "Dooey", "Louie", "Walter", "Jesse"]
    var currentEmployee = ShiftEmployee()
    var shiftEmployees = [ShiftEmployee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeList.dataSource = self
        employeeList.delegate = self
        positiontableView.delegate = self
        positiontableView.dataSource = self
        //make custom tableview to reduce code
        positiontableView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        positiontableView.layer.borderWidth = 2
        employeeList.layer.borderWidth = 2
        employeeList.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    
    @IBAction func addEmpButPressed(_ sender: UIButton) {
        employeeList.isHidden = false
    }
    
}

extension mainVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
        return employees.count
        }
        else{
            return positions.count
        }
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1{
            let cell = employeeList.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        employees.sort()
        cell.textLabel?.text = employees[indexPath.row]
            return cell
        }
        else {
            let cell = positiontableView.dequeueReusableCell(withIdentifier: "PositionCell", for: indexPath)
            cell.textLabel?.text = positions[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            currentEmployee.name = String(employees[indexPath.row])
            positiontableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
            employeeList.isHidden = true
            positiontableView.isHidden = false
        }
        else if tableView.tag == 0 {
            currentEmployee.position = String(positions[indexPath.row])
            let employee = currentEmployee
            //need to check for duplicates
            shiftEmployees.append(employee)
            print("\(shiftEmployees[shiftEmployees.count - 1].name) is a \(shiftEmployees[shiftEmployees.count - 1].position)")
            positiontableView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == 0 {
            return NSLocalizedString(currentEmployee.name, comment: "choose title")
            } else {
                return ""
                }
        }
}
