//
//  CommentViewController.swift
//  Instagram
//
//  Created by 山本梨野 on 2022/02/25.
//

import UIKit
import Firebase
import SVProgressHUD


class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextView: UITextView!
    var commentText: String?

    override func viewDidLoad() {
        commentText = commentTextView.text
    }
    
    
 
//    //投稿のIDをもらう場所
//    var postId: String? = ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    //投稿ボタンを押したら、コメントのid、投稿のid、コメントユーザーのid、コメントの内容を保存
    @IBAction func commentButton(_ postData: PostData) {

        // 投稿データの保存場所を定義する
        let commentRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // FireStoreにコメントデータを保存する
        //コメントをしたユーザー名とコメントを
        let name = Auth.auth().currentUser!.displayName!
        let comment = "\(name) : \(String(describing: commentText))"
        let postDic = ["comment": comment]
        commentRef.setData(postDic)

        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        // 投稿処理が完了したので先頭画面に戻る
       UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
        
    
    //キャンセルボタンを押したらページを閉じる
    @IBAction func commentCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }


}

