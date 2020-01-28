//
//  DetailViewController.swift
//  collectionViewWithServerData
//
//  Created by R Shantha Kumar on 1/6/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit
import AVKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var uiImageView: UIImageView!
    
    @IBOutlet weak var titleLAbel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var videoPlayer:AVPlayer?
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    if(section == 0){
        
        return 1
    }
    else if
        (section == 1)
    
    {
        
        return FormData.shared.songTitle[FormData.shared.selectedItem!].count
        
    }
    else{
        
        return 1
    }
    
    
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath) as! TableViewCell
        
        if(indexPath.section == 0){
            
            cell.imageView?.image = FormData.shared.images[FormData.shared.selectedItem!]
    
          cell.textLabel?.text = FormData.shared.title[FormData.shared.selectedItem!]
            return cell
           
        }
       else if(indexPath.section == 1){
       
            cell.textLabel?.text = FormData.shared.songTitle[FormData.shared.selectedItem!][indexPath.row]
            cell.backgroundColor = .systemOrange
            return cell
        }else{
            
            cell.textLabel?.text = "click here for trailer"
            cell.backgroundColor = .systemBlue
             return cell
          
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0){
        
        return "Movie"
            
    } else if(section == 1){
           
           return "Songs"
               
       }
        
        else{
            
            return "Trailer"
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
        return 200
    }
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(indexPath.section == 1){
            
            let video:AVPlayer!
                                
             video = AVPlayer(url: URL(string: FormData.shared.songz[FormData.shared.selectedItem!][indexPath.row])!)
                               
            
            print(FormData.shared.songz[FormData.shared.selectedItem!][indexPath.row])
            let videoPlayer = AVPlayerViewController()

            videoPlayer.player = video
                                
                video.play()
         
        }
        
        if(indexPath.section == 2){
            
            if(indexPath.row == 0)
            {
            let video:AVPlayer!
                     
                   video = AVPlayer(url: URL(string: FormData.shared.videoData[FormData.shared.selectedItem!])!)
                     
                     let videoPlayer = AVPlayerViewController()

                     videoPlayer.player = video
                     
                     video.play()
                     
                     present(videoPlayer, animated: true) {
                         
                     }
         
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "abc")
        
        tableView.delegate = self
        tableView.dataSource = self
         
    }
 
}
