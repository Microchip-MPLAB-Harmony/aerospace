"""*****************************************************************************
* Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries.
*
* Subject to your compliance with these terms, you may use Microchip software
* and any derivatives exclusively with Microchip products. It is your
* responsibility to comply with third party license terms applicable to your
* use of third party software (including open source software) that may
* accompany Microchip software.
*
* THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
* EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
* WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
* PARTICULAR PURPOSE.
*
* IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
* INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
* WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
* BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
* FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
* ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
* THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
*****************************************************************************"""

###################################################################################################
#################################### Global Variables #############################################
###################################################################################################
global interruptVector
global interruptHandler
global interruptHandlerLock
LinkList = []

###################################################################################################
######################################### Functions ###############################################
###################################################################################################

def interruptControl(NVIC, event):
    global interruptVector
    global interruptHandler
    global interruptHandlerLock
    Database.clearSymbolValue("core", interruptVector)
    Database.clearSymbolValue("core", interruptHandler)
    Database.clearSymbolValue("core", interruptHandlerLock)
    if (event["value"] == True):
        Database.setSymbolValue("core", interruptVector, True, 2)
        Database.setSymbolValue("core", interruptHandler, spwInstanceName.getValue() + "_InterruptHandler", 2)
        Database.setSymbolValue("core", interruptHandlerLock, True, 2)
    else :
        Database.setSymbolValue("core", interruptVector, False, 2)
        Database.setSymbolValue("core", interruptHandler, "SPW_Handler", 2)
        Database.setSymbolValue("core", interruptHandlerLock, False, 2)

def spwCreateLink(component, menu, LinkNumber):
    linkDescriptor = component.createMenuSymbol(spwInstanceName.getValue() + "_LINK"+ str(LinkNumber), menu)
    linkDescriptor.setLabel("Link " + str(LinkNumber) + " configuration")

    linkCommand = component.createKeyValueSetSymbol(spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_CMD", linkDescriptor)
    linkCommand.setLabel("Link command")
    linkCommand.setDisplayMode("Description")
    linkCommand.setOutputMode("Value")
    linkCommand.addKey("DISABLE",  "0", "Disable")
    linkCommand.addKey("NOCMD", "1", "No Command")
    linkCommand.addKey("AUTOSTART", "2", "Auto Start")
    linkCommand.addKey("START", "3", "Start")
    linkCommand.setSelectedKey("AUTOSTART")

    linkSpeed = component.createIntegerSymbol(spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_SPEED", linkDescriptor)
    linkSpeed.setLabel("Link speed Kbit/s:")
    linkSpeed.setMin(0)
    linkSpeed.setMax(200000)
    linkSpeed.setDefaultValue(200000)

    linkInitDiv = component.createIntegerSymbol(spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_INIT_DIV", linkDescriptor)
    linkInitDiv.setDependencies(updateInitDivisor, ["SPW_CLOCK_FREQ"])
    linkInitDiv.setVisible(False)

    linkOperDiv = component.createIntegerSymbol(spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_OPER_DIV", linkDescriptor)
    linkOperDiv.setDependencies(updateOperDivisor, ["SPW_CLOCK_FREQ", spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_SPEED"])
    linkOperDiv.setVisible(False)

    spwInitClockDivInvalid = component.createCommentSymbol(spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_INIT_CLOCK_INVALID_COMMENT", None)
    spwInitClockDivInvalid.setLabel("Warning!!! " + spwInstanceName.getValue() + " Clock Frequency is too low for required Initialization link " + str(LinkNumber) + " speed")
    computeInitDivisor(linkInitDiv)

    spwOperClockDivInvalid = component.createCommentSymbol(spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_OPER_CLOCK_INVALID_COMMENT", None)
    spwOperClockDivInvalid.setLabel("Warning!!! " + spwInstanceName.getValue() + " Clock Frequency is too low for required Operationnal link " + str(LinkNumber) + " speed")
    computeOperDivisor(linkOperDiv, LinkNumber, Database.getSymbolValue(spwInstanceName.getValue().lower(), spwInstanceName.getValue() + "_LINK" + str(LinkNumber) + "_SPEED"))

def spwCreateTableEntry(component, menu, LogicalAddress):
    LogicalAddrDescMenu = component.createMenuSymbol(spwInstanceName.getValue() + "_ROUTER_TABLE_LA"+ str(LogicalAddress), menu)
    LogicalAddrDescMenu.setLabel("Logical address " + str(LogicalAddress))

    LogicalAddrDelHeader = component.createBooleanSymbol(spwInstanceName.getValue() + "_ROUTER_TABLE_LA"+ str(LogicalAddress) + "_DEL", LogicalAddrDescMenu)
    LogicalAddrDelHeader.setLabel("Delete header byte")
    LogicalAddrDelHeader.setDefaultValue(False)

    LogicalAddrPhysicalAddr = component.createKeyValueSetSymbol(spwInstanceName.getValue() + "_ROUTER_TABLE_LA"+ str(LogicalAddress) + "_ADDR", LogicalAddrDescMenu)
    LogicalAddrPhysicalAddr.setLabel("Physical address")
    LogicalAddrPhysicalAddr.setDisplayMode("Description")
    LogicalAddrPhysicalAddr.setOutputMode("Value")
    LogicalAddrPhysicalAddr.addKey("DISABLE",  "0", "Disable")
    LogicalAddrPhysicalAddr.addKey("LINK 1", "1", "Link 1")
    LogicalAddrPhysicalAddr.addKey("LINK 2", "2", "Link 2")
    LogicalAddrPhysicalAddr.addKey("PKTRX", "9", "Packet receiver")
    LogicalAddrPhysicalAddr.addKey("RMAP", "17", "RMAP reveiver")
    LogicalAddrPhysicalAddr.setSelectedKey("DISABLE")

###################################################################################################
########################################## Callbacks  #############################################
###################################################################################################

def spwSourceFreq(symbol, event):
    symbol.setValue(int(Database.getSymbolValue("core", spwInstanceName.getValue() + "_SPWCLK_CLOCK_FREQUENCY")), 2)

def spwTimeTickFreq(symbol, event):
    symbol.setValue(int(Database.getSymbolValue("core", spwInstanceName.getValue() + "_TIMETICK_CLOCK_FREQUENCY")), 2)

def spwClockWarningStatus(symbol, event):
    symbol.setVisible(not event["value"])

def InterruptStatusWarning(symbol, event):
    if (Database.getSymbolValue(spwInstanceName.getValue().lower(), "INTERRUPT_MODE") == True):
        symbol.setVisible(event["value"])

def updateInitDivisor(symbol, event):
    computeInitDivisor(symbol)

def computeInitDivisor(symbol):
    link_num_index = symbol.getID().index("_INIT_DIV") - 1
    link = symbol.getID()[link_num_index:link_num_index+1]
    warningSymbol = symbol.getComponent().getSymbolByID(spwInstanceName.getValue() + "_LINK" + str(link) + "_INIT_CLOCK_INVALID_COMMENT")
    clk = Database.getSymbolValue(spwInstanceName.getValue().lower(), "SPW_CLOCK_FREQ")
    div = int(((2*clk)/10000000)-1)
    if (div < 0):
        warningSymbol.setVisible(True)
        div = 0
    else:
        warningSymbol.setVisible(False)
    symbol.setValue(div)

def updateOperDivisor(symbol, event):
    link_num_index = symbol.getID().index("_OPER_DIV") - 1
    link = symbol.getID()[link_num_index:link_num_index+1]
    if ("SPW_CLOCK_FREQ" in event["id"]):
        #Get corresponding link rate in kbit/s
        rate = Database.getSymbolValue(spwInstanceName.getValue().lower(), spwInstanceName.getValue() + "_LINK" + str(link) + "_SPEED")
    else:
        rate = event["value"]
    computeOperDivisor(symbol, link, rate)

def computeOperDivisor(symbol, link, rate):
    warningSymbol = symbol.getComponent().getSymbolByID(spwInstanceName.getValue() + "_LINK" + str(link) + "_OPER_CLOCK_INVALID_COMMENT")
    clk = Database.getSymbolValue(spwInstanceName.getValue().lower(), "SPW_CLOCK_FREQ")
    div = int(((2*clk)/(rate*1000))-1)
    if (div < 0):
        warningSymbol.setVisible(True)
        div = 0
    else:
        warningSymbol.setVisible(False)
    symbol.setValue(div)

def spwSetVisibleIfEventTrue(symbol, event):
    symbol.setVisible(event["value"])

def spwEnRmapSourceFileIfTrue(symbol, event):
    symbol.setEnabled(event["value"])

###################################################################################################
########################################## Component  #############################################
###################################################################################################

def instantiateComponent(spwComponent):

    global spwInstanceName
    global InterruptVectorUpdate
    global interruptVector
    global interruptHandler
    global interruptHandlerLock

    spwInstanceName = spwComponent.createStringSymbol("SPW_INSTANCE_NAME", None)
    spwInstanceName.setVisible(False)
    spwInstanceName.setDefaultValue(spwComponent.getID().upper())
    print("Running " + spwInstanceName.getValue())

    # Initialize peripheral clock
    Database.setSymbolValue("core", spwInstanceName.getValue() + "_SPWCLK_CLOCK_ENABLE", True, 1)
    Database.setSymbolValue("core", spwInstanceName.getValue() + "_TIMETICK_CLOCK_ENABLE", True, 1)

    ################################################################################
    #### Menu ####
    ################################################################################

    ## spw Clock Frequency
    spwClkValue = spwComponent.createIntegerSymbol("SPW_CLOCK_FREQ", None)
    spwClkValue.setLabel("SPW Clock Frequency")
    spwClkValue.setMin(0)
    spwClkValue.setReadOnly(True)
    spwClkValue.setVisible(True)
    spwClkValue.setDefaultValue(int(Database.getSymbolValue("core", spwInstanceName.getValue() + "_SPWCLK_CLOCK_FREQUENCY")))
    spwClkValue.setDependencies(spwSourceFreq, ["core." + spwInstanceName.getValue() + "_SPWCLK_CLOCK_FREQUENCY"])

    ## spw Timetick clock Frequency
    spwClkValue = spwComponent.createIntegerSymbol("SPW_TIMETICK_CLOCK_FREQ", None)
    spwClkValue.setLabel("SPW TimeTick Frequency")
    spwClkValue.setMin(0)
    spwClkValue.setReadOnly(True)
    spwClkValue.setVisible(True)
    spwClkValue.setDefaultValue(int(Database.getSymbolValue("core", spwInstanceName.getValue() + "_TIMETICK_CLOCK_FREQUENCY")))
    spwClkValue.setDependencies(spwTimeTickFreq, ["core." + spwInstanceName.getValue() + "_TIMETICK_CLOCK_FREQUENCY"])

    spwInterruptMode = spwComponent.createBooleanSymbol("INTERRUPT_MODE", None)
    spwInterruptMode.setLabel("Interrupt Mode")
    spwInterruptMode.setDefaultValue(False)

    # Link configuration
    spwLinkMenu = spwComponent.createMenuSymbol(spwInstanceName.getValue() + "_LINK", None)
    spwLinkMenu.setLabel("Links configuration")

    for filter in range (2):
        LinkList.append(spwCreateLink(spwComponent, spwLinkMenu, (filter + 1) ) )

    #Router configuration
    spwRouterMenu = spwComponent.createMenuSymbol(spwInstanceName.getValue() + "_ROUTER", None)
    spwRouterMenu.setLabel("Router configuration")

    spwRouterDisTimeout = spwComponent.createBooleanSymbol(spwInstanceName.getValue() + "_ROUTER_DISTIMEOUT", spwRouterMenu)
    spwRouterDisTimeout.setLabel("Disable timeout")
    spwRouterDisTimeout.setDefaultValue(False)

    spwRouterEnLogicalAddr = spwComponent.createBooleanSymbol(spwInstanceName.getValue() + "_ROUTER_LAENA", spwRouterMenu)
    spwRouterEnLogicalAddr.setLabel("Enable Logical Addressing")
    spwRouterEnLogicalAddr.setDefaultValue(False)

    spwRouterEnFallback = spwComponent.createBooleanSymbol(spwInstanceName.getValue() + "_ROUTER_FALLBACK", spwRouterMenu)
    spwRouterEnFallback.setLabel("Enable Fallback Routing")
    spwRouterEnFallback.setDefaultValue(False)
    spwRouterEnFallback.setVisible(False)
    spwRouterEnFallback.setDependencies(spwSetVisibleIfEventTrue, [spwInstanceName.getValue() + "_ROUTER_LAENA"])

    spwRouterTableMenu = spwComponent.createMenuSymbol(spwInstanceName.getValue() + "_ROUTER_TABLE", spwRouterMenu)
    spwRouterTableMenu.setLabel("Logical Address Table Entries")
    spwRouterTableMenu.setVisible(False)
    spwRouterTableMenu.setDependencies(spwSetVisibleIfEventTrue, [spwInstanceName.getValue() + "_ROUTER_LAENA"])

    for address in range (32, 256):
        LinkList.append(spwCreateTableEntry(spwComponent, spwRouterTableMenu, address) )

    # RMAP module configuration
    spwRmapMenu = spwComponent.createMenuSymbol(spwInstanceName.getValue() + "_RMAP", None)
    spwRmapMenu.setLabel("RMAP configuration")

    spwRmapEnable = spwComponent.createBooleanSymbol(spwInstanceName.getValue() + "_RMAP_EN", spwRmapMenu)
    spwRmapEnable.setLabel("Enable RMAP")
    spwRmapEnable.setDefaultValue(False)

    spwRmapTargetLogicalAddr = spwComponent.createIntegerSymbol(spwInstanceName.getValue() + "_RMAP_TLA", spwRmapMenu)
    spwRmapTargetLogicalAddr.setLabel("Target Logical Address")
    spwRmapTargetLogicalAddr.setMin(0)
    spwRmapTargetLogicalAddr.setMax(0xFF)
    spwRmapTargetLogicalAddr.setDefaultValue(0)

    spwRmapDestKey = spwComponent.createIntegerSymbol(spwInstanceName.getValue() + "_RMAP_DESTKEY", spwRmapMenu)
    spwRmapDestKey.setLabel("Destination Key")
    spwRmapDestKey.setMin(0)
    spwRmapDestKey.setMax(0xFF)
    spwRmapDestKey.setDefaultValue(0)

    ############################################################################
    #### Dependency ####
    ############################################################################

    # Clock dependency Warning status
    spwClkEnComment = spwComponent.createCommentSymbol("SPW_CLOCK_ENABLE_COMMENT", None)
    spwClkEnComment.setLabel("Warning!!! " + spwInstanceName.getValue() + " Peripheral Clock SPWCLK is Disabled in Clock Manager")
    spwClkEnComment.setDependencies(spwClockWarningStatus, ["core." + spwInstanceName.getValue() + "_SPWCLK_CLOCK_ENABLE"])
    if (Database.getSymbolValue("core", spwInstanceName.getValue() + "_SPWCLK_CLOCK_ENABLE")):
        spwClkEnComment.setVisible(False)

    # Clock dependency Warning status
    spwClkTimeTickEnComment = spwComponent.createCommentSymbol("SPW_CLOCK_TIMETICK_ENABLE_COMMENT", None)
    spwClkTimeTickEnComment.setLabel("Warning!!! " + spwInstanceName.getValue() + " Peripheral Clock TIMETICK is Disabled in Clock Manager")
    spwClkTimeTickEnComment.setDependencies(spwClockWarningStatus, ["core." + spwInstanceName.getValue() + "_TIMETICK_CLOCK_ENABLE"])
    if (Database.getSymbolValue("core", spwInstanceName.getValue() + "_TIMETICK_CLOCK_ENABLE")):
        spwClkEnComment.setVisible(False)

    interruptVector = spwInstanceName.getValue() + "_INTERRUPT_ENABLE"
    interruptHandler = spwInstanceName.getValue() + "_INTERRUPT_HANDLER"
    interruptHandlerLock = spwInstanceName.getValue() + "_INTERRUPT_HANDLER_LOCK"
    interruptVectorUpdate = spwInstanceName.getValue() + "_INTERRUPT_ENABLE_UPDATE"

    # NVIC Dynamic settings
    spwinterruptControl = spwComponent.createBooleanSymbol("NVIC_SPW_ENABLE", None)
    spwinterruptControl.setDependencies(interruptControl, ["INTERRUPT_MODE"])
    spwinterruptControl.setVisible(False)

    # Dependency Status for interrupt
    spwIntEnComment = spwComponent.createCommentSymbol("SPW_INTERRUPT_ENABLE_COMMENT", None)
    spwIntEnComment.setVisible(False)
    spwIntEnComment.setLabel("Warning!!! " + spwInstanceName.getValue() + " Interrupt is Disabled in Interrupt Manager")
    spwIntEnComment.setDependencies(InterruptStatusWarning, ["core." + interruptVectorUpdate])

    ###################################################################################################
    ####################################### Code Generation  ##########################################
    ###################################################################################################

    configName = Variables.get("__CONFIGURATION_NAME")

    spwHeaderFile = spwComponent.createFileSymbol("SPW_HEADER", None)
    spwHeaderFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw.h.ftl")
    spwHeaderFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + ".h")
    spwHeaderFile.setDestPath("peripheral/spw/")
    spwHeaderFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwHeaderFile.setType("HEADER")
    spwHeaderFile.setMarkup(True)

    spwSourceFile = spwComponent.createFileSymbol("SPW_SOURCE", None)
    spwSourceFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw.c.ftl")
    spwSourceFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + ".c")
    spwSourceFile.setDestPath("peripheral/spw/")
    spwSourceFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwSourceFile.setType("SOURCE")
    spwSourceFile.setMarkup(True)

    spwLinkHeaderFile = spwComponent.createFileSymbol("SPW_LINK_HEADER", None)
    spwLinkHeaderFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_link.h.ftl")
    spwLinkHeaderFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_link.h")
    spwLinkHeaderFile.setDestPath("peripheral/spw/")
    spwLinkHeaderFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwLinkHeaderFile.setType("HEADER")
    spwLinkHeaderFile.setMarkup(True)

    spwLinkSourceFile = spwComponent.createFileSymbol("SPW_LINK_SOURCE", None)
    spwLinkSourceFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_link.c.ftl")
    spwLinkSourceFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_link.c")
    spwLinkSourceFile.setDestPath("peripheral/spw/")
    spwLinkSourceFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwLinkSourceFile.setType("SOURCE")
    spwLinkSourceFile.setMarkup(True)

    spwRouterHeaderFile = spwComponent.createFileSymbol("SPW_ROUTER_HEADER", None)
    spwRouterHeaderFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_router.h.ftl")
    spwRouterHeaderFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_router.h")
    spwRouterHeaderFile.setDestPath("peripheral/spw/")
    spwRouterHeaderFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwRouterHeaderFile.setType("HEADER")
    spwRouterHeaderFile.setMarkup(True)

    spwRouterSourceFile = spwComponent.createFileSymbol("SPW_ROUTER_SOURCE", None)
    spwRouterSourceFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_router.c.ftl")
    spwRouterSourceFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_router.c")
    spwRouterSourceFile.setDestPath("peripheral/spw/")
    spwRouterSourceFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwRouterSourceFile.setType("SOURCE")
    spwRouterSourceFile.setMarkup(True)

    spwPckRxHeaderFile = spwComponent.createFileSymbol("SPW_PKTRX_HEADER", None)
    spwPckRxHeaderFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_pktrx.h.ftl")
    spwPckRxHeaderFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_pktrx.h")
    spwPckRxHeaderFile.setDestPath("peripheral/spw/")
    spwPckRxHeaderFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwPckRxHeaderFile.setType("HEADER")
    spwPckRxHeaderFile.setMarkup(True)

    spwPckRxSourceFile = spwComponent.createFileSymbol("SPW_PKTRX_SOURCE", None)
    spwPckRxSourceFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_pktrx.c.ftl")
    spwPckRxSourceFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_pktrx.c")
    spwPckRxSourceFile.setDestPath("peripheral/spw/")
    spwPckRxSourceFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwPckRxSourceFile.setType("SOURCE")
    spwPckRxSourceFile.setMarkup(True)

    spwPckTxHeaderFile = spwComponent.createFileSymbol("SPW_PKTTX_HEADER", None)
    spwPckTxHeaderFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_pkttx.h.ftl")
    spwPckTxHeaderFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_pkttx.h")
    spwPckTxHeaderFile.setDestPath("peripheral/spw/")
    spwPckTxHeaderFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwPckTxHeaderFile.setType("HEADER")
    spwPckTxHeaderFile.setMarkup(True)

    spwPckTxSourceFile = spwComponent.createFileSymbol("SPW_PKTTX_SOURCE", None)
    spwPckTxSourceFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_pkttx.c.ftl")
    spwPckTxSourceFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_pkttx.c")
    spwPckTxSourceFile.setDestPath("peripheral/spw/")
    spwPckTxSourceFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwPckTxSourceFile.setType("SOURCE")
    spwPckTxSourceFile.setMarkup(True)

    spwRmapHeaderFile = spwComponent.createFileSymbol("SPW_RMAP_HEADER", None)
    spwRmapHeaderFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_rmap.h.ftl")
    spwRmapHeaderFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_rmap.h")
    spwRmapHeaderFile.setDestPath("peripheral/spw/")
    spwRmapHeaderFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwRmapHeaderFile.setType("HEADER")
    spwRmapHeaderFile.setMarkup(True)
    spwRmapHeaderFile.setDependencies(spwEnRmapSourceFileIfTrue, [spwInstanceName.getValue() + "_RMAP_EN"])
    if (Database.getSymbolValue(spwInstanceName.getValue().lower(), spwInstanceName.getValue() + "_RMAP_EN")):
        spwRmapHeaderFile.setEnabled(True)
    else:
        spwRmapHeaderFile.setEnabled(False)

    spwRmapSourceFile = spwComponent.createFileSymbol("SPW_RMAP_SOURCE", None)
    spwRmapSourceFile.setSourcePath("/peripheral/spw_44126/templates/plib_spw_rmap.c.ftl")
    spwRmapSourceFile.setOutputName("plib_" + spwInstanceName.getValue().lower() + "_rmap.c")
    spwRmapSourceFile.setDestPath("peripheral/spw/")
    spwRmapSourceFile.setProjectPath("config/" + configName +"/peripheral/spw/")
    spwRmapSourceFile.setType("SOURCE")
    spwRmapSourceFile.setMarkup(True)
    spwRmapSourceFile.setDependencies(spwEnRmapSourceFileIfTrue, [spwInstanceName.getValue() + "_RMAP_EN"])
    if (Database.getSymbolValue(spwInstanceName.getValue().lower(), spwInstanceName.getValue() + "_RMAP_EN")):
        spwRmapSourceFile.setEnabled(True)
    else:
        spwRmapSourceFile.setEnabled(False)

    spwSystemInitFile = spwComponent.createFileSymbol("SPW_INIT", None)
    spwSystemInitFile.setType("STRING")
    spwSystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_SYS_INITIALIZE_PERIPHERALS")
    spwSystemInitFile.setSourcePath("/peripheral/spw_44126/templates/system/initialization.c.ftl")
    spwSystemInitFile.setMarkup(True)

    spwSystemDefFile = spwComponent.createFileSymbol("SPW_DEF", None)
    spwSystemDefFile.setType("STRING")
    spwSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    spwSystemDefFile.setSourcePath("/peripheral/spw_44126/templates/system/definitions.h.ftl")
    spwSystemDefFile.setMarkup(True)
