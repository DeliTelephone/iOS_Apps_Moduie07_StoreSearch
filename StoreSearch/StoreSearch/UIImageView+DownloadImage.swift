//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Nick "Fox" Borer on 02/26/2023.
//

import Foundation
import UIKit

extension UIImageView
{
   
   //Downloads the Image Thumbnail for the Icon Grid Screen
   func loadImage(url: URL) -> URLSessionDownloadTask
   {
      let session = URLSession.shared
      
      let downloadTask = session.downloadTask(with: url)
      {
	 [weak self] url, _, error in
	 
	 if error == nil, let url = url,
	    let data = try? Data(contentsOf: url),
	    let image = UIImage(data: data)
	 {
	    DispatchQueue.main.async  //Get the Data in the Background
	    {
	       if let weakSelf = self
	       {
		  weakSelf.image = image
	       }
	    }
	 }
      }
      downloadTask.resume()
      return downloadTask
   }
}
