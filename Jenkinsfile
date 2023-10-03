pipeline {
    agent any

    environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
  }
    stages {
        stage('Run terraform') {
            steps {
                // Terraform init
		
                sh 'terraform destroy --var-file lab2.tfvars -lock=false --auto-approve'
            }
        }

    }
}
