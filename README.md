# ACP Multipage Example App

This repository created the ACP Multipage Example App, which has been created for use in displaying the capabilities of using the Keycloak gatekeeper image in the [kube-example-app](https://github.com/UKHomeOffice/kube-example-app).

## Setup

### Build locally

To build the image locally, run:

```bash
docker build -t acp-multipage-example-app .
```

### Drone Build & Push

1. [Activate repository in Drone CI](https://github.com/UKHomeOffice/application-container-platform/blob/master/docs/how-to-docs/drone-how-to.md#activate-your-pipeline)
2. [Request for an Artifactory access token](https://github.com/UKHomeOffice/application-container-platform/blob/master/docs/how-to-docs/artifactory-token.md#create-an-artifactory-access-token). This is required to be able to push and pull images from [ACP Artifactory](https://artifactory.digital.homeoffice.gov.uk/artifactory/webapp/#/home)
3. Add the artifactory secret to Drone CI: `https://drone-gh.acp.homeoffice.gov.uk/<Group|Organisation>/<Repository>/settings` 
4. Update your `.drone.yml`, referencing the [name of the secret](https://github.com/UKHomeOffice/acp-multipage-example-app/blob/master/.drone.yml#L69)

The `.drone.yml` in the repo will:

- Build the image on a push to any branch
- Upload the image to Artifactory with the `latest` tag on a push to master
- Upload the image to Artifactory with specific tag on tag creation

## Dockerfile non-root user

within the ACP environments, all containers are enforced via PodSecurityPolicies to run with a non-root user. This is specified within the Dockerfile as follows:

```Dockerfile
# Create a non-root user and set file permissions
RUN addgroup -S app \
    && adduser -S -g app -u 1000 app \
    # you may need to remove this line, if the /app directory hasn't been created by the previous commands
    && chown -R app:app /app

# Run as the non-root user (specify UID rather than username)
USER 1000
```