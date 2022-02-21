
import UIKit

import FirebaseCore
import FirebaseFirestore

class FirebaseManager
{
    var db: Firestore!
    var global_jackpot: String
    var highest_payout: String
    
    init()
    {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        global_jackpot = "1000"
        highest_payout = "0"
        
//        let gdRef = db.collection("global_data")
//        gdRef.document("global_jackpot").setData([
//            "global_jackpot": 1000
//            ])
//        gdRef.document("highest_payout").setData([
//            "highest_payout": 0
//            ])
    }
    
    
    public func saveData()
    {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    public func updateGlobalData(key: String, value: Int)
    {
        let gdRef = db.collection("global_data")
        
        gdRef.document(key).setData([
            key: value
            ])
    }
    
    public func getGlobalData(key:String)
    {
        let docRef = db.collection("global_data").document(key)

        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.global_jackpot = data["global_jackpot"] as? String ?? ""
                    print("gg", self.global_jackpot)
                }
            }
            
            
            
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
        }
        
    }
    
    
}
