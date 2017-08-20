//
//  BYMusicTypeCell.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYMusicTypeCell.h"

@interface BYMusicTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *collectionImageViiew;
@property (weak, nonatomic) IBOutlet UILabel *musicLabel;

@end

@implementation BYMusicTypeCell

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
//    self.collectionImageViiew.image = [UIImage imageNamed:@"index3"];
    self.collectionImageViiew.backgroundColor = BYRandomColor;
    self.musicLabel.text = @"主题风";
}

@end
