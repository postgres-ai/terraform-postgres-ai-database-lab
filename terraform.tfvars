dle_version = "2.5.0"  # it is also possible to use branch name here (e.g., "master")
joe_version = "0.10.0"

aws_ami_name = "DBLABserver*"

aws_deploy_region = "us-east-1"
aws_deploy_ebs_availability_zone = "us-east-1a"
aws_deploy_ec2_instance_type = "c5.large"
aws_deploy_ec2_instance_tag_name = "DBLABserver-ec2instance"
aws_deploy_ebs_size = "10"
aws_deploy_ebs_type = "gp2"
aws_deploy_ec2_volumes_count = "2"
#aws_deploy_ec2_volumes_names = ["/dev/xvdf", "/dev/xvdg",]
aws_deploy_allow_ssh_from_cidrs = ["0.0.0.0/0"]
aws_deploy_dns_api_subdomain = "tf-test" # subdomain in aws.postgres.ai, fqdn will be ${dns_api_subdomain}.aws.postgres.ai

source_postgres_version = "13"
source_postgres_host = "ec2-3-215-57-87.compute-1.amazonaws.com"
source_postgres_port = "5432"
source_postgres_dbname = "d3dljqkrnopdvg" # this is an existing DB (Heroku example DB)
source_postgres_username = "bfxuriuhcfpftt" # in secret.tfvars, use:   source_postgres_password = "dfe01cbd809a71efbaecafec5311a36b439460ace161627e5973e278dfe960b7" 

dle_debug_mode = "true"
dle_retrieval_refresh_timetable = "0 0 * * 0"
postgres_config_shared_preload_libraries = "pg_stat_statements,logerrors" # DB Migration Checker requires logerrors extension

platform_project_name = "aws_test_tf"

# Edit this list to have all public keys that will be placed to 
# have them placed to authorized_keys. Instead of ssh_public_keys_files_list,
# it is possible to use ssh_public_keys_list containing public keys as text values.
ssh_public_keys_files_list = ["~/.ssh/id_rsa.pub"]
