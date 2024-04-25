pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Checkout the code from Git
                checkout scm
                
                // Build Docker image
                script {
                    docker.build("jest-junit-reporter")
                }
            }
        }
        
        stage('Test') {
            steps {
                // Run tests inside Docker container
                script {
                    docker.image("jest-junit-reporter").inside {
                        sh 'npm test'
                    }
                }
            }
        }
        
        stage('Generate Report') {
            steps {
                // Generate JUnit test report
                script {
                    docker.image("jest-junit-reporter").inside {
                        sh 'npm run test:report'
                    }
                }
                
                // Archive JUnit test report
                junit 'test-report/*.xml'
            }
        }
    }
}
