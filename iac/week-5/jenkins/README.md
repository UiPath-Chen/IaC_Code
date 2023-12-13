### 配置cloudflare的prefix
* 在terraform 的variables.tf的变量prefix中修改为个性化的prefix，每个人都不一样


### 配置github的person-access-tokens
* variables.tf
* 建议通过定义环境变量TF_VAR_，而不是直接在variables.tf中显示指定git's token