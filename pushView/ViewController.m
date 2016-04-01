//
//  ViewController.m
//  pushView
//
//  Created by BingoMacMini on 16/3/31.
//  Copyright © 2016年 BingoMacMini. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "fristCell.h"
#import "secondCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView1;
@property (nonatomic,strong) UITableView *tableView2;


@property (nonatomic,assign) NSInteger numRow;
@property (nonatomic,assign) NSInteger topMargin;

@property (assign) BOOL isOpen;


@end

@implementation ViewController


- (UITableView *)tableView1{
    if (!_tableView1) {
        _tableView1 = [UITableView new];
        
        self.tableView1.delegate = self;
        self.tableView1.dataSource = self;
        
        [self.tableView2 addSubview:self.tableView1];
        
        
        [self.tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.bottomMargin.mas_equalTo(self.view);
            make.top.mas_equalTo(self.topMargin);

     
                    }];
        

        [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView1;
}

- (UITableView *)tableView2{
    if (!_tableView2) {
       
        _tableView2 = [UITableView new];
        
        self.tableView2.delegate = self;
        self.tableView2.dataSource = self;
        
        
        [self.view addSubview:self.tableView2];
       
        self.tableView2.frame = self.view.bounds;
        

        [self.tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
        

   
    }
    
    return _tableView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.topMargin = self.view.bounds.size.height-30;
    
    self.topMargin = self.view.bounds.size.height-30;
   



    self.view.backgroundColor = [UIColor grayColor];
    self.tableView2.backgroundColor = [UIColor whiteColor];
    self.tableView1.backgroundColor = [UIColor whiteColor];
    
    
    
    
    self.isOpen = NO;
   
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- tableViewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView1]) {
        return 15;
    }else if([tableView isEqual:_tableView2]){
        
        return self.numRow;
    }
    
    return 0;
}



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableView1]) {
         fristCell *cell = [self.tableView1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
         cell.backgroundColor = [UIColor blackColor];
         cell.textLabel.text = @"推出";
         cell.textLabel.textColor = [UIColor whiteColor];
        
       
        return cell;
    
    
       
    
    } else if ([tableView isEqual:self.tableView2]) {
        
        secondCell  *cell2 = [self.tableView2 dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
  
                 cell2.textLabel.text = @"推出123";
                 cell2.textLabel.textColor = [UIColor redColor];
        cell2.backgroundColor = [UIColor yellowColor];
        
   
        
               return cell2;
    }
    
  
    
    
   
    
    return nil;
    
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isEqual:self.tableView1]){
        
        return UITableViewAutomaticDimension;
    }else if([self isEqual:self.tableView2]){
       
        return UITableViewAutomaticDimension;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if ([tableView isEqual:self.tableView1]) {
        return 40;
    }else if ([tableView isEqual: self.tableView2]){
        
        return 50;
        
    }
    

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    if ([tableView isEqual:self.tableView1]) {
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blackColor];
        
        UIButton *button = [UIButton buttonWithType:0];
        [button setTitle:@"其他成员" forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTintColor:[UIColor whiteColor]];
        
        [button addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        
        return view;

        
    }else if ([tableView isEqual: self.tableView2]){
        
        return nil;
        
    }
    
    
    return nil;
    
    
    
}




- (void)pushView:(UIButton *)sender{
    
    self.isOpen = !self.isOpen;
    
    if (self.isOpen == YES) {
        self.numRow = 10;
        self.topMargin = self.view.bounds.size.height-200;

        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.type = @"cube";
        [self.tableView1.layer addAnimation:animation forKey:nil];
            [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
 
                     make.top.mas_equalTo(self.topMargin);
            }];
        [self.tableView1 reloadData];
    }else{
        self.numRow = 0;
        self.topMargin = self.view.bounds.size.height-30;
        CATransition *animation = [CATransition animation];
        animation.duration = 1;
        animation.type = kCATransitionFade ;
        [self.tableView1.layer addAnimation:animation forKey:nil];
        [self.tableView1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.topMargin);
        }];
        [self.tableView1 reloadData];
    }
    
}

@end
