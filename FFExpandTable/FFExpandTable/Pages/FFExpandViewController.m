//
//  FFExpandViewController.m
//  FFExpandTable
//
//  Created by 张玲玉 on 16/8/17.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFExpandViewController.h"
#import "FFExpandModel.h"
#import "FFExpandFirstCell.h"
#import "FFExpandSecondCell.h"

#define kAnimation UITableViewRowAnimationNone

@interface FFExpandViewController ()

@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)NSIndexPath *selectIndex;
@property(nonatomic,assign)BOOL isOpen;

@end

@implementation FFExpandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor=[UIColor magentaColor];
    
    int count=50;
    self.modelArray=[NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++) {
        FFExpandModel *model=[[FFExpandModel alloc]init];
        [self.modelArray addObject:model];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isOpen && _selectIndex.section == section) {
        return 2;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isOpen && _selectIndex.section == indexPath.section && indexPath.row != 0) {
        static NSString *identifer=@"FFExpandFirstCell";
        FFExpandFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil) {
            cell=[[FFExpandFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        return cell;
    }
    else {
        static NSString *identifer=@"FFExpandSecondCell";
        FFExpandSecondCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil) {
            cell=[[FFExpandSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.model=self.modelArray[indexPath.section];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isOpen && _selectIndex.section == indexPath.section && indexPath.row != 0) {
        FFExpandModel *model=self.modelArray[indexPath.section];
        return model.secondCellHeight;
    }
    else {
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (_selectIndex==nil)
        {
            _isOpen=YES;
            _selectIndex = indexPath;
            NSIndexPath *insertRow = [NSIndexPath indexPathForRow:1 inSection:_selectIndex.section];
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[insertRow] withRowAnimation:kAnimation];
            [self.tableView endUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:insertRow.section]] withRowAnimation:UITableViewRowAnimationNone];
        }
        else if ([indexPath isEqual:_selectIndex])
        {
            _isOpen=NO;
            NSIndexPath *deleteRow = [NSIndexPath indexPathForRow:1 inSection:_selectIndex.section];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[deleteRow] withRowAnimation:kAnimation];
            [self.tableView endUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:deleteRow.section]] withRowAnimation:UITableViewRowAnimationNone];
            _selectIndex = nil;
        }
        else
        {
            _isOpen=NO;
            NSIndexPath *deleteRow = [NSIndexPath indexPathForRow:1 inSection:_selectIndex.section];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[deleteRow] withRowAnimation:kAnimation];
            [self.tableView endUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:deleteRow.section]] withRowAnimation:UITableViewRowAnimationNone];
            _selectIndex = nil;
            
            _isOpen=YES;
            _selectIndex = [self.tableView indexPathForSelectedRow];
            NSIndexPath *insertRow = [NSIndexPath indexPathForRow:1 inSection:_selectIndex.section];
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[insertRow] withRowAnimation:kAnimation];
            [self.tableView endUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:insertRow.section]] withRowAnimation:UITableViewRowAnimationNone];
        }
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

@end
