import UIKit
import WImage

public class WImageView: UIView {
    
    private var item: WItem?
    private lazy var  imageView: UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()
    
    public var url: URL? {
        set {
            if newValue != item?.url {
                self.updateImage()
            }
        }
        get {
            return item?.url
        }
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let newFrame = CGRect(x:0, y: 0, width: self.frame.width, height:self.frame.height)
        if self.imageView.frame != newFrame {
            self.imageView.frame = frame
            self.updateImage()
        }
    }
    
    private func updateImage() {
        if let url = self.url {
            WImage.shared.load(url: url, width: self.frame.width, height: self.frame.height, priority: .normal) { image in
                self.imageView.image = image
            }
        } else {
            self.imageView.image = nil
        }
    }
}
