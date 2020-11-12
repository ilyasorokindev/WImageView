import UIKit
import WImage

public class WImageView: UIView {
    
    private var item: WItem?
    private lazy var  imageView: UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()
    
    @IBInspectable public var URLString: String? {
        set {
            self.url = URL(string: newValue ?? "")
        }
        get {
            return self.url?.absoluteString
        }
    }
    
    public var url: URL? {
        set {
            if newValue != item?.url {
                if let item = self.item {
                    WImage.shared.cancel(item: item)
                }
                if let url = newValue {
                    self.item = WImage.shared.load(url: url)
                } else {
                    self.item = nil
                }
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
