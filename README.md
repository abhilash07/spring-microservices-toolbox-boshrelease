# BOSH Release for spring-microservices-toolbox




## Purpose

The purpose of this bosh release is to offer some preconfigured Spring Cloud components, for use in Bosh / Cloudfoundry operations.
http://projects.spring.io/spring-cloud/

The idea is to ease bosh ops activities, providing them usefull features of Spring Cloud / Spring Cloud Foundry, in a bosh standard way (manifest, errand, etc ..)


### Oauth Gateway Errand

Create a space, route and cf application to offer a secure Oauth2 front end to an internal bosh deployment backend.

prerequisite:
* a Oauth Client Id, with scope=openid (configured with uaa, or from cloudfoundry UAA manifest)
* org admin privileged, to create the space and route

Leverages:
* Spring Cloud Zuul, http://cloud.spring.io/spring-cloud-netflix/
* Spring Cloud Security, enabling UAA Oauth login, http://cloud.spring.io/spring-cloud-security/



### Spring Cloud Sleuth Zipkin

https://gitlab.com/dsyer/spring-cloud-sleuth/tree/master/spring-cloud-sleuth-zipkin-stream
https://spring.io/blog/2016/02/15/distributed-tracing-with-spring-cloud-sleuth-and-spring-cloud-zipkin
https://programmaticponderings.wordpress.com/2016/02/15/diving-deeper-into-getting-started-with-spring-cloud/


prerequisite:
* a cloudfoundry org admin account
* marketplace with mysql and rabbitmq services



## Usage

To use this bosh release, first upload it to your bosh:

```
bosh target BOSH_HOST
git clone https://github.com/cloudfoundry-community/spring-microservices-toolbox-boshrelease.git
cd spring-microservices-toolbox-boshrelease
bosh upload release releases/spring-microservices-toolbox-1.yml
```

For [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy a cluster:

```
templates/make_manifest warden
bosh -n deploy
```

For AWS EC2, create a single VM:

```
templates/make_manifest aws-ec2
bosh -n deploy
```

### Override security groups

For AWS & Openstack, the default deployment assumes there is a `default` security group. If you wish to use a different security group(s) then you can pass in additional configuration when running `make_manifest` above.

Create a file `my-networking.yml`:

``` yaml
---
networks:
  - name: spring-microservices-toolbox1
    type: dynamic
    cloud_properties:
      security_groups:
        - spring-microservices-toolbox
```

Where `- spring-microservices-toolbox` means you wish to use an existing security group called `spring-microservices-toolbox`.

You now suffix this file path to the `make_manifest` command:

```
templates/make_manifest openstack-nova my-networking.yml
bosh -n deploy
```

### Development

As a developer of this release, create new releases and upload them:

```
bosh create release --force && bosh -n upload release
```

### Final releases

To share final releases:

```
bosh create release --final
```

By default the version number will be bumped to the next major number. You can specify alternate versions:


```
bosh create release --final --version 2.1
```

After the first release you need to contact [Dmitriy Kalinin](mailto://dkalinin@pivotal.io) to request your project is added to https://bosh.io/releases (as mentioned in README above).
