//
//                       __
//                      /\ \   _
//    ____    ____   ___\ \ \_/ \           _____    ___     ___
//   / _  \  / __ \ / __ \ \    <     __   /\__  \  / __ \  / __ \
//  /\ \_\ \/\  __//\  __/\ \ \\ \   /\_\  \/_/  / /\ \_\ \/\ \_\ \
//  \ \____ \ \____\ \____\\ \_\\_\  \/_/   /\____\\ \____/\ \____/
//   \/____\ \/____/\/____/ \/_//_/         \/____/ \/___/  \/___/
//     /\____/
//     \/___/
//
//	Powered by BeeFramework
//

#import "Bee.h"
#import "ecmobile.h"

#pragma mark -

@interface UserModel : BeeOnceViewModel

AS_SINGLETON( UserModel )

@property (nonatomic, retain) SESSION *	session;
@property (nonatomic, retain) UIImage *	avatar;
@property (nonatomic, retain) NSArray *	fields;
@property (nonatomic, retain) USER *	user;
@property (nonatomic, assign) BOOL		firstUse;

AS_NOTIFICATION( LOGIN )
AS_NOTIFICATION( LOGOUT )
AS_NOTIFICATION( KICKOUT )
AS_NOTIFICATION( UPDATED )

+ (BOOL)online;

- (void)setOnline:(BOOL)flag;
- (void)setOffline:(BOOL)flag;

- (void)signinWithUser:(NSString *)user
			  password:(NSString *)password;
//- (void)signupWithUser:(NSString *)user
//			  password:(NSString *)password
//				 email:(NSString *)email
//				fields:(NSArray *)fields;
// 重写注册传参
- (void)signupWithUser:(NSString *)user
              password:(NSString *)password
           mobilePhone:(NSString *)mobilePhone
                fields:(NSArray *)fields;

- (void)signupWithUser:(NSString *)user
          inviteUserId:(NSString *)inviteUserId
              password:(NSString *)password
           mobilePhone:(NSString *)mobilePhone
                fields:(NSArray *)fields
              realname:(NSString *)realname
                school:(NSString *)school
                course:(NSString *)course
             isTeacher:(NSString *)isTeacher
               country:(NSString *)country
          provinceName:(NSString *)provinceName
              cityName:(NSString *)cityName
              townName:(NSString *)townName;

// 通过父亲id查询地区
- (void)selectRegionByParentId:(NSString *)parent_id;

- (void)get_course;     // 注册时查询课程
- (void)getCourse:(NSNumber *)student_id;       // 关注时查询课程
- (void)getTeacher:(NSNumber *)student_id;

- (void)searchUserByName:(NSString *)name
             andCourseId:(NSNumber *)course_id
               andUserId:(NSNumber *)user_id;

- (void)addFollowByTeacherId:(NSNumber *)teacher_user_id
                   studentId:(NSNumber *)student_user_id
                    courseId:(NSNumber *)course_id;

- (void)cancelFollowByStudentId:(NSNumber *)student_user_id
                       courseId:(NSNumber *)course_id;

- (void)searchIntegral;

- (void)signout;
- (void)kickout;

- (void)updateFields;
- (void)updateProfile;

- (void)checkUser:(NSString *)user andInviteCode:(NSString *)inviteCode;

- (void)postAvatar:(NSString *)avatar;

@end
