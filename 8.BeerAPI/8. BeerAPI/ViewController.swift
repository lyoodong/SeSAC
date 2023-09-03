//
//  ViewController.swift
//  8. BeerAPI
//
//  Created by Dongwan Ryoo on 2023/08/08.
//

import Alamofire
import Kingfisher
import SwiftyJSON
import UIKit

//데이터 저장할 구조체
struct Bear {
    let name, image_url, description:String
    let abv:Double
}

class ViewController: UIViewController {
    //MARK: - UI property
    @IBOutlet var bearNameLabel: UILabel!
    @IBOutlet var bearImageView: UIImageView!
    @IBOutlet var bearDicrptLabel: UILabel!
    @IBOutlet var abvView: UIView!
    @IBOutlet var resetButton: UIButton!
    
    //MARK: - Define method
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        resetbuttonSet()
    }
    
    //데이터 호출
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                //맥주 이름, 사진, 설명, 도수 데이터 저장
                let      = json[0]["name"].stringValue
                let imageUrl = json[0]["image_url"].stringValue
                let description = json[0]["description"].stringValue
                let abv = json[0]["abv"].doubleValue
                
                //인스턴스에 데이터 저장
                let data = Bear(name: name, image_url: imageUrl, description: description, abv: abv)
                
                //이미지링크 스트링에서 url로 변환
                let url = URL(string: data.image_url)
                
                //도수 정도를 에니메이션을 활용해 구현
                UIView.animate(withDuration: 1) {
                    //뷰의 길이
                    let viewWidth:CGFloat = UIScreen.main.bounds.width
                    //최대 도수를 60도로 잡고, 호출된 술의 도수를 퍼센트화
                    let abvPercnet = data.abv / 60
                    //도수의 정도를 나타낼 막대바를 self.view의 크기에 비례해서 계산
                    self.abvView.frame.size.width = viewWidth * abvPercnet
                }
                self.abvView.backgroundColor = .red
                
                //텍스트 및 이미지 UI property에 할당.
                self.bearNameLabel.text = "\(data.name), \(data.abv)도"
                self.bearImageView.kf.setImage(with: url)
                self.bearDicrptLabel.text = data.description
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //데이터 초기화 버튼
    func resetbuttonSet() {
        resetButton.setTitle("리셋", for: .normal)
        resetButton.tintColor = .white
        resetButton.backgroundColor = .black
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
    }
    
    //버튼 클릭 시 데이터 초기화
    @objc
    func resetButtonClicked() {
        callRequest()
    }
}

