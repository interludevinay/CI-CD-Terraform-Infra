pipeline {
    agent any
    stages {
        stage('View') {
            steps {
                sh 'pwd'
                sh 'ls'
            }
        }
        stage('Plan') {
            steps {
                sh 'pwd; terraform init'
                sh "pwd; terraform validate"
                sh 'pwd; terraform plan'
            }
        }
    }
}



