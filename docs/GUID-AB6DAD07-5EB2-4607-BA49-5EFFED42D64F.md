# SPW_LINK_DistAckInterruptDisable

```c
void SPW_LINK_DistAckInterruptDisable(SPW_LINK link, SPW_LINK_DIST_ACK_MASK interruptMask)
```

**Summary**

Disables SPW LINK Distributed Acknowledge Interrupts for a given link interface.

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance.

**Parameters**

* *link* - The selected link ID
* *interruptMask* - Distributed Acknowledge Interrupts to be disabled

**Returns**

None
