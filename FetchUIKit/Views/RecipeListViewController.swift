//
//  RecipeListViewController.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//
import UIKit

class RecipeListViewController: UIViewController {
    @IBOutlet weak var collectionVw: UICollectionView!

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var viewModel = RecipeListViewModel(category: .dessert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dessert"
        setupUI()
        Task {
            await fetchRecipes()
        }
    }

    private func setupUI() {
        activityIndicator.color = .darkGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        collectionVw.delegate = self
        collectionVw.dataSource = self
        collectionVw.registerCellNib(RecipeColCell.self)
    }

    private func fetchRecipes() async {
        activityIndicator.startAnimating()
        await viewModel.fetchRecipes()
        activityIndicator.stopAnimating()
        
        viewModel.sortRecipesAlphabetically()
        collectionVw.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeColCell", for: indexPath) as? RecipeColCell else {
            return UICollectionViewCell()
        }
        let recipe = viewModel.recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = viewModel.recipes[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            detailVC.viewModel = RecipeDetailViewModel(recipe: recipe)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let totalSpacing = (2 - 1) * spacing
        let width = (collectionView.bounds.width - 32.0 - totalSpacing) / 2
        return CGSize(width: width, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? RecipeColCell
        cell?.isSelected = true
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? RecipeColCell
        cell?.isSelected = false
    }
}
