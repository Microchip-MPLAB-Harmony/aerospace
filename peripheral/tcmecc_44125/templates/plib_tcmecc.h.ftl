/*******************************************************************************
  TCMECC Peripheral Library
  Instance Header File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${TCMECC_INSTANCE_NAME?lower_case}.h

  Summary:
    ${TCMECC_INSTANCE_NAME} PLIB Header file

  Description:
    This file defines the interface to the ${TCMECC_INSTANCE_NAME} peripheral 
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

#ifndef PLIB_${TCMECC_INSTANCE_NAME}_H
#define PLIB_${TCMECC_INSTANCE_NAME}_H

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
// Section: ${TCMECC_INSTANCE_NAME} defines
// *****************************************************************************
// *****************************************************************************
/* Return fixable counter field value in TCMECC status word. */
#define TCMECC_STATUS_GET_CPT_FIX(status) ( (status & TCMECC_STATUS_CPT_FIX_MASK) >> TCMECC_SR_MEM_FIX_I_Pos ) 

/* Return unfixable counter field value in TCMECC status word. */
#define TCMECC_STATUS_GET_CPT_NOFIX(status) ( (status & TCMECC_STATUS_CPT_NOFIX_MASK) >> TCMECC_SR_MEM_NOFIX_I_Pos ) 

/* Return Hardware error size field value in TCMECC status word. */
#define TCMECC_STATUS_GET_HES(status) ( (status & TCMECC_STATUS_HES_MASK) >> TCMECC_SR_HES_Pos ) 

// *****************************************************************************
// *****************************************************************************
// Section: ${TCMECC_INSTANCE_NAME} Types
// *****************************************************************************
// *****************************************************************************
/* TCMECC status
   Summary:
    Identifies the TCMECC current status

   Description:
    This data type identifies the TCMECC status
*/
typedef enum
{
    TCMECC_STATUS_MEM_FIX_I = TCMECC_SR_MEM_FIX_I_Msk,
    TCMECC_STATUS_MEM_FIX_D = TCMECC_SR_MEM_FIX_D_Msk, 
    TCMECC_STATUS_CPT_FIX_MASK = TCMECC_SR_CPT_FIX_Msk,
    TCMECC_STATUS_OVER_FIX = TCMECC_SR_OVER_FIX_Msk,
    TCMECC_STATUS_MEM_NOFIX_I = TCMECC_SR_MEM_NOFIX_I_Msk,
    TCMECC_STATUS_MEM_NOFIX_D = TCMECC_SR_MEM_NOFIX_D_Msk,
    TCMECC_STATUS_CPT_NOFIX_MASK = TCMECC_SR_CPT_NOFIX_Msk,
    TCMECC_STATUS_OVER_NOFIX = TCMECC_SR_OVER_NOFIX_Msk,
    TCMECC_STATUS_HES_MASK = TCMECC_SR_HES_Msk, 
    TCMECC_STATUS_ONE = TCMECC_SR_ONE_Msk,
    TCMECC_STATUS_MEM_ID_I = TCMECC_SR_MEM_ID_I_Msk,
    TCMECC_STATUS_MEM_ID_D = TCMECC_SR_MEM_ID_D_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    TCMECC_STATUS_INVALID = 0xFFFFFFFF
} TCMECC_STATUS;

// *****************************************************************************
/* TCMECC Callback

   Summary:
    TCMECC Callback Function Pointer.

   Description:
    This data type defines the TCMECC Callback Function Pointer.

   Remarks:
    None.
*/
typedef void (*TCMECC_CALLBACK) (uintptr_t contextHandle);

// *****************************************************************************

/* TCMECC PLib Instance Object

   Summary:
    TCMECC PLib Object structure.

   Description:
    This data structure defines the TCMECC PLib Instance Object.

   Remarks:
    None.
*/
typedef struct
{
    /* Transfer Event Callback for Fixable Error interrupt*/
    TCMECC_CALLBACK fix_callback;

    /* Transfer Event Callback Context for Fixable Error interrupt*/
    uintptr_t fix_context;

    /* Transfer Event Callback for NoFixable Error interrupt */
    TCMECC_CALLBACK nofix_callback;

    /* Transfer Event Callback Context for NoFixable Error interrupt */
    uintptr_t nofix_context;
} TCMECC_OBJ;

// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************

/*
 * The following functions make up the methods (set of possible operations) of
 * this interface.
 */

void ${TCMECC_INSTANCE_NAME}_Initialize(void);

TCMECC_STATUS ${TCMECC_INSTANCE_NAME}_StatusGet(void);

uint32_t ${TCMECC_INSTANCE_NAME}_GetFailAddressITCM(void);

uint32_t ${TCMECC_INSTANCE_NAME}_GetFailAddressDTCM(void);

void ${TCMECC_INSTANCE_NAME}_ResetCounters(void);

<#if INJECTION_TEST_MODE == true>
// *****************************************************************************
// *****************************************************************************
// Section: Interface Inlined TestMode Routines
// *****************************************************************************
// *****************************************************************************
/* Function:
    void ${TCMECC_INSTANCE_NAME}_TestModeReadEnable(void)

   Summary:
    Enable the ${TCMECC_INSTANCE_NAME} peripheral test mode Read. When enabled the
    ECC check bit value read is updated in TESTCB1 register at each TCM data read.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${TCMECC_INSTANCE_NAME}_TestModeReadEnable(void)
{
    TCMECC_REGS->TCMECC_CR |= TCMECC_CR_TEST_MODE_RD_Msk;
    while ( !( TCMECC_REGS->TCMECC_CR & TCMECC_CR_TEST_MODE_RD_Msk ) );
}

// *****************************************************************************
/* Function:
    void ${TCMECC_INSTANCE_NAME}_TestModeReadDisable(void)

   Summary:
    Disable the ${TCMECC_INSTANCE_NAME} peripheral test mode Read.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${TCMECC_INSTANCE_NAME}_TestModeReadDisable(void)
{
    TCMECC_REGS->TCMECC_CR &= ~(TCMECC_CR_TEST_MODE_RD_Msk);
    while ( TCMECC_REGS->TCMECC_CR & TCMECC_CR_TEST_MODE_RD_Msk );
}

// *****************************************************************************
/* Function:
    void ${TCMECC_INSTANCE_NAME}_TestModeWriteEnable(void)

   Summary:
    Enable the ${TCMECC_INSTANCE_NAME} peripheral test mode Write. When enabled the
    ECC check bit value in TESTCB1 register is write in memory at each TCM data write
    instead of calculated check bit.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${TCMECC_INSTANCE_NAME}_TestModeWriteEnable(void)
{
    TCMECC_REGS->TCMECC_CR |= TCMECC_CR_TEST_MODE_WR_Msk;
    while ( !( TCMECC_REGS->TCMECC_CR & TCMECC_CR_TEST_MODE_WR_Msk ) );

}

// *****************************************************************************
/* Function:
    void ${TCMECC_INSTANCE_NAME}_TestModeWriteDisable(void)

   Summary:
    Disable the ${TCMECC_INSTANCE_NAME} peripheral test mode Write.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
static inline void ${TCMECC_INSTANCE_NAME}_TestModeWriteDisable(void)
{
    TCMECC_REGS->TCMECC_CR &= ~(TCMECC_CR_TEST_MODE_WR_Msk);
    while ( TCMECC_REGS->TCMECC_CR & TCMECC_CR_TEST_MODE_WR_Msk );
}

// *****************************************************************************
/* Function:
    void ${TCMECC_INSTANCE_NAME}_TestModeGetCbValue(uint8_t* tcb1, uint8_t* tcb2)

   Summary:
    Get the ${TCMECC_INSTANCE_NAME} peripheral test mode check bit values.

   Precondition:
    None.

   Parameters:
    tcb1 - pointer of the variable to be updated with test check bit 1 value.
    tcb2 - pointer of the variable to be updated with test check bit 2 value.

   Returns:
    None
*/
static inline void ${TCMECC_INSTANCE_NAME}_TestModeGetCbValue(uint8_t* tcb1, uint8_t* tcb2)
{
    uint32_t testcb1 = TCMECC_REGS->TCMECC_TESTCB1 & TCMECC_TESTCB1_Msk;
    (*tcb1) = ( (testcb1 & TCMECC_TESTCB1_TCB1_Msk) >> TCMECC_TESTCB1_TCB1_Pos );
    (*tcb2) = ( (testcb1 & TCMECC_TESTCB1_TCB2_Msk) >> TCMECC_TESTCB1_TCB2_Pos );
}

// *****************************************************************************
/* Function:
    void ${TCMECC_INSTANCE_NAME}_TestModeSetCbValue(uint8_t tcb1, uint8_t tcb2)

   Summary:
    Set the ${TCMECC_INSTANCE_NAME} peripheral test mode check bit values.

   Precondition:
    None.

   Parameters:
    tcb1 - Test check bit 1 value to set.
    tcb2 - Test check bit 2 value to set.

   Returns:
    None
*/
static inline void ${TCMECC_INSTANCE_NAME}_TestModeSetCbValue(uint8_t tcb1, uint8_t tcb2)
{
    TCMECC_REGS->TCMECC_TESTCB1 = TCMECC_TESTCB1_TCB1(tcb1) | TCMECC_TESTCB1_TCB2(tcb2);
}
</#if>


<#if INTERRUPT_MODE == true>

void ${TCMECC_INSTANCE_NAME}_FixCallbackRegister(TCMECC_CALLBACK callback, uintptr_t contextHandle);

void ${TCMECC_INSTANCE_NAME}_NoFixCallbackRegister(TCMECC_CALLBACK callback, uintptr_t contextHandle);

void TCMRAM_INTFIX_InterruptHandler(void);

void TCMRAM_NOINTFIX_InterruptHandler(void);

</#if>

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility
}
#endif
// DOM-IGNORE-END

#endif /* PLIB_${TCMECC_INSTANCE_NAME}_H */
