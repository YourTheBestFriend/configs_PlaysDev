#!/bin/env python3
import boto3 # work with aws
import time  # set sleep for wait init ec2 
#---------------------------------------------------------------------------------------Stop & Terminate EC2 via ID
def terminate(instance_id):
    try:
        # sleep, - give time to give up ec2
        print('wait 20 second for init ec2 and get info')
        time.sleep(20)
        # stop ec2
        boto3.client('ec2').stop_instances(
            InstanceIds=[
                instance_id,
            ],
            #Hibernate=True|False, #DryRun=True,
            Force=True
        )
        # terminate via modify attr ec2
        ec2 = boto3.resource('ec2')
        ec2.Instance(instance_id).modify_attribute(
            DisableApiTermination={
            'Value': False
            })
        ec2.Instance(instance_id).terminate()
        # return info about complete without errors
        time.sleep(10)
        return 'ec2 with id {0} - stopped && terminated'.format(instance_id)
    except Exception as e:
        return 'Error -- Funtion terminate -- {0}'.format(e)
#--------------------------------------------------------------------------------------Function_get_Info_and_terminate_ec2
def get_info_and_terminate_ec2(list_ec2_data):
    try: 
        # get service's resource ec2
        ec2 = boto3.resource('ec2')
        # get machine ID - down get resource and terminate it
        instance_id = list_ec2_data[0]['InstanceId']
        # data via list 
        print(list_ec2_data)  
        # data via resource
        instance = ec2.Instance(instance_id)
        print("""Key name: {0}\nPublic IP: {1}\nInstance type: {2}\nInstance AMI: {3}
              """.format(instance.key_name, instance.public_ip_address, instance.instance_type, instance.image.id))
        #------------------ change ssh key
        #instance.key_name='ke2'
        #instance.reload()
        #ssm_client = boto3.client('ssm')
        #commands = ['ssh-keygen -t rsa']
        #instance_ids = [instance_id]
        #print('sleep 40 second before CHANGE key') 
        #resp = ssm_client.send_command(
        #        DocumentName="AWS-RunShellScript", # One of AWS’ preconfigured documents
        #        Parameters={'commands': commands},InstanceIds=instance_ids,
        #)
        #print(resp)
        #print('sleep 40 second before terminate')
        #time.sleep(40)
        #------------------ change ssh key
        # terminate & check status
        print(terminate(instance_id))
    except Exception as e:
        print('Error -- Function get_info_and_terminate_ec2 -- {0}'.format(e))
#---------------------------------------------------------------------------------------Just create & run ec2, and => call getInf then terminate
def run():
    try:
        # create object ec2 via client 
        ec2 = boto3.client('ec2')
        # run ec2 with parametrs
        instance = ec2.run_instances(
            ImageId='ami-08c40ec9ead489470', # ubuntu image
            MinCount=1,                      # min max - count instances
            MaxCount=1,                      # 
            InstanceType='t2.micro',         # instance type 
            KeyName='linux-key-pair'         # set ssh key 
        )
        #---All information via dict +with list Instances - down I get ec2 - index 0 (first)
        #print(f'\n{instance}\n')
        # get data about ec2
        list_data_info_first_ec2 = instance['Instances']
        # wait init ec2
        print('ec2 run wait 40 second')
        time.sleep(40)
        # call second function
        get_info_and_terminate_ec2(list_data_info_first_ec2)
    except Exception as e:
        print('Error Function -- Run --  {0}'.format(e))

# start 
if __name__ == "__main__":
    run() # just run   
