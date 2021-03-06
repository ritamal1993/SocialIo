//
//  UsersTableTableViewController.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit
import Kingfisher
class PostsTableViewController: UITableViewController {
      
        var data = [Post]()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
            
            ModelEvents.UserDataEvent.observe {
                self.refreshControl?.beginRefreshing()
                self.reloadData();
            }
            ModelEvents.DeleteDataEvent.observe {
                self.refreshControl?.beginRefreshing()
                self.reloadData();
            }
            self.refreshControl?.beginRefreshing()
            reloadData();
        }
        
        @objc func reloadData(){
            Model.instance.getAllPosts { (_data:[Post]?) in
                if (_data != nil) {
                    self.data = _data!;
                    self.tableView.reloadData();
                }
             
                self.refreshControl?.endRefreshing()
            };
        }
        
        override func viewWillAppear(_ animated: Bool) {
            print("viewWillAppear")
            
        }
        
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:PostViewCell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as! PostViewCell
            
            let st = data[indexPath.row]
           
            cell.name.text = st.name
            cell.idLabel.text = st.post
            cell.avatarImg.image = UIImage(named: "avatar")
            if st.avatar != ""{
                cell.avatarImg.kf.setImage(with: URL(string: st.avatar));
            }
            return cell
        }
        
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "PostInfoSegue"){
                let vc:PostInfoViewController = segue.destination as! PostInfoViewController
                vc.post = selected
            }
        }
        
        
        var selected:Post?
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selected = data[indexPath.row]
            performSegue(withIdentifier: "PostInfoSegue", sender: self)
        }
 
    }
