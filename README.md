# fr24feed
Docker container for Flightradar24 feeder

Use a cheap RTL2832U based DVB-T receiver to receive ADS-B signals and feed them to [Flightradar24](http://flightradar24.com)

If you are not yet registered to Flightradar24 you first need to sign up using the following command
```
docker run -it --rm liggy1/fr24feed --signup
```

Make sure to store the flightradar24 signup key in a safe location before starting to feed data to Flightradar24 executing
```
docker run -d \
--name fr24feed \
--restart unless-stopped \
--privileged \
-p 8080:8080 \
-p 8754:8754 \
-p 30001-30005:30001-30005 \
liggy1/fr24feed --fr24key={Flightradar24 signup key}
```

The ```--privileged``` option will grant access to all host devices. This might not be the desired behaviour, instead you can use ```--device=/dev/bus/usb/xxx/yyy```
In order to find the correct values for **xxx** and **yyy** run ```lsusb```:
> Bus **001** Device **002**: ID 0bda:2838 Realtek Semiconductor Corp. RTL2838 DVB-T

For this sample output you would replace xxx with 001 and yyy with 002 and the full command to run the feeder would be
```
docker run -d \
--name fr24feed \
--restart unless-stopped \
--device=/dev/bus/usb/001/002:/dev/bus/usb/001/002 \
-p 8080:8080 \
-p 8754:8754 \
-p 30001-30005:30001-30005 \
liggy1/fr24feed --fr24key={Flightradar24 signup key}
```
Be aware that the values for **xxx** and **yyy** may change if you plug the dongle into a different USB port.

Upon successful start you can check dump1090 activities on http://dockerhost:8080 and the Flightradar feeder status on http://dockerhost:8754

In order to access your free Flightradar24 business subscription, [register here](https://www.flightradar24.com/premium/signup?account=free) for an account using the email address your provided when you signed up.
