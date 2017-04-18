//
//  HJHttpManager.m
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJHttpManager.h"
#import <MJExtension.h>
#import "GDataXMLNode.h"
/*========================NSLog=======================*/
#ifdef DEBUG
#define XHJLog(FORMAT, ...) NSLog(@"%@:%d行   \n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define XHJLog(FORMAT, ...) nil
#endif
static HJHttpManager *httpManager = nil;
@implementation HJHttpManager

+ (HJHttpManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[HJHttpManager alloc] init];
        httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [httpManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [httpManager.requestSerializer setValue:@"application/json, text/html" forHTTPHeaderField:@"Accept"];
        [httpManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"image/jpeg", @"image/png", @"application/octet-stream", nil]];
        //超时时间
        httpManager.requestSerializer.timeoutInterval = 20;
    });
    return httpManager;
}

- (void)requestJSONWithURL:(NSString *)urlString type:(RequestType)type paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic progress:(void (^)(NSProgress *progress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    HJHttpManager *manager = [HJHttpManager sharedInstance];
    if ([urlString containsString:@"GetUserFen"]) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    //去掉空字符串
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *temp = dic;
    if (object != nil) {
        temp = object.mj_keyValues;
    }
    XHJLog(@"上传参数-------%@", temp);
    switch (type) {
        case RequestTypeGet:
        {
            [manager GET:urlString parameters:temp progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    progress(downloadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                XHJLog(@"请求成功-------%@", responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                XHJLog(@"请求失败-------%@", error.description);
            }];
        }
            break;
            
        case RequestTypePost:
        {
            [manager POST:urlString parameters:temp progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    progress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                XHJLog(@"请求成功-------%@", responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                XHJLog(@"请求失败-------%@", error.description);
            }];
        }
            break;
    }
    
}

- (void)requestObjectWithURL:(NSString *)urlString class:(Class)className type:(RequestType)type paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic progress:(void (^)(NSProgress *))progress success:(void (^)(NSObject *object))success failure:(void (^)(NSError *))failure {
    [self requestJSONWithURL:urlString type:type paramObject:object paramDictionary:dic progress:^(NSProgress *progress1) {
        if (progress) {
            progress(progress1);
        }
    } success:^(id responseObject) {
        if ([className isSubclassOfClass:[NSObject class]] && success) {
            success([className mj_objectWithKeyValues:responseObject]);
        } else {
            failure([NSError errorWithDomain:@"类型错误" code:999 userInfo:nil]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//上传文件
- (void)uploadFiles:(NSArray <HJFormData *>*)files url:(NSString *)urlString paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic  progress:(void (^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    HJHttpManager *manager = [HJHttpManager sharedInstance];
    NSDictionary *temp = dic;
    //去掉空字符串
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (object != nil) {
        temp = object.mj_keyValues;
    }
    [manager POST:urlString parameters:temp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (HJFormData *data in files) {
            [formData appendPartWithFileData:data.data name:data.name fileName:data.filename mimeType:data.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//- (NSString *)getRequestTime{
//    return [[NSDate date] stringWithFormatter:@"yyyyMMdd"];
//}
//- (NSString *)checkValue {
//    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kCat_InvestorIDKey];
//    if (!userID) {
//        userID = @"0";
//    }
//    NSString *value = [[[NSString stringWithFormat:@"%@%@%@", [self getRequestTime], userID, kSecretKey].md5String substringWithRange:NSMakeRange(4, 20)] uppercaseString];
//    return value;
//}


/**
 *  请求SOAP，返回NSData
 *
 *  @param url      请求地址
 *  @param bodyParams soap的XML中方法和参数段
 *  @param success  成功block
 *  @param failure  失败block
 */
+ (void)requestSOAPData:(NSString *)url soapBody:(NSDictionary *)bodyParams success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    NSString *paramsStr = @"";
    
    for (NSString *key in bodyParams.allKeys) {
        if (![key isEqualToString:@"method"] ) {
            paramsStr = [NSString stringWithFormat:@"%@<%@>%@</%@>",paramsStr,key,bodyParams[key],key];
        }
    }
    
    //调用的方法 + (命名空间:这个对应wsdl文档的命名空间)
    NSString *bodyStr = [NSString stringWithFormat:
                         @"<%@ xmlns = \"http://tempuri.org/\">%@</%@>\n",bodyParams[@"method"],paramsStr,bodyParams[@"method"]];
    NSString *soapStr = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                         "<SOAP-ENV:Envelope SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                         "<SOAP-ENV:Body>%@</SOAP-ENV:Body>\n"
                         "</SOAP-ENV:Envelope>\n",bodyStr];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapStr length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //[request addValue: @"暂不设置,使用默认值" forHTTPHeaderField:@"SOAPAction"];
    
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPMethod:@"POST"];//因为body可能很长所以选择POST方式
     
     [request setHTTPBody: [soapStr dataUsingEncoding:NSUTF8StringEncoding]];
     
     NSURLSession *session = [NSURLSession sharedSession];
     
     //线程安全,显示小菊花作为网络的提示状态(HUDTool是对MBProgress进行了封装)
//     dispatch_main_async_safe(^{
//        
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [HUDTool showToView:app.window];
//        
//    });
    
     
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        dispatch_main_async_safe(^{
//            
//            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            [HUDTool hideForView:app.window];
//            
//        });
        
//        NSString *result212 = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];

        if (error) {
//            NSLog(@"Session----失败----%@", error.localizedDescription);
            if (failure) {
//                dispatch_main_async_safe(^{
                    failure(error);
//                });
                
            }
            
        }else{
            
//            NSLog(@"进入成功回调Session-----结果：%@----请求地址：%@", result, response.URL);
            
            NSError *error = nil;
            GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
            
            //获取根节点 及中间所有的节点 GDataXMLElement类表示节点
            //获取根节点
            GDataXMLElement *rootElement = [document rootElement];
            
            //追踪到有效父节点 Result(分析返回结果的XML与当前调用方法的规律)
            //1.第一层soap:body解析
            GDataXMLElement *soapBody=[[rootElement elementsForName : @"soap:Body" ] objectAtIndex : 0 ];
            //2.第二层不同方法的Response解析
            GDataXMLElement *response=[[soapBody elementsForName :[NSString stringWithFormat:@"%@Response",bodyParams[@"method"]]] objectAtIndex : 0 ];
            //3.第三层不同方法的Result解析
            GDataXMLElement *result=[[response elementsForName :[NSString stringWithFormat:@"%@Result",bodyParams[@"method"]]] objectAtIndex : 0 ];
            
//            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithCapacity:1];
//            
//            NSArray *arr = result.children;
//            
//            if (result.childCount == 1) {
//                
//                [resultDic setValue:[result stringValue] forKey:@"result"];
            
//            }else{
//                
//                for (GDataXMLElement *element in arr) {
//                    
//                    NSString *str = [[[result elementsForName:element.name] objectAtIndex : 0 ] stringValue ];
//                    if (str != nil) {
//                        [resultDic setValue:str forKey:element.name];
//                    }
//                    
//                }
//                
//            }
            
//            GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
//            GDataXMLElement *rootElement = [document rootElement];
//            GDataXMLElement *result = [rootElement nodesForXPath:[NSString stringWithFormat:@"/%@Response/%@Result", bodyParams[@"method"], bodyParams[@"method"]] error:nil][0];
            if (success) {
//                dispatch_main_async_safe(^{
                    success([result stringValue]);
//                });
            }
        }
    }];
     [task resume];
     }


@end

@implementation HJFormData

@end
