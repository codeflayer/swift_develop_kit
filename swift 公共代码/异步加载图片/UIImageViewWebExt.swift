//
//  UIImageViewWebExt.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-5.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView
{
    func setImage(urlString:String,placeHolder:UIImage!)
    {
    
        var url = NSURL(string: urlString)
        var cacheFilename = url!.lastPathComponent
        var cachePath = FileUtility.cachePath(cacheFilename!)
        var image : AnyObject = FileUtility.imageDataFromPath(cachePath)
      //  println(cachePath)
        if image as NSObject != NSNull()
        {
            self.image = image as? UIImage
        }
        else
        {
            var req = NSURLRequest(URL: url!)
            var queue = NSOperationQueue();
            //异步发送请求获取图片
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                //如果没有返回错误
                if (error != nil)
                {
                     //主线程中更新ui,设置显示图片是占位图
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            println(error)
                            self.image = placeHolder
                        })
                }
                else
                {
                    //如果有返回结果就设置为返回结果图片
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            
                            var image = UIImage(data: data)
                            if (image == NSNull())
                            {
                                self.image = placeHolder
                            }
                            else
                            {
                                self.image = image
                                FileUtility.imageCacheToPath(cachePath,image:data)
                            }
                        })
                }
                })

        }
        
    }
}


