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
        Database.setSymbolValue("core", interruptHandler, mil1553InstanceName.getValue() + "_InterruptHandler", 2)
        Database.setSymbolValue("core", interruptHandlerLock, True, 2)
    else :
        Database.setSymbolValue("core", interruptVector, False, 2)
        Database.setSymbolValue("core", interruptHandler, "IP1553_Handler", 2)
        Database.setSymbolValue("core", interruptHandlerLock, False, 2)

###################################################################################################
########################################## Callbacks  #############################################
###################################################################################################

def mil1553SourceFreq(symbol, event):
    symbol.setValue(int(Database.getSymbolValue("core", mil1553InstanceName.getValue() + "_CLOCK_FREQUENCY")), 2)

def mil1553ClockWarningStatus(symbol, event):
    symbol.setVisible(not event["value"])

def mil1553ClockValueStatus(symbol, event):
    symbol.setVisible(event["value"] != 12000000)

def InterruptStatusWarning(symbol, event):
    if (Database.getSymbolValue(mil1553InstanceName.getValue().lower(), "INTERRUPT_MODE") == True):
        symbol.setVisible(event["value"])

def checkRtMode(symbol, event):
    if (event["value"] == 0):  # 0 is Remote Terminal
        symbol.setVisible(True)
        symbol.setReadOnly(False)
    else:
        symbol.setVisible(False)
        symbol.setReadOnly(True)

###################################################################################################
########################################## Component  #############################################
###################################################################################################


def instantiateComponent(mil1553Component):

    global mil1553InstanceName
    global InterruptVectorUpdate
    global interruptVector
    global interruptHandler
    global interruptHandlerLock

    mil1553InstanceName = mil1553Component.createStringSymbol("IP1553_INSTANCE_NAME", None)
    mil1553InstanceName.setVisible(False)
    mil1553InstanceName.setDefaultValue(mil1553Component.getID().upper())
    print("Running " + mil1553InstanceName.getValue())

    # Initialize peripheral clock
    Database.setSymbolValue("core", mil1553InstanceName.getValue() + "_CLOCK_ENABLE", True, 1)

    ################################################################################
    #### Menu ####
    ################################################################################

    ## 1553 Clock Frequency
    mil1553ClkValue = mil1553Component.createIntegerSymbol("IP1553_CLOCK_FREQ", None)
    mil1553ClkValue.setLabel("1553 Clock Frequency")
    mil1553ClkValue.setMin(0)
    mil1553ClkValue.setReadOnly(True)
    mil1553ClkValue.setVisible(True)
    mil1553ClkValue.setDefaultValue(int(Database.getSymbolValue("core", mil1553InstanceName.getValue() + "_CLOCK_FREQUENCY")))
    mil1553ClkValue.setDependencies(mil1553SourceFreq, ["core." + mil1553InstanceName.getValue() + "_CLOCK_FREQUENCY"])

    mil1553mode = mil1553Component.createKeyValueSetSymbol("IP1553_MODE", None)
    mil1553mode.setLabel("Select 1553 Mode")
    mil1553mode.setOutputMode("Key")
    mil1553mode.setDisplayMode("Description")
    mil1553mode.addKey("RT", "0", "Remote Terminal")
    mil1553mode.addKey("BC", "1", "Bus Controller")
    mil1553mode.setSelectedKey("BC", 1)
    
    mil1553InterruptMode = mil1553Component.createBooleanSymbol("INTERRUPT_MODE", None)
    mil1553InterruptMode.setLabel("Interrupt Mode")
    mil1553InterruptMode.setDefaultValue(False)

    mil1553rtAddress = mil1553Component.createIntegerSymbol("IP1553_RT_ADDR", None)
    mil1553rtAddress.setLabel("RT Address")
    mil1553rtAddress.setMin(1)
    mil1553rtAddress.setMax(30)
    mil1553rtAddress.setDefaultValue(1)
    mil1553rtAddress.setVisible(False)
    mil1553rtAddress.setDependencies(checkRtMode, ["IP1553_MODE"])

    ############################################################################
    #### Dependency ####
    ############################################################################

    # Clock dependency Warning status
    mil1553ClkEnComment = mil1553Component.createCommentSymbol("IP1553_CLOCK_ENABLE_COMMENT", None)
    mil1553ClkEnComment.setLabel("Warning!!! " + mil1553InstanceName.getValue() + " Peripheral Clock is Disabled in Clock Manager")
    mil1553ClkEnComment.setVisible(False)
    mil1553ClkEnComment.setDependencies(mil1553ClockWarningStatus, ["core." + mil1553InstanceName.getValue() + "_CLOCK_ENABLE"])

    mil1553ClockInvalidSym = mil1553Component.createCommentSymbol("IP1553_CLOCK_INVALID_COMMENT", None)
    mil1553ClockInvalidSym.setLabel("Warning!!! " + mil1553InstanceName.getValue() + " GCLK clock frequency should be 12MHz")
    mil1553ClockInvalidSym.setVisible(False)
    mil1553ClockInvalidSym.setDependencies(mil1553ClockValueStatus, ["core." + mil1553InstanceName.getValue() + "_CLOCK_FREQUENCY"])

    interruptVector = mil1553InstanceName.getValue() + "_INTERRUPT_ENABLE"
    interruptHandler = mil1553InstanceName.getValue() + "_INTERRUPT_HANDLER"
    interruptHandlerLock = mil1553InstanceName.getValue() + "_INTERRUPT_HANDLER_LOCK"
    interruptVectorUpdate = mil1553InstanceName.getValue() + "_INTERRUPT_ENABLE_UPDATE"

    # NVIC Dynamic settings
    mil1553interruptControl = mil1553Component.createBooleanSymbol("NVIC_IP1553_ENABLE", None)
    mil1553interruptControl.setDependencies(interruptControl, ["INTERRUPT_MODE"])
    mil1553interruptControl.setVisible(False)

    # Dependency Status for interrupt
    mil1553IntEnComment = mil1553Component.createCommentSymbol("IP1553_INTERRUPT_ENABLE_COMMENT", None)
    mil1553IntEnComment.setVisible(False)
    mil1553IntEnComment.setLabel("Warning!!! " + mil1553InstanceName.getValue() + " Interrupt is Disabled in Interrupt Manager")
    mil1553IntEnComment.setDependencies(InterruptStatusWarning, ["core." + interruptVectorUpdate])

    ###################################################################################################
    ####################################### Code Generation  ##########################################
    ###################################################################################################

    configName = Variables.get("__CONFIGURATION_NAME")

    mil1553HeaderFile = mil1553Component.createFileSymbol("IP1553_HEADER", None)
    mil1553HeaderFile.setSourcePath("/peripheral/ip1553_44127/templates/plib_1553.h.ftl")
    mil1553HeaderFile.setOutputName("plib_" + mil1553InstanceName.getValue().lower() + ".h")
    mil1553HeaderFile.setDestPath("peripheral/1553/")
    mil1553HeaderFile.setProjectPath("config/" + configName +"/peripheral/1553/")
    mil1553HeaderFile.setType("HEADER")
    mil1553HeaderFile.setMarkup(True)

    mil1553Source1File = mil1553Component.createFileSymbol("IP1553_SOURCE", None)
    mil1553Source1File.setSourcePath("/peripheral/ip1553_44127/templates/plib_1553.c.ftl")
    mil1553Source1File.setOutputName("plib_" + mil1553InstanceName.getValue().lower() + ".c")
    mil1553Source1File.setDestPath("peripheral/1553/")
    mil1553Source1File.setProjectPath("config/" + configName +"/peripheral/1553/")
    mil1553Source1File.setType("SOURCE")
    mil1553Source1File.setMarkup(True)

    mil1553SystemInitFile = mil1553Component.createFileSymbol("IP1553_INIT", None)
    mil1553SystemInitFile.setType("STRING")
    mil1553SystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_SYS_INITIALIZE_PERIPHERALS")
    mil1553SystemInitFile.setSourcePath("/peripheral/ip1553_44127/templates/system/initialization.c.ftl")
    mil1553SystemInitFile.setMarkup(True)

    mil1553SystemDefFile = mil1553Component.createFileSymbol("IP1553_DEF", None)
    mil1553SystemDefFile.setType("STRING")
    mil1553SystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    mil1553SystemDefFile.setSourcePath("/peripheral/ip1553_44127/templates/system/definitions.h.ftl")
    mil1553SystemDefFile.setMarkup(True)
