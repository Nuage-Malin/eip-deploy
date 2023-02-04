# Requirements

## Softwares
- **Docker :** 20.10.23
- **Docker Compose :** v2.15.1

## Files
### Environment variables
- **File :** *./.env*
    - *GIT_REPOSITORY_URL_FRONT*
    - *GIT_REPOSITORY_URL_USERS_BACK*
    - *GIT_REPOSITORY_URL_MAESTRO*
    - *GIT_REPOSITORY_URL_CHOUF*
- Those environment variables that must be added are the full repository names templated as `user-or-organisation-name/repository-name`.

### Jenkins users
- **File :** *./jenkins/users.yml*
- This is a YAML file with a ***users*** parent with an array of users as value.  
A user contains a ***name***, a ***password*** and an array of ***roles***.  
The available roles are :
    - Admin (full access)
    - Manager (Read, Build, Cancel jobs)
    - Developer (Read, Cancel jobs)
    - Visitor (Read jobs)

    <u>Exemple :</u>
    ```yaml
    users:
    - name: John Doe
        password: password_1
        roles:
        - Visitor
    - name: Jane Doe
        password: password_2
        roles:
        - Developer
    ```

### Secrets
- **File :** *./secrets/*
    - *nm_eip_front_ssh*
    - *nm_users_back_ssh*
    - *nm_protobuf_interfaces_ssh*
    - *nm_maestro_ssh*
    - *nm_chouf_ssh*
- *nm_\*_ssh* files are private SSH keys linked to public keys added to GitHub repositories as **Deploy keys**.  
This keys are used by Jenkins to pull there repositories.

# Startup

1. Start the docker compose
```shell
docker compose up --build
```
This will build and start the **Jenkins controller**, the **Jenkins Agent** and the **Docker registry**.  
The Jenkins Agent is the only one to run jobs. Jobs on the master node has been disabled.