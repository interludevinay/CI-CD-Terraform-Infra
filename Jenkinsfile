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
        stage('Get EC2 Public IP') {
            steps {
                script {
                    def ec2_ip = sh(
                        script: "terraform output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()
                    
                    env.EC2_IP = ec2_ip
                    echo "✅ EC2 Public IP: ${ec2_ip}"
                    }
                }
            }
        }
}




