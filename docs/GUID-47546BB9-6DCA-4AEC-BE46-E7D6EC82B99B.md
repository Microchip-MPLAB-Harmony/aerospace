# SPW_TCH_ConfigureWatchdog

```c
void SPW_TCH_ConfigureWatchdog(uint16_t earlyNumTick, uint16_t lateNumTick)
```

**Summary**

Set SPW TCH watchdog configuration for early and late watchdog interrupts

**Preconditions**

None

**Parameters**

* *earlyNumTick* - Trigger watchdog if new Time Code before this number of tick (TimeTick clock)
* *lateNumTick* - Trigger watchdog if No new Time Code is received before this number of tick (TimeTick clock)

**Returns**

None
