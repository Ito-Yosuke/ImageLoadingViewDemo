//
//  ImageLoadingView.swift
//  Sandbox
//
//  Created by Yosuke Ito on 2023/06/14.
//
import UIKit

class ImageLoadingView: UIImageView {
    // ローディング表示のビュー
    var activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    // 画像なしの場合表示するタイムアウト画像
    var noImage: UIImage?
    
    // タイムアウト後に実行するブロック
    private var workItem: DispatchWorkItem?
    
    // UIImage
    override var image: UIImage? {
        didSet {
            guard image != nil else { return }
            
            // imageがセットされたらActivity Indicatorを消す
            activityIndicatorView.stopAnimating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    /// 初期化処理
    private func configure() {
        guard image == nil else {
            return
        }
        
        // activityIndicatorViewを追加
        activityIndicatorView.frame.size = self.frame.size
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    /// ActivityIndicatorを表示する場合呼ぶメソッド
    /// - Parameters:
    ///   - timeout: ActivityIndicatorを消してnoImageを表示するまでのduration。0を指定した場合はtimeoutしない。デフォルトは10.0
    ///   - noImage: タイムアウト画像として表示する画像。デフォルトはnil
    public func showIndicator(timeout: Double = 10.0, noImage: UIImage? = nil) {
        guard image == nil else { return }
        
        self.noImage = noImage
        
        // ローディング表示の開始
        activityIndicatorView.startAnimating()
        
        // タイムアウト時の処理の初期化
        workItem?.cancel()
        
        // タイムアウト時の処理
        workItem = DispatchWorkItem { [weak self] in
            // すでに画像が差し込まれているなら上書きしない
            guard self?.image == nil else { return }
            
            // タイムアウト画像をセット
            self?.image = self?.noImage ?? UIImage()
        }
        
        // タイムアウト処理の予約
        if timeout != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeout, execute: workItem!)
        }
    }
}
