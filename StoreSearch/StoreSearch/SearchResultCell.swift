//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Nick "Fox" Borer on 02/22/2023.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell
{
   
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var artistNameLabel: UILabel!
   @IBOutlet weak var artistImageView: UIImageView!
   
   var downloadTask: URLSessionDownloadTask?

    override func awakeFromNib()
   {
      super.awakeFromNib()
      
      let selectedView = UIView(frame: CGRect.zero)
      selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
      selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool)
   {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   func configure(for result: SearchResult)
   {
      nameLabel.text = result.name
      
      //Check if ArtistName is empty, if so, then force a value "Unknown", otherwise, parse the string to extract the data Enumerated in the Search.swift File
      if result.artist.isEmpty == true
      {
	 artistNameLabel.text = NSLocalizedString("Unknown", comment: "Localized Artist Name Label: Unknown")
      }
      else
      {
	 artistNameLabel.text = String(
	    format: "%@ (%@)",
	    result.artist,
	    result.type)
      }
      
      //Get Pictures for the Album Artwork
      artistImageView.image = UIImage(systemName: "square")
      
      if let smallURL = URL(string: result.imageSmall)
      {
	 downloadTask = artistImageView.loadImage(url: smallURL)
      }
      
   }
}
