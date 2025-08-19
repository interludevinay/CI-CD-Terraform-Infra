pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git "https://github.com/interludevinay/CI-CD-Terraform-Infra.git"
                    }
                }
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                sh 'pwd;cd terraform/ ; terraform init'
                sh 'pwd;cd terraform/ ; terraform validate'
                sh 'pwd;cd terraform/ ; terraform plan'
            }
        }
    }
}



