pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script{
                        dir("terraform"){
                            git "https://github.com/interludevinay/CI-CD-Terraform-Infra.git"
                        }
                    }
                }
            }
        stage('Plan') {
            steps {
                sh 'pwd;cd terraform/ ; ls'
                sh 'ls'
            }
        }
        }
    }



