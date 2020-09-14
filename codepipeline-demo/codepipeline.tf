#
# codepipeline - demo
#
resource "aws_codepipeline" "demo" {
  name     = "demo-docker-pipeline"
  role_arn = aws_iam_role.demo-codepipeline.arn # All roles defined in iam-*.tf files
   # role_arn = all the roles and policies necessary to read from git; exec a deploy etc. 
  artifact_store { # every artifact S3 is encrypted with kms ( key mgmt svvcs ) 
    location = aws_s3_bucket.demo-artifacts.bucket
    type     = "S3" 
    encryption_key { # 
      id   = aws_kms_alias.demo-artifacts.arn
      type = "KMS"
    }
  }


#####################################################################
#                                                                   #
#   The three stages of our pipeline 1. source 2. build 3. deploy   #
#                                                                   #
#####################################################################


  stage {
    name = "Source" # See documentation to figure out values for each key below. 

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["demo-docker-source"] # this is where the encrypted artifact is stored. 

      configuration = {
        RepositoryName = aws_codecommit_repository.demo.repository_name
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["demo-docker-source"] # zip file with build artifacts. 
      output_artifacts = ["demo-docker-build"]
      version          = "1"

      configuration = { # this requires we define an aws codebuild project in tf where we can store our config 
        ProjectName = aws_codebuild_project.demo.name # of build coponents. Typically this file is buildspec.yaml
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["demo-docker-build"]
      version         = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.demo.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.demo.deployment_group_name
        TaskDefinitionTemplateArtifact = "demo-docker-build"
        AppSpecTemplateArtifact        = "demo-docker-build"
      }
    }
  }
}


