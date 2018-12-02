
//
//  UETopViewController.swift
//  UICatalog
//

import UIKit

class UETopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
        tableView.separatorStyle = .none        
        tableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        
        // back button title hidden
        let item = UIBarButtonItem()
        item.title = ""
        self.navigationItem.backBarButtonItem = item
    }
}

extension UETopViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stoaryboard = UIStoryboard(name: "UEDetail", bundle: nil)
        let vc = stoaryboard.instantiateInitialViewController()!
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UETopViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
        return cell
    }
}

extension UETopViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if fromVC is AnimationDataSource && toVC is AnimationDataSource {
            let animator = Animator()
            animator.isForward = operation == .push
            return animator
        }
        return nil
    }
}

extension UETopViewController: AnimationDataSource {
    func animationDataSource() -> AnimationResource {
        
        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! RestaurantCell
        return AnimationResource(imageView: cell.restaurantImageView)
    }
}

