/*******************************************************************************
  FLEXRAMECC Peripheral Library
  Source File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${FLEXRAMECC_INSTANCE_NAME?lower_case}.c

  Summary:
    ${FLEXRAMECC_INSTANCE_NAME} PLIB Implementation file

  Description:
    This file defines the interface to the ${FLEXRAMECC_INSTANCE_NAME} peripheral library.
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
#include "plib_${FLEXRAMECC_INSTANCE_NAME?lower_case}.h"

// *****************************************************************************
// *****************************************************************************
// Section: Global Data
// *****************************************************************************
// *****************************************************************************

<#if INTERRUPT_MODE == true>
static FLEXRAMECC_OBJ ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj;
</#if>

// *****************************************************************************
// *****************************************************************************
// ${FLEXRAMECC_INSTANCE_NAME} PLib Interface Routines
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************

/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_Initialize(void)

   Summary:
    Initializes given instance of the ${FLEXRAMECC_INSTANCE_NAME} peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void ${FLEXRAMECC_INSTANCE_NAME}_Initialize(void)
{
    FLEXRAMECC_REGS->FLEXRAMECC_CR = FLEXRAMECC_CR_ENABLE(1);

<#if INTERRUPT_MODE == true>
    FLEXRAMECC_REGS->FLEXRAMECC_IER = (FLEXRAMECC_IER_MEM_FIX_Msk | FLEXRAMECC_IER_MEM_NOFIX_Msk);
</#if>
}
// *****************************************************************************
/* Function:
    FLEXRAMECC_STATUS ${FLEXRAMECC_INSTANCE_NAME}_StatusGet(void)

   Summary:
    Get the status of the ${FLEXRAMECC_INSTANCE_NAME} peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    Current status of the ${FLEXRAMECC_INSTANCE_NAME} peripheral.
*/
FLEXRAMECC_STATUS ${FLEXRAMECC_INSTANCE_NAME}_StatusGet(void)
{
    return (FLEXRAMECC_STATUS)(FLEXRAMECC_REGS->FLEXRAMECC_SR);
}

// *****************************************************************************
/* Function:
    uint32_t ${FLEXRAMECC_INSTANCE_NAME}_GetFailAddress(void)

   Summary:
    Get the last fail address were ECC error occurs in FLEXRAM memory.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    Fail address were fixable or unfixable error occured in FLEXRAM memory.
*/
uint32_t ${FLEXRAMECC_INSTANCE_NAME}_GetFailAddress(void)
{
    return FLEXRAMECC_REGS->FLEXRAMECC_FAILAR;
}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_ResetCounters(void)

   Summary:
    Reset Fix and NoFix error counters of the ${FLEXRAMECC_INSTANCE_NAME} peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void ${FLEXRAMECC_INSTANCE_NAME}_ResetCounters(void)
{
    FLEXRAMECC_REGS->FLEXRAMECC_CR |= (FLEXRAMECC_CR_RST_FIX_CPT_Msk | FLEXRAMECC_CR_RST_NOFIX_CPT_Msk);
}

<#if INTERRUPT_MODE == true>
// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_FixCallbackRegister(FLEXRAMECC_CALLBACK callback,
                                                              uintptr_t context)

   Summary:
    Sets the pointer to the function (and it's context) to be called when the
    given FLEXRAMECC's ECC Fixable Error interrupt events occur.

  Description:
    This function sets the pointer to a client function to be called "back" when
    the given FLEXRAMECC's interrupt events occur. It also passes a context value
    (usually a pointer to a context structure) that is passed into the function
    when it is called. The specified callback function will be called from the
    peripheral interrupt context.

  Precondition:
    ${FLEXRAMECC_INSTANCE_NAME}_Initialize must have been called for the associated
    FLEXRAMECC instance.

  Parameters:
    callback      - A pointer to a function with a calling signature defined by
                    the FLEXRAMECC_CALLBACK data type. Setting this to NULL
                    disables the callback feature.

    contextHandle - A value (usually a pointer) passed (unused) into the
                    function identified by the callback parameter.

  Returns:
    None.

  Example:
    <code>
        // Refer to the description of the FLEXRAMECC_CALLBACK data type for
        // example usage.
    </code>

  Remarks:
    None.
*/
void ${FLEXRAMECC_INSTANCE_NAME}_FixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t contextHandle)
{
    if (callback == NULL)
    {
        return;
    }

    ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.fix_callback = callback;
    ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.fix_context = contextHandle;
}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_NoFixCallbackRegister(FLEXRAMECC_CALLBACK callback,
                                                              uintptr_t context)

   Summary:
    Sets the pointer to the function (and it's context) to be called when the
    given FLEXRAMECC's ECC Not Fixable Error interrupt events occur.

  Description:
    This function sets the pointer to a client function to be called "back" when
    the given FLEXRAMECC's interrupt events occur. It also passes a context value
    (usually a pointer to a context structure) that is passed into the function
    when it is called. The specified callback function will be called from the
    peripheral interrupt context.

  Precondition:
    ${FLEXRAMECC_INSTANCE_NAME}_Initialize must have been called for the associated
    FLEXRAMECC instance.

  Parameters:
    callback      - A pointer to a function with a calling signature defined by
                    the FLEXRAMECC_CALLBACK data type. Setting this to NULL
                    disables the callback feature.

    contextHandle - A value (usually a pointer) passed (unused) into the
                    function identified by the callback parameter.

  Returns:
    None.

  Example:
    <code>
        // Refer to the description of the FLEXRAMECC_CALLBACK data type for
        // example usage.
    </code>

  Remarks:
    None.
*/
void ${FLEXRAMECC_INSTANCE_NAME}_NoFixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t contextHandle)
{
    if (callback == NULL)
    {
        return;
    }

    ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.nofix_callback = callback;
    ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.nofix_context = contextHandle;
}


// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_INTFIX_InterruptHandler(void)

   Summary:
    ${FLEXRAMECC_INSTANCE_NAME} Peripheral Interrupt Handler.

   Description:
    This function is ${FLEXRAMECC_INSTANCE_NAME} Peripheral Interrupt Handler and will
    called on every ${FLEXRAMECC_INSTANCE_NAME} ECC Fixable error interrupt.

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
void ${FLEXRAMECC_INSTANCE_NAME}_INTFIX_InterruptHandler(void)
{

    if (${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.fix_callback != NULL)
    {
        ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.fix_callback(${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.fix_context);
    }
}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_INTNOFIX_InterruptHandler(void)

   Summary:
    ${FLEXRAMECC_INSTANCE_NAME} Peripheral Interrupt Handler.

   Description:
    This function is ${FLEXRAMECC_INSTANCE_NAME} Peripheral Interrupt Handler and will
    called on every ${FLEXRAMECC_INSTANCE_NAME} ECC Not Fixable error interrupt.

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
void ${FLEXRAMECC_INSTANCE_NAME}_INTNOFIX_InterruptHandler(void)
{

    if (${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.nofix_callback != NULL)
    {
        ${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.nofix_callback(${FLEXRAMECC_INSTANCE_NAME?lower_case}Obj.nofix_context);
    }
}
</#if>
