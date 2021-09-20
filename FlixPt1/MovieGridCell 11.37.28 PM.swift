//You need to add this class for the collection view's class, and as the reuse identifier (also within the collection view portion)

//NOTE THE REUSE IDENTIFIER MAKES IT ABLE TO BE REUSED, SO THIS WILL BE REUSED FOR EACH GRID, THIS UI ELEMENT (JUST THE IMAGE VIEW FOR THIS) WILL BE REUSED FOR EVERY GRID AND IN THE FUNCTION FOR THE ACTUAL VIEW CONTROLLER SWIFT FILE YOU TELL THE CELL TO EQUAL dequeuereusable cell and then put in this file which makes it known what ui elements you will be reusing

//SO for this class, you draw the actual UI elements here, so it does it for each element (each square in the grid)

//all you do in this seperate class is drag the ui elements of collection view or of a table view (drag in all the elements in one grid or one cell)

import UIKit

class MovieGridCell: UICollectionViewCell {
    @IBOutlet weak var posterView: UIImageView!
    
}
