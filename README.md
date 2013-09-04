# SPLive
This is solely an API for accepting requests on the database. The Main index updates displaying current contents of SPLIVE database.

{URL} = Server Address

## Add a Value via Curl:
	{SENSOR_ID} = sensor's ID
	{DECIBEL_VALUE} = value of the sensor
	
    curl -d "value[decibel]={DECIBEL_VALUE}" {URL}/sensors/{SENSOR_ID}/values

Example: 
    
    curl -d "value[decibel]=1" localhost:3000/sensors/5/values

## Add a Sensor via Curl:
	{SENSOR_NAME} = name of sensor
    curl -d "sensor[name]={SENSOR_NAME}" {URL}/sensors

Example: 
	
	curl -d "sensor[name]=LeftSensor" localhost:3000/sensors/
	
	
	
Demo: http://sheltered-badlands-4355.herokuapp.com

*Currently not connecting with Redis Server on Heroku Hosting. Demo doesn't update in realtime only on page refresh.*