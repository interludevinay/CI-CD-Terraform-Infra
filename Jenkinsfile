pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
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
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform init -upgrade'
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                }
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
                            set -e
                            sudo apt-get update -y
                            sudo apt-get install -y nginx
                            sudo systemctl start nginx
                            sudo systemctl enable nginx
                            echo "Terraform creation is successful" | sudo tee /var/www/html/index.html
                        '
                    """
                }
            }
        }

        stage('Destroy Approval') {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        input message: 'Do you want to destroy the created resources?', ok: 'Yes, Destroy'
                    }
                }
            }
        }

        stage('Destroy Resources') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
