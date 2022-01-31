pipeline {
    agent any
    stages {
        stage('Compile') {
            steps {
                withMaven {
                    sh 'mvn clean compile'
                }
            }
        }
        stage('Run tests') {
            steps {
                withMaven {
                    sh 'mvn test -Dtest=!academy.softserve.eschool.*.*IntegrationTest'
                }
            }
        }
        stage('Build') {
            options {
              azureKeyVault([
                                [envVariable: 'DB_URL', name: 'eschool-db-url-fs', secretType: 'Secret'],
                                [envVariable: 'DB_USER', name: 'eschool-db-username', secretType: 'Secret'],
                                [envVariable: 'DB_PASS', name: 'eschool-db-password', secretType: 'Secret'],
                                [envVariable: 'LB_ADMIN_NAME', name: 'liquibase-admin-name', secretType: 'Secret'],
                                [envVariable: 'LB_ADMIN_PASS', name: 'liquibase-admin-password', secretType: 'Secret'],
                                [envVariable: 'PASSWORD_ENC_KEY', name: 'password-encoding-key', secretType: 'Secret']
              ])
            }
            steps {
                sh '''
                    sed -i -r -e "
                    s|(DATASOURCE_URL:).*(\\})|\\1$DB_URL\\2|
                    s|(DATASOURCE_USERNAME:).*(\\})|\\1$DB_USER\\2|
                    s|(DATASOURCE_PASSWORD:).*(\\})|\\1$DB_PASS\\2|
                    s|(ADMIN_USERNAME:).*(\\})|\\1$LB_ADMIN_NAME\\2|
                    s|(ADMIN_PASSWORD:).*(\\})|\\1$LB_ADMIN_PASS\\2|
                    s|(LOGGING_PATH:).*(\\})|\\1$LOG_PATH\\2|
                    s|(logging.level.academy.softserve.eschool=).*|\\1$LOG_LVL|
                    s|(PASSWORD_ENCODING_KEY:).*(\\})|\\1$PASSWORD_ENC_KEY\\2|
                    s|(ESCHOOL_APP_HOST:).*(\\})|\\1$APP_HOST\\2|" ./src/main/resources/application.properties
                '''
                withMaven {
                    sh 'mvn package -Dmaven.test.skip=true'
                }
            }
        }
    }
}