//
//  BYRightChooseView.m
//  LookPiano
//
//  Created by lby on 2017/8/22.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYRightChooseView.h"

@interface BYRightChooseView ()

@property (weak, nonatomic) IBOutlet UIButton *easyBtn;
@property (weak, nonatomic) IBOutlet UIButton *normalBtn;
@property (weak, nonatomic) IBOutlet UIButton *hardBtn;
@property (weak, nonatomic) IBOutlet UIButton *key88Btn;
@property (weak, nonatomic) IBOutlet UIButton *key37Btn;
@property (nonatomic, weak) UIButton *selectedTitleButton;
@end

@implementation BYRightChooseView

 - (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIColor *blackColor = [UIColor blackColor];
    UIColor *redColor = [UIColor redColor];
    [self.easyBtn setNormalTitleColor:blackColor selectTitleColor:redColor];
    [self.normalBtn setNormalTitleColor:blackColor selectTitleColor:redColor];
    [self.hardBtn setNormalTitleColor:blackColor selectTitleColor:redColor];
    [self.key88Btn setNormalTitleColor:blackColor selectTitleColor:redColor];
    [self.key37Btn setNormalTitleColor:blackColor selectTitleColor:redColor];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    for (UIButton *btn in self.subviews)
//    {
//        if ([btn isKindOfClass:NSClassFromString(@"UIButton")])
//        {
//            [self reSetClick:btn];
//        }
//    }
}

- (IBAction)easyClick:(UIButton *)sender
{
    BYLogFunc
    
    // 若简单原为未选中状态,转为选中状态,其他转为未选中状态
    if (!sender.selected) // NO
    {
        if (self.normalBtn.selected) // YES
        {
            self.normalBtn.selected = sender.selected; // NO
            self.normalBtn.backgroundColor = BYGrayColor(230);
        }
        if (self.hardBtn.selected) // YES
        {
            self.hardBtn.selected = sender.selected; // NO
            self.hardBtn.backgroundColor = BYGrayColor(230);
        }
    }
    [self setMusicListCount:1 withSelectButton:sender];
    
}

- (IBAction)normalClick:(UIButton *)sender
{
    BYLogFunc
    if (!sender.selected)
    {
        if (self.easyBtn.selected) // YES
        {
            self.easyBtn.selected = sender.selected;
            self.easyBtn.backgroundColor = BYGrayColor(230);
        }
        if (self.hardBtn.selected)
        {
            self.hardBtn.selected = sender.selected;
            self.hardBtn.backgroundColor = BYGrayColor(230);
        }
    }
    [self setMusicListCount:3 withSelectButton:sender];
}

- (IBAction)hardClick:(UIButton *)sender
{
    BYLogFunc
    
    if (!sender.selected)
    {
        if (self.easyBtn.selected) // YES
        {
            self.easyBtn.selected = sender.selected;
            self.easyBtn.backgroundColor = BYGrayColor(230);
        }
        if (self.normalBtn.selected) // YES
        {
            self.normalBtn.selected = sender.selected;
            self.normalBtn.backgroundColor = BYGrayColor(230);
        }
    }
    [self setMusicListCount:5 withSelectButton:sender];

}

- (IBAction)key88Click:(UIButton *)sender
{
    BYLogFunc
    if (!sender.selected)
    {
        if (self.key37Btn.selected) // YES
        {
            self.key37Btn.selected = sender.selected;
            self.key37Btn.backgroundColor = BYGrayColor(230);
        }
    }
    [self setMusicListCount:8 withSelectButton:sender];

}

- (IBAction)key37Click:(UIButton *)sender
{
    BYLogFunc
    if (!sender.selected)
    {
        if (self.key88Btn.selected) // YES
        {
            self.key88Btn.selected = sender.selected;
            self.key88Btn.backgroundColor = BYGrayColor(230);
        }
    }
    [self setMusicListCount:7 withSelectButton:sender];

}

- (void)setMusicListCount:(int)musicListCount withSelectButton:(UIButton *)selectButton
{
    if (selectButton.selected)
    {
        // 按钮原为选中状态,变成选未中状态
        selectButton.selected = NO;
        selectButton.backgroundColor = BYGrayColor(230);
        if (self.chooseFinishBlcok)
        {
            self.chooseFinishBlcok(20, NO);
        }
    }
    else
    {
        // 按钮原为未选中状态,变成选中状态
        selectButton.selected = YES;
        selectButton.backgroundColor = BYColor(255, 210, 200);
        if (self.chooseFinishBlcok)
        {
            self.chooseFinishBlcok(musicListCount, NO);
        }
    }
}

- (IBAction)finishChooseClick:(UIButton *)sender
{
    BYLogFunc
    if (self.chooseFinishBlcok)
    {
        self.chooseFinishBlcok(0, YES);
    }
}

- (IBAction)reSetClick:(UIButton *)sender
{
    BYLogFunc
    
    if (self.chooseFinishBlcok)
    {
        self.chooseFinishBlcok(20, NO);
    }
    
    if (self.easyBtn.selected)
    {
        [self easyClick:self.easyBtn];
    }
    
    if (self.normalBtn.selected)
    {
       [self normalClick:self.normalBtn];
    }
    
    if (self.hardBtn.selected)
    {
        [self hardClick:self.hardBtn];
    }
    
    if (self.key88Btn.selected)
    {
        [self key88Click:self.key88Btn];
    }
    
    if (self.key37Btn.selected)
    {
        [self key37Click:self.key37Btn];
    }
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"easySelected"])
//    {
//        [self easyClick:self.easyBtn];
//        [[NSUserDefaults standardUserDefaults] setBool:self.easyBtn.selected forKey:@"easySelected"];
//    }
//    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"normalSelected"])
//    {
//        [self normalClick:self.normalBtn];
//        [[NSUserDefaults standardUserDefaults] setBool:self.normalBtn.selected forKey:@"normalSelected"];
//    }
//    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hardSelected"])
//    {
//        [self hardClick:self.hardBtn];
//        [[NSUserDefaults standardUserDefaults] setBool:self.hardBtn.selected forKey:@"hardSelected"];
//    }
//    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"key88Selected"])
//    {
//        [self key88Click:self.key88Btn];
//        [[NSUserDefaults standardUserDefaults] setBool:self.key88Btn.selected forKey:@"key88Selected"];
//    }
//    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"key37Selected"])
//    {
//        [self key37Click:self.key37Btn];
//        [[NSUserDefaults standardUserDefaults] setBool:self.key37Btn.selected forKey:@"key37Selected"];
//    }
}

@end
