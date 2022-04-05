//
//  BarGraphUsingCollectionView.swift
//  CustomGraphs
//
//  Created by Nitin Bhatia on 05/04/22.
//

import UIKit

class BarGraphUsingCollectionView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var values : [CGFloat] = [10,20,30,40,50,100,500,1000,1500]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BarCollectionViewCell
        
        cell.barView.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: (values[indexPath.row] / (values.max() ?? 100)) ).isActive = true
        
        if indexPath.row % 2 == 0 {
            cell.barView.backgroundColor = .red
        } else {
            cell.barView.backgroundColor = .blue
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 34, height: collectionView.frame.height)
    }

}
