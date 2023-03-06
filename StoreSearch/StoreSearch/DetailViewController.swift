//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Nick "Fox" Borer on 02/28/2023.
//

import Foundation
import UIKit
import MessageUI


class DetailViewController: UIViewController
{
   @IBOutlet weak var popupView: UIView!
   @IBOutlet weak var artworkImageView: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var artistNameLabel: UILabel!
   @IBOutlet weak var kindLabel: UILabel!
   @IBOutlet weak var genreLabel: UILabel!
   @IBOutlet weak var priceButton: UIButton!
   
   @IBAction func openInStore()
   {
      if let url = URL(string: searchResult.storeURL)
      {
	 UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
   }
   

   var searchResult: SearchResult!
   {
      didSet
      {
	if isViewLoaded == true
	 {
	   updateUI()
	}
      }
   }
   
   var downloadTask: URLSessionDownloadTask?
   
   var isPopUp = false
   
   
   required init?(coder aDecoder: NSCoder)
   {
      super.init(coder: aDecoder)
      transitioningDelegate = self
   }
   
   deinit
   {
      print("deinit \(self)")
      downloadTask?.cancel()
   }

   
   
    override func viewDidLoad()
   {
      super.viewDidLoad()
      
      if isPopUp == true
      {
	 popupView.layer.cornerRadius = 10
	 
	 let gestureRecognizer = UITapGestureRecognizer(
	    target: self,
	    action: #selector(close))
	 gestureRecognizer.cancelsTouchesInView = false
	 gestureRecognizer.delegate = self
	 view.addGestureRecognizer(gestureRecognizer)
	 
	    //Gradient View
	 view.backgroundColor = UIColor.clear
	 let dimmingView = GradientView(frame: CGRect.zero)
	 dimmingView.frame = view.bounds
	 view.insertSubview(dimmingView, at: 0)
      }
      else
      {
	 view.backgroundColor = UIColor(
	    patternImage: UIImage(named: "LandscapeBackground")!
	                                )
	 
	 //Add Popover Action Button
	 navigationItem.rightBarButtonItem = UIBarButtonItem(
	    barButtonSystemItem: .action, target: self,
	    action: #selector(showPopover(_:))
	                                                     )
      }
      
      if searchResult != nil
      {
	 updateUI()
      }
   }
    
   @objc func showPopover(_ sender: UIBarButtonItem)
   {
      guard let popover = storyboard?.instantiateViewController(
	 withIdentifier: "PopoverView") as? MenuViewController
      else { return }
      
      popover.modalPresentationStyle = .popover
      
      if let ppc = popover.popoverPresentationController
      {
	 ppc.barButtonItem = sender
      }
      
      popover.delegate = self
      
      present(popover, animated: true, completion: nil)
   }

   
    //MARK: - Actions
     @IBAction func close ()
     {
	dismiss(animated: true, completion: nil)
	
	dismissStyle = .slide
	dismiss(animated: true, completion: nil)
     }
     
   //MARK: -  Helper Methods
   func updateUI()
   {
      nameLabel.text = searchResult.name
      
      if searchResult.artist.isEmpty == true
      {
	 artistNameLabel.text = NSLocalizedString("Unknown", comment: "Localized Artist Name: Unknown")
      }
      else
      {
	 artistNameLabel.text = searchResult.artist
	 
	 if let largeURL = URL(string: searchResult.imageLarge)
	 {
	    downloadTask = artworkImageView.loadImage(url: largeURL)
	 }
	 
      }
      
      kindLabel.text = searchResult.type
      genreLabel.text = searchResult.genre
      
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencyCode = searchResult.currency
      
      let priceText: String
      
      if searchResult.price == 0
      {
	 priceText = NSLocalizedString("Free", comment: "Localized Price: Free")
      }
      else if let text = formatter.string(from: searchResult.price as NSNumber)
      {
	 priceText = text
      }
      else
      {
	 priceText = NSLocalizedString("Not Found", comment: "Localized Price: Not Found")
      }
      priceButton.setTitle(priceText, for: .normal)
      
      popupView.isHidden = false 
   }
   
   
   enum AnimationStyle
   {
      case slide
      case fade
   }
   
   var dismissStyle = AnimationStyle.fade
     
}

extension DetailViewController: UIGestureRecognizerDelegate
{
   func gestureRecognizer(
      _ gestureRecognizer: UIGestureRecognizer,
      shouldReceive touch: UITouch) -> Bool
   {
      return (touch.view === self.view)
   }
}


extension DetailViewController: UIViewControllerTransitioningDelegate
{
   func animationController(
      forPresented presented: UIViewController,
      presenting: UIViewController,
      source: UIViewController) -> UIViewControllerAnimatedTransitioning?
   {
      return BounceAnimationController()
   }
   
   func animationController(
      forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
   {
      switch dismissStyle
      {
      case .slide:
	 return SlideOutAnimationController()
      case .fade:
	 return FadeOutAminationController()
      }
   }
   
}

extension DetailViewController: MenuViewControllerDelegate
{
   //Show the E-Mail Support and fill in the default information
   func menuViewControllerSendEmail(_: MenuViewController)
   {
    dismiss(animated: true)
      {
	 if MFMailComposeViewController.canSendMail()
	 {
	    let controller = MFMailComposeViewController()
	    controller.setSubject(
	       NSLocalizedString("Support Request", comment: "E-Mail Subject")
	                          )
	    
	    controller.setToRecipients(["lasagnemicrowave@gmail.com"])
	    self.present(controller, animated: true, completion: nil)
	    
	    controller.mailComposeDelegate = self
	 }
      }
   }
   
}

//Compose E-Mail Form on Support Cell Function
extension DetailViewController: MFMailComposeViewControllerDelegate
{
   func mailComposeController(
      _ controller: MFMailComposeViewController,
      didFinishWith result: MFMailComposeResult,
      error: Error?)
   {
      dismiss(animated: true, completion: nil)
   }
}
