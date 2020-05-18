import { getConnection } from './connection';

module.exports.printDeviceInfo = (device, devices) => {
  let info = {
    instanceId: device.instanceId,
    name: device.name,
    modelNumber: device.deviceInfo.modelNumber,
  };

  switch (device.type) {
    case 0: // remote
    case 4: // sensor
    case 7: // roller-blind
      info.battery = device.deviceInfo.battery;
      devices.push(info);

      break;
    case 2: // light
      let lightInfo = device.lightList[0];
      info.onOff = lightInfo.onOff;
      info.spectrum = lightInfo.spectrum;
      info.dimmer = lightInfo.dimmer;
      info.color = lightInfo.color;
      info.colorTemperature = lightInfo.colorTemperature;
      devices.push(info);

      break;
    case 3: // plug
      info.inOff = device.plugList[0].onOff;
      devices.push(info);

      break;
    case 6: // signal repeater
      devices.push(info);

      break;
    default:
      console.log(device.instanceId, device.name, "unknown type", device.type);
      console.log(device)
  }
};

// Only run this method if invoked with "node devices.js"
if (__filename === process.argv[1]) {
  (async () => {
    const tradfri = await getConnection();

    await tradfri.observeDevices();

    let devices = [];

    for (const deviceId in tradfri.devices) {
      const device = tradfri.devices[deviceId];
      printDeviceInfo(device, devices)
    }

    console.log(JSON.stringify(devices));

    tradfri.destroy();
    process.exit(0);
  })()
}
