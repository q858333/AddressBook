//
//  ViewController.m
//  FriendList
//
//  Created by DengBin on 15/12/16.
//  Copyright © 2015年 DB. All rights reserved.
//

#import "ViewController.h"
#import "Friend.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray  *friends;

@property(nonatomic,strong)NSMutableArray  *sections;

@property(nonatomic,strong)NSMutableArray  *indexs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self getData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void )getData
{
    UITableView  *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P", @"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#",nil];

    _friends  = [NSMutableArray array];
    
    for (int i = 0 ; i<20 ; i++)
    {
        Friend *friend = [[Friend alloc] init];
        
        friend.name = arr[arc4random()%10];
        friend.detail = [NSString stringWithFormat:@"%lf",arc4random()];
        [_friends addObject:friend];
        
        
    }
    
    [self getIndexListAndData];
    [tableView reloadData];
    
    
}
-(void)getIndexListAndData
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    
    _indexs = [NSMutableArray new];
    
    //每个对象纪录下section的位置
    for ( Friend *friend in _friends)
    {
        NSInteger sect = [theCollation sectionForObject:friend
                                collationStringSelector:@selector(getFirstName)];
        friend.section = sect;//记录下对象的section id
        
        
    }
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    
    
    for (int i=0; i<highSection; i++)
    {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    //吧对象添加到section对应的数组位置
    for (Friend *friend in _friends)
    {
        [(NSMutableArray *)[sectionArrays objectAtIndex:friend.section] addObject:friend];
        
        
    }
    
    self.sections=[[NSMutableArray alloc]init];
    
    int i = 0;
    //sectionArrays 有27个数组
    for (NSMutableArray *sectionArray in sectionArrays)
    {
        
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(getFirstName)];
                if (sortedSection.count>0)
                {
                    
                  [_sections addObject:sortedSection];
                    
                    if (![_indexs containsObject:theCollation.sectionTitles[i]])
                    {
                        [_indexs addObject:theCollation.sectionTitles[i]];
                        
                    }
                }
        i++;
    }
    
   // [_sections insertObject:[NSArray new] atIndex:0];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource &&  UITableViewDelegate
//去头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSArray *arr = _sections[section];
    
    if (arr.count>0)
    {
        return 15;
    }
    else
    {
        return 0.0001;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *friends =_sections[section];
    
    return friends.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *arr = _sections[indexPath.section];
    Friend *f = arr[indexPath.row];
    cell.textLabel.text =f.name;
    
 

    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *arr = _sections[section];
    
    
    
    if (arr.count>0)
    {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    else
    {
        return @"";
    }
    
    
  
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
   
    
}

//点击
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    return index;
    
   // NSLog(@"%@",[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles] );
    
    //return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];

}
//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return _indexs;
   // return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}
@end
