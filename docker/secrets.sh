#!/bin/bash
if [ "$GKE_CLUSTER" = "prod" ]; then
    gcloud container clusters get-credentials gcc-prod --zone us-central1-a --project numeric-scope-320318
fi

if [ "$GKE_CLUSTER" = "uat" ]; then
    gcloud container clusters get-credentials gcc-uat --zone us-central1-a --project numeric-scope-320318
fi

if [ "$SET_ENV_VARS_FOR_SLIC_WEB_APP" = true ]; then
    echo "Configuring environment variables for slic-web-app"
    kubectl set env deployment/$DEPLOYMENT_NAME_WEB_APP -n $NAMESPACE_WEB_APP NEXT_PUBLIC_API_URI=`gcloud secrets versions access latest --secret=slic-web-app | grep NEXT_PUBLIC_API_URI | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_WEB_APP -n $NAMESPACE_WEB_APP NEXT_PUBLIC_GOOGLE_ANALYTICS_ID=`gcloud secrets versions access latest --secret=slic-web-app | grep NEXT_PUBLIC_GOOGLE_ANALYTICS_ID | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_WEB_APP -n $NAMESPACE_WEB_APP NODE_ENV=`gcloud secrets versions access latest --secret=slic-web-app | grep NODE_ENV | cut -d= -f2-`
    kubectl scale deployment/$DEPLOYMENT_NAME_WEB_APP -n $NAMESPACE_WEB_APP --replicas=0
    kubectl scale deployment/$DEPLOYMENT_NAME_WEB_APP -n $NAMESPACE_WEB_APP --replicas=1
fi

if [ "$SET_ENV_VARS_FOR_SLIC_WEB_APP" = false ]; then
    echo "Environment variables for slic-web-app not configured"
fi

if [ "$SET_ENV_VARS_FOR_SLIC_API" = true ]; then
    echo "Configuring environment variables for slic-api"
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API HOST=`gcloud secrets versions access latest --secret=slic-api | grep HOST | cut -d= -f2- | head -1`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API PORT=`gcloud secrets versions access latest --secret=slic-api | grep PORT | cut -d= -f2- | head -1`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_HOST=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_HOST | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_SRV=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_SRV | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_PORT=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_PORT | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_NAME=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_NAME | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_USERNAME=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_USERNAME | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_PASSWORD=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_PASSWORD | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API AUTHENTICATION_DATABASE=`gcloud secrets versions access latest --secret=slic-api | grep AUTHENTICATION_DATABASE | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API DATABASE_SSL=`gcloud secrets versions access latest --secret=slic-api | grep DATABASE_SSL | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API SENDGRID_API_KEY=`gcloud secrets versions access latest --secret=slic-api | grep SENDGRID_API_KEY | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API SENDGRID_DEFAULT_FROM=`gcloud secrets versions access latest --secret=slic-api | grep SENDGRID_DEFAULT_FROM | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API SENDGRID_DEFAULT_REPLAYTO=`gcloud secrets versions access latest --secret=slic-api | grep SENDGRID_DEFAULT_REPLAYTO | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API GCP_BUCKET_NAME=`gcloud secrets versions access latest --secret=slic-api | grep GCP_BUCKET_NAME | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API GCP_SERVICE_ACCOUNT=`gcloud secrets versions access latest --secret=slic-api | grep GCP_SERVICE_ACCOUNT | cut -d= -f2- | tr -d "[:space:]"`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API GCP_BASE_URL=`gcloud secrets versions access latest --secret=slic-api | grep GCP_BASE_URL | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API API_URI=`gcloud secrets versions access latest --secret=slic-api | grep API_URI | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API ADMIN_JWT_SECRET=`gcloud secrets versions access latest --secret=slic-api | grep ADMIN_JWT_SECRET | cut -d= -f2-`
    kubectl set env deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API FRONT_URL=`gcloud secrets versions access latest --secret=slic-api | grep FRONT_URL | cut -d= -f2-`
    kubectl scale deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API --replicas=0
    kubectl scale deployment/$DEPLOYMENT_NAME_API -n $NAMESPACE_API --replicas=1
fi

if [ "$SET_ENV_VARS_FOR_SLIC_API" = false ]; then
    echo "Environment variables for slic-api not configured"
fi