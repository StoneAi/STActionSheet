# STActionSheet #
此项目主要用于给到用户良好的二次确认体验.
## 用法说明#
/**<br />
ActionSheet 展示,通过titlestring 来辨别有无headview <br />
@param titleSting headview的文字描述 可为nil<br />
@param titles 按键文字描述数组 不需要加入取消按钮<br />
@param imageArray 图片名字数组 可为nil<br />
@param colors 文字颜色数组 为为nil<br />
@param clickBlock 回调 从0开始<br />
@return <#return value description#><br />
*/<br />
-(instancetype)initWithTitleString:(NSString *)titleSting WithTitles:(NSArray *)titles WithImageArray:(NSArray *)imageArray WithColors:(NSArray *)colors clickAction:(STClickBlock)clickBlock;
