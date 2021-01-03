//
//  User+Sql.swift
//  SocialIo
//
//  Created by admin on 26/11/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//



import Foundation


extension Post{
    static func create_table(database: OpaquePointer?){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS POSTS1(ST_ID TEXT PRIMARY KEY, NAME TEXT, AVATAR TEXT, POST TEXT, USERID TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    func addToDb(){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO POSTS1(ST_ID, NAME, AVATAR, POST, USERID) VALUES (?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = self.id.cString(using: .utf8)
            let name = self.name.cString(using: .utf8)
            let avatar = self.avatar.cString(using: .utf8)
            let post = self.post.cString(using: .utf8)
            let userid = self.userid.cString(using: .utf8)
           
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, avatar,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, post,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, userid,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }

   static func delete(post : Post){
           
            
            let deleteStatementString = "DELETE FROM POSTS1 where ST_ID like ?;"
            print(deleteStatementString)

            var sqlite3_stmt: OpaquePointer? = nil
            
            if (sqlite3_prepare_v2(ModelSql.instance.database,deleteStatementString,-1,&sqlite3_stmt,nil) == SQLITE_OK) {
                sqlite3_bind_text(sqlite3_stmt, 1,post.id,-1,nil);

                if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                    print("\nSuccessfully deleted row.")
                } else {
                    print("\nCould not delete row.")
                }
            } else {
                print("\nDELETE statement could not be prepared")
            }
            
            sqlite3_finalize(sqlite3_stmt)
        }
    
    static func getAllPostsFromDb()->[Post]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        
        if (sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from POSTS1;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let stId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let st = Post(id: stId);
                st.name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                st.avatar = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                st.post = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                st.userid = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                data.append(st)
                
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    static func setLastUpdate(lastUpdated:Int64){
        return ModelSql.instance.setLastUpdate(name: "POSTS1", lastUpdated: lastUpdated);
    }
    
    static func getLastUpdateDate()->Int64{
        return ModelSql.instance.getLastUpdateDate(name: "POSTS1")
    }
    
    
}
