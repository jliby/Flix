//Note how this file is only for this screen (view controller)--> you always have one swift file for each screen and you do all the logic for that screen on this swift file

//Collection view is very similar to the table view so, also have to make a seperate class for all the ui elements within each box of the grid

import UIKit
import AlamofireImage

//just like table view we add the data source and view delegate and fix, which will add 2 functions which we put on the bottom
class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    //dragged the collection view itself here (not the image inside it)
    @IBOutlet var collectionView: UICollectionView!
    
    var movies = [[String:Any]]() //this declares the movies variable so it can be used

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Have to also add these for collection view functions and stuff to work (just like table view)
        collectionView.delegate = self
        collectionView.dataSource = self

        
        
        
        //CONFIGURING THE COLLECTION VIEW LAYOUT (This creates an object of the collection view)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4 //controls space in btwn the rows so up and down spacing (40 pixels btwn row 1 and 2)
        layout.minimumInteritemSpacing = 4 //sets the space between each poster as the given value (in pixels)
        
        //Now we will try to configure how many posters there will be in each row
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3 //this will give you the width of the phone the user has
                
        layout.itemSize = CGSize(width: width , height: width * 1.5)  //this sets the item size (so the picture size
        //note how the item size is 1/3 the width bc want to fit 3 on the width of the screen in each row
        //also you have to account for the distance in between so you subtract that distance (mult by 2 bc for 3 pics, theres 2 spaces in between)
        
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/848278/recommendations?api_key=a15a9e4c46f04a84b0a2526ad0c42488")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                //note how everything is loaded only once at the beginning, and it will give a white screen without this, need to reload it so that it displays //be
                self.collectionView.reloadData()
            
               
             }
        }
        task.resume()
    }
    
    
    
   
    //This returns an int, the number of grid squares
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    
    //This returns a type of UICollectionViewCell, so an actual grid box itself, so what are we doing with each box
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //now this lets your cell be equal to the reusable cell file you made, with the reuse identifier, (note the reuse identifier is the file we made where we dragged the image view)--the image view will be reused for each cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell  //downCast it to MovieGridCell ( our specific version of a collection view cell)
        
        //so now that its set to reuse, you just set the values for all the ui elements (like set label = blah, title = blah, etc.) but right now
        
        let movie = movies[indexPath.item]  //collection views, the index path portion that your accessing is the item now, not a row (note how an indexPath contains a lot of information like row, height, etc)
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        cell.posterView.af.setImage(withURL: posterUrl)
        
        
        return cell  //then you just return the cell
    }
    
    
    
}
