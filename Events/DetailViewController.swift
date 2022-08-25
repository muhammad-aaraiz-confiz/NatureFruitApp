//
//  DetailViewController.swift
//  Events
//
//  Created by Muhammad Aaraiz Wasim on 09/08/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!

    @IBOutlet weak var carbs: UILabel!

    @IBOutlet weak var prot: UILabel!
    
    @IBOutlet weak var fat: UILabel!
    
    @IBOutlet weak var cal: UILabel!
    
    @IBOutlet weak var sug: UILabel!
    
    @IBOutlet weak var CollectionView: UICollectionView!

    var fruitObj : FruitListElement?

    override func viewDidLoad() {

        if (fruitObj?.name != "Grapes") {
            self.title = "\(fruitObj!.name)'s Detail"
        }
        else {
            self.title = "\(fruitObj!.name)' Detail"
        }
        super.viewDidLoad()

        CollectionView.dataSource = self
        CollectionView.delegate = self

        

        if fruitObj?.name != nil {
            if (fruitObj?.name != "Grapes") {
                lbl.text = "\(fruitObj!.name)'s Nutrition Chart"
            }
            else {
                lbl.text = "\(fruitObj!.name)' Nutrition Chart"
            }
        }
        
        if fruitObj?.nutritions.carbohydrates != nil {
            carbs.text = "Carbohydrates: \(fruitObj!.nutritions.carbohydrates)"
        }
        
        if fruitObj?.nutritions.protein != nil {
            prot.text = "Protein: \(fruitObj!.nutritions.protein)"
        }
        
        if fruitObj?.nutritions.fat != nil {
            fat.text = "Fat: \(fruitObj!.nutritions.fat)"
        }
        
        if fruitObj?.nutritions.calories != nil {
            cal.text = "Calories: \(fruitObj!.nutritions.calories)"
        }
        
        if fruitObj?.nutritions.sugar != nil {
            sug.text = "Sugar: \(fruitObj!.nutritions.sugar)"
        }

    }

}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let url = URL(string: FruitDictionary.topTen[(fruitObj!.name)]!)
        let data = try? Data(contentsOf: url!)
        cell.setup(with: UIImage(data: data!)! )
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }

}

