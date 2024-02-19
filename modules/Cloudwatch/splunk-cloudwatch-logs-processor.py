# This AWS SAM template has been generated from your function's configuration. If
# your function has one or more triggers, note that the AWS resources associated
# with these triggers aren't fully specified in this template and include
# placeholder values. Open this template in AWS Application Composer or your
# favorite IDE and modify it to specify a serverless application with other AWS
# resources.
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: An AWS Serverless Application Model template describing your function.
Resources:
  g3:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: .
      Description: Stream events from AWS CloudWatch Logs to Splunk's HTTP event collector
      MemorySize: 512
      Timeout: 10
      Handler: index.handler
      Runtime: nodejs18.x
      Architectures:
        - x86_64
      EphemeralStorage:
        Size: 512
      Environment:
        Variables:
          SPLUNK_HEC_TOKEN: e9175852-aa6e-483d-93c9-5726f7106f06
          SPLUNK_HEC_URL: http://52.87.226.204:8088/
      EventInvokeConfig:
        MaximumEventAgeInSeconds: 21600
        MaximumRetryAttempts: 2
      PackageType: Zip
      Policies:
        - Statement:
            - Effect: Allow
              Action:
                - logs:CreateLogGroup
              Resource: arn:aws:logs:us-east-1:889796695136:*
            - Effect: Allow
              Action:
                - logs:CreateLogStream
                - logs:PutLogEvents
              Resource:
                - arn:aws:logs:us-east-1:889796695136:log-group:/aws/lambda/g3:*
      SnapStart:
        ApplyOn: None
      Tags:
        lambda-console:blueprint: splunk-cloudwatch-logs-processor
      Events:
        CloudWatchLogs1:
          Type: CloudWatchLogs
          Properties:
            FilterPattern: ''
            LogGroupName: LogGroup1
      RuntimeManagementConfig:
        UpdateRuntimeOn: Auto
  CloudWatchLogs1:
    Type: AWS::Logs::LogGroup
    Properties:
      LogGroupName: LogGroup1

