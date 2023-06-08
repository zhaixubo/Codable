//
//  ViewController.swift
//  Codable测试
//
//  Created by 翟旭博 on 2023/6/8.
//

import UIKit
//https://news-at.zhihu.com/api/4/version/ios/2.3.0
//https://news-at.zhihu.com/api/4/news/latest
class ViewController: UIViewController, Encodable {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        netWorkWithData()
        netWorkWithData2()
    }
    struct Person: Codable {
        var status: Int
        var msg: String
        var latest: String
    }

    struct DailyNews: Codable {
        let date: String
        let stories: [Story]
        let topStories: [TopStory]

        enum CodingKeys: String, CodingKey {
            case date, stories
            case topStories = "top_stories"
        }
    }

    struct Story: Codable {
        let imageHue: String
        let title: String
        let url: String
        let hint: String
        let gaPrefix: String
        let images: [String]
        let type: Int
        let id: Int

        enum CodingKeys: String, CodingKey {
            case imageHue = "image_hue"
            case title, url, hint
            case gaPrefix = "ga_prefix"
            case images, type, id
        }
    }

    struct TopStory: Codable {
        let imageHue: String
        let hint: String
        let url: String
        let image: String
        let title: String
        let gaPrefix: String
        let type: Int
        let id: Int

        enum CodingKeys: String, CodingKey {
           case imageHue = "image_hue"
           case hint, url, image, title
           case gaPrefix = "ga_prefix"
           case type, id
       }
    }
    func netWorkWithData(){
        if let urlString = URL(string: "https://news-at.zhihu.com/api/4/version/ios/2.3.0") {
            let request = URLRequest(url: urlString)

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                            
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // 有需要则配置这个属性
                    let newsVersion = try decoder.decode(Person.self, from: data!)
                    print(newsVersion)
                    print(newsVersion)
                } catch {
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
    }
    func netWorkWithData2(){
        if let urlString = URL(string: "https://news-at.zhihu.com/api/4/news/latest") {
            let request = URLRequest(url: urlString)
            URLSession.shared.dataTask(with: request) { data, response, error in
                        
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                            
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase // 有需要则配置这个属性
                    let newsVersion = try decoder.decode(DailyNews.self, from: data!)
                    print(newsVersion.stories[0].title)
                } catch {
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
    }
}

