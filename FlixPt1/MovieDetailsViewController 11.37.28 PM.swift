//Note you have to make a new file every time you make a new screen
//we drag the movie cell to this new screen (the 3rd one )

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    //Input Outlets for all UI Pieces
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    
    
    //Now in our new class, we create a variable of type dictionary that will hold our current movie based on the movie we tapped on in the previous screen
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        //This is where we will put everything, bc here we want everything to load first thing when page opens
        
        //access titleLabel variable and do .text to access the text property of this specific variable --> you set it equal to the dictionary value at the title key (note we use the movie variable which we passed in through the prepare function)
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        //this makes both labels scale to the size needed by inputted text
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        
        
        //now copy/paste the posterviewURL code so can set posterview in this
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        //note how this is not a cell anymore, just setting image of the posterviewUIImage view
        posterView.af.setImage(withURL: posterUrl)//u set it with a URL
        
        
        //BACKDROP
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string:  "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backdropView.af.setImage(withURL: backdropURL)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
