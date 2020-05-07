//
//  ViewController.swift
//  AdGateMedia Swift Demo
//
//  Copyright © 2019 AdGateMedia. All rights reserved.
//

import UIKit
//import AdGateMedia

class ViewController : UIViewController {
    @IBOutlet var textFieldUserID: UITextField!
    @IBOutlet var textFieldRewardCode: UITextField!
    @IBOutlet var textFieldVideoCode: UITextField!
    @IBOutlet var textFieldSubIDs_s2: UITextField!
    @IBOutlet var textFieldSubIDs_s3: UITextField!
    @IBOutlet var textFieldSubIDs_s4: UITextField!
    @IBOutlet var textFieldSubIDs_s5: UITextField!
    @IBOutlet var buttonResetValue: UIButton!
    @IBOutlet var buttonShowOfferWall: UIButton!
    @IBOutlet var buttonLoadAndShowOfferWall: UIButton!
    @IBOutlet var buttonLoadAndShowVideo: UIButton!
    @IBOutlet var buttonSeeLatestConversions: UIButton!

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    private var adgateMedia: AdGateMedia?
    private var adgateVideo: ADMAdGateVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetDefaultAction(nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    func startAnimating() {
        activityIndicatorView.startAnimating()

        buttonResetValue.isEnabled = false
        buttonShowOfferWall.isEnabled = false
        buttonLoadAndShowOfferWall.isEnabled = false
        buttonLoadAndShowVideo.isEnabled = false
        buttonSeeLatestConversions.isEnabled = false
    }

    func stopAnimating() {
        activityIndicatorView.stopAnimating()

        buttonResetValue.isEnabled = true
        buttonShowOfferWall.isEnabled = true
        buttonLoadAndShowOfferWall.isEnabled = true
        buttonLoadAndShowVideo.isEnabled = true
        buttonSeeLatestConversions.isEnabled = true
    }

    @IBAction func resetDefaultAction(_ sender: UIButton?) {
        textFieldSubIDs_s2.text = ""
        textFieldSubIDs_s3.text = ""
        textFieldSubIDs_s4.text = ""
        textFieldSubIDs_s5.text = ""

        textFieldRewardCode.text = "nqeX"
        textFieldUserID.text = "USERIDHERE"
        textFieldVideoCode.text = "23dedb56-35c6-438b-be63-dbc386ccfc29"
    }

    @IBAction func loadAndShowOfferWallAction(_ sender: UIButton) {
        
        guard let rewardCode = textFieldRewardCode.text, let userId = textFieldUserID.text else {
            return
        }
        
        if adgateMedia == nil {
            adgateMedia = AdGateMedia(rewardCode: rewardCode, userId: userId, parentViewController: self)
        } else {
            adgateMedia?.strRewardCode = rewardCode
            adgateMedia?.strUserId = userId
        }

        var dictParameters = [String:String]()
        dictParameters["s2"] = textFieldSubIDs_s2.text
        dictParameters["s3"] = textFieldSubIDs_s3.text
        dictParameters["s4"] = textFieldSubIDs_s4.text
        dictParameters["s5"] = textFieldSubIDs_s5.text

        startAnimating()

        adgateMedia?.loadOfferWall(dictParameters, onOfferWallLoadSuccess: {
            self.stopAnimating()

            self.adgateMedia?.showOfferWall({
                print("Closed wall")
                self.stopAnimating()
            })

        }, onOfferWallLoadFailed: { error in
            self.stopAnimating()

            print("failed to load wall \(error.localizedDescription)")

            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        })
    }

    @IBAction func showOfferWallAction(_ sender: UIButton) {
        
        guard let rewardCode = textFieldRewardCode.text, let userId = textFieldUserID.text else {
            return
        }

        print("val \(rewardCode) \(userId) ")
        if adgateMedia == nil {
            adgateMedia = AdGateMedia(rewardCode: rewardCode, userId: userId, parentViewController: self)
        } else {
            adgateMedia?.strRewardCode = rewardCode
            adgateMedia?.strUserId = userId
        }

        var dictParameters = [String:String]()
        dictParameters["s2"] = textFieldSubIDs_s2.text
        dictParameters["s3"] = textFieldSubIDs_s3.text
        dictParameters["s4"] = textFieldSubIDs_s4.text
        dictParameters["s5"] = textFieldSubIDs_s5.text
        
        /*
         * Only s2, s3, s4 and s5 parameters can be provided when showing a wall. Other parameters will be discarded.
         */
        startAnimating()
        let success = adgateMedia?.loadOfferWall(dictParameters, onOfferWallLoadSuccess: {
            self.stopAnimating()
            print("Load Success")

        }, onOfferWallLoadFailed: { error in
            self.stopAnimating()
            
            print("failed to load wall \(error.localizedDescription)")
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        })

        if let success = success, success == true {
            adgateMedia?.showOfferWall({
                print("Closed wall")
                self.stopAnimating()
            })
        }
    }

    @IBAction func loadAndShowVideoAction(_ sender: Any) {

        guard let videoCode = textFieldVideoCode.text, let userId = textFieldUserID.text else {
            return
        }
        
        var dictParameters = [String:String]()
        dictParameters["s2"] = textFieldSubIDs_s2.text
        dictParameters["s3"] = textFieldSubIDs_s3.text
        dictParameters["s4"] = textFieldSubIDs_s4.text
        dictParameters["s5"] = textFieldSubIDs_s5.text

        if (adgateVideo == nil) {
            adgateVideo = ADMAdGateVideo()
        }

        startAnimating()
        adgateVideo?.load(videoCode, userId: userId, subIds: dictParameters, onVideoLoadSuccess: {
            self.stopAnimating()
            print("video downloaded")
            self.adgateVideo?.show(self, showCrossButtonAfterDelay: 0, onVideoWatchedAndClosed: {
                print("Closed video")
                self.adgateVideo?.strVideoUDID = nil
                self.adgateVideo = nil
            }, onUserLeftApplication: {
                print("Here user leaves your app and goes to App Store Page")
                self.adgateVideo = nil
            }, onUserClickCloseWithoutWatching: {
                print("Closed Without Watching")
                self.adgateVideo = nil
            })

        }, onVideoLoadFailed: { error in
            self.stopAnimating()
            self.adgateVideo?.strVideoUDID = nil
            self.adgateVideo = nil

            print("failed to download: \(error)")

            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        })
    }

    @IBAction func showLatestConversionsAction(_ sender: UIButton) {
        
        guard let rewardCode = textFieldRewardCode.text, let userId = textFieldUserID.text else {
            return
        }
        
        if adgateMedia == nil {
            adgateMedia = AdGateMedia(rewardCode: rewardCode, userId: userId, parentViewController: self)
        }
        
        var dictParameters = [String:String]()
        dictParameters["s2"] = textFieldSubIDs_s2.text
        dictParameters["s3"] = textFieldSubIDs_s3.text
        dictParameters["s4"] = textFieldSubIDs_s4.text
        dictParameters["s5"] = textFieldSubIDs_s5.text

        /*
         * Only s2, s3, s4 and s5 parameters can be provided when showing a wall. Other parameters will be discarded.
         */
        startAnimating()
        adgateMedia?.getConversions(dictParameters, rewardCode: rewardCode, userId: userId, completionHandler: { offers, error in

            self.stopAnimating()

            if error != nil {
                let alert = UIAlertController(title: "Conversions List", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                })
                alert.addAction(defaultAction)
                self.present(alert, animated: true)
            } else {
                var alert: UIAlertController? = nil
                if let offers = offers {
                    alert = UIAlertController(title: "Conversions List", message: "\(offers)", preferredStyle: .alert)
                }
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                })
                alert?.addAction(defaultAction)
                if let alert = alert {
                    self.present(alert, animated: true)
                }
            }
            if let offers = offers {
                print("offers: \(offers)")
            }
        })
    }

    // MARK: - UITextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

