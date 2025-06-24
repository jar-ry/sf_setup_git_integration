-- Use role, warehouse and data
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE DEMO_GIT;
USE SCHEMA INTEGRATIONS;

-- Create git repo
CREATE GIT REPOSITORY snowflake_notebook_git_demo 
 ORIGIN = 'https://github.com/jar-ry/sfguide-getting-started-with-snowflake-notebook-container-runtime' 
 API_INTEGRATION = 'GIT_INTEGRATION';

-- Create external access to all
 CREATE NETWORK RULE allow_all_rule
  TYPE = 'HOST_PORT'
  MODE= 'EGRESS'
  VALUE_LIST = ('0.0.0.0:443','0.0.0.0:80');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION allow_all_integration
  ALLOWED_NETWORK_RULES = (allow_all_rule)
  ENABLED = true;

-- Create external access to Pip
CREATE OR REPLACE NETWORK RULE pypi_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org',  'files.pythonhosted.org');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION pypi_access_integration
  ALLOWED_NETWORK_RULES = (pypi_network_rule)
  ENABLED = true;
