pipeline {
    agent any
    environment {
    TEST_HOST = ${params.HOST}
        TEST_USER = ${params.USER_NAME}
        TEST_PASS = ${params.USER_PASS}
    }

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                echo "Deploying Ceph Node Pre-reqs on: $TEST_HOST"
                 sh '''#!/usr/bin/env bash
                ssh $TEST_USER@$TEST_HOST -pw $TEST_PASS cat /root/test_jenkins
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        
    }
}
