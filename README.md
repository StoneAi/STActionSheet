# STActionSheet
此项目主要用于给到用户良好的二次确认体验.
#1
/**
ActionSheet 展示,通过titlestring 来辨别有无headview

@param titleSting headview的文字描述 可为nil
@param titles 按键文字描述数组 不需要加入取消按钮
@param imageArray 图片名字数组 可为nil
@param colors 文字颜色数组 为为nil
@param clickBlock 回调 从0开始
@return <#return value description#>
*/
-(instancetype)initWithTitleString:(NSString *)titleSting WithTitles:(NSArray *)titles WithImageArray:(NSArray *)imageArray WithColors:(NSArray *)colors clickAction:(STClickBlock)clickBlock;
