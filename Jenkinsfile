pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }
    stages {
        stage('Clone') {
            steps {
                echo "Cloning code..."
            }
        }

        stage('Docker Image'){
            steps{
                sh "docker --version"
               sh "docker image -t flask-todo-app:latest ."
            }
        }

        stage('Docker Image Push To DockerHub'){
            steps{
                echo "Pushing image to DockerHub"
                withCredentials([usernamePassword('credentialsId':"dockerHubCred",
                passwordVariable:"dockerHubPass",
                usernameVariable:"dockerHubUser")]){
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker image tag flask-todo-app:latest ${env.dockerHubUser}/flask-todo-app:latest"
                    sh "docker push ${env.dockerHubUser}/flask-todo-app:latest"
                }
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

        stage('SSH to EC2 and Run container') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${env.EC2_IP} '
                        set -e
                        echo "⏳ Waiting for EC2 to be ready..."
                        sleep 40

                        docker pull interludevinay/flask-todo-app:latest
                        docker run -d --name=flask-app -p 5000:5000 flask-todo-app:latest
                        
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
