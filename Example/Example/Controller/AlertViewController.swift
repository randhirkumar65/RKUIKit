//
//  AlertViewController.swift
//  Example
//
//  Created by Randhir Kumar on 07/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import RKUIKit

class AlertViewController: UIViewController, AlertPresenting {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ShowAlertAction(_ sender: UIButton) {
        showAlert(title: "Alert Title", message: "Sample Alert", completion: nil)
    }
    
    @IBAction func ShowChoiceAlertAction(_ sender: UIButton) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "delete", style: .destructive, handler: nil)
        showChoiceAlert(title: "Choice Alert Title", message: "Sample Alert", alertActions: [deleteAction, okAction], completion: nil)
    }
    
    @IBAction func ShowChoiceAlertSheet(_ sender: UIButton) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "delete", style: .destructive, handler: nil)

        showChoiceActionSheet(title: "Choice Alert Title", message: "Sample Alert", alertActions:  [deleteAction, okAction], completion: nil, barButtonItem: nil, sourceView: sender)
    }
}
