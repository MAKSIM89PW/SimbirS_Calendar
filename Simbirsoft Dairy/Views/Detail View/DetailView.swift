import UIKit

class DetailView: UIView {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var finish: UILabel!
    @IBOutlet var contentView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        //  стандартная логика инициализации
        let nib = UINib(nibName: "DetailView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
