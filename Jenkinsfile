pipeline {
    agent any
    tools {
        // 这里的 'JDK17' 要和你Jenkins全局工具配置里的JDK安装名称完全一致
        jdk 'JDK17'
        // 如果用Maven构建，这里指定你配置的Maven工具名，比如 'Maven3'
        maven 'Maven-3.10.0'
    }
    environment {
        // 指定构建产物输出目录，也可以自定义
        BUILD_OUTPUT_DIR = 'target'
        DOCKER_IMAGE_NAME = "messaging-redis"
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
        }
    stages {
        stage('拉取代码') {
            steps {
                checkout scm
                echo "成功拉取 messaging-redis 项目最新代码"
            }
        }
        stage('清理构建环境') {
            steps {
                sh 'mvn clean'
                // Windows 环境下把上面的 sh 替换成 bat，即 bat 'mvn clean'
            }
        }
        stage('执行项目打包') {
            steps {
                sh 'mvn package -Dmaven.test.skip=true'
                // 跳过单元测试执行打包，如果需要执行测试去掉-Dmaven.test.skip=true即可
            }
        }
        stage('归档构建产物') {
            steps {
                archiveArtifacts artifacts: "${BUILD_OUTPUT_DIR}/*.jar", fingerprint: true
                echo "打包完成，Jar包已归档到Jenkins任务产物中,cheer!"
            }
        }
        stage('构建 Docker 镜像') {
                        steps {
                            script {
                                // 3. Docker 负责封装
                                // 注意：这里的 '.' 表示当前目录，Docker 会读取当前目录下的 Dockerfile
                                // 并且由于 Dockerfile 中写了 COPY target/*.jar，所以 target 目录必须在构建上下文中
                                sh """
                                    docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .
                                """
                            }
                        }
            }
    }
    post {
        success {
            echo "messaging-redis 项目 Pipeline 打包全部流程执行成功"
        }
        failure {
            echo "打包流程执行失败，请查看日志排查问题"
        }
    }
}
