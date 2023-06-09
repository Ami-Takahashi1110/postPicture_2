//
//  PostViewController.swift
//  postPicture
//
//  Created by USER on 2023/05/03.
//

import UIKit
import FirebaseCore
import FirebaseStorage
//import FirebaseStorageUI

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func SelectPhotoAction(_ sender: Any) {
        // フォトライブラリーが利用可能かチェック
        
        
    }
    
    @IBAction func StartCameraAction(_ sender: Any) {
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // UIImagePickerControllerのインスタンスを作成
            let imagePickerController = UIImagePickerController()
            // sourceTypeにcameraを設定
            imagePickerController.sourceType = .camera
            // delegate作成
            imagePickerController.delegate = self
            // モーダルビュー作成
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラは利用できません")
        }
    }
    // 撮影後に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影した画像を配置したpictureimageに渡す
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PostPhotoAction(_ sender: Any) {
        if let shareImage = pictureImage.image {
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems,applicationActivities: nil)
            present(controller, animated: true, completion: nil)
        }
        
        // 参照の作成
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // アップロードしたい画像ファイルを取得する
        let image = UIImage(named: "space.jpg")
        let imagesRef = storageRef.child("images")

        // アップロードするイメージの参照を作成する
        let imageRef = imagesRef.child("images/space.jpg")

        // データとメタデータを準備する
        if let imageData = image?.jpegData(compressionQuality: 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            // ストレージにイメージをアップロードする
            let uploadTask = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    // アップロード中にエラーが発生した場合の処理
                    print("アップロードエラー: \(error.localizedDescription)")
                } else {
                    // アップロードが成功した場合の処理
                    print("アップロード成功")
                }
            }
        }

    }
}
