-- --------------------------------
-- Drop everything
-- --------------------------------

use role accountadmin;
drop database if exists raw cascade;
drop database if exists analytics cascade;
drop warehouse if exists loading cascade;
drop warehouse if exists transforming cascade;
drop warehouse if exists reporting cascade;
drop role if exists loader;
drop role if exists transformer;
drop role if exists reporter;

-- --------------------------------
-- Create everything
-- --------------------------------

-- use role accountadmin;
use role sysadmin;

create database raw;
create schema dbt_mr;
create database analytics;

create warehouse loading
    warehouse_size = xsmall
    auto_suspend = 3600
    auto_resume = false
    initially_suspended = true;

create warehouse transforming
    warehouse_size = xsmall
    auto_suspend = 60
    auto_resume = true
    initially_suspended = true;

create warehouse reporting
    warehouse_size = xsmall
    auto_suspend = 60
    auto_resume = true
    initially_suspended = true;

-- Create Roles
use role securityadmin;

create role loader;
create role transformer;
create role reporter;

-- Grant Warehouse privileges to Roles
grant all on warehouse loading to role loader; 
grant all on warehouse transforming to role transformer;
grant all on warehouse reporting to role reporter;

-- Grant Database privileges to Roles
-- use role sysadmin;
use role securityadmin;

grant all on database raw to role loader;

grant usage on database raw to role transformer;
grant usage on future schemas in database raw to role transformer;
grant select on future tables in database raw to role transformer;
grant select on future views in database raw to role transformer;

grant usage on all schemas in database raw to role transformer;
grant select on all tables in database raw to role transformer;
grant select on all views in database raw to role transformer;

grant all on database analytics to role transformer;

grant usage on database analytics to role reporter;
grant usage on future schemas in database analytics to role reporter;
grant select on future tables in database analytics to role reporter;
grant select on future views in database analytics to role reporter;

grant usage on all schemas in database analytics to role reporter;
grant select on all tables in database analytics to role transformer;
grant select on all views in database analytics to role transformer;

-- Create users, assigning them to their roles

-- create user stitch_user -- or fivetran_user
--     password = '_generate_this_'
--     default_warehouse = loading
--     default_role = loader; 

-- create user claire -- or amy, jeremy, etc.
--     password = '_generate_this_'
--     default_warehouse = transforming
--     default_role = transformer
--     must_change_password = true;

-- create user dbt_cloud_user
--     password = '_generate_this_'
--     default_warehouse = transforming
--     default_role = transformer;

-- create user looker_user -- or mode_user etc.
--     password = '_generate_this_'
--     default_warehouse = reporting
--     default_role = reporter;
