//
//  ICDataModel.m
//  MyData
//
//  Created by xu on 16/6/4.
//  Copyright © 2016年 xu. All rights reserved.
//

#import "ICDataModel.h"

#import <objc/runtime.h>

@implementation ICDataModel
//输出对象属性
+(void)printObjectInfoWithOb:(id)classObject {
    //获取参数
    unsigned int varCount;
    Ivar *vars = class_copyIvarList([classObject class], &varCount);
    //为对象赋值
    for (unsigned int i = 0; i < varCount; i++) {
        Ivar var = vars[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s",ivar_getName(var)];
        if ([[propertyName substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]) {
            propertyName =[propertyName substringWithRange:NSMakeRange(1, propertyName.length - 1)];
        }
    }
    free(vars);
}

//数据映射－支持单层映射
-(void)objectFromDictWith:(NSMutableDictionary *)dictData {
    //获取参数
    unsigned int varCount;
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    //为对象赋值
    for (unsigned int i = 0; i < varCount; i++) {
        Ivar var = vars[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s",ivar_getName(var)];
        if ([[propertyName substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]) {
            propertyName =[propertyName substringWithRange:NSMakeRange(1, propertyName.length - 1)];
        }
        //字段解析 字段不是nsnull而且拥有数值才去映射
        if ((![[dictData objectForKey:propertyName] isEqual:[NSNull class]]) && [dictData objectForKey:propertyName]) {
            //复合对象不解析
            if ([[dictData objectForKey:propertyName] isKindOfClass:[NSArray class]] ) {
                // DebugLog(@"复合对象 %@",propertyName);
                NSArray* array = [dictData objectForKey:propertyName];
                object_setIvar(self, var, [[NSMutableArray alloc] initWithArray:array]);
                
            }else if([[dictData objectForKey:propertyName] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* dict = [dictData objectForKey:propertyName];
                object_setIvar(self, var, [NSMutableDictionary dictionaryWithDictionary:dict]);
                
            }
            else
            {
                NSString *propertyType = [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(var)];
                if ([propertyType isEqualToString:@"@\"NSString\""] || [propertyType isEqualToString:@"@\"String\""]) {
                    object_setIvar(self, var, [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dictData objectForKey:propertyName]]]);
                }
            }
        }/*else
          {
          if ([[dictData objectForKey:propertyName] isKindOfClass:[NSMutableArray class]] ||[[dictData objectForKey:propertyName] isKindOfClass:[NSArray class]] || [[dictData objectForKey:propertyName] isKindOfClass:[NSDictionary class]]) {
          // DebugLog(@"复合对象 %@",propertyName);
          continue;
          }
          object_setIvar(self, var, @"");
          }*/
        // NSLog(propertyName);
    }
    free(vars);
}

//数据逆映射
-(NSMutableDictionary *)dictFromObject {
    //创建字典
    NSMutableDictionary *dictReturn = [[NSMutableDictionary alloc] init];
    
    //获取参数
    unsigned int varCount;
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    //为对象赋值
    for (unsigned int i = 0; i < varCount; i++) {
        Ivar var = vars[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s",ivar_getName(var)];
        if ([[propertyName substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]) {
            propertyName =[propertyName substringWithRange:NSMakeRange(1, propertyName.length - 1)];
        }
        
        //转换成字典
        [dictReturn setValue:object_getIvar(self, var) forKey:propertyName];
    }
    free(vars);
    return dictReturn;
}

@end
