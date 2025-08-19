pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script{
                    git "https://github.com/interludevinay/CI-CD-Terraform-Infra.git"
                    }
                }
            }
        stage('Plan') {
            steps {
                sh 'pwd'
                sh 'ls'
            }
        }
        }
    }



