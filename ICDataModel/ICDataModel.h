//
//  ICDataModel.h
//  MyData
//
//  Created by xu on 16/6/4.
//  Copyright © 2016年 xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICDataModel : NSObject

/** 输出对象属性 **/
+(void)printObjectInfoWithOb:(id)classObject;
/** 数据映射 **/
-(void)objectFromDictWith:(NSMutableDictionary *)dictData;
/** 数据逆映射 **/
-(NSMutableDictionary *)dictFromObject;

@end
