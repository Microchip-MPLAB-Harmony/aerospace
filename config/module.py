######################  Harmony Aerospace  ######################
def loadModule():
    print("Load Module: Harmony Aerospace")
    d = dict(locals(), **globals())
    execfile(Module.getPath()+"peripheral/config/peripheral.py", d, d)

