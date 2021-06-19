//
//  EmployeesService.swift
//  MVVMExample
//
//  Created by John Codeos on 06/19/20.
//

import Foundation

protocol EmployeesServiceProtocol {
    func getEmployees(completion: @escaping (_ success: Bool, _ results: Employees?, _ error: String?) -> ())
}

class EmployeesService: EmployeesServiceProtocol {
    func getEmployees(completion: @escaping (Bool, Employees?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Employees.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
