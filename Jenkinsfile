pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script{
                        dir("terraform")
                        {
                            git clone "https://github.com/yeshwanthlm/Terraform-Jenkins.git"
                        }
                    }
                }
            }
        }
    }
}



