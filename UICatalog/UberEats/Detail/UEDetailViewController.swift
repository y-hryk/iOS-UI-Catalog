//
//  UEDetailViewController.swift
//  UICatalog
//

import UIKit

class UEDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var headerView = UETableHeaderView()
    var foodInfoView = Bundle.main.loadNibNamed("\(UEFoodInfoView.self)", owner: nil, options: nil)!.first as! UEFoodInfoView
    
    deinit {
        print("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TableView Setting
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableFooterView = UIView()
        
        // FoodInfoView Setting
        view.addSubview(foodInfoView)
        foodInfoView.layout(in: view, targetImageView: headerView.imageView, imageSize: headerView.imageSize)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        foodInfoView.startAnimation()
    }
}

extension UEDetailViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.updateScrollViewOffset(scrollView)
        foodInfoView.updateScrollViewOffset(scrollView) { (result) in
            navigationController?.navigationBar.tintColor = result ? .black : .white
        }
    }
}

extension UEDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
}

extension UEDetailViewController: AnimationDataSource {
    func animationDataSource() -> AnimationResource {
        return AnimationResource(imageView: headerView.imageView)
    }
}
