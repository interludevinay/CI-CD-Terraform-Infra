pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
    }
    stages {
        stage('View') {
            steps {
                sh 'pwd'
                sh 'ls'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform init -upgrade'
                sh 'terraform plan'
                
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
        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${env.EC2_IP} '
                            sudo apt-get update -y &&
                            sudo apt install nginx -y &&
                            sudo systemctl start nginx &&
                            sudo systemctl enable nginx
        
                        '
                    """
                }
            }
        }

        }
}




