pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', credentialsId: 'eya-github-creds', url: 'https://github.com/eya-cfu/devops-project.git'

                // Run Maven.
                sh "mvn compile"
            }
        }
        stage('JUnit tests') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean test"
            }
            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
        stage('SQ Analysis') {
            steps {
                sh "mvn verify sonar:sonar -Dsonar.login=1556bd29928aa0a5425e292317edc770a50b7b5b"
            }
        }
        stage('Nexus Deploy') {
            steps {
                sh "mvn clean deploy -Dmaven.test.skip=true"
            }
        }
    }
}
