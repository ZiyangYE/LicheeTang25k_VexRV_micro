package vexriscv.demo

import vexriscv.plugin._
import vexriscv.{plugin, VexRiscv, VexRiscvConfig}
import spinal.core._
import spinal.lib.cpu.riscv.debug.DebugTransportModuleParameter

object GenLAKKA_micro_dbg extends App{
  def cpu() = new VexRiscv(
    config = VexRiscvConfig(
      plugins = List(
        new IBusSimplePlugin(
          resetVector = 0x00000000l,
          cmdForkOnSecondStage = false,
          cmdForkPersistence = false,
          prediction = NONE,
          catchAccessFault = false,
          compressedGen = true,
          injectorStage = true
        ),
        new DBusSimplePlugin(
          catchAddressMisaligned = false,
          catchAccessFault = false
        ),
        new CsrPlugin(
            CsrPluginConfig(
                catchIllegalAccess = false,
                mvendorid      = null,
                marchid        = null,
                mimpid         = null,
                mhartid        = null,
                misaExtensionsInit = 66,
                misaAccess     = CsrAccess.NONE,
                mtvecAccess    = CsrAccess.NONE,
                mtvecInit      = 0x00000020l,
                mepcAccess     = CsrAccess.NONE,
                mscratchGen    = false,
                mcauseAccess   = CsrAccess.READ_ONLY,
                mbadaddrAccess = CsrAccess.NONE,
                mcycleAccess   = CsrAccess.NONE,
                minstretAccess = CsrAccess.NONE,
                ecallGen       = false,
                wfiGenAsWait   = false,
                ucycleAccess   = CsrAccess.NONE,
                uinstretAccess = CsrAccess.NONE,
                withPrivilegedDebug = true
            )
        ),
        new DecoderSimplePlugin(
          catchIllegalInstruction = false
        ),
        new RegFilePlugin(
          regFileReadyKind = plugin.ASYNC,
          rv32e = true,
          zeroBoot = false
        ),
        new IntAluPlugin,
        new SrcPlugin(
          separatedAddSub = false,
          executeInsertion = false
        ),
        new LightShifterPlugin,
        new HazardSimplePlugin(
          bypassExecute           = false,
          bypassMemory            = false,
          bypassWriteBack         = false,
          bypassWriteBackBuffer   = false,
          pessimisticUseSrc       = false,
          pessimisticWriteRegFile = false,
          pessimisticAddressMatch = false
        ),
        new BranchPlugin(
          earlyBranch = false,
          catchAddressMisaligned = false
        ),
        new EmbeddedRiscvJtag(
            p = DebugTransportModuleParameter(
                addressWidth = 7,
                version      = 1,
                idle         = 7
            ),
            debugCd = ClockDomain.current.copy(reset = Bool().setName("debugReset")),
            withTunneling = false,
            withTap = true
        ),
        new YamlPlugin("cpu0.yaml")
      )
    )
  )

  SpinalVerilog(cpu())
}
