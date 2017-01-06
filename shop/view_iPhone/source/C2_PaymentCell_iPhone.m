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

#import "C2_PaymentCell_iPhone.h"

#pragma mark -

@implementation C2_PaymentCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)dataDidChanged
{
    if ( self.data )
    {
        PAYMENT * payment = self.data;
//        self.title.data = payment.pay_name;
//        self.subtitle.data = payment.format_pay_fee;
//        self.accessory.hidden = !payment.scrollSelected;
        if ([payment.pay_name isEqualToString:@"微信支付"])
        {
            $(@"#payment_icon").IMAGE(@"weixin_pay.png");
            $(@"#payment_name").TEXT(payment.pay_name);
            $(@"#payment_desc").TEXT(@"亿万用户的选择，更快更安全");
        }
        if ([payment.pay_name isEqualToString:@"支付宝"])
        {
            $(@"#payment_icon").IMAGE(@"zhifubao_pay.png");
            $(@"#payment_name").TEXT(payment.pay_name);
            $(@"#payment_desc").TEXT(@"数亿用户都在用，安全可托付");
        }
    }
}
@end
