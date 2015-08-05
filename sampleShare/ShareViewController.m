//
//  ShareViewController.m
//  sampleShare
//
//  Created by satoutakeshi on 2015/08/04.
//  Copyright (c) 2015年 satoutakeshi. All rights reserved.
//

#import "ShareViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    //現在の文字数を表示する
    self.charactersRemaining = @(self.contentText.length);
    
    //1文字以上入力されている場合のみ投稿できるようにする
    if (self.contentText.length > 0) {
        return YES;
    }
    
    return NO;
}

- (void)didSelectPost {
    // 今回は共有するコンテンツがURL1つに制限していると仮定する
    // 共有するコンテンツを取り出す
    NSExtensionItem *inputItem = self.extensionContext.inputItems.firstObject;
    NSItemProvider *urlItemProvider = inputItem.attachments.firstObject;
    
    
    
    // URLを取り出す
    if ([urlItemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeURL])
    {
        [urlItemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypeURL
                                           options:nil
                                 completionHandler:^(NSURL *url, NSError *error) {
                                     // kUTTypeURLの場合itemはNSURLクラスで渡される
                                     if (!error) {
                                         
                                         // ここでなんらかのサービスに投稿する処理をする
                                         
                                         // 投稿に成功したら、必要に応じて実際に投稿したアイテムをこのExtenstionを呼び出したホストアプリに伝える
                                         NSExtensionItem *outputItem = [inputItem copy];
                                         outputItem.attributedContentText = [[NSAttributedString alloc] initWithString:self.contentText attributes:nil];
                                         
                                         NSArray *outputItems = @[outputItem];

                                         
                                         
                                         [self.extensionContext completeRequestReturningItems:outputItems completionHandler:nil];
                                         
                                     }
                                 }
         
         ];
    }
    
    
    //データ保存
    NSString *username = @"monoqlo";
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.personal-factory.sampleShareExtension"];
    [sharedUserDefaults setObject:username forKey:@"username"];
    
    
}
- (NSArray *)configurationItems {
    
    SLComposeSheetConfigurationItem *configurationItem = [[SLComposeSheetConfigurationItem alloc] init];
    
    // カラムの左側に表示されるタイトル
    configurationItem.title = @"アカウント";
    
    // 右側に表示されるデフォルト値（現在選択されている値）
    configurationItem.value = @"サトウアカウント";
    
    // アカウント選択等をさせる場合、SLComposeSheetConfigurationItemのtapHandlerに
    // ViewControllerをつくり、そして表示させるブロックを渡す
    // デフォルトではUINavigationControllerで画面遷移して表示される
    configurationItem.tapHandler = ^(void){
        // 適当なViewControllerを渡す
        UIViewController *viewController = [[UIViewController alloc] init];
        [self pushConfigurationViewController:viewController];
    };
    
    return @[configurationItem];
}


@end
