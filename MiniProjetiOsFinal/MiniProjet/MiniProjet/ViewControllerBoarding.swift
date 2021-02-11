//
//  ViewControllerBoarding.swift
//  MiniProjet
//
//  Created by mac  on 27/11/2020.
//

import UIKit

class ViewControllerBoarding: UIViewController , UIScrollViewDelegate{

    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnGetStarted: UIButton!
   
    var scrollWidth: CGFloat! = 0.0
        var scrollHeight: CGFloat! = 0.0

        //data for the slides
        var titles = ["Géolocalisation","Plannifier ","Messagerie instantanée"]
        var descs = ["Trouvez le bon plan le plus proche à vous.","Plannifier un rendez-vous ","Contactez le professionels directement depuis l'application."]
        var imgs = ["map","schedule","text-message"]

        //get dynamic width and height of scrollview and save it
        override func viewDidLayoutSubviews() {
          scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.layoutIfNeeded()
            //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview

            self.scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false

           // save true flag to UserDefaults

            //crete the slides and add them
            var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

            for index in 0..<titles.count {
                frame.origin.x = scrollWidth * CGFloat(index)
                frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                let slide = UIView(frame: frame)

                //subviews
                let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
                imageView.frame = CGRect(x:0,y:0,width:300,height:300)
                imageView.contentMode = .scaleAspectFit
                imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
              
                let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
                txt1.textAlignment = .center
                txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
                txt1.text = titles[index]

                let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
                txt2.textAlignment = .center
                txt2.numberOfLines = 3
                txt2.font = UIFont.systemFont(ofSize: 18.0)
                txt2.text = descs[index]

                slide.addSubview(imageView)
                slide.addSubview(txt1)
                slide.addSubview(txt2)
                scrollView.addSubview(slide)

            }
           


            //set width of scrollview to accomodate all the slides
            scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

            //disable vertical scroll/bounce
            self.scrollView.contentSize.height = 1.0

            //initial state
            pageControl.numberOfPages = titles.count
            pageControl.currentPage = 0

        }

    override func viewDidAppear(_ animated: Bool) {
            if UserDefaults.standard.bool(forKey: "isInstall") == true {
                
              //  print("yes")
                let newViewController1 = self.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController
                newViewController1?.modalPresentationStyle = .fullScreen
                self.present(newViewController1!, animated:false, completion:nil)
                
            }
     
        }
        //indicator
        @IBAction func pageChanged(_ sender: Any) {
            scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            setIndiactorForCurrentPage()
        }

        func setIndiactorForCurrentPage()  {
            let page = (scrollView?.contentOffset.x)!/scrollWidth
            pageControl?.currentPage = Int(page)
        }
    
    
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isInstall") 
        let newViewController1 = self.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController
        newViewController1?.modalPresentationStyle = .fullScreen
        self.present(newViewController1!, animated:false, completion:nil)
    }
    
    }

