//
//  HJHttpManager.h
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
@class HJFormData;

/**
 请求类型
 
 - RequestTypeGet: get请求
 - RequestTypePost: post请求
 */
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet = 1,
    RequestTypePost = 2,
};
@interface HJHttpManager : AFHTTPSessionManager

+ (HJHttpManager *)sharedInstance;

/**
 post、get请求, 返回JSON
 
 @param urlString url地址
 @param type post、get
 @param object 参数对象
 @param dic 参数字典
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
- (void)requestJSONWithURL:(NSString *)urlString type:(RequestType)type paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic progress:(void (^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)requestJSONWithURL:(NSString *)urlString semaphore:(dispatch_semaphore_t)semaphore type:(RequestType)type paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic progress:(void (^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 post、get请求, 返回NSObject

 @param urlString url地址
 @param className 对象的类型
 @param type post、get
 @param object 参数对象
 @param dic 参数字典
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
- (void)requestObjectWithURL:(NSString *)urlString class:(Class)className type:(RequestType)type paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic progress:(void (^)(NSProgress *progress))progress success:(void (^)(NSObject *object))success failure:(void(^)(NSError *error))failure;


/**
 上传文件

 @param files 文件数组
 @param urlString url地址
 @param object 参数对象
 @param dic 参数字典
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
- (void)uploadFiles:(NSArray <HJFormData *>*)files url:(NSString *)urlString paramObject:(NSObject *)object paramDictionary:(NSDictionary *)dic  progress:(void (^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  请求SOAP，返回NSData
 *
 *  @param url      请求地址
 *  @param bodyParams soap的XML中方法和参数段
 *  @param success  成功block
 *  @param failure  失败block
 */
+ (void)requestSOAPData:(NSString *)url soapBody:(NSDictionary *)bodyParams success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end


/**
 上传文件模型
 */
@interface HJFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
