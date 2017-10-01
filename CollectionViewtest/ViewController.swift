//
//  ViewController.swift
//  CollectionViewtest
//
//  Created by Kalyan Vishnubhatla on 9/30/17.
//  Copyright © 2017 Kalyan Vishnubhatla. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var isCollectionViewExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(buttonWasClicked))
        
        self.collectionView?.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "default")
        self.collectionView?.register(UINib(nibName: "ExpandedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "expanded")
        
        self.setCellFlowLayout()
    }
    
    @objc func buttonWasClicked() {
        self.isCollectionViewExpanded = !self.isCollectionViewExpanded
        self.setCellFlowLayout()
    }
    
    private func setCellFlowLayout() {
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        if (self.isCollectionViewExpanded) {
            self.collectionView?.setCollectionViewLayout(self.createFlowLayout(height: 200), animated: true)
        } else {
            self.collectionView?.setCollectionViewLayout(self.createFlowLayout(height: 100), animated: true)
        }
    }
    
    private func createFlowLayout(height: CGFloat) -> UICollectionViewLayout {
        let width = self.collectionView!.frame.size.width - 20
        let size = CGSize(width: width, height: height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = size
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        return layout
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CollectionCell!
        if self.isCollectionViewExpanded {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "expanded", for: indexPath) as! CollectionCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! CollectionCell
        }
        
        cell.imageView.image = UIImage(named: String(indexPath.row))
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

