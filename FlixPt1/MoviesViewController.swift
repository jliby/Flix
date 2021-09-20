
import UIKit //this basically imports all the ui things like labels and allows you to use them
import AlamofireImage   //this allows you to actually put the poster image on

//Now this is the first view controller or the first screen, which is of type UI view Controller -->
//we add UItableViewDataSource and ViewDelegate, and fix, which will add in 2 functions ----this makes our current class a subclass of these 2 additional classes so we can use their functionality --> made the two functions, but we can put those anywhere
//everything below is within this view controller class even the didload
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //We dragged and dropped our movies screen here using ctrl drag
    //this puts our table view into our actual code so we can add logic to it (this is within the movies controller)
    @IBOutlet weak var tableView: UITableView!
    
    
    //Variables created up here are available for the lifetime of the screen, the entire time(called properties)
    var movies = [[String:Any]]() //this is a declaration/creation of an array of dictionaries  (so inside the arrays [] there is a dictionary declaration where the key is type string and the actual value is anything)
    
    
    //this is the function that first executes, its the first thing to be done when your view/screen loads --> the  view did load function is run the first time a screen (view controller) comes up,, want to put everything you want executed first thing in this function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These allow it to call the 2 functions we made when first loading the app so it displays the rows
        tableView.dataSource = self
        tableView.delegate = self

        //This API brings an array of dictionaries. Each dictionary is a movie : there is a key: like name, id, video  and then the value for the name, id , and video
        
        //This brings the API into our app//networking that we dont know how to do
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //our data from the web is stored in this dataDictionary Variable
                
                //print(dataDictionary) -- this prints all the data, there are results, dates, etc.  but we just want the movies which are stored in the results tab --> we create a movies array that holds dictionaries of each movie (name,id,etc) as each element of the array
                
                self.movies = dataDictionary["results"] as! [[String:Any]]  //this sets movies to equal the results part (the results part is an array of dictionaries)  so you have movies equal the results key  bc the data dictionary is a dictionary itself. --> then you cast this as the same type  as movies was declared as
            
                self.tableView.reloadData()  //this re calls the 2 functions again after the api data is loaded so it can actually use the data and input it into the cells (before the row count was 0 bc we hadnt had the movies array yet so movies.count was 0 meaning 0 rows

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()

        
    }
    
    
    
    //This function returns the number of rows you will be using (so however you get the rows you just return and it will automatically make that many rows for u. it returns it to the ui) (so however many movies you have total)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count  // this .count gives back the size of the array "movies"
    }
    
    //Given the row, what will you do with this row? --> basically what's the content for each row --> (you display each movie on each row)
    //this returns a table view cell itself
    //These are just functions, dont worry about the actual input parameters(, just know the first one you will return the number of cells for it and the second one you actually return the cell itself, so you do all the specifications for the cell, like the labels and shit and set those values, and just return which will get the cell onto the UI)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        //as! downcasts it to a more specific type bc Its normally type UITableViewcell, but we make it more specific to our specific UITableViewCell which is our MovieCell
        
        //this creates a new cell(each time the function is called)-->note its reusable and the identifier is the name of the cell class bc you are using that new class you made for the layout of each cell --> cast it as a movieCell so can use it as a movie cell
        
        let movie = movies[indexPath.row] //this gets the movie dictionary from the array at the specific row we are on (row 3 gets the 3rd movie in the api list)
        let title = movie["title"] as! String //this sets the title by accessing from the movie dictionary the key: title which will have a string value (we set this by casting it)
        let synopsis = movie["overview"] as! String //this gives this variable the data that is in the overview key of the movie dictionary for each movie (note it has to be a string), bc we never gave it a type, safer to cast it
        
        
        //this is making the textLabel an optional (meaning it does not have a value assigned to it yet)-->it could contain something or nothing at all (? declares it as optional, where ! unwrapps it, to get the actual value)  (this actually isn't for this, was for a previous line of code we deleted, still good info)
        
        cell.titleLabel.text = title  //this is the actual text that is displayed on the cell, note how we made the title called titleLabel when we dragged it to the .swift file, so we are setting the label value to the movie's title now
        cell.synopsisLabel.text = synopsis //this assigns the synopsis label text with the let variable we just made
        //note in story board you can set lines to 0 and itll automatically do the lines it needs, until it fills up the cell
        //also you use cell.variableName.text   to access the cells, the specific label, and then text to refer that you will be changing the text
        
        //to get the actual picture we consult the api documentation, which tells us we need the base url, the image with after that, then added onto that the file path of the particular image which is under the key: poster path
        let baseUrl = "https://image.tmdb.org/t/p/w185"  //note the size is added to it
        let posterPath = movie["poster_path"] as! String//accesses the posterpath portion to add to the url by using this key to get the value in the dictionary (note everytime you access a dictionary you should say what type the value you want is
        
        //now you combine both of these
        let posterUrl = URL(string: baseUrl + posterPath)!//this is a special type, making it a URL that can access the path and then you add the two together
        
        //now in order to use a picture we need the alamofireimage library, which we downloaded in swift package dependencies (or could do with cocoa pods)
        cell.posterView.af.setImage(withURL: posterUrl)  //using the alamofire library, we set our posterView variable equal to the url which sets our image in the specific cell to that
        
        
        
        
        
        
        return cell
    }
    
    
    //This function is for when you are leaving your current screen (the tablie view you set up here) and want to prepare the next screen -->so in this function we need to pass in the movie info (note the sender variable (of type any) input is the sell that was tapped on)
    //This is everything you want to happen when transitioning screens
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Find selected movie(the one you click on so that when you click on a movie it brings it to more info of the movie you clicked on)
        let cell = sender as! UITableViewCell //so now our cell variable equals the one you tap on and the type is a Table View cell
        
        //this accesses the index path (cell # u tapped on)
        let indexPath = tableView.indexPath(for: cell)!
        //This says the row index (the row number is the table view and you are accessing the index path of that specific cell for the table view interface/UI element
        
        //this sets the movie to equal that specific dictionary at that row number from the array
        let movie = movies[indexPath.row]
        
        
        
        
        //now the segue(input)  we can set this new variable to the destination of the segway and cast it as MovieDetailsViewController -->this sets the detailsViewController as our destination
        let detailsViewController = segue.destination as! MovieDetailsViewController
        //this casting gives us access to our MoviesViewController
        
        detailsViewController.movie = movie  //so now it sets the movie variable in the new screen (in the detailsViewController Screen) to the movie dictionary we just found, so ultimately now we passes along the movie that was selected into the segue, or the next screen destination as a variable called movie)--> now we can use that movie variable in the next screen to do stuff.
        
        
        //Now we have the movie and want to pass that into the new view/screen
        
        //last thing you want to do now before actually transitioning is to deselect the row you are on (it highlights gray normally)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
