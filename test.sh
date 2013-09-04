#!/bin/bash

for i in {1..27} 
do
	content="$(curl -d 'value[decibel]=69' localhost:3000/sensors/${i}/values)"
done
														        
