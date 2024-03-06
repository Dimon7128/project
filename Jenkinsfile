pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                gitlab branch: 'master', credentialsId: 'gitlab-credentials', url: 'git@gitlab.com:your_repo.git'
            }
        }
        stage('Terraform Init and Plan') {
            steps {
                sh 'terraform init'
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                input(message: "Apply Terraform changes?", ok: "Apply")
                sh 'terraform apply -auto-approve'
            }
        }
    }
    post {
        always {
            // Add any cleanup or notification steps here
        }
    }
}
