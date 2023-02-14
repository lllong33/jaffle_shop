raw_payments -> stg_payments 过程? 

macro 调试方式
- 这里return(results_list) 加了一对[], 导致无法被遍历; 
- 通过log(), 编译后的sql文件


jinja 怎么实现的 list 去重? 直接在sql里面 distinct 处理了


comment方式通过/**/
-- 代码中间避免注释


return 语法怎么用


jinja 文档: https://docs.getdbt.com/reference/dbt-jinja-functions

set 不能放在macro外面
jinja2 string format : https://stackoverflow.com/questions/35183744/jinja2-format-join-the-items-of-a-list



增量限制:
{{ this }} 获取当前查询目标表



