//
//  FileUtility.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-7.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class FileUtility: NSObject {
   
    //拼接路径
    class func cachePath(fileName:String)->String
    {
      var arr =  NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
       var path = arr[0] as String
        return "\(path)/\(fileName)"
    }
    
    //将文件写入路径
    class func imageCacheToPath(path:String,image:NSData)->Bool
    {
       return image.writeToFile(path, atomically: true)
    }
    
    class func imageDataFromPath(path:String)->AnyObject
    {
       var exist = NSFileManager.defaultManager().fileExistsAtPath(path)
        if exist
        {
          return  UIImage(contentsOfFile: path)!
        }
        
        return NSNull()
    }
    
    
    
    
}
