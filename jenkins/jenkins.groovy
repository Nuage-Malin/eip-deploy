job("Front") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_FRONT", 'ssh')
                credentials('eip_front')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/front.sh')
    }
}
job("Users Back") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_USERS_BACK", 'ssh')
                credentials('users_back')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/users-back.sh')
    }
}
job("Maestro") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_MAESTRO", 'ssh')
                credentials('maestro')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/maestro.sh')
    }
}
job("Chouf") {
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_CHOUF", 'ssh')
                credentials('chouf')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/chouf.sh')
    }
}