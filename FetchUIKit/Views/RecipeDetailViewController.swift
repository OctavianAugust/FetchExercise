//
//  RecipeDetailViewController.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import UIKit
import Kingfisher

public class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollVw: UIScrollView!
    @IBOutlet weak var mainStackVw: UIStackView!
    @IBOutlet weak var recipeImageVw: UIImageView!
    @IBOutlet weak var recipeNameLbl: UILabel!
    @IBOutlet weak var expandableInstructionsVw: ExpandableLabelView!
    @IBOutlet weak var expandableIngredientsVw: ExpandableLabelView!
    
    @IBOutlet weak var recipeImageVwHeightConstraint: NSLayoutConstraint!
    
    public var viewModel: RecipeDetailViewModel?
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var scrollingNow = false

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        Task {
            await fetchRecipeDetails()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goScrollVwToNormalPointIfNeeded(animated: false)
    }

    private func setupUI() {
        self.scrollVw.delegate = self
        self.view.backgroundColor = .white
        
        self.activityIndicator.color = UIColor.darkGray
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.activityIndicator)
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchRecipeDetails() async {
        self.showLoadingIndicator()
        await viewModel?.fetchRecipeDetails()
        self.hideLoadingIndicator();
        self.updateUI()
    }
    
    private func showLoadingIndicator() {
        self.activityIndicator.startAnimating()
        self.scrollVw.isHidden = true
    }
        
    private func hideLoadingIndicator() {
        self.activityIndicator.stopAnimating()
        self.scrollVw.isHidden = false
    }

    private func updateUI() {
        guard let recipe = viewModel?.recipe else { return }
        
        recipeNameLbl.text = recipe.name
        expandableInstructionsVw.delegate = self
        expandableInstructionsVw.title = "Instructions:"
        expandableInstructionsVw.fullText = recipe.instructions
        if let url = URL(string: recipe.imageUrl) {
            loadImage(from: url)
        }
        expandableIngredientsVw.delegate = self
        expandableIngredientsVw.title = "Ingredients:"
        expandableIngredientsVw.fullText = recipe.ingredientsInString()
    }

    private func loadImage(from url: URL) {
        self.recipeImageVw.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [
            .transition(.fade(0.2)),
            .cacheOriginalImage
        ])
    }
}

// MARK: - UIScrollViewDelegate
extension RecipeDetailViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollingNow = true
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollingNow = true
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingNow = false
        goScrollVwToNormalPointIfNeeded(animated: true)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollingNow = false
        if decelerate == false {
            goScrollVwToNormalPointIfNeeded(animated: true)
        }
    }
    
    private func goScrollVwToNormalPointIfNeeded(animated: Bool) {
        let recipeImageVwHeight = self.recipeImageVwHeightConstraint.constant
        let offsetY = scrollVw.contentOffset.y
        
        updateTbVwContentHeight()
        
        if recipeImageVwHeight != 0 && recipeImageVwHeight > (offsetY - 2) && offsetY > 0
        {
            let goingUp = offsetY > (recipeImageVwHeight / 2)
            if goingUp
            {
                let desiredOffset = CGPoint(x: 0, y: recipeImageVwHeight)
                scrollVw.setContentOffset(desiredOffset, animated: animated)
            }
            else
            {
                let desiredOffset = CGPoint(x: 0, y: 0)
                scrollVw.setContentOffset(desiredOffset, animated: animated)
            }
        }
    }
    
    private func updateTbVwContentHeight()
    {
        mainStackVw.superview?.layoutIfNeeded()
        var bottomInset = scrollVw.frame.size.height - (mainStackVw.frame.height + 8)
        bottomInset = bottomInset > 0 ? bottomInset : 0
        if scrollVw.contentInset.bottom != bottomInset
        {
            scrollVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        }
    }
}

// MARK: - ExpandableLabelViewDelegate
extension RecipeDetailViewController: ExpandableLabelViewDelegate {
    func expandableLabelViewHeightDidChange(_ view: ExpandableLabelView) {
        self.goScrollVwToNormalPointIfNeeded(animated: false)
    }
}
