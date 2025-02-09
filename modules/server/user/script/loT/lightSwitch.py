# Example Usage of TinyTuya
import tinytuya

d = tinytuya.OutletDevice('ebb6b94c791074a3a0jp5k', '192.168.2.224', 'q9Nw0<QmaqL#A(JQ')
d.set_version(3.4)
data = d.status()
switch_state = data['dps']['1']
data = d.set_status(not switch_state)  # This requires a valid key
if data:
    print('set_status() result %r' % data)
