/*******************************************************************************
  FLEXRAMECC Peripheral Library
  Instance Header File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${FLEXRAMECC_INSTANCE_NAME?lower_case}.h

  Summary:
    ${FLEXRAMECC_INSTANCE_NAME} PLIB Header file

  Description:
    This file defines the interface to the ${FLEXRAMECC_INSTANCE_NAME} peripheral 
    library. This library provides access to and control of the associated 
    peripheral instance.
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

#ifndef PLIB_${FLEXRAMECC_INSTANCE_NAME}_H
#define PLIB_${FLEXRAMECC_INSTANCE_NAME}_H

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************
/* This section lists the other files that are included in this file.
*/

// DOM-IGNORE-BEGIN
#ifdef __cplusplus // Provide C++ Compatibility
    extern "C" {
#endif
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: ${FLEXRAMECC_INSTANCE_NAME} defines
// *****************************************************************************
// *****************************************************************************


// *****************************************************************************
// *****************************************************************************
// Section: ${FLEXRAMECC_INSTANCE_NAME} Types
// *****************************************************************************
// *****************************************************************************
/* FLEXRAMECC status
   Summary:
    Identifies the FLEXRAMECC current status

   Description:
    This data type identifies the FLEXRAMECC status
*/
typedef uint32_t FLEXRAMECC_STATUS;

#define FLEXRAMECC_STATUS_MEM_FIX               (FLEXRAMECC_SR_MEM_FIX_Msk)
#define FLEXRAMECC_STATUS_CPT_FIX_MASK          (FLEXRAMECC_SR_CPT_FIX_Msk)
#define FLEXRAMECC_STATUS_OVER_FIX              (FLEXRAMECC_SR_OVER_FIX_Msk)
#define FLEXRAMECC_STATUS_MEM_NOFIX             (FLEXRAMECC_SR_MEM_NOFIX_Msk)
#define FLEXRAMECC_STATUS_CPT_NOFIX_MASK        (FLEXRAMECC_SR_CPT_NOFIX_Msk)
#define FLEXRAMECC_STATUS_OVER_NOFIX            (FLEXRAMECC_SR_OVER_NOFIX_Msk)
#define FLEXRAMECC_STATUS_HES_MASK              (FLEXRAMECC_SR_HES_Msk)
#define FLEXRAMECC_STATUS_TYPE                  (FLEXRAMECC_SR_TYPE_Msk)
#define FLEXRAMECC_STATUS_INVALID               (0xFFFFFFFFUL)

// *****************************************************************************
/* FLEXRAMECC Callback

   Summary:
    FLEXRAMECC Callback Function Pointer.

   Description:
    This data type defines the FLEXRAMECC Callback Function Pointer.

   Remarks:
    None.
*/
typedef void (*FLEXRAMECC_CALLBACK) (uintptr_t contextHandle);

// *****************************************************************************

/* FLEXRAMECC PLib Instance Object

   Summary:
    FLEXRAMECC PLib Object structure.

   Description:
    This data structure defines the FLEXRAMECC PLib Instance Object.

   Remarks:
    None.
*/
typedef struct
{
    /* Transfer Event Callback for Fixable Error interrupt*/
    FLEXRAMECC_CALLBACK fix_callback;

    /* Transfer Event Callback Context for Fixable Error interrupt*/
    uintptr_t fix_context;

    /* Transfer Event Callback for NoFixable Error interrupt*/
    FLEXRAMECC_CALLBACK nofix_callback;

    /* Transfer Event Callback Context for NoFixable Error interrupt*/
    uintptr_t nofix_context;
} FLEXRAMECC_OBJ;

// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************

/*
 * The following functions make up the methods (set of possible operations) of
 * this interface.
 */

void ${FLEXRAMECC_INSTANCE_NAME}_Initialize(void);

FLEXRAMECC_STATUS ${FLEXRAMECC_INSTANCE_NAME}_StatusGet(void);

uint32_t* ${FLEXRAMECC_INSTANCE_NAME}_GetFailAddress(void);

<#if FLEXRAMECC_HAS_FAIL_DATA == true >
uint32_t ${FLEXRAMECC_INSTANCE_NAME}_GetFailData(void);

</#if>
void ${FLEXRAMECC_INSTANCE_NAME}_ResetCounters(void);

<#if INTERRUPT_MODE == true>

void ${FLEXRAMECC_INSTANCE_NAME}_FixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t contextHandle);

void ${FLEXRAMECC_INSTANCE_NAME}_NoFixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t contextHandle);

</#if>

<#if INJECTION_TEST_MODE == true>
// *****************************************************************************
// *****************************************************************************
// Section: Interface Inlined TestMode Routines
// *****************************************************************************
// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_TestModeReadEnable(void)

   Summary:
    Enable the ${FLEXRAMECC_INSTANCE_NAME} peripheral test mode Read. When enabled the
    ECC check bit value read is updated in TESTCB1 register at each FLEXRAM data read.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${FLEXRAMECC_INSTANCE_NAME}_TestModeReadEnable(void)
{
    FLEXRAMECC_REGS->FLEXRAMECC_CR |= FLEXRAMECC_CR_TEST_MODE_RD_Msk;
    while ( ( FLEXRAMECC_REGS->FLEXRAMECC_CR & FLEXRAMECC_CR_TEST_MODE_RD_Msk ) != FLEXRAMECC_CR_TEST_MODE_RD_Msk)
    {
        /* Wait for the update of the control register */
    }
}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_TestModeReadDisable(void)

   Summary:
    Disable the ${FLEXRAMECC_INSTANCE_NAME} peripheral test mode Read.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${FLEXRAMECC_INSTANCE_NAME}_TestModeReadDisable(void)
{
    FLEXRAMECC_REGS->FLEXRAMECC_CR &= ~(FLEXRAMECC_CR_TEST_MODE_RD_Msk);
    while ( (FLEXRAMECC_REGS->FLEXRAMECC_CR & FLEXRAMECC_CR_TEST_MODE_RD_Msk) ==  FLEXRAMECC_CR_TEST_MODE_RD_Msk )
    {
        /* Wait for the update of the control register */
    }
}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_TestModeWriteEnable(void)

   Summary:
    Enable the ${FLEXRAMECC_INSTANCE_NAME} peripheral test mode Write. When enabled the
    ECC check bit value in TESTCB1 register is write in memory at each FLEXRAM data write
    instead of calculated check bit.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${FLEXRAMECC_INSTANCE_NAME}_TestModeWriteEnable(void)
{
    FLEXRAMECC_REGS->FLEXRAMECC_CR |= FLEXRAMECC_CR_TEST_MODE_WR_Msk;
    while ( ( FLEXRAMECC_REGS->FLEXRAMECC_CR & FLEXRAMECC_CR_TEST_MODE_WR_Msk ) != FLEXRAMECC_CR_TEST_MODE_WR_Msk )
    {
        /* Wait for the update of the control register */
    }

}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_TestModeWriteDisable(void)

   Summary:
    Disable the ${FLEXRAMECC_INSTANCE_NAME} peripheral test mode Write.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${FLEXRAMECC_INSTANCE_NAME}_TestModeWriteDisable(void)
{
    FLEXRAMECC_REGS->FLEXRAMECC_CR &= ~(FLEXRAMECC_CR_TEST_MODE_WR_Msk);
    while ( (FLEXRAMECC_REGS->FLEXRAMECC_CR & FLEXRAMECC_CR_TEST_MODE_WR_Msk) == FLEXRAMECC_CR_TEST_MODE_WR_Msk )
    {
        /* Wait for the update of the control register */
    }
}

// *****************************************************************************
/* Function:
    uint8_t ${FLEXRAMECC_INSTANCE_NAME}_TestModeGetCbValue(void)

   Summary:
    Get the ${FLEXRAMECC_INSTANCE_NAME} peripheral test mode check bit values.

   Precondition:
    None.

   Parameters:
     None.

   Returns:
    Test check bit value.
*/
static inline uint8_t ${FLEXRAMECC_INSTANCE_NAME}_TestModeGetCbValue(void)
{
    return (uint8_t)(FLEXRAMECC_REGS->FLEXRAMECC_TESTCB1 & FLEXRAMECC_TESTCB1_Msk);
}

// *****************************************************************************
/* Function:
    void ${FLEXRAMECC_INSTANCE_NAME}_TestModeSetCbValue(uint8_t tcb1)

   Summary:
    Set the ${FLEXRAMECC_INSTANCE_NAME} peripheral test mode check bit values.

   Precondition:
    None.

   Parameters:
    tcb1 - Test check bit value to set.

   Returns:
    None
*/
static inline void ${FLEXRAMECC_INSTANCE_NAME}_TestModeSetCbValue(uint8_t tcb1)
{
    FLEXRAMECC_REGS->FLEXRAMECC_TESTCB1 = FLEXRAMECC_TESTCB1_TCB1(tcb1);
}
</#if>

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility
}
#endif
// DOM-IGNORE-END

#endif /* PLIB_${FLEXRAMECC_INSTANCE_NAME}_H */
