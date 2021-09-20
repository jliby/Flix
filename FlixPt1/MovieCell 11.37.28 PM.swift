//This is a seperate file we made for the cell function itself because it makes no sense to put in viewController bc we repeat it like 20 times

import UIKit

class MovieCell: UITableViewCell {

    //connecting all 3 parts of cell to the logic
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
