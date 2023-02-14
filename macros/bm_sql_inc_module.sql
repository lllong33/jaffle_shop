
/*
inc_flag = 1/0 True/False 增全量切换
inc_typ = d/m/y day/mo/yr 日月年粒度
inc_range = 0-31/1-12/1-x
add_column # 新增列
*/

{% macro bm_sql_inc_module(table_name, inc_flag, inc_typ, inc_range, add_column) %}

-- base_col
{% if inc_typ in ['d', 'day'] %}
{% set base_col = "t.this_day as stat_dt" %}
{% set inc_typ2 = "and t.month>=from_unixtime(cast(now()-interval %s day as bigint),'yyyyMMdd')".format(inc_range) %}
{% elif inc_typ in ['m', 'mo', 'month'] %}
{% set base_col = "t.month as stat_mo" %}
{% set inc_typ2 = "and t.month>=from_unixtime(cast(now()-interval %s month as bigint),'yyyyMM')".format(inc_range) %}
{% elif inc_typ in ['y', 'yr', 'year'] %}
{% set base_col = "t.year as stat_yr" %}
{% set inc_typ2 = "and t.month>=from_unixtime(cast(now()-interval %s year as bigint),'yyyy')".format(inc_range) %}
{% endif %}

-- base where
{% if inc_flag in ['1', '增量', 'incremental', 'inc'] %}
{% set base_where = "where t.this_day<=from_unixtime(unix_timestamp(),'yyyyMMdd') %s ".format(inc_typ2) %}
{% else %}
{% set base_where = "where t.this_day<=from_unixtime(unix_timestamp(),'yyyyMMdd')" %}
{% endif %}

-- 日粒度 stat_dt, 月 stat_mo, 年 stat_yr 
{% set inc_module = """drop table if exists temp.%s_inc;
create table temp.%s_inc STORED AS parquet as 
select distinct 
    %s
from dw.dim_day  t
%s
;"""  | format(table_name, table_name, base_col, base_where) %}

{{ log(inc_module, info=False) }}

{{ return(inc_module) }}

{% endmacro %}

