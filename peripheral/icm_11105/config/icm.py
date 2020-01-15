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

from math import ceil, floor

###################################################################################################
#################################### Global Variables #############################################
###################################################################################################
global interruptVector
global interruptHandler
global interruptHandlerLock

RegionDescList = []

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
        Database.setSymbolValue("core", interruptHandler, icmInstanceName.getValue() + "_InterruptHandler", 2)
        Database.setSymbolValue("core", interruptHandlerLock, True, 2)
    else :
        Database.setSymbolValue("core", interruptVector, False, 2)
        Database.setSymbolValue("core", interruptHandler, "ICM_Handler", 2)
        Database.setSymbolValue("core", interruptHandlerLock, False, 2)

def icmCreateRegionDesc(component, menu, RegionNumber):
    regionDescriptor = component.createMenuSymbol(icmInstanceName.getValue() + "_REGION_DESC"+ str(RegionNumber), menu)
    regionDescriptor.setLabel("Region descriptor " + str(RegionNumber))
    
    icmRegionDescStartAddr = component.createHexSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_TYPE", regionDescriptor)
    icmRegionDescStartAddr.setLabel("Start Address :")

    icmRegionDescAlgo = component.createKeyValueSetSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_ALGO", regionDescriptor)
    icmRegionDescAlgo.setLabel("SHA Algorithm")
    icmRegionDescAlgo.setDisplayMode("Description")
    icmRegionDescAlgo.setOutputMode("Value")
    icmRegionDescAlgo.addKey("SHA1",  "0", "SHA1 algorithm")
    icmRegionDescAlgo.addKey("SHA256", "1", "SHA256 algorithm")
    icmRegionDescAlgo.addKey("SHA224", "4", "SHA224 algorithm")
    icmRegionDescAlgo.setSelectedKey("SHA1")

    icmRegionDescPROCDLY = component.createKeyValueSetSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_PROCDLY", regionDescriptor)
    icmRegionDescPROCDLY.setLabel("SHA Processing Delay")
    icmRegionDescPROCDLY.setOutputMode("Value")
    icmRegionDescPROCDLY.addKey("SHORTEST",  "0", "SHA processing runtime shortest")
    icmRegionDescPROCDLY.addKey("LONGEST", "1", "SHA processing runtime longest")
    icmRegionDescPROCDLY.setDefaultValue(0)
    icmRegionDescPROCDLY.setSelectedKey("SHORTEST")

    icmRegionDescDisableInt = component.createMenuSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_DISABLE_INT", regionDescriptor)
    icmRegionDescDisableInt.setLabel("Disable interrupt events")

    icmRegionDescDisIntSUIEN = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_SUIEN", icmRegionDescDisableInt)
    icmRegionDescDisIntSUIEN.setLabel("Disable Status Updated Condition")
    icmRegionDescDisIntSUIEN.setDescription("If disabled, the Region Status Updated Condition interrupt flag remains cleared")
    icmRegionDescDisIntSUIEN.setDefaultValue(False)

    icmRegionDescDisIntECIEN = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_ECIEN", icmRegionDescDisableInt)
    icmRegionDescDisIntECIEN.setLabel("Disable End Bit Condition")
    icmRegionDescDisIntECIEN.setDescription("If disabled, the End Bit Condition interrupt flag remains cleared")
    icmRegionDescDisIntECIEN.setDefaultValue(False)

    icmRegionDescDisIntWCIEN = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_WCIEN", icmRegionDescDisableInt)
    icmRegionDescDisIntWCIEN.setLabel("Disable Wrap Condition")
    icmRegionDescDisIntWCIEN.setDescription("If disabled, the Wrap Condition interrupt flag remains cleared")
    icmRegionDescDisIntWCIEN.setDefaultValue(False)

    icmRegionDescDisIntBEIEN = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_BEIEN", icmRegionDescDisableInt)
    icmRegionDescDisIntBEIEN.setLabel("Disable Bus Error Interrupt")
    icmRegionDescDisIntBEIEN.setDescription("If disabled, the Bus Error Interrupt flag remains cleared")
    icmRegionDescDisIntBEIEN.setDefaultValue(False)

    icmRegionDescDisIntDMIEN = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_DMIEN", icmRegionDescDisableInt)
    icmRegionDescDisIntDMIEN.setLabel("Disable Digest Mismatch Interrupt")
    icmRegionDescDisIntDMIEN.setDescription("If disabled, the Digest Mismatch Interrupt flag remains cleared")
    icmRegionDescDisIntDMIEN.setDefaultValue(False)

    icmRegionDescDisIntRHIEN = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_RHIEN", icmRegionDescDisableInt)
    icmRegionDescDisIntRHIEN.setLabel("Disable Digest Mismatch Interrupt")
    icmRegionDescDisIntRHIEN.setDescription("If disabled, the Digest Mismatch Interrupt flag remains cleared")
    icmRegionDescDisIntRHIEN.setDefaultValue(False)

    icmRegionDescEOM = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_EOM", regionDescriptor)
    icmRegionDescEOM.setLabel("Enable End of Monitoring")
    icmRegionDescEOM.setDescription("The current descriptor terminates the Main List. WRAP value has no effect.")
    icmRegionDescEOM.setDefaultValue(False)

    icmRegionDescWRAP = component.createBooleanSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_WRAP", regionDescriptor)
    icmRegionDescWRAP.setLabel("Wrap command")
    icmRegionDescWRAP.setDescription("The next region descriptor address loaded is the descriptor list base address.")
    icmRegionDescWRAP.setDefaultValue(False)

    icmRegionDescCDWBN = component.createKeyValueSetSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_CDWBN", regionDescriptor)
    icmRegionDescCDWBN.setLabel("Digest process")
    icmRegionDescCDWBN.setOutputMode("Value")
    icmRegionDescCDWBN.addKey("Write Back", "0", "The digest is written to the Hash area.")
    icmRegionDescCDWBN.addKey("Compare", "1", "The digest value is compared to the digest stored in the Hash area.")
    icmRegionDescCDWBN.setSelectedKey("Write Back")

    icmRegionDescSize = component.createIntegerSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_SIZE", regionDescriptor)
    icmRegionDescSize.setLabel("Size in byte (multiple of 64):")
    icmRegionDescSize.setMin(64)
    icmRegionDescSize.setMax(64*65536)
    icmRegionDescSize.setDefaultValue(64)

    icmRegionDescSizeRounded = component.createIntegerSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_SIZE_REG", regionDescriptor)
    icmRegionDescSizeRounded.setDependencies(adjustRegionDescriptorSize, [icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_SIZE"])
    icmRegionDescSizeRounded.setVisible(False)

    # Region size rounded display
    icmRegionDescSizeComment = component.createCommentSymbol(icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_SIZE_COMMENT", regionDescriptor)
    icmRegionDescSizeComment.setLabel("****Region size will be rounded to n bytes****")
    icmRegionDescSizeComment.setVisible(False)
    icmRegionDescSizeComment.setDependencies(checkRegionDescriptorSizeComment, [icmInstanceName.getValue() + "_REGION_DESC" + str(RegionNumber) + "_SIZE"])

    regionDescriptor.setVisible(False)
    regionDescriptor.setEnabled(False)
    return regionDescriptor

###################################################################################################
########################################## Callbacks  #############################################
###################################################################################################

# Round entered value to multiple of 64 byte 
def adjustRegionDescriptorSize(symbol, event):
    value = event["value"]
    if (value != 64):
        symbol.setValue(int(floor(value/64)))
    else:
        symbol.setValue(0)

# Display comment if value is rounded 
def checkRegionDescriptorSizeComment(symbol, event):
    value = event["value"]
    if ((value % 64) != 0):
        symbol.setLabel("****Region size will be rounded to " + str(int((floor(value/64)+1)*64)) +" bytes****")
        symbol.setVisible(True)
    else:
        symbol.setVisible(False)

# adjust how many region descriptors are shown based on number entered
def adjustRegionDescriptor(list, event):
    for region in RegionDescList[:event["value"]]:
        if region.getVisible() != True:
            region.setVisible(True)
            region.setEnabled(True)
    for region in RegionDescList[event["value"]:]:
        if region.getVisible() != False:
            region.setVisible(False)
            region.setEnabled(False)

def icmClockWarningStatus(symbol, event):
    symbol.setVisible(not event["value"])

def InterruptStatusWarning(symbol, event):
    if (Database.getSymbolValue(icmInstanceName.getValue().lower(), "INTERRUPT_MODE") == True):
        symbol.setVisible(event["value"])


###################################################################################################
########################################## Component  #############################################
###################################################################################################


def instantiateComponent(icmComponent):

    global icmInstanceName
    global InterruptVectorUpdate
    global interruptVector
    global interruptHandler
    global interruptHandlerLock

    icmInstanceName = icmComponent.createStringSymbol("ICM_INSTANCE_NAME", None)
    icmInstanceName.setVisible(False)
    icmInstanceName.setDefaultValue(icmComponent.getID().upper())
    print("Running " + icmInstanceName.getValue())

    # Initialize peripheral clock
    Database.setSymbolValue("core", icmInstanceName.getValue() + "_CLOCK_ENABLE", True, 1)

    ################################################################################
    #### Menu ####
    ################################################################################

    icmInterruptMode = icmComponent.createBooleanSymbol("INTERRUPT_MODE", None)
    icmInterruptMode.setLabel("Interrupt Mode")
    icmInterruptMode.setDefaultValue(False)

    icmDualBuff = icmComponent.createBooleanSymbol("DUALBUFF", None)
    icmDualBuff.setLabel("Enable dual input buffer")
    icmDualBuff.setDefaultValue(False)

    icmASCD = icmComponent.createBooleanSymbol("ASCD", None)
    icmASCD.setLabel("Automatic switch to compare digest")
    icmASCD.setDefaultValue(False)

    icmBusBurdenControl = icmComponent.createIntegerSymbol("BUS_BURDEN_CONTROL", None)
    icmBusBurdenControl.setLabel("Bus Burden Control:")
    icmBusBurdenControl.setDefaultValue(0)
    icmBusBurdenControl.setMin(0)
    icmBusBurdenControl.setMax(15)

    icmDisableSecList = icmComponent.createBooleanSymbol("SLBDIS", None)
    icmDisableSecList.setLabel("Disable Secondary list branch")
    icmDisableSecList.setDefaultValue(False)

    icmDisableEndMonitoring = icmComponent.createBooleanSymbol("EOMDIS", None)
    icmDisableEndMonitoring.setLabel("Disable End of Monitoring")
    icmDisableEndMonitoring.setDefaultValue(False)
    
    icmDisableWriteBack = icmComponent.createBooleanSymbol("WBDIS", None)
    icmDisableWriteBack.setLabel("Disable Write Back")
    icmDisableWriteBack.setDefaultValue(False)

    # up to 4 region descriptor
    icmRegionDescriptorMenu = icmComponent.createMenuSymbol("regionDescriptor", None)
    icmRegionDescriptorMenu.setLabel("Region Descriptor (up to 4)")
    icmRegionDescriptorMenu.setDependencies(adjustRegionDescriptor, ["REGION_DESC_NUM"])

    icmRegionDescriptorNumber = icmComponent.createIntegerSymbol("REGION_DESC_NUM", icmRegionDescriptorMenu)
    icmRegionDescriptorNumber.setLabel("Number of Region Descriptor:")
    icmRegionDescriptorNumber.setDefaultValue(0)
    icmRegionDescriptorNumber.setMin(0)
    icmRegionDescriptorNumber.setMax(4)

    #Create all of the standard filters in a disabled state
    for filter in range (4):
        RegionDescList.append(icmCreateRegionDesc(icmComponent, icmRegionDescriptorMenu, filter))

    ############################################################################
    #### Dependency ####
    ############################################################################

    # Clock dependency Warning status
    icmClkEnComment = icmComponent.createCommentSymbol("ICM_CLOCK_ENABLE_COMMENT", None)
    icmClkEnComment.setLabel("Warning!!! " + icmInstanceName.getValue() + " Peripheral Clock is Disabled in Clock Manager")
    icmClkEnComment.setVisible(False)
    icmClkEnComment.setDependencies(icmClockWarningStatus, ["core." + icmInstanceName.getValue() + "_CLOCK_ENABLE"])

    interruptVector = icmInstanceName.getValue() + "_INTERRUPT_ENABLE"
    interruptHandler = icmInstanceName.getValue() + "_INTERRUPT_HANDLER"
    interruptHandlerLock = icmInstanceName.getValue() + "_INTERRUPT_HANDLER_LOCK"
    interruptVectorUpdate = icmInstanceName.getValue() + "_INTERRUPT_ENABLE_UPDATE"

    # NVIC Dynamic settings
    icminterruptControl = icmComponent.createBooleanSymbol("NVIC_ICM_ENABLE", None)
    icminterruptControl.setDependencies(interruptControl, ["INTERRUPT_MODE"])
    icminterruptControl.setVisible(False)

    # Dependency Status for interrupt
    icmIntEnComment = icmComponent.createCommentSymbol("ICM_INTERRUPT_ENABLE_COMMENT", None)
    icmIntEnComment.setVisible(False)
    icmIntEnComment.setLabel("Warning!!! " + icmInstanceName.getValue() + " Interrupt is Disabled in Interrupt Manager")
    icmIntEnComment.setDependencies(InterruptStatusWarning, ["core." + interruptVectorUpdate])

    ###################################################################################################
    ####################################### Code Generation  ##########################################
    ###################################################################################################

    configName = Variables.get("__CONFIGURATION_NAME")

    icmHeaderFile = icmComponent.createFileSymbol("ICM_HEADER", None)
    icmHeaderFile.setSourcePath("/peripheral/icm_11105/templates/plib_icm.h.ftl")
    icmHeaderFile.setOutputName("plib_" + icmInstanceName.getValue().lower() + ".h")
    icmHeaderFile.setDestPath("peripheral/icm/")
    icmHeaderFile.setProjectPath("config/" + configName +"/peripheral/icm/")
    icmHeaderFile.setType("HEADER")
    icmHeaderFile.setMarkup(True)

    icmSource1File = icmComponent.createFileSymbol("ICM_SOURCE", None)
    icmSource1File.setSourcePath("/peripheral/icm_11105/templates/plib_icm.c.ftl")
    icmSource1File.setOutputName("plib_" + icmInstanceName.getValue().lower() + ".c")
    icmSource1File.setDestPath("peripheral/icm/")
    icmSource1File.setProjectPath("config/" + configName +"/peripheral/icm/")
    icmSource1File.setType("SOURCE")
    icmSource1File.setMarkup(True)

    icmSystemInitFile = icmComponent.createFileSymbol("ICM_INIT", None)
    icmSystemInitFile.setType("STRING")
    icmSystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_SYS_INITIALIZE_PERIPHERALS")
    icmSystemInitFile.setSourcePath("/peripheral/icm_11105/templates/system/initialization.c.ftl")
    icmSystemInitFile.setMarkup(True)

    icmSystemDefFile = icmComponent.createFileSymbol("ICM_DEF", None)
    icmSystemDefFile.setType("STRING")
    icmSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    icmSystemDefFile.setSourcePath("/peripheral/icm_11105/templates/system/definitions.h.ftl")
    icmSystemDefFile.setMarkup(True)
