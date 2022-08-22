# Allow bundler to authenticate with Artifactory. Note that this is handled by the Clio 'dev' tool on local environments
export BUNDLE_CLIO__JFROG__IO="${ARTIFACTORY_USERNAME}:${ARTIFACTORY_API_KEY}"
