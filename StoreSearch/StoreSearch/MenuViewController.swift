//
//  MenuViewController.swift
//  StoreSearch
//
//  Created by Nick "Fox" Borer on 03/04/2023.
//

import UIKit

//Code for the "orphaned" item on the Storyboard.  Has three rows, top being E=Mail Support
class MenuViewController: UITableViewController
{
   weak var delegate: MenuViewControllerDelegate?
   
   //MARK: - Table View Delegates
   
   override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath)
   {
      tableView.deselectRow(at: indexPath, animated: true)
      
      if indexPath.row == 0
      {
	 delegate?.menuViewControllerSendEmail(self)
      }
   }
   
}

protocol MenuViewControllerDelegate: AnyObject
{
   func menuViewControllerSendEmail(_ controller: MenuViewController)
   
}
