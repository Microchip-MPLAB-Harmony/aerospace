/*******************************************************************************
  ICM Peripheral Library
  Source File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${ICM_INSTANCE_NAME?lower_case}.c

  Summary:
    ${ICM_INSTANCE_NAME} PLIB Implementation file

  Description:
    This file defines the interface to the ${ICM_INSTANCE_NAME} peripheral library.
    This library provides access to and control of the associated peripheral
    instance.

*******************************************************************************/
// DOM-IGNORE-BEGIN
/*******************************************************************************
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
*******************************************************************************/
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include "device.h"
#include "plib_${ICM_INSTANCE_NAME?lower_case}.h"

// *****************************************************************************
// *****************************************************************************
// Section: Global Data
// *****************************************************************************
// *****************************************************************************

<#if INTERRUPT_MODE == true>
static ICM_OBJ ${ICM_INSTANCE_NAME?lower_case}Obj;
</#if>

<#if REGION_DESC_NUM?number gt 0>
<#assign numInstance=REGION_DESC_NUM?number>
/* ICM memory region descriptor object */
static const icm_descriptor_registers_t __attribute__((aligned (64))) ${ICM_INSTANCE_NAME?lower_case}ListDescriptor[] =
{
    <#list 0..(numInstance-1) as idx>
    {
        .ICM_RADDR = ICM_RADDR_RADDR(0x${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_TYPE"]}),
        .ICM_RCFG = ICM_RCFG_ALGO(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_ALGO"]}) |
                    ICM_RCFG_PROCDLY(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_PROCDLY"]}) |
                    ICM_RCFG_SUIEN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_SUIEN"]?then(1,0)}) |
                    ICM_RCFG_ECIEN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_ECIEN"]?then(1,0)}) |
                    ICM_RCFG_WCIEN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_WCIEN"]?then(1,0)}) |
                    ICM_RCFG_BEIEN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_BEIEN"]?then(1,0)}) |
                    ICM_RCFG_DMIEN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_DMIEN"]?then(1,0)}) |
                    ICM_RCFG_RHIEN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_RHIEN"]?then(1,0)}) |
                    ICM_RCFG_EOM(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_EOM"]?then(1,0)}) |
                    ICM_RCFG_WRAP(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_WRAP"]?then(1,0)}) |
                    ICM_RCFG_CDWBN(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_CDWBN"]}),
        .ICM_RCTRL = ICM_RCTRL_TRSIZE(${.vars["${ICM_INSTANCE_NAME}_REGION_DESC${idx}_SIZE_REG"]}),
        .ICM_RNEXT = 0,
    },
    </#list>
};
</#if>

// *****************************************************************************
// *****************************************************************************
// ${ICM_INSTANCE_NAME} PLib Interface Routines
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************

/* Function:
    void ${ICM_INSTANCE_NAME}_Initialize(void)

   Summary:
    Initializes given instance of the ${ICM_INSTANCE_NAME} peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void ${ICM_INSTANCE_NAME}_Initialize(void)
{
    //Reset the ICM
    ${ICM_INSTANCE_NAME}_SoftwareReset();

    // Set ICM configuration
    <#assign NUM_SPACE = "${ICM_INSTANCE_NAME}_REGS->ICM_CFG"?length >
    ${ICM_INSTANCE_NAME}_REGS->ICM_CFG = ICM_CFG_BBC(${BUS_BURDEN_CONTROL})<#if DUALBUFF> |
    <#list 1..NUM_SPACE as j> </#list>   ICM_CFG_DUALBUFF(1)</#if><#if ASCD> |
    <#list 1..NUM_SPACE as j> </#list>   ICM_CFG_ASCD(1)</#if><#if SLBDIS> |
    <#list 1..NUM_SPACE as j> </#list>   ICM_CFG_SLBDIS(1)</#if><#if EOMDIS> |
    <#list 1..NUM_SPACE as j> </#list>   ICM_CFG_EOMDIS(1)</#if><#if WBDIS> |
    <#list 1..NUM_SPACE as j> </#list>   ICM_CFG_WBDIS(1)</#if>;

<#if REGION_DESC_NUM?number gt 0>
    // Set Region list descriptor address.
    ${ICM_INSTANCE_NAME}_REGS->ICM_DSCR = (uint32_t)&${ICM_INSTANCE_NAME?lower_case}ListDescriptor;
</#if>
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_SetEndOfMonitoringDisable(bool disable)

   Summary:
    Disables/enables the ICM End of Monitoring Configuration

   Description:
    None

   Precondition:
    None.

   Parameters:
    disable - if true, End of Monitoring is disabled. Enabled if false.

   Returns:
    None

   Remarks:
    None
*/
void ${ICM_INSTANCE_NAME}_SetEndOfMonitoringDisable(bool disable)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CFG = ( ${ICM_INSTANCE_NAME}_REGS->ICM_CFG & ~ICM_CFG_EOMDIS_Msk ) | ICM_CFG_EOMDIS(disable == true);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_WriteBackDisable(bool disable)

   Summary:
    Disables/enables the ICM Write Back Configuration

   Description:
    None

   Precondition:
    None.

   Parameters:
    disable - if true, Write Back is disabled. Enabled if false.

   Returns:
    None

   Remarks:
    None
*/
void ${ICM_INSTANCE_NAME}_WriteBackDisable(bool disable)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CFG = ( ${ICM_INSTANCE_NAME}_REGS->ICM_CFG & ~ICM_CFG_WBDIS_Msk ) | ICM_CFG_WBDIS(disable == true);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_SoftwareReset(void)

   Summary:
    Reset the ${ICM_INSTANCE_NAME} Peripheral.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None.
*/
void ${ICM_INSTANCE_NAME}_SoftwareReset(void)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CTRL = ICM_CTRL_SWRST(1);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}ICM_SetDescStartAddress(icm_descriptor_registers_t* addr)

   Summary:
    Set the ${ICM_INSTANCE_NAME} descriptor area start address register.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    addr - The address of the ICM list descriptor.

   Returns:
    None.
    
   Remarks: 
    The start address must be aligned with size of the data structure (64 bytes).
*/
void ICM_SetDescStartAddress(icm_descriptor_registers_t* addr)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_DSCR = (uint32_t)addr;
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}ICM_SetHashStartAddress(void)

   Summary:
    Set the ${ICM_INSTANCE_NAME} hash area start address register.

   Description:
    The ICM Hash Area should be a contiguous area of system memory that the controller
    and the processor can access. This address is a multiple of 128 bytes.
    For each region, 32 bytes are used to store the computed hash.

   Precondition:
    None.

   Parameters:
    addr - The address of the ICM Hash memory location.

   Returns:
    None.
    
   Remarks: 
    This field points at the Hash memory location. The address must be aligned to 128 bytes.
*/
void ICM_SetHashStartAddress(uint32_t addr)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_HASH = addr;
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_Enable(void)

   Summary:
    Enable the ${ICM_INSTANCE_NAME} Peripheral.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None.
*/
void ${ICM_INSTANCE_NAME}_Enable(void)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CTRL = ICM_CTRL_ENABLE(1);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_Disable(void)

   Summary:
    Disable the ${ICM_INSTANCE_NAME} Peripheral.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None.
*/
void ${ICM_INSTANCE_NAME}_Disable(void)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CTRL = ICM_CTRL_DISABLE(1);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_ReComputeHash(ICM_REGION_MASK regions)

   Summary:
    Re-compute the ${ICM_INSTANCE_NAME} hash area start for the given regions.

   Description:
    None.

   Precondition:
    Region monitoring should be disabled.

   Parameters:
    region - The regions for which the digest will be re-computed.

   Returns:
    None.
*/
void ${ICM_INSTANCE_NAME}_ReComputeHash(ICM_REGION_MASK regions)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CTRL = ICM_CTRL_REHASH(regions);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_MonitorEnable(ICM_REGION_MASK regions)

   Summary:
    Enable the ${ICM_INSTANCE_NAME} monitoring of the given regions.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    region - The regions for which the monitoring will be enabled.

   Returns:
    None.
*/
void ${ICM_INSTANCE_NAME}_MonitorEnable(ICM_REGION_MASK regions)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CTRL = ICM_CTRL_RMEN(regions);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_MonitorDisable(ICM_REGION_MASK regions)

   Summary:
    Disable the ${ICM_INSTANCE_NAME} monitoring of the given regions.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    region - The regions for which the monitoring will be disabled.

   Returns:
    None.
*/
void ${ICM_INSTANCE_NAME}_MonitorDisable(ICM_REGION_MASK regions)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_CTRL = ICM_CTRL_RMDIS(regions);
}

// *****************************************************************************
/* Function:
    ICM_INT_MSK ${ICM_INSTANCE_NAME}_InterruptGet(void)

   Summary:
    Returns the Interrupt status.

   Precondition:
    ${ICM_INSTANCE_NAME}_Initialize must have been called for the associated ICM instance.

   Parameters:
    None.

   Returns:
    Interrupts that are active.
*/
ICM_INT_MSK ${ICM_INSTANCE_NAME}_InterruptGet(void)
{
    return (ICM_INT_MSK)(${ICM_INSTANCE_NAME}_REGS->ICM_ISR);
}

// *****************************************************************************
/* Function:
    ICM_INT_MSK ${ICM_INSTANCE_NAME}_InterruptMasked(void)

   Summary:
    Returns the current masked Interrupts.

   Precondition:
    ${ICM_INSTANCE_NAME}_Initialize must have been called for the associated ICM instance.

   Parameters:
    None.

   Returns:
    Interrupts that are currently masked.
*/
ICM_INT_MSK ${ICM_INSTANCE_NAME}_InterruptMasked(void)
{
    return (ICM_INT_MSK)(${ICM_INSTANCE_NAME}_REGS->ICM_IMR);
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_InterruptEnable(ICM_INT_MSK interruptMask)

   Summary:
    Enables ICM Interrupt.

   Precondition:
    ${ICM_INSTANCE_NAME}_Initialize must have been called for the associated ICM instance.

   Parameters:
    interruptMask - Interrupt to be enabled

   Returns:
    None
*/
void ${ICM_INSTANCE_NAME}_InterruptEnable(ICM_INT_MSK interruptMask)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_IER = interruptMask;
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_InterruptDisable(ICM_INT_MSK interruptMask)

   Summary:
    Disables ICM Interrupt.

   Precondition:
    ${ICM_INSTANCE_NAME}_Initialize must have been called for the associated ICM instance.

   Parameters:
    interruptMask - Interrupt to be disabled

   Returns:
    None
*/
void ${ICM_INSTANCE_NAME}_InterruptDisable(ICM_INT_MSK interruptMask)
{
    ${ICM_INSTANCE_NAME}_REGS->ICM_IDR = interruptMask;
}

// *****************************************************************************
/* Function:
    ICM_STATUS ${ICM_INSTANCE_NAME}_StatusGet(void)

   Summary:
    Get the ${ICM_INSTANCE_NAME} Peripheral Status.

   Description:
    None.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    The current ICM status.
*/
ICM_STATUS ${ICM_INSTANCE_NAME}_StatusGet(void)
{
    return (ICM_STATUS)(${ICM_INSTANCE_NAME}_REGS->ICM_SR);
}

<#if INTERRUPT_MODE == true>
// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_CallbackRegister(ICM_CALLBACK callback,
                                                              uintptr_t context)

   Summary:
    Sets the pointer to the function (and it's context) to be called when the
    given ICM's interrupt events occur.

  Description:
    This function sets the pointer to a client function to be called "back" when
    the given ICM's interrupt events occur. It also passes a context value
    (usually a pointer to a context structure) that is passed into the function
    when it is called. The specified callback function will be called from the
    peripheral interrupt context.

  Precondition:
    ${ICM_INSTANCE_NAME}_Initialize must have been called for the associated
    ICM instance.

  Parameters:
    callback      - A pointer to a function with a calling signature defined by
                    the ICM_CALLBACK data type. Setting this to NULL
                    disables the callback feature.

    contextHandle - A value (usually a pointer) passed (unused) into the
                    function identified by the callback parameter.

  Returns:
    None.

  Example:
    <code>
        // Refer to the description of the ICM_CALLBACK data type for
        // example usage.
    </code>

  Remarks:
    None.
*/
void ${ICM_INSTANCE_NAME}_CallbackRegister(ICM_CALLBACK callback, uintptr_t contextHandle)
{
    if (callback == NULL)
    {
        return;
    }

    ${ICM_INSTANCE_NAME?lower_case}Obj.callback = callback;
    ${ICM_INSTANCE_NAME?lower_case}Obj.context = contextHandle;
}

// *****************************************************************************
/* Function:
    void ${ICM_INSTANCE_NAME}_InterruptHandler(void)

   Summary:
    ${ICM_INSTANCE_NAME} Peripheral Interrupt Handler.

   Description:
    This function is ${ICM_INSTANCE_NAME} Peripheral Interrupt Handler and will
    called on every ${ICM_INSTANCE_NAME} interrupt.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None.

   Remarks:
    The function is called as peripheral instance's interrupt handler if the
    instance interrupt is enabled. If peripheral instance's interrupt is not
    enabled user need to call it from the main while loop of the application.
*/
void ${ICM_INSTANCE_NAME}_InterruptHandler(void)
{

    if (${ICM_INSTANCE_NAME?lower_case}Obj.callback != NULL)
    {
        ${ICM_INSTANCE_NAME?lower_case}Obj.callback(${ICM_INSTANCE_NAME?lower_case}Obj.context);
    }
}
</#if>
