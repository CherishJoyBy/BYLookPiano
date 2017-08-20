//
//  BYHomeCell.m
//  LookPiano
//
//  Created by lby on 2017/8/16.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYHomeCell.h"
#import "BYHTTPSessionManager.h"
#import <UIImageView+WebCache.h>

@interface BYHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cycleImageView;
//@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation BYHomeCell

- (void)setHome:(BYHome *)home
{
    _home = home;
    [self.cycleImageView sd_setImageWithURL:[NSURL URLWithString:home.imgUrl]];
}

//- (void)setIndexPath:(NSIndexPath *)indexPath
//{
//    _indexPath = indexPath;
//    
//    self.cycleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"index%zd",indexPath.item + 1]];
////    self.tagLabel.text = [NSString stringWithFormat:@"第%zd组的第%zd个", indexPath.section, indexPath.item];
//}

@end
