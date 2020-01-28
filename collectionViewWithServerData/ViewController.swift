//
//  ViewController.swift
//  collectionViewWithServerData
//
//  Created by R Shantha Kumar on 1/4/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
 
    var collectionView:UICollectionView?
    
     var flowLayOut = UICollectionViewFlowLayout()
    

    override func viewDidLoad() {
    super.viewDidLoad()
        
        dataOperation()
        flowLayOut.minimumLineSpacing = 15
        flowLayOut.minimumInteritemSpacing = 10
        flowLayOut.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame:CGRect(x: 10, y: 50, width: 400, height: 800), collectionViewLayout: flowLayOut)
        view.addSubview(collectionView!)
        
        collectionView?.delegate   = self
        collectionView?.dataSource = self
        
        collectionView?.collectionViewLayout = flowLayOut
        collectionView?.backgroundColor = .clear
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "abc")
        
        
        // Do any additional setup after loading the view.
    }
    
    
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return FormData.shared.title.count
    
 }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        FormData.shared.selectedItem = indexPath.item
        
        let target = storyboard?.instantiateViewController(identifier: "abcd") as! DetailViewController
        
        present(target, animated: true, completion: nil)
        
        print("app number \(indexPath.item)")
   
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        return CGSize(width: 190, height: 190)
      
       
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    

    
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "abc", for: indexPath)
    let imagrVIew = UIImageView(image: FormData.shared.images[indexPath.row])
    
    
    
   imagrVIew.frame = CGRect(x: 0, y: 0, width: 190, height: 190)
    
//    imagrVIew.layer.cornerRadius = imagrVIew.frame.width/2
//    imagrVIew.clipsToBounds = true
    
   
    cell.contentView.addSubview(imagrVIew)
 
    return cell
    
 }
    
        func dataOperation(){
            
            
           
            
                                       FormData.shared.data = [[String:Any]]()
                                       FormData.shared.movieType = [String]()
                                       FormData.shared.images = [UIImage]()
                                       FormData.shared.title = [String]()
                                       FormData.shared.stories = [String]()
                                       FormData.shared.songz = [[String]]()
                                       FormData.shared.songTitle = [[String]]()
                                       FormData.shared.videoData = [String]()

            
            
            
         var   serverData1 = mediaData()
                
          for x in 0...serverData1.count-1{
    //                  pageController.numberOfPages = data.count
            let titles = serverData1[x]["title"] as!  String
            FormData.shared.title.append(titles)
            print(titles)
            
//  image data
            
            let imageString = (serverData1[x]["posters"] as!  [String])
            
            print("#######",imageString)
            let string1 = imageString.joined(separator: "")
            
            
            
            var strig2 = "https://www.brninfotech.com/tws/ "
            var perentile = "%20"
            let newString = strig2.replacingOccurrences(of: " ", with: string1, options: .literal, range: nil)
            let newString2 = newString.replacingOccurrences(of: " ", with: perentile, options: .literal, range: nil)
          
                       let url  = URL(string: newString2)
                       let data = try! Data(contentsOf: url!)


                 var  imaged = UIImage(data: data)
            
            
                   FormData.shared.images.append(imaged!)
print(FormData.shared.images)

    // appending story to singleton class
            

            let stories = serverData1[x]["story"] as? String ?? "DATA NOT AVAILABLE"
            
            FormData.shared.stories.append(stories)
            
    //appending director info to singleton class
            
            
            let director = serverData1[x]["director"] as! String
            
            FormData.shared.director.append(director)
            
          
            
    //appending director info to singleton class
            
            let actorDetails = serverData1[x]["actors"] as! [String]
            
            FormData.shared.actorDetials.append(actorDetails)
            
    // song appending
            
            
                          let audio = serverData1[x]["songs"] as! [String]
            
                          let replace = "%20"
                          let ith = " "
            
                          let strig6 = "https://www.brninfotech.com/tws/"
            
                          var allSongsUrlInString = [String]()
                          var names = [String]()
            
                          for x in audio
                              {
                                   if (x.count != 0){
                                      let replace = "%20"
                                  let ith = " "
                          
                                  let urlData = x.replacingOccurrences(of: ith, with: replace)
                                  
                                  allSongsUrlInString.append(strig6 + urlData)
                                  
                                  
                                  if let index =  (x.range(of: "-")?.upperBound)
                                          {
                                              names.append(String(x.suffix(from: index)))
                                              
                                          }
                                  
                              
                              }
                              }
            
            FormData.shared.songz.append(allSongsUrlInString)
            FormData.shared.songTitle.append(names)
            
     
    //video data
            
                          let video = serverData1[x]["trailers"] as!  [String]
            
                          var videoclub:String!
                          var trialer:String!
            
                          for v in video{
                           videoclub = strig2.replacingOccurrences(of: " ", with: v)
                              let v = "%20"
            
                             trialer = videoclub.replacingOccurrences(of: " ", with: v)
            
            
                          }
                             
            
                          FormData.shared.videoData.append(trialer)
            
            
            
                    }
 
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
  func mediaData()-> [[String:Any]]
    {
        
       
        
        
        var data1:[[String:Any]]?
        
        
       var urlRequestObj = URLRequest(url: URL(string: "https://www.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!)
        
        urlRequestObj.httpMethod = "GET"
        
       var dataTaskObj = URLSession.shared.dataTask(with: urlRequestObj, completionHandler: { (data, respond, error) in
            do{
                
                data1 = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:Any]]
           
                
            }catch{
                
                                print("something error")
                
            }
            
            
        })
        dataTaskObj.resume()
        
        while (data1==nil) {
            
           
        }
        
        
        FormData.shared.data = data1!
        
       
        
        return data1!
    }
    
    
    
    
  
    
    
    
    
 

    
    
    
    
    


}

