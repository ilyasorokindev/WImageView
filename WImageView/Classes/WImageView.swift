import UIKit
import WImage

public class WImageView: UIView {
    
    private var item: WItem?
    private lazy var  imageView: UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()
    
    @IBInspectable public var imagePath: String? {
        set {
            if let item = self.item {
                WImage.shared.cancel(item: item)
            }
            if let path = newValue {
                self.item = WImage.shared.load(path: path)
            } else {
                self.item = nil
            }
            self.updateImage()
        }
        get {
            return self.item?.path
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
        if let path = self.imagePath {
            WImage.shared.load(path: path, width: self.frame.width, height: self.frame.height, priority: .normal) { image in
                self.imageView.image = image
            }
        } else {
            self.imageView.image = nil
        }
    }
}
