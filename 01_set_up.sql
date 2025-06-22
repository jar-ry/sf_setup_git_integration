-- Step 1: Switch to ACCOUNTADMIN to create the role and assign privileges
USE ROLE ACCOUNTADMIN;

-- Create a dedicated database and warehouse
CREATE OR REPLACE DATABASE DEMO_GIT;

CREATE SCHEMA INTEGRATIONS;
 
CREATE OR REPLACE SECRET my_git_secret
  TYPE = password
  USERNAME = 'jar-ry'
  PASSWORD = '';

-- Create git integration
create or replace api integration git_integration
    api_provider = git_https_api
    api_allowed_prefixes = ('https://github.com/jar-ry')
    enabled = true
    allowed_authentication_secrets = (my_git_secret)
    comment='Git integration for jar-ry';

CREATE GIT REPOSITORY snowflake_notebook_git_demo 
 ORIGIN = 'https://github.com/jar-ry/sfguide-getting-started-with-snowflake-notebook-container-runtime' 
 API_INTEGRATION = 'GIT_INTEGRATION';

-- Create external access to all
--  CREATE NETWORK RULE allow_all_rule
--   TYPE = 'HOST_PORT'
--   MODE= 'EGRESS'
--   VALUE_LIST = ('0.0.0.0:443','0.0.0.0:80');

-- CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION allow_all_integration
--   ALLOWED_NETWORK_RULES = (allow_all_rule)
--   ENABLED = true;

-- Create external access to Pip
CREATE OR REPLACE NETWORK RULE pypi_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org',  'files.pythonhosted.org');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION pypi_access_integration
  ALLOWED_NETWORK_RULES = (pypi_network_rule)
  ENABLED = true;
