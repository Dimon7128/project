pipeline {
	agent {
		label 'Agent_WeatherApp1'
	}
 // Update agent specifier based on your Jenkins configuration
    environment {
        AWS_CREDENTIALS = credentials('aws-credentials-id')
        AWS_DEFAULT_REGION    = 'us-west-3' // Replace with your AWS region
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/master']], // Use '*/master' if your default branch is master
                    userRemoteConfigs: [[
                        url: 'http://13.36.136.165/the_dimi_gang/infrastracture_terraform.git', 
                        credentialsId: '813dec95-17f9-4dd5-8485-ce61e0dccc0e'
                    ]]
                ])
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
            sh 'terraform apply -auto-approve'
    }
}
    }
    
    post {
        always {
            // Add any cleanup or  notification steps here, like terraform destroy or workspace cleanup
            echo 'Cleaning up...'
            sh 'terraform destroy -auto-approve'
        }
    }
}
