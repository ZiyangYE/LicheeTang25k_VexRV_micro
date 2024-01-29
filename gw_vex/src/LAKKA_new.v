// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : VexRiscv
// Git hash  : 0effdecbe60a37beb8822e713745345a5dfaf7ba

`timescale 1ns/1ps
`ifndef SYNTHESIS
  `define SYNTHESIS
`endif
module VexRiscv (
  output wire          iBus_cmd_valid,
  input  wire          iBus_cmd_ready,
  output wire [31:0]   iBus_cmd_payload_pc,
  input  wire          iBus_rsp_valid,
  input  wire          iBus_rsp_payload_error,
  input  wire [31:0]   iBus_rsp_payload_inst,
  input  wire          timerInterrupt,
  input  wire          externalInterrupt,
  input  wire          softwareInterrupt,
  input  wire          jtag_tms,
  input  wire          jtag_tdi,
  output wire          jtag_tdo,
  input  wire          jtag_tck,
  output wire          ndmreset,
  output wire          dBus_cmd_valid,
  input  wire          dBus_cmd_ready,
  output wire          dBus_cmd_payload_wr,
  output wire [31:0]   dBus_cmd_payload_address,
  output wire [31:0]   dBus_cmd_payload_data,
  output wire [1:0]    dBus_cmd_payload_size,
  input  wire          dBus_rsp_ready,
  input  wire          dBus_rsp_error,
  input  wire [31:0]   dBus_rsp_data,
  input  wire          reset,
  output reg           stoptime,
  input  wire          clk,
  input  wire          debugReset
);
  localparam BranchCtrlEnum_INC = 2'd0;
  localparam BranchCtrlEnum_B = 2'd1;
  localparam BranchCtrlEnum_JAL = 2'd2;
  localparam BranchCtrlEnum_JALR = 2'd3;
  localparam ShiftCtrlEnum_DISABLE_1 = 2'd0;
  localparam ShiftCtrlEnum_SLL_1 = 2'd1;
  localparam ShiftCtrlEnum_SRL_1 = 2'd2;
  localparam ShiftCtrlEnum_SRA_1 = 2'd3;
  localparam AluBitwiseCtrlEnum_XOR_1 = 2'd0;
  localparam AluBitwiseCtrlEnum_OR_1 = 2'd1;
  localparam AluBitwiseCtrlEnum_AND_1 = 2'd2;
  localparam AluCtrlEnum_ADD_SUB = 2'd0;
  localparam AluCtrlEnum_SLT_SLTU = 2'd1;
  localparam AluCtrlEnum_BITWISE = 2'd2;
  localparam EnvCtrlEnum_NONE = 2'd0;
  localparam EnvCtrlEnum_XRET = 2'd1;
  localparam EnvCtrlEnum_EBREAK = 2'd2;
  localparam Src2CtrlEnum_RS = 2'd0;
  localparam Src2CtrlEnum_IMI = 2'd1;
  localparam Src2CtrlEnum_IMS = 2'd2;
  localparam Src2CtrlEnum_PC = 2'd3;
  localparam Src1CtrlEnum_RS = 2'd0;
  localparam Src1CtrlEnum_IMU = 2'd1;
  localparam Src1CtrlEnum_PC_INCREMENT = 2'd2;
  localparam Src1CtrlEnum_URS1 = 2'd3;
  localparam DebugDmToHartOp_DATA = 2'd0;
  localparam DebugDmToHartOp_EXECUTE = 2'd1;
  localparam DebugDmToHartOp_REG_WRITE = 2'd2;
  localparam DebugDmToHartOp_REG_READ = 2'd3;
  localparam CsrPlugin_dcsr_stepLogic_enumDef_BOOT = 2'd0;
  localparam CsrPlugin_dcsr_stepLogic_enumDef_IDLE = 2'd1;
  localparam CsrPlugin_dcsr_stepLogic_enumDef_SINGLE = 2'd2;
  localparam CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 = 2'd3;

  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_flush;
  wire       [31:0]   _zz_RegFilePlugin_regFile_port0;
  wire       [31:0]   _zz_RegFilePlugin_regFile_port1;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire       [0:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire       [0:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_availability;
  wire                reset_buffercc_io_dataOut;
  wire                debugModule_1_io_ctrl_cmd_ready;
  wire                debugModule_1_io_ctrl_rsp_valid;
  wire                debugModule_1_io_ctrl_rsp_payload_error;
  wire       [31:0]   debugModule_1_io_ctrl_rsp_payload_data;
  wire                debugModule_1_io_ndmreset;
  wire                debugModule_1_io_harts_0_resume_cmd_valid;
  wire                debugModule_1_io_harts_0_dmToHart_valid;
  wire       [1:0]    debugModule_1_io_harts_0_dmToHart_payload_op;
  wire       [4:0]    debugModule_1_io_harts_0_dmToHart_payload_address;
  wire       [31:0]   debugModule_1_io_harts_0_dmToHart_payload_data;
  wire       [2:0]    debugModule_1_io_harts_0_dmToHart_payload_size;
  wire                debugModule_1_io_harts_0_haltReq;
  wire                debugModule_1_io_harts_0_ackReset;
  wire                debugTransportModuleJtagTap_1_io_jtag_tdo;
  wire                debugTransportModuleJtagTap_1_io_bus_cmd_valid;
  wire                debugTransportModuleJtagTap_1_io_bus_cmd_payload_write;
  wire       [31:0]   debugTransportModuleJtagTap_1_io_bus_cmd_payload_data;
  wire       [6:0]    debugTransportModuleJtagTap_1_io_bus_cmd_payload_address;
  wire       [31:0]   _zz_decode_FORMAL_PC_NEXT;
  wire       [2:0]    _zz_decode_FORMAL_PC_NEXT_1;
  wire       [1:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload_1;
  wire       [1:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload_2;
  wire       [31:0]   _zz_IBusSimplePlugin_fetchPc_pc;
  wire       [2:0]    _zz_IBusSimplePlugin_fetchPc_pc_1;
  wire       [31:0]   _zz_IBusSimplePlugin_decodePc_pcPlus;
  wire       [2:0]    _zz_IBusSimplePlugin_decodePc_pcPlus_1;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_27;
  wire       [0:0]    _zz_IBusSimplePlugin_decompressor_decompressed_28;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_29;
  wire       [31:0]   _zz_IBusSimplePlugin_decompressor_decompressed_30;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_31;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_32;
  wire       [6:0]    _zz_IBusSimplePlugin_decompressor_decompressed_33;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_34;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_35;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_36;
  wire       [11:0]   _zz_IBusSimplePlugin_decompressor_decompressed_37;
  wire       [11:0]   _zz_IBusSimplePlugin_decompressor_decompressed_38;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next_1;
  wire       [0:0]    _zz_IBusSimplePlugin_pending_next_2;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next_3;
  wire       [0:0]    _zz_IBusSimplePlugin_pending_next_4;
  wire       [2:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire       [0:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1;
  wire       [2:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2;
  wire       [0:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3;
  wire       [2:0]    _zz_CsrPlugin_timeout_counter_valueNext;
  wire       [0:0]    _zz_CsrPlugin_timeout_counter_valueNext_1;
  wire       [0:0]    _zz_when;
  wire       [1:0]    _zz_CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext;
  wire       [0:0]    _zz_CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext_1;
  wire       [63:0]   _zz_CsrPlugin_mcycle;
  wire       [0:0]    _zz_CsrPlugin_mcycle_1;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_1;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_2;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_3;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_4;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_5;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_6;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_7;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_8;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_9;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_10;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_11;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_12;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_13;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_14;
  wire       [19:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_15;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_16;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_17;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_18;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_19;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_20;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_21;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_22;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_23;
  wire       [16:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_24;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_25;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_26;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_27;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_28;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_29;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_30;
  wire       [13:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_31;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_32;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_33;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_34;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_35;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_36;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_37;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_38;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_39;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_40;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_41;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_42;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_43;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_44;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_45;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_46;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_47;
  wire       [9:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_48;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_49;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_50;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_51;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_52;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_53;
  wire       [4:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_54;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_55;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_56;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_57;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_58;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_59;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_60;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_61;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_62;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_63;
  wire       [6:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_64;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_65;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_66;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_67;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_68;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_69;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_70;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_71;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_72;
  wire       [2:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_73;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_74;
  wire       [3:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_75;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_76;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_77;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_78;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_79;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_80;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_81;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_82;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_83;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_84;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_85;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_86;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_87;
  wire       [0:0]    _zz__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz__zz_decode_SRC1;
  wire       [4:0]    _zz__zz_decode_SRC1_1;
  wire       [11:0]   _zz__zz_decode_SRC2_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_4;
  wire       [31:0]   _zz__zz_execute_to_memory_REGFILE_WRITE_DATA_1;
  wire       [32:0]   _zz__zz_execute_to_memory_REGFILE_WRITE_DATA_1_1;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_branch_src2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_branch_src2_4;
  reg        [31:0]   _zz__zz_CsrPlugin_csrMapping_readDataInit_5;
  wire       [7:0]    _zz_when_CsrPlugin_l1718;
  wire       [31:0]   memory_MEMORY_READ_DATA;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [1:0]    memory_MEMORY_ADDRESS_LOW;
  wire       [1:0]    execute_MEMORY_ADDRESS_LOW;
  wire       [31:0]   decode_SRC2;
  wire       [31:0]   decode_SRC1;
  wire                decode_SRC2_FORCE_ZERO;
  wire       [31:0]   decode_RS2;
  wire       [31:0]   decode_RS1;
  wire       [1:0]    decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       [1:0]    decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       [1:0]    decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire       [1:0]    decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL_1;
  wire       [1:0]    _zz_memory_to_writeBack_ENV_CTRL;
  wire       [1:0]    _zz_memory_to_writeBack_ENV_CTRL_1;
  wire       [1:0]    _zz_execute_to_memory_ENV_CTRL;
  wire       [1:0]    _zz_execute_to_memory_ENV_CTRL_1;
  wire       [1:0]    decode_ENV_CTRL;
  wire       [1:0]    _zz_decode_ENV_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ENV_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ENV_CTRL_1;
  wire                decode_IS_CSR;
  wire                decode_MEMORY_STORE;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire                decode_MEMORY_ENABLE;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire       [31:0]   memory_BRANCH_CALC;
  wire                memory_BRANCH_DO;
  wire       [31:0]   execute_PC;
  wire       [31:0]   execute_RS1;
  wire       [1:0]    execute_BRANCH_CTRL;
  wire       [1:0]    _zz_execute_BRANCH_CTRL;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire       [1:0]    execute_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_decode_to_execute_PC;
  wire       [31:0]   _zz_decode_to_execute_RS2;
  wire       [1:0]    decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_SRC2_CTRL;
  wire       [31:0]   _zz_decode_to_execute_RS1;
  wire       [1:0]    decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       [1:0]    execute_ALU_CTRL;
  wire       [1:0]    _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       [1:0]    execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_1;
  reg                 decode_REGFILE_WRITE_VALID;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_1;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_CTRL_1;
  wire       [1:0]    _zz_decode_ENV_CTRL_1;
  wire       [1:0]    _zz_decode_SRC2_CTRL_1;
  wire       [1:0]    _zz_decode_SRC1_CTRL_1;
  reg        [31:0]   _zz_execute_to_memory_REGFILE_WRITE_DATA;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire                execute_IS_CSR;
  wire       [1:0]    memory_ENV_CTRL;
  wire       [1:0]    _zz_memory_ENV_CTRL;
  wire       [1:0]    execute_ENV_CTRL;
  wire       [1:0]    _zz_execute_ENV_CTRL;
  wire       [1:0]    writeBack_ENV_CTRL;
  wire       [1:0]    _zz_writeBack_ENV_CTRL;
  wire       [31:0]   execute_SRC1;
  reg                 CsrPlugin_running_aheadValue;
  reg        [31:0]   _zz_lastStageRegFileWrite_payload_data;
  wire                writeBack_MEMORY_ENABLE;
  wire       [1:0]    writeBack_MEMORY_ADDRESS_LOW;
  wire       [31:0]   writeBack_MEMORY_READ_DATA;
  wire                memory_MEMORY_STORE;
  wire                memory_MEMORY_ENABLE;
  wire       [31:0]   execute_SRC_ADD;
  wire       [31:0]   execute_RS2;
  wire       [31:0]   execute_INSTRUCTION;
  wire                execute_MEMORY_STORE;
  wire                execute_MEMORY_ENABLE;
  wire                execute_ALIGNEMENT_FAULT;
  reg        [31:0]   _zz_memory_to_writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   decode_PC;
  wire       [31:0]   decode_INSTRUCTION;
  wire                decode_IS_RVC;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  reg                 decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  wire                execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  wire                execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  reg                 memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  wire                writeBack_arbitration_haltItself;
  wire                writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  reg                 writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusSimplePlugin_fetcherHalt;
  wire                IBusSimplePlugin_forceNoDecodeCond;
  reg                 IBusSimplePlugin_incomingInstruction;
  wire                IBusSimplePlugin_pcValids_0;
  wire                IBusSimplePlugin_pcValids_1;
  wire                IBusSimplePlugin_pcValids_2;
  wire                IBusSimplePlugin_pcValids_3;
  wire       [31:0]   CsrPlugin_csrMapping_readDataSignal;
  wire       [31:0]   CsrPlugin_csrMapping_readDataInit;
  wire       [31:0]   CsrPlugin_csrMapping_writeDataSignal;
  reg                 CsrPlugin_csrMapping_allowCsrSignal;
  wire                CsrPlugin_csrMapping_hazardFree;
  wire                CsrPlugin_csrMapping_doForceFailCsr;
  wire                CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  wire                CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_selfException_valid;
  reg        [3:0]    CsrPlugin_selfException_payload_code;
  wire       [31:0]   CsrPlugin_selfException_payload_badAddr;
  reg                 CsrPlugin_allowInterrupts;
  wire                CsrPlugin_allowException;
  wire                CsrPlugin_allowEbreakException;
  reg                 CsrPlugin_xretAwayFromMachine;
  wire                CsrPlugin_injectionPort_valid;
  reg                 CsrPlugin_injectionPort_ready;
  wire       [31:0]   CsrPlugin_injectionPort_payload;
  wire                debugMode;
  wire                debugBus_halted;
  wire                debugBus_running;
  wire                debugBus_unavailable;
  reg                 debugBus_exception;
  wire                debugBus_commit;
  reg                 debugBus_ebreak;
  wire                debugBus_redo;
  wire                debugBus_regSuccess;
  wire                debugBus_ackReset;
  wire                debugBus_haveReset;
  wire                debugBus_resume_cmd_valid;
  reg                 debugBus_resume_rsp_valid;
  wire                debugBus_haltReq;
  wire                debugBus_dmToHart_valid;
  wire       [1:0]    debugBus_dmToHart_payload_op;
  wire       [4:0]    debugBus_dmToHart_payload_address;
  wire       [31:0]   debugBus_dmToHart_payload_data;
  wire       [2:0]    debugBus_dmToHart_payload_size;
  wire                debugBus_hartToDm_valid;
  wire       [3:0]    debugBus_hartToDm_payload_address;
  wire       [31:0]   debugBus_hartToDm_payload_data;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  reg                 BranchPlugin_inDebugNoFetchFlag;
  wire                IBusSimplePlugin_externalFlush;
  wire                IBusSimplePlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusSimplePlugin_jump_pcLoad_payload;
  wire       [1:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload;
  wire                IBusSimplePlugin_fetchPc_output_valid;
  wire                IBusSimplePlugin_fetchPc_output_ready;
  wire       [31:0]   IBusSimplePlugin_fetchPc_output_payload;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusSimplePlugin_fetchPc_correction;
  reg                 IBusSimplePlugin_fetchPc_correctionReg;
  wire                IBusSimplePlugin_fetchPc_output_fire;
  wire                IBusSimplePlugin_fetchPc_corrected;
  reg                 IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg                 IBusSimplePlugin_fetchPc_booted;
  reg                 IBusSimplePlugin_fetchPc_inc;
  wire                when_Fetcher_l133;
  wire                when_Fetcher_l133_1;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pc;
  reg                 IBusSimplePlugin_fetchPc_flushed;
  wire                when_Fetcher_l160;
  reg                 IBusSimplePlugin_decodePc_flushed;
  reg        [31:0]   IBusSimplePlugin_decodePc_pcReg /* verilator public */ ;
  wire       [31:0]   IBusSimplePlugin_decodePc_pcPlus;
  reg                 IBusSimplePlugin_decodePc_injectedDecode;
  wire                when_Fetcher_l182;
  wire                when_Fetcher_l194;
  wire                IBusSimplePlugin_iBusRsp_redoFetch;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire                IBusSimplePlugin_iBusRsp_flush;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  reg                 _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid_1;
  reg                 IBusSimplePlugin_iBusRsp_readyForError;
  wire                IBusSimplePlugin_iBusRsp_output_valid;
  wire                IBusSimplePlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire                IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_input_valid;
  wire                IBusSimplePlugin_decompressor_input_ready;
  wire       [31:0]   IBusSimplePlugin_decompressor_input_payload_pc;
  wire                IBusSimplePlugin_decompressor_input_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_decompressor_input_payload_rsp_inst;
  wire                IBusSimplePlugin_decompressor_input_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_output_valid;
  wire                IBusSimplePlugin_decompressor_output_ready;
  wire       [31:0]   IBusSimplePlugin_decompressor_output_payload_pc;
  wire                IBusSimplePlugin_decompressor_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_decompressor_output_payload_rsp_inst;
  wire                IBusSimplePlugin_decompressor_output_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_flushNext;
  wire                IBusSimplePlugin_decompressor_consumeCurrent;
  reg                 IBusSimplePlugin_decompressor_bufferValid;
  reg        [15:0]   IBusSimplePlugin_decompressor_bufferData;
  wire                IBusSimplePlugin_decompressor_isInputLowRvc;
  wire                IBusSimplePlugin_decompressor_isInputHighRvc;
  reg                 IBusSimplePlugin_decompressor_throw2BytesReg;
  wire                IBusSimplePlugin_decompressor_throw2Bytes;
  wire                IBusSimplePlugin_decompressor_unaligned;
  reg                 IBusSimplePlugin_decompressor_bufferValidLatch;
  reg                 IBusSimplePlugin_decompressor_throw2BytesLatch;
  wire                IBusSimplePlugin_decompressor_bufferValidPatched;
  wire                IBusSimplePlugin_decompressor_throw2BytesPatched;
  wire       [31:0]   IBusSimplePlugin_decompressor_raw;
  wire                IBusSimplePlugin_decompressor_isRvc;
  wire       [15:0]   _zz_IBusSimplePlugin_decompressor_decompressed;
  reg        [31:0]   IBusSimplePlugin_decompressor_decompressed;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_1;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_2;
  wire       [11:0]   _zz_IBusSimplePlugin_decompressor_decompressed_3;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_4;
  reg        [11:0]   _zz_IBusSimplePlugin_decompressor_decompressed_5;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_6;
  reg        [9:0]    _zz_IBusSimplePlugin_decompressor_decompressed_7;
  wire       [20:0]   _zz_IBusSimplePlugin_decompressor_decompressed_8;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_9;
  reg        [14:0]   _zz_IBusSimplePlugin_decompressor_decompressed_10;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_11;
  reg        [2:0]    _zz_IBusSimplePlugin_decompressor_decompressed_12;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_13;
  reg        [9:0]    _zz_IBusSimplePlugin_decompressor_decompressed_14;
  wire       [20:0]   _zz_IBusSimplePlugin_decompressor_decompressed_15;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_16;
  reg        [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_17;
  wire       [12:0]   _zz_IBusSimplePlugin_decompressor_decompressed_18;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_19;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_20;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_21;
  wire       [4:0]    switch_Misc_l44;
  wire                when_Misc_l47;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_22;
  wire       [1:0]    switch_Misc_l241;
  wire       [1:0]    switch_Misc_l241_1;
  reg        [2:0]    _zz_IBusSimplePlugin_decompressor_decompressed_23;
  reg        [2:0]    _zz_IBusSimplePlugin_decompressor_decompressed_24;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_25;
  reg        [6:0]    _zz_IBusSimplePlugin_decompressor_decompressed_26;
  wire                IBusSimplePlugin_decompressor_output_fire;
  wire                IBusSimplePlugin_decompressor_bufferFill;
  wire                when_Fetcher_l285;
  wire                when_Fetcher_l288;
  wire                when_Fetcher_l293;
  wire                IBusSimplePlugin_injector_decodeInput_valid;
  wire                IBusSimplePlugin_injector_decodeInput_ready;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire                IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire                IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_valid;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l331;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l331_1;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l331_2;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l331_3;
  reg        [31:0]   IBusSimplePlugin_injector_formal_rawInDecode;
  wire                IBusSimplePlugin_cmd_valid;
  wire                IBusSimplePlugin_cmd_ready;
  wire       [31:0]   IBusSimplePlugin_cmd_payload_pc;
  wire                IBusSimplePlugin_pending_inc;
  wire                IBusSimplePlugin_pending_dec;
  reg        [2:0]    IBusSimplePlugin_pending_value;
  wire       [2:0]    IBusSimplePlugin_pending_next;
  wire                IBusSimplePlugin_cmdFork_canEmit;
  wire                when_IBusSimplePlugin_l305;
  wire                IBusSimplePlugin_cmd_fire;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  reg        [2:0]    IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire                iBus_rsp_toStream_valid;
  wire                iBus_rsp_toStream_ready;
  wire                iBus_rsp_toStream_payload_error;
  wire       [31:0]   iBus_rsp_toStream_payload_inst;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_flush;
  wire                toplevel_IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_fire;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg                 IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire                when_IBusSimplePlugin_l376;
  wire                IBusSimplePlugin_rspJoin_join_valid;
  wire                IBusSimplePlugin_rspJoin_join_ready;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_pc;
  wire                IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire                IBusSimplePlugin_rspJoin_exceptionDetected;
  wire                IBusSimplePlugin_rspJoin_join_fire;
  wire                _zz_IBusSimplePlugin_iBusRsp_output_valid;
  wire                _zz_dBus_cmd_valid;
  reg                 execute_DBusSimplePlugin_skipCmd;
  reg        [31:0]   _zz_dBus_cmd_payload_data;
  wire                when_DBusSimplePlugin_l436;
  reg        [3:0]    _zz_execute_DBusSimplePlugin_formalMask;
  wire       [3:0]    execute_DBusSimplePlugin_formalMask;
  wire                when_DBusSimplePlugin_l490;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspShifted;
  wire       [1:0]    switch_Misc_l241_2;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_1;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspFormated;
  wire                when_DBusSimplePlugin_l566;
  reg                 when_CsrPlugin_l818;
  reg        [1:0]    _zz_CsrPlugin_privilege;
  reg                 CsrPlugin_running;
  wire                when_CsrPlugin_l711;
  reg                 CsrPlugin_reseting;
  reg                 _zz_debugBus_haveReset;
  reg                 CsrPlugin_running_aheadValue_regNext;
  wire                CsrPlugin_enterHalt;
  reg                 CsrPlugin_doHalt;
  wire                when_CsrPlugin_l729;
  wire                CsrPlugin_forceResume;
  reg                 _zz_CsrPlugin_doResume;
  wire                CsrPlugin_doResume;
  reg                 CsrPlugin_timeout_state;
  reg                 CsrPlugin_timeout_stateRise;
  wire                CsrPlugin_timeout_counter_willIncrement;
  reg                 CsrPlugin_timeout_counter_willClear;
  reg        [2:0]    CsrPlugin_timeout_counter_valueNext;
  reg        [2:0]    CsrPlugin_timeout_counter_value;
  wire                CsrPlugin_timeout_counter_willOverflowIfInc;
  wire                CsrPlugin_timeout_counter_willOverflow;
  wire                when_CsrPlugin_l735;
  reg                 _zz_debugBus_hartToDm_valid;
  reg        [31:0]   CsrPlugin_dataCsrw_value_0;
  wire                when_CsrPlugin_l750;
  wire                CsrPlugin_inject_cmd_valid;
  wire       [1:0]    CsrPlugin_inject_cmd_payload_op;
  wire       [4:0]    CsrPlugin_inject_cmd_payload_address;
  wire       [31:0]   CsrPlugin_inject_cmd_payload_data;
  wire       [2:0]    CsrPlugin_inject_cmd_payload_size;
  wire                CsrPlugin_inject_cmd_toStream_valid;
  reg                 CsrPlugin_inject_cmd_toStream_ready;
  wire       [1:0]    CsrPlugin_inject_cmd_toStream_payload_op;
  wire       [4:0]    CsrPlugin_inject_cmd_toStream_payload_address;
  wire       [31:0]   CsrPlugin_inject_cmd_toStream_payload_data;
  wire       [2:0]    CsrPlugin_inject_cmd_toStream_payload_size;
  wire                CsrPlugin_inject_buffer_valid;
  wire                CsrPlugin_inject_buffer_ready;
  wire       [1:0]    CsrPlugin_inject_buffer_payload_op;
  wire       [4:0]    CsrPlugin_inject_buffer_payload_address;
  wire       [31:0]   CsrPlugin_inject_buffer_payload_data;
  wire       [2:0]    CsrPlugin_inject_buffer_payload_size;
  reg                 CsrPlugin_inject_cmd_toStream_rValid;
  reg        [1:0]    CsrPlugin_inject_cmd_toStream_rData_op;
  reg        [4:0]    CsrPlugin_inject_cmd_toStream_rData_address;
  reg        [31:0]   CsrPlugin_inject_cmd_toStream_rData_data;
  reg        [2:0]    CsrPlugin_inject_cmd_toStream_rData_size;
  wire                when_Stream_l369;
  wire                CsrPlugin_injectionPort_fire;
  reg                 CsrPlugin_inject_pending;
  wire                when_CsrPlugin_l786;
  wire                when_CsrPlugin_l786_1;
  reg        [31:0]   CsrPlugin_dpc;
  reg        [1:0]    CsrPlugin_dcsr_prv;
  reg                 CsrPlugin_dcsr_step;
  wire                CsrPlugin_dcsr_nmip;
  wire                CsrPlugin_dcsr_mprven;
  reg        [2:0]    CsrPlugin_dcsr_cause;
  reg                 CsrPlugin_dcsr_stoptime;
  reg                 CsrPlugin_dcsr_stopcount;
  reg                 CsrPlugin_dcsr_stepie;
  reg                 CsrPlugin_dcsr_ebreakm;
  wire       [3:0]    CsrPlugin_dcsr_xdebugver;
  wire                CsrPlugin_dcsr_stepLogic_wantExit;
  reg                 CsrPlugin_dcsr_stepLogic_wantStart;
  wire                CsrPlugin_dcsr_stepLogic_wantKill;
  reg        [1:0]    CsrPlugin_dcsr_stepLogic_stateReg;
  reg        [1:0]    CsrPlugin_dcsr_stepLogic_stateNext;
  wire                when_CsrPlugin_l812;
  wire                when_CsrPlugin_l830;
  wire                when_CsrPlugin_l862;
  reg        [0:0]    CsrPlugin_trigger_tselect_index;
  wire                CsrPlugin_trigger_tselect_outOfRange;
  reg                 CsrPlugin_trigger_decodeBreak_enabled;
  reg                 CsrPlugin_trigger_decodeBreak_timeout_state;
  reg                 CsrPlugin_trigger_decodeBreak_timeout_stateRise;
  wire                CsrPlugin_trigger_decodeBreak_timeout_counter_willIncrement;
  reg                 CsrPlugin_trigger_decodeBreak_timeout_counter_willClear;
  reg        [1:0]    CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext;
  reg        [1:0]    CsrPlugin_trigger_decodeBreak_timeout_counter_value;
  wire                CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflowIfInc;
  wire                CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflow;
  wire                when_Utils_l651;
  wire                CsrPlugin_trigger_slots_0_selected;
  reg        [31:0]   CsrPlugin_trigger_slots_0_tdata1_read;
  wire       [3:0]    CsrPlugin_trigger_slots_0_tdata1_tpe;
  reg                 CsrPlugin_trigger_slots_0_tdata1_dmode;
  reg                 CsrPlugin_trigger_slots_0_tdata1_execute;
  reg                 CsrPlugin_trigger_slots_0_tdata1_m;
  reg                 CsrPlugin_trigger_slots_0_tdata1_s;
  reg                 CsrPlugin_trigger_slots_0_tdata1_u;
  reg        [3:0]    CsrPlugin_trigger_slots_0_tdata1_action;
  reg                 _zz_CsrPlugin_trigger_slots_0_tdata1_privilegeHit;
  wire                CsrPlugin_trigger_slots_0_tdata1_privilegeHit;
  reg        [31:0]   CsrPlugin_trigger_slots_0_tdata2_value;
  wire                CsrPlugin_trigger_slots_0_tdata2_execute_enabled;
  wire                CsrPlugin_trigger_slots_0_tdata2_execute_hit;
  wire                CsrPlugin_trigger_slots_1_selected;
  reg        [31:0]   CsrPlugin_trigger_slots_1_tdata1_read;
  wire       [3:0]    CsrPlugin_trigger_slots_1_tdata1_tpe;
  reg                 CsrPlugin_trigger_slots_1_tdata1_dmode;
  reg                 CsrPlugin_trigger_slots_1_tdata1_execute;
  reg                 CsrPlugin_trigger_slots_1_tdata1_m;
  reg                 CsrPlugin_trigger_slots_1_tdata1_s;
  reg                 CsrPlugin_trigger_slots_1_tdata1_u;
  reg        [3:0]    CsrPlugin_trigger_slots_1_tdata1_action;
  reg                 _zz_CsrPlugin_trigger_slots_1_tdata1_privilegeHit;
  wire                CsrPlugin_trigger_slots_1_tdata1_privilegeHit;
  reg        [31:0]   CsrPlugin_trigger_slots_1_tdata2_value;
  wire                CsrPlugin_trigger_slots_1_tdata2_execute_enabled;
  wire                CsrPlugin_trigger_slots_1_tdata2_execute_hit;
  wire                when_CsrPlugin_l958;
  wire       [1:0]    CsrPlugin_misa_base;
  wire       [25:0]   CsrPlugin_misa_extensions;
  wire       [1:0]    CsrPlugin_mtvec_mode;
  wire       [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle;
  reg        [63:0]   CsrPlugin_minstret;
  wire                _zz_when_CsrPlugin_l1302;
  wire                _zz_when_CsrPlugin_l1302_1;
  wire                _zz_when_CsrPlugin_l1302_2;
  wire                CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  wire                CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire                when_CsrPlugin_l1259;
  wire                when_CsrPlugin_l1259_1;
  wire                when_CsrPlugin_l1259_2;
  wire                when_CsrPlugin_l1272;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                when_CsrPlugin_l1296;
  wire                when_CsrPlugin_l1302;
  wire                when_CsrPlugin_l1302_1;
  wire                when_CsrPlugin_l1302_2;
  wire                when_CsrPlugin_l1315;
  wire                CsrPlugin_exception;
  wire                CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  wire                when_CsrPlugin_l1335;
  wire                when_CsrPlugin_l1335_1;
  wire                when_CsrPlugin_l1335_2;
  wire                when_CsrPlugin_l1340;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                when_CsrPlugin_l1346;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  reg                 CsrPlugin_trapCauseEbreakDebug;
  wire                when_CsrPlugin_l1373;
  wire                when_CsrPlugin_l1375;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  reg                 CsrPlugin_trapEnterDebug;
  wire                when_CsrPlugin_l1389;
  wire                when_CsrPlugin_l1390;
  wire                when_CsrPlugin_l1398;
  wire                when_CsrPlugin_l1428;
  wire                when_CsrPlugin_l1456;
  wire       [1:0]    switch_CsrPlugin_l1460;
  wire                when_CsrPlugin_l1468;
  reg                 execute_CsrPlugin_wfiWake;
  wire                when_CsrPlugin_l1527;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire                when_CsrPlugin_l1547;
  wire                when_CsrPlugin_l1548;
  wire                when_CsrPlugin_l1565;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  wire       [31:0]   execute_CsrPlugin_readToWriteData;
  wire                switch_Misc_l241_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_writeDataSignal;
  wire                when_CsrPlugin_l1587;
  wire                when_CsrPlugin_l1591;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  wire       [25:0]   _zz_decode_SRC_LESS_UNSIGNED;
  wire                _zz_decode_SRC_LESS_UNSIGNED_1;
  wire                _zz_decode_SRC_LESS_UNSIGNED_2;
  wire                _zz_decode_SRC_LESS_UNSIGNED_3;
  wire                _zz_decode_SRC_LESS_UNSIGNED_4;
  wire                _zz_decode_SRC_LESS_UNSIGNED_5;
  wire                _zz_decode_SRC_LESS_UNSIGNED_6;
  wire       [1:0]    _zz_decode_SRC1_CTRL_2;
  wire       [1:0]    _zz_decode_SRC2_CTRL_2;
  wire       [1:0]    _zz_decode_ENV_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_2;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_2;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_2;
  wire                when_RegFilePlugin_l63;
  wire                when_RegFilePlugin_l66;
  wire       [3:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [3:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [3:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_5;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_decode_SRC1;
  wire                _zz_decode_SRC2;
  reg        [19:0]   _zz_decode_SRC2_1;
  wire                _zz_decode_SRC2_2;
  reg        [19:0]   _zz_decode_SRC2_3;
  reg        [31:0]   _zz_decode_SRC2_4;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  reg                 execute_LightShifterPlugin_isActive;
  wire                execute_LightShifterPlugin_isShift;
  reg        [4:0]    execute_LightShifterPlugin_amplitudeReg;
  wire       [4:0]    execute_LightShifterPlugin_amplitude;
  wire       [31:0]   execute_LightShifterPlugin_shiftInput;
  wire                execute_LightShifterPlugin_done;
  wire                when_ShiftPlugins_l169;
  reg        [31:0]   _zz_execute_to_memory_REGFILE_WRITE_DATA_1;
  wire                when_ShiftPlugins_l175;
  wire                when_ShiftPlugins_l184;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l59;
  wire                when_HazardSimplePlugin_l62;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l59_1;
  wire                when_HazardSimplePlugin_l62_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l59_2;
  wire                when_HazardSimplePlugin_l62_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l241_4;
  reg                 _zz_execute_BRANCH_DO;
  reg                 _zz_execute_BRANCH_DO_1;
  wire       [31:0]   execute_BranchPlugin_branch_src1;
  wire                _zz_execute_BranchPlugin_branch_src2;
  reg        [10:0]   _zz_execute_BranchPlugin_branch_src2_1;
  wire                _zz_execute_BranchPlugin_branch_src2_2;
  reg        [19:0]   _zz_execute_BranchPlugin_branch_src2_3;
  wire                _zz_execute_BranchPlugin_branch_src2_4;
  reg        [18:0]   _zz_execute_BranchPlugin_branch_src2_5;
  reg        [31:0]   _zz_execute_BranchPlugin_branch_src2_6;
  wire       [31:0]   execute_BranchPlugin_branch_src2;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  reg                 toplevel_debugModule_1_io_harts_0_dmToHart_regNext_valid;
  reg        [1:0]    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op;
  reg        [4:0]    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_address;
  reg        [31:0]   toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_data;
  reg        [2:0]    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_size;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_9;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  wire                when_Pipeline_l124_10;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  wire                when_Pipeline_l124_11;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_12;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_13;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_14;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_15;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_16;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_17;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_18;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_19;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_20;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_21;
  reg                 decode_to_execute_MEMORY_STORE;
  wire                when_Pipeline_l124_22;
  reg                 execute_to_memory_MEMORY_STORE;
  wire                when_Pipeline_l124_23;
  reg                 decode_to_execute_IS_CSR;
  wire                when_Pipeline_l124_24;
  reg        [1:0]    decode_to_execute_ENV_CTRL;
  wire                when_Pipeline_l124_25;
  reg        [1:0]    execute_to_memory_ENV_CTRL;
  wire                when_Pipeline_l124_26;
  reg        [1:0]    memory_to_writeBack_ENV_CTRL;
  wire                when_Pipeline_l124_27;
  reg        [1:0]    decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_28;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_29;
  reg        [1:0]    decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_30;
  reg        [1:0]    decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_31;
  reg        [1:0]    decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_32;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_33;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_34;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_35;
  reg        [31:0]   decode_to_execute_SRC1;
  wire                when_Pipeline_l124_36;
  reg        [31:0]   decode_to_execute_SRC2;
  wire                when_Pipeline_l124_37;
  reg        [1:0]    execute_to_memory_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_38;
  reg        [1:0]    memory_to_writeBack_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_39;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_40;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_41;
  reg                 execute_to_memory_BRANCH_DO;
  wire                when_Pipeline_l124_42;
  reg        [31:0]   execute_to_memory_BRANCH_CALC;
  wire                when_Pipeline_l124_43;
  reg        [31:0]   memory_to_writeBack_MEMORY_READ_DATA;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  reg        [2:0]    IBusSimplePlugin_injector_port_state;
  wire                when_Fetcher_l373;
  wire                when_Fetcher_l391;
  wire                when_Fetcher_l411;
  wire                when_CsrPlugin_l1669;
  reg                 execute_CsrPlugin_csr_1972;
  wire                when_CsrPlugin_l1669_1;
  reg                 execute_CsrPlugin_csr_1969;
  wire                when_CsrPlugin_l1669_2;
  reg                 execute_CsrPlugin_csr_1968;
  wire                when_CsrPlugin_l1669_3;
  reg                 execute_CsrPlugin_csr_1952;
  wire                when_CsrPlugin_l1669_4;
  reg                 execute_CsrPlugin_csr_1956;
  wire                when_CsrPlugin_l1669_5;
  reg                 execute_CsrPlugin_csr_1953;
  wire                when_CsrPlugin_l1669_6;
  reg                 execute_CsrPlugin_csr_1954;
  wire                when_CsrPlugin_l1669_7;
  reg                 execute_CsrPlugin_csr_768;
  wire                when_CsrPlugin_l1669_8;
  reg                 execute_CsrPlugin_csr_836;
  wire                when_CsrPlugin_l1669_9;
  reg                 execute_CsrPlugin_csr_772;
  wire                when_CsrPlugin_l1669_10;
  reg                 execute_CsrPlugin_csr_834;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_5;
  wire       [1:0]    switch_CsrPlugin_l1031;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_6;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_7;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_8;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_9;
  wire                when_CsrPlugin_l1702;
  wire       [11:0]   _zz_when_CsrPlugin_l1709;
  wire                when_CsrPlugin_l1709;
  reg                 when_CsrPlugin_l1719;
  wire                when_CsrPlugin_l1717;
  wire                when_CsrPlugin_l1718;
  wire                when_CsrPlugin_l1725;
  `ifndef SYNTHESIS
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_1_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_1_string;
  reg [47:0] decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_1_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [47:0] _zz_decode_ENV_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [47:0] memory_ENV_CTRL_string;
  reg [47:0] _zz_memory_ENV_CTRL_string;
  reg [47:0] execute_ENV_CTRL_string;
  reg [47:0] _zz_execute_ENV_CTRL_string;
  reg [47:0] writeBack_ENV_CTRL_string;
  reg [47:0] _zz_writeBack_ENV_CTRL_string;
  reg [71:0] debugBus_dmToHart_payload_op_string;
  reg [71:0] CsrPlugin_inject_cmd_payload_op_string;
  reg [71:0] CsrPlugin_inject_cmd_toStream_payload_op_string;
  reg [71:0] CsrPlugin_inject_buffer_payload_op_string;
  reg [71:0] CsrPlugin_inject_cmd_toStream_rData_op_string;
  reg [47:0] CsrPlugin_dcsr_stepLogic_stateReg_string;
  reg [47:0] CsrPlugin_dcsr_stepLogic_stateNext_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [47:0] _zz_decode_ENV_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_2_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [71:0] toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op_string;
  reg [47:0] decode_to_execute_ENV_CTRL_string;
  reg [47:0] execute_to_memory_ENV_CTRL_string;
  reg [47:0] memory_to_writeBack_ENV_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  `endif

  (* ram_style = "distributed" *) reg [31:0] RegFilePlugin_regFile [0:15] /* verilator public */ ;

  assign _zz_decode_FORMAL_PC_NEXT_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_decode_FORMAL_PC_NEXT = {29'd0, _zz_decode_FORMAL_PC_NEXT_1};
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_1 = (_zz_IBusSimplePlugin_jump_pcLoad_payload & (~ _zz_IBusSimplePlugin_jump_pcLoad_payload_2));
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_2 = (_zz_IBusSimplePlugin_jump_pcLoad_payload - 2'b01);
  assign _zz_IBusSimplePlugin_fetchPc_pc_1 = {IBusSimplePlugin_fetchPc_inc,2'b00};
  assign _zz_IBusSimplePlugin_fetchPc_pc = {29'd0, _zz_IBusSimplePlugin_fetchPc_pc_1};
  assign _zz_IBusSimplePlugin_decodePc_pcPlus_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_IBusSimplePlugin_decodePc_pcPlus = {29'd0, _zz_IBusSimplePlugin_decodePc_pcPlus_1};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_30 = {{_zz_IBusSimplePlugin_decompressor_decompressed_10,_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2]},12'h000};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_37 = {{{4'b0000,_zz_IBusSimplePlugin_decompressor_decompressed[8 : 7]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_38 = {{{4'b0000,_zz_IBusSimplePlugin_decompressor_decompressed[8 : 7]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_IBusSimplePlugin_pending_next = (IBusSimplePlugin_pending_value + _zz_IBusSimplePlugin_pending_next_1);
  assign _zz_IBusSimplePlugin_pending_next_2 = IBusSimplePlugin_pending_inc;
  assign _zz_IBusSimplePlugin_pending_next_1 = {2'd0, _zz_IBusSimplePlugin_pending_next_2};
  assign _zz_IBusSimplePlugin_pending_next_4 = IBusSimplePlugin_pending_dec;
  assign _zz_IBusSimplePlugin_pending_next_3 = {2'd0, _zz_IBusSimplePlugin_pending_next_4};
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1 = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000));
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter = {2'd0, _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1};
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3 = IBusSimplePlugin_pending_dec;
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2 = {2'd0, _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3};
  assign _zz_CsrPlugin_timeout_counter_valueNext_1 = CsrPlugin_timeout_counter_willIncrement;
  assign _zz_CsrPlugin_timeout_counter_valueNext = {2'd0, _zz_CsrPlugin_timeout_counter_valueNext_1};
  assign _zz_when = 1'b1;
  assign _zz_CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext_1 = CsrPlugin_trigger_decodeBreak_timeout_counter_willIncrement;
  assign _zz_CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext = {1'd0, _zz_CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext_1};
  assign _zz_CsrPlugin_mcycle_1 = ((! debugMode) || (! CsrPlugin_dcsr_stopcount));
  assign _zz_CsrPlugin_mcycle = {63'd0, _zz_CsrPlugin_mcycle_1};
  assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz__zz_decode_SRC1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz__zz_decode_SRC1_1 = decode_INSTRUCTION[19 : 15];
  assign _zz__zz_decode_SRC2_2 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_execute_SrcPlugin_addSub = ($signed(_zz_execute_SrcPlugin_addSub_1) + $signed(_zz_execute_SrcPlugin_addSub_4));
  assign _zz_execute_SrcPlugin_addSub_1 = ($signed(_zz_execute_SrcPlugin_addSub_2) + $signed(_zz_execute_SrcPlugin_addSub_3));
  assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? 32'h00000001 : 32'h00000000);
  assign _zz__zz_execute_to_memory_REGFILE_WRITE_DATA_1 = (_zz__zz_execute_to_memory_REGFILE_WRITE_DATA_1_1 >>> 1'd1);
  assign _zz__zz_execute_to_memory_REGFILE_WRITE_DATA_1_1 = {((execute_SHIFT_CTRL == ShiftCtrlEnum_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz__zz_execute_BranchPlugin_branch_src2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_branch_src2_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_when_CsrPlugin_l1718 = (execute_CsrPlugin_csrAddress >>> 3'd4);
  assign _zz_IBusSimplePlugin_decompressor_decompressed_27 = {_zz_IBusSimplePlugin_decompressor_decompressed_12,_zz_IBusSimplePlugin_decompressor_decompressed[4 : 3]};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_28 = _zz_IBusSimplePlugin_decompressor_decompressed[5];
  assign _zz_IBusSimplePlugin_decompressor_decompressed_29 = _zz_IBusSimplePlugin_decompressor_decompressed[2];
  assign _zz_IBusSimplePlugin_decompressor_decompressed_31 = (_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] == 2'b01);
  assign _zz_IBusSimplePlugin_decompressor_decompressed_32 = ((_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] == 2'b11) && (_zz_IBusSimplePlugin_decompressor_decompressed[6 : 5] == 2'b00));
  assign _zz_IBusSimplePlugin_decompressor_decompressed_33 = 7'h00;
  assign _zz_IBusSimplePlugin_decompressor_decompressed_34 = _zz_IBusSimplePlugin_decompressor_decompressed[6 : 2];
  assign _zz_IBusSimplePlugin_decompressor_decompressed_35 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  assign _zz_IBusSimplePlugin_decompressor_decompressed_36 = _zz_IBusSimplePlugin_decompressor_decompressed[11 : 7];
  assign _zz__zz_decode_SRC_LESS_UNSIGNED = (decode_INSTRUCTION & 32'h0000001c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_1 = 32'h00000004;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_2 = (decode_INSTRUCTION & 32'h00000058);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_3 = 32'h00000040;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_4 = ((decode_INSTRUCTION & 32'h00007054) == 32'h00005010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_5 = {(_zz__zz_decode_SRC_LESS_UNSIGNED_6 == _zz__zz_decode_SRC_LESS_UNSIGNED_7),(_zz__zz_decode_SRC_LESS_UNSIGNED_8 == _zz__zz_decode_SRC_LESS_UNSIGNED_9)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_10 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_11,_zz__zz_decode_SRC_LESS_UNSIGNED_12});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_13 = (|_zz__zz_decode_SRC_LESS_UNSIGNED_14);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_15 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_16),{_zz__zz_decode_SRC_LESS_UNSIGNED_18,{_zz__zz_decode_SRC_LESS_UNSIGNED_21,_zz__zz_decode_SRC_LESS_UNSIGNED_24}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_6 = (decode_INSTRUCTION & 32'h40003054);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_7 = 32'h40001010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_8 = (decode_INSTRUCTION & 32'h00007054);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_9 = 32'h00001010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_11 = ((decode_INSTRUCTION & 32'h00000064) == 32'h00000024);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_12 = ((decode_INSTRUCTION & 32'h00003054) == 32'h00001010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_14 = ((decode_INSTRUCTION & 32'h00001000) == 32'h00001000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_16 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_17) == 32'h00002000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_18 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_19,_zz__zz_decode_SRC_LESS_UNSIGNED_20});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_21 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_22,_zz__zz_decode_SRC_LESS_UNSIGNED_23});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_24 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_25),{_zz__zz_decode_SRC_LESS_UNSIGNED_26,{_zz__zz_decode_SRC_LESS_UNSIGNED_28,_zz__zz_decode_SRC_LESS_UNSIGNED_31}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_17 = 32'h00003000;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_19 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_20 = ((decode_INSTRUCTION & 32'h00005000) == 32'h00001000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_22 = ((decode_INSTRUCTION & 32'h00006004) == 32'h00006000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_23 = ((decode_INSTRUCTION & 32'h00005004) == 32'h00004000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_25 = _zz_decode_SRC_LESS_UNSIGNED_2;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_26 = (|((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_27) == 32'h00000050));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_28 = (|(_zz__zz_decode_SRC_LESS_UNSIGNED_29 == _zz__zz_decode_SRC_LESS_UNSIGNED_30));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_31 = {(|{_zz__zz_decode_SRC_LESS_UNSIGNED_32,_zz__zz_decode_SRC_LESS_UNSIGNED_34}),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_36),{_zz__zz_decode_SRC_LESS_UNSIGNED_41,{_zz__zz_decode_SRC_LESS_UNSIGNED_46,_zz__zz_decode_SRC_LESS_UNSIGNED_48}}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_27 = 32'h10003050;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_29 = (decode_INSTRUCTION & 32'h00103050);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_30 = 32'h00000050;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_32 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_33) == 32'h00001050);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_34 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_35) == 32'h00002050);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_36 = {(_zz__zz_decode_SRC_LESS_UNSIGNED_37 == _zz__zz_decode_SRC_LESS_UNSIGNED_38),(_zz__zz_decode_SRC_LESS_UNSIGNED_39 == _zz__zz_decode_SRC_LESS_UNSIGNED_40)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_41 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_42,{_zz__zz_decode_SRC_LESS_UNSIGNED_43,_zz__zz_decode_SRC_LESS_UNSIGNED_44}});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_46 = (|_zz__zz_decode_SRC_LESS_UNSIGNED_47);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_48 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_49),{_zz__zz_decode_SRC_LESS_UNSIGNED_51,{_zz__zz_decode_SRC_LESS_UNSIGNED_52,_zz__zz_decode_SRC_LESS_UNSIGNED_64}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_33 = 32'h00001050;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_35 = 32'h00002050;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_37 = (decode_INSTRUCTION & 32'h00000034);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_38 = 32'h00000020;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_39 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_40 = 32'h00000020;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_42 = ((decode_INSTRUCTION & 32'h00000050) == 32'h00000040);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_43 = _zz_decode_SRC_LESS_UNSIGNED_3;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_44 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_45) == 32'h00000040);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_47 = ((decode_INSTRUCTION & 32'h00000020) == 32'h00000020);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_49 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_50) == 32'h00000010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_51 = (|_zz_decode_SRC_LESS_UNSIGNED_5);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_52 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_53,_zz__zz_decode_SRC_LESS_UNSIGNED_54});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_64 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_65),{_zz__zz_decode_SRC_LESS_UNSIGNED_68,{_zz__zz_decode_SRC_LESS_UNSIGNED_70,_zz__zz_decode_SRC_LESS_UNSIGNED_75}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_45 = 32'h00003040;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_50 = 32'h00000010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_53 = _zz_decode_SRC_LESS_UNSIGNED_6;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_54 = {(_zz__zz_decode_SRC_LESS_UNSIGNED_55 == _zz__zz_decode_SRC_LESS_UNSIGNED_56),{_zz__zz_decode_SRC_LESS_UNSIGNED_57,{_zz__zz_decode_SRC_LESS_UNSIGNED_58,_zz__zz_decode_SRC_LESS_UNSIGNED_59}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_65 = {_zz_decode_SRC_LESS_UNSIGNED_4,(_zz__zz_decode_SRC_LESS_UNSIGNED_66 == _zz__zz_decode_SRC_LESS_UNSIGNED_67)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_68 = (|{_zz_decode_SRC_LESS_UNSIGNED_4,_zz__zz_decode_SRC_LESS_UNSIGNED_69});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_70 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_71,_zz__zz_decode_SRC_LESS_UNSIGNED_73});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_75 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_76),{_zz__zz_decode_SRC_LESS_UNSIGNED_78,{_zz__zz_decode_SRC_LESS_UNSIGNED_82,_zz__zz_decode_SRC_LESS_UNSIGNED_85}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_55 = (decode_INSTRUCTION & 32'h00001010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_56 = 32'h00001010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_57 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_58 = _zz_decode_SRC_LESS_UNSIGNED_5;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_59 = {(_zz__zz_decode_SRC_LESS_UNSIGNED_60 == _zz__zz_decode_SRC_LESS_UNSIGNED_61),(_zz__zz_decode_SRC_LESS_UNSIGNED_62 == _zz__zz_decode_SRC_LESS_UNSIGNED_63)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_66 = (decode_INSTRUCTION & 32'h00000070);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_67 = 32'h00000020;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_69 = ((decode_INSTRUCTION & 32'h00000020) == 32'h00000000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_71 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_72) == 32'h00000000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_73 = {_zz_decode_SRC_LESS_UNSIGNED_3,{_zz_decode_SRC_LESS_UNSIGNED_2,_zz__zz_decode_SRC_LESS_UNSIGNED_74}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_76 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_77) == 32'h00000000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_78 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_79,{_zz__zz_decode_SRC_LESS_UNSIGNED_80,_zz__zz_decode_SRC_LESS_UNSIGNED_81}});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_82 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_83,_zz__zz_decode_SRC_LESS_UNSIGNED_84});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_85 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_86,_zz__zz_decode_SRC_LESS_UNSIGNED_87});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_60 = (decode_INSTRUCTION & 32'h0000000c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_61 = 32'h00000004;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_62 = (decode_INSTRUCTION & 32'h00000028);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_63 = 32'h00000000;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_72 = 32'h00000044;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_74 = ((decode_INSTRUCTION & 32'h00005004) == 32'h00001000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_77 = 32'h00000058;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_79 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000040);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_80 = ((decode_INSTRUCTION & 32'h00002014) == 32'h00002010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_81 = ((decode_INSTRUCTION & 32'h40004034) == 32'h40000030);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_83 = ((decode_INSTRUCTION & 32'h00000014) == 32'h00000004);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_84 = _zz_decode_SRC_LESS_UNSIGNED_1;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_86 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000004);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_87 = _zz_decode_SRC_LESS_UNSIGNED_1;
  assign _zz_RegFilePlugin_regFile_port0 = RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
  assign _zz_RegFilePlugin_regFile_port1 = RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
  always @(posedge clk) begin
    if(_zz_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rspJoin_rspBuffer_c (
    .io_push_valid         (iBus_rsp_toStream_valid                                       ), //i
    .io_push_ready         (IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready            ), //o
    .io_push_payload_error (iBus_rsp_toStream_payload_error                               ), //i
    .io_push_payload_inst  (iBus_rsp_toStream_payload_inst[31:0]                          ), //i
    .io_pop_valid          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid             ), //o
    .io_pop_ready          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready             ), //i
    .io_pop_payload_error  (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error     ), //o
    .io_pop_payload_inst   (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst[31:0]), //o
    .io_flush              (IBusSimplePlugin_rspJoin_rspBuffer_c_io_flush                 ), //i
    .io_occupancy          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy             ), //o
    .io_availability       (IBusSimplePlugin_rspJoin_rspBuffer_c_io_availability          ), //o
    .clk                   (clk                                                           ), //i
    .reset                 (reset                                                         )  //i
  );
  BufferCC reset_buffercc (
    .io_dataIn  (reset                    ), //i
    .io_dataOut (reset_buffercc_io_dataOut), //o
    .clk        (clk                      ), //i
    .reset      (reset                    )  //i
  );
  DebugModule debugModule_1 (
    .io_ctrl_cmd_valid                   (debugTransportModuleJtagTap_1_io_bus_cmd_valid               ), //i
    .io_ctrl_cmd_ready                   (debugModule_1_io_ctrl_cmd_ready                              ), //o
    .io_ctrl_cmd_payload_write           (debugTransportModuleJtagTap_1_io_bus_cmd_payload_write       ), //i
    .io_ctrl_cmd_payload_data            (debugTransportModuleJtagTap_1_io_bus_cmd_payload_data[31:0]  ), //i
    .io_ctrl_cmd_payload_address         (debugTransportModuleJtagTap_1_io_bus_cmd_payload_address[6:0]), //i
    .io_ctrl_rsp_valid                   (debugModule_1_io_ctrl_rsp_valid                              ), //o
    .io_ctrl_rsp_payload_error           (debugModule_1_io_ctrl_rsp_payload_error                      ), //o
    .io_ctrl_rsp_payload_data            (debugModule_1_io_ctrl_rsp_payload_data[31:0]                 ), //o
    .io_ndmreset                         (debugModule_1_io_ndmreset                                    ), //o
    .io_harts_0_halted                   (debugBus_halted                                              ), //i
    .io_harts_0_running                  (debugBus_running                                             ), //i
    .io_harts_0_unavailable              (debugBus_unavailable                                         ), //i
    .io_harts_0_exception                (debugBus_exception                                           ), //i
    .io_harts_0_commit                   (debugBus_commit                                              ), //i
    .io_harts_0_ebreak                   (debugBus_ebreak                                              ), //i
    .io_harts_0_redo                     (debugBus_redo                                                ), //i
    .io_harts_0_regSuccess               (debugBus_regSuccess                                          ), //i
    .io_harts_0_ackReset                 (debugModule_1_io_harts_0_ackReset                            ), //o
    .io_harts_0_haveReset                (debugBus_haveReset                                           ), //i
    .io_harts_0_resume_cmd_valid         (debugModule_1_io_harts_0_resume_cmd_valid                    ), //o
    .io_harts_0_resume_rsp_valid         (debugBus_resume_rsp_valid                                    ), //i
    .io_harts_0_haltReq                  (debugModule_1_io_harts_0_haltReq                             ), //o
    .io_harts_0_dmToHart_valid           (debugModule_1_io_harts_0_dmToHart_valid                      ), //o
    .io_harts_0_dmToHart_payload_op      (debugModule_1_io_harts_0_dmToHart_payload_op[1:0]            ), //o
    .io_harts_0_dmToHart_payload_address (debugModule_1_io_harts_0_dmToHart_payload_address[4:0]       ), //o
    .io_harts_0_dmToHart_payload_data    (debugModule_1_io_harts_0_dmToHart_payload_data[31:0]         ), //o
    .io_harts_0_dmToHart_payload_size    (debugModule_1_io_harts_0_dmToHart_payload_size[2:0]          ), //o
    .io_harts_0_hartToDm_valid           (debugBus_hartToDm_valid                                      ), //i
    .io_harts_0_hartToDm_payload_address (debugBus_hartToDm_payload_address[3:0]                       ), //i
    .io_harts_0_hartToDm_payload_data    (debugBus_hartToDm_payload_data[31:0]                         ), //i
    .clk                                 (clk                                                          ), //i
    .debugReset                          (debugReset                                                   )  //i
  );
  DebugTransportModuleJtagTap debugTransportModuleJtagTap_1 (
    .io_jtag_tms                (jtag_tms                                                     ), //i
    .io_jtag_tdi                (jtag_tdi                                                     ), //i
    .io_jtag_tdo                (debugTransportModuleJtagTap_1_io_jtag_tdo                    ), //o
    .io_jtag_tck                (jtag_tck                                                     ), //i
    .io_bus_cmd_valid           (debugTransportModuleJtagTap_1_io_bus_cmd_valid               ), //o
    .io_bus_cmd_ready           (debugModule_1_io_ctrl_cmd_ready                              ), //i
    .io_bus_cmd_payload_write   (debugTransportModuleJtagTap_1_io_bus_cmd_payload_write       ), //o
    .io_bus_cmd_payload_data    (debugTransportModuleJtagTap_1_io_bus_cmd_payload_data[31:0]  ), //o
    .io_bus_cmd_payload_address (debugTransportModuleJtagTap_1_io_bus_cmd_payload_address[6:0]), //o
    .io_bus_rsp_valid           (debugModule_1_io_ctrl_rsp_valid                              ), //i
    .io_bus_rsp_payload_error   (debugModule_1_io_ctrl_rsp_payload_error                      ), //i
    .io_bus_rsp_payload_data    (debugModule_1_io_ctrl_rsp_payload_data[31:0]                 ), //i
    .clk                        (clk                                                          ), //i
    .debugReset                 (debugReset                                                   )  //i
  );
  always @(*) begin
    case(CsrPlugin_trigger_tselect_index)
      1'b0 : _zz__zz_CsrPlugin_csrMapping_readDataInit_5 = CsrPlugin_trigger_slots_0_tdata1_read;
      default : _zz__zz_CsrPlugin_csrMapping_readDataInit_5 = CsrPlugin_trigger_slots_1_tdata1_read;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_1_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_execute_to_memory_ENV_CTRL_1_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : decode_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : decode_ENV_CTRL_string = "EBREAK";
      default : decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_decode_to_execute_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : memory_ENV_CTRL_string = "EBREAK";
      default : memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : execute_ENV_CTRL_string = "EBREAK";
      default : execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : writeBack_ENV_CTRL_string = "EBREAK";
      default : writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(debugBus_dmToHart_payload_op)
      DebugDmToHartOp_DATA : debugBus_dmToHart_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : debugBus_dmToHart_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : debugBus_dmToHart_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : debugBus_dmToHart_payload_op_string = "REG_READ ";
      default : debugBus_dmToHart_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(CsrPlugin_inject_cmd_payload_op)
      DebugDmToHartOp_DATA : CsrPlugin_inject_cmd_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : CsrPlugin_inject_cmd_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : CsrPlugin_inject_cmd_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : CsrPlugin_inject_cmd_payload_op_string = "REG_READ ";
      default : CsrPlugin_inject_cmd_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(CsrPlugin_inject_cmd_toStream_payload_op)
      DebugDmToHartOp_DATA : CsrPlugin_inject_cmd_toStream_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : CsrPlugin_inject_cmd_toStream_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : CsrPlugin_inject_cmd_toStream_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : CsrPlugin_inject_cmd_toStream_payload_op_string = "REG_READ ";
      default : CsrPlugin_inject_cmd_toStream_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(CsrPlugin_inject_buffer_payload_op)
      DebugDmToHartOp_DATA : CsrPlugin_inject_buffer_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : CsrPlugin_inject_buffer_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : CsrPlugin_inject_buffer_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : CsrPlugin_inject_buffer_payload_op_string = "REG_READ ";
      default : CsrPlugin_inject_buffer_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(CsrPlugin_inject_cmd_toStream_rData_op)
      DebugDmToHartOp_DATA : CsrPlugin_inject_cmd_toStream_rData_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : CsrPlugin_inject_cmd_toStream_rData_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : CsrPlugin_inject_cmd_toStream_rData_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : CsrPlugin_inject_cmd_toStream_rData_op_string = "REG_READ ";
      default : CsrPlugin_inject_cmd_toStream_rData_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(CsrPlugin_dcsr_stepLogic_stateReg)
      CsrPlugin_dcsr_stepLogic_enumDef_BOOT : CsrPlugin_dcsr_stepLogic_stateReg_string = "BOOT  ";
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : CsrPlugin_dcsr_stepLogic_stateReg_string = "IDLE  ";
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : CsrPlugin_dcsr_stepLogic_stateReg_string = "SINGLE";
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : CsrPlugin_dcsr_stepLogic_stateReg_string = "WAIT_1";
      default : CsrPlugin_dcsr_stepLogic_stateReg_string = "??????";
    endcase
  end
  always @(*) begin
    case(CsrPlugin_dcsr_stepLogic_stateNext)
      CsrPlugin_dcsr_stepLogic_enumDef_BOOT : CsrPlugin_dcsr_stepLogic_stateNext_string = "BOOT  ";
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : CsrPlugin_dcsr_stepLogic_stateNext_string = "IDLE  ";
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : CsrPlugin_dcsr_stepLogic_stateNext_string = "SINGLE";
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : CsrPlugin_dcsr_stepLogic_stateNext_string = "WAIT_1";
      default : CsrPlugin_dcsr_stepLogic_stateNext_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_2)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_2_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_2_string = "XRET  ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_2_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_2)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_2_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_2_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_2_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_2_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_2_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op)
      DebugDmToHartOp_DATA : toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op_string = "REG_READ ";
      default : toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_to_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : decode_to_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_to_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : execute_to_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_EBREAK : memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  `endif

  always @(*) begin
    CsrPlugin_running_aheadValue = CsrPlugin_running;
    if(CsrPlugin_trigger_decodeBreak_enabled) begin
      if(CsrPlugin_trigger_decodeBreak_timeout_state) begin
        CsrPlugin_running_aheadValue = 1'b0;
      end
    end
    if(when_CsrPlugin_l1390) begin
      if(!when_CsrPlugin_l1398) begin
        CsrPlugin_running_aheadValue = 1'b0;
      end
    end
    if(CsrPlugin_doResume) begin
      CsrPlugin_running_aheadValue = 1'b1;
    end
  end

  assign memory_MEMORY_READ_DATA = dBus_rsp_data;
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_DO = _zz_execute_BRANCH_DO_1;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = dBus_cmd_payload_address[1 : 0];
  assign decode_SRC2 = _zz_decode_SRC2_4;
  assign decode_SRC1 = _zz_decode_SRC1;
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign decode_RS2 = decode_RegFilePlugin_rs2Data;
  assign decode_RS1 = decode_RegFilePlugin_rs1Data;
  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_SRC_LESS_UNSIGNED[18];
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
  assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1;
  assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1;
  assign decode_ENV_CTRL = _zz_decode_ENV_CTRL;
  assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1;
  assign decode_IS_CSR = _zz_decode_SRC_LESS_UNSIGNED[13];
  assign decode_MEMORY_STORE = _zz_decode_SRC_LESS_UNSIGNED[10];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_SRC_LESS_UNSIGNED[9];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_SRC_LESS_UNSIGNED[8];
  assign decode_MEMORY_ENABLE = _zz_decode_SRC_LESS_UNSIGNED[3];
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20);
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h00)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h00))));
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = (decode_PC + _zz_decode_FORMAL_PC_NEXT);
  assign memory_PC = execute_to_memory_PC;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
  assign decode_RS2_USE = _zz_decode_SRC_LESS_UNSIGNED[12];
  assign decode_RS1_USE = _zz_decode_SRC_LESS_UNSIGNED[4];
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_decode_to_execute_PC = decode_PC;
  assign _zz_decode_to_execute_RS2 = decode_RS2;
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
  assign _zz_decode_to_execute_RS1 = decode_RS1;
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
  assign decode_SRC_USE_SUB_LESS = _zz_decode_SRC_LESS_UNSIGNED[2];
  assign decode_SRC_ADD_ZERO = _zz_decode_SRC_LESS_UNSIGNED[21];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
  assign execute_SRC2 = decode_to_execute_SRC2;
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    _zz_1 = 1'b0;
    if(lastStageRegFileWrite_valid) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_SRC_LESS_UNSIGNED[7];
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
    if(when_RegFilePlugin_l66) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @(*) begin
    _zz_execute_to_memory_REGFILE_WRITE_DATA = execute_REGFILE_WRITE_DATA;
    if(when_CsrPlugin_l1587) begin
      _zz_execute_to_memory_REGFILE_WRITE_DATA = CsrPlugin_csrMapping_readDataSignal;
    end
    if(when_ShiftPlugins_l169) begin
      _zz_execute_to_memory_REGFILE_WRITE_DATA = _zz_execute_to_memory_REGFILE_WRITE_DATA_1;
    end
  end

  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_memory_ENV_CTRL;
  assign execute_ENV_CTRL = _zz_execute_ENV_CTRL;
  assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL;
  assign execute_SRC1 = decode_to_execute_SRC1;
  always @(*) begin
    _zz_lastStageRegFileWrite_payload_data = writeBack_REGFILE_WRITE_DATA;
    if(when_DBusSimplePlugin_l566) begin
      _zz_lastStageRegFileWrite_payload_data = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_MEMORY_STORE = execute_to_memory_MEMORY_STORE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = 1'b0;
  always @(*) begin
    _zz_memory_to_writeBack_FORMAL_PC_NEXT = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid) begin
      _zz_memory_to_writeBack_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload;
    end
  end

  assign decode_PC = IBusSimplePlugin_decodePc_pcReg;
  assign decode_INSTRUCTION = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign decode_IS_RVC = IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @(*) begin
    decode_arbitration_haltItself = 1'b0;
    case(IBusSimplePlugin_injector_port_state)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    decode_arbitration_haltByOther = 1'b0;
    case(CsrPlugin_dcsr_stepLogic_stateReg)
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : begin
      end
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : begin
      end
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : begin
        if(decode_arbitration_isValid) begin
          decode_arbitration_haltByOther = 1'b1;
        end
      end
      default : begin
      end
    endcase
    if(CsrPlugin_trigger_decodeBreak_enabled) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_pipelineLiberator_active) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_CsrPlugin_l1527) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0;
    if(CsrPlugin_trigger_decodeBreak_enabled) begin
      if(CsrPlugin_trigger_decodeBreak_timeout_state) begin
        decode_arbitration_removeIt = 1'b1;
      end
    end
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  always @(*) begin
    decode_arbitration_flushNext = 1'b0;
    if(CsrPlugin_trigger_decodeBreak_enabled) begin
      if(CsrPlugin_trigger_decodeBreak_timeout_state) begin
        decode_arbitration_flushNext = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l436) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_CsrPlugin_l1591) begin
      if(execute_CsrPlugin_blockedBySideEffects) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(when_ShiftPlugins_l169) begin
      if(when_ShiftPlugins_l184) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign execute_arbitration_haltByOther = 1'b0;
  always @(*) begin
    execute_arbitration_removeIt = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_removeIt = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  assign execute_arbitration_flushIt = 1'b0;
  always @(*) begin
    execute_arbitration_flushNext = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    memory_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l490) begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @(*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @(*) begin
    memory_arbitration_flushNext = 1'b0;
    if(BranchPlugin_jumpInterface_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_flushIt = 1'b0;
    if(CsrPlugin_doResume) begin
      writeBack_arbitration_flushIt = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(when_CsrPlugin_l1390) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1456) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @(*) begin
    IBusSimplePlugin_fetcherHalt = 1'b0;
    if(when_CsrPlugin_l711) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1272) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1390) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1456) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
  end

  assign IBusSimplePlugin_forceNoDecodeCond = 1'b0;
  always @(*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_csrMapping_allowCsrSignal = 1'b0;
    if(when_CsrPlugin_l1702) begin
      CsrPlugin_csrMapping_allowCsrSignal = 1'b1;
    end
    if(when_CsrPlugin_l1709) begin
      CsrPlugin_csrMapping_allowCsrSignal = 1'b1;
    end
  end

  assign CsrPlugin_csrMapping_doForceFailCsr = 1'b0;
  assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit;
  assign CsrPlugin_inWfi = 1'b0;
  always @(*) begin
    CsrPlugin_thirdPartyWake = 1'b0;
    if(when_CsrPlugin_l862) begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(when_CsrPlugin_l1390) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(when_CsrPlugin_l1456) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(CsrPlugin_doResume) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_CsrPlugin_l1390) begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00};
    end
    if(when_CsrPlugin_l1456) begin
      case(switch_CsrPlugin_l1460)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        default : begin
        end
      endcase
    end
    if(CsrPlugin_doResume) begin
      CsrPlugin_jumpInterface_payload = CsrPlugin_dpc;
    end
  end

  assign CsrPlugin_forceMachineWire = 1'b0;
  always @(*) begin
    CsrPlugin_allowInterrupts = 1'b1;
    if(debugMode) begin
      CsrPlugin_allowInterrupts = 1'b0;
    end
  end

  assign CsrPlugin_allowException = 1'b1;
  assign CsrPlugin_allowEbreakException = 1'b1;
  always @(*) begin
    CsrPlugin_xretAwayFromMachine = 1'b0;
    if(when_CsrPlugin_l1456) begin
      case(switch_CsrPlugin_l1460)
        2'b11 : begin
          if(when_CsrPlugin_l1468) begin
            CsrPlugin_xretAwayFromMachine = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    BranchPlugin_inDebugNoFetchFlag = 1'b0;
    if(debugMode) begin
      BranchPlugin_inDebugNoFetchFlag = 1'b1;
    end
  end

  assign IBusSimplePlugin_externalFlush = (|{writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}});
  assign IBusSimplePlugin_jump_pcLoad_valid = (|{BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid});
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload = {BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid};
  assign IBusSimplePlugin_jump_pcLoad_payload = (_zz_IBusSimplePlugin_jump_pcLoad_payload_1[0] ? CsrPlugin_jumpInterface_payload : BranchPlugin_jumpInterface_payload);
  always @(*) begin
    IBusSimplePlugin_fetchPc_correction = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_correction = 1'b1;
    end
  end

  assign IBusSimplePlugin_fetchPc_output_fire = (IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready);
  assign IBusSimplePlugin_fetchPc_corrected = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_correctionReg);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready) begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  assign when_Fetcher_l133 = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_pcRegPropagate);
  assign when_Fetcher_l133_1 = ((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_IBusSimplePlugin_fetchPc_pc);
    if(IBusSimplePlugin_fetchPc_inc) begin
      IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
    end
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
  end

  always @(*) begin
    IBusSimplePlugin_fetchPc_flushed = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign when_Fetcher_l160 = (IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetchPc_correction) || IBusSimplePlugin_fetchPc_pcRegPropagate));
  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  always @(*) begin
    IBusSimplePlugin_decodePc_flushed = 1'b0;
    if(when_Fetcher_l194) begin
      IBusSimplePlugin_decodePc_flushed = 1'b1;
    end
  end

  assign IBusSimplePlugin_decodePc_pcPlus = (IBusSimplePlugin_decodePc_pcReg + _zz_IBusSimplePlugin_decodePc_pcPlus);
  always @(*) begin
    IBusSimplePlugin_decodePc_injectedDecode = 1'b0;
    if(when_Fetcher_l373) begin
      IBusSimplePlugin_decodePc_injectedDecode = 1'b1;
    end
  end

  assign when_Fetcher_l182 = (decode_arbitration_isFiring && (! IBusSimplePlugin_decodePc_injectedDecode));
  assign when_Fetcher_l194 = (IBusSimplePlugin_jump_pcLoad_valid && ((! decode_arbitration_isStuck) || decode_arbitration_removeIt));
  assign IBusSimplePlugin_iBusRsp_redoFetch = 1'b0;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
    if(when_IBusSimplePlugin_l305) begin
      IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_flush = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_iBusRsp_redoFetch);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready = ((1'b0 && (! _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid)) || IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid_1;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_decompressor_input_valid = (IBusSimplePlugin_iBusRsp_output_valid && (! IBusSimplePlugin_iBusRsp_redoFetch));
  assign IBusSimplePlugin_decompressor_input_payload_pc = IBusSimplePlugin_iBusRsp_output_payload_pc;
  assign IBusSimplePlugin_decompressor_input_payload_rsp_error = IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  assign IBusSimplePlugin_decompressor_input_payload_rsp_inst = IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  assign IBusSimplePlugin_decompressor_input_payload_isRvc = IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  assign IBusSimplePlugin_iBusRsp_output_ready = IBusSimplePlugin_decompressor_input_ready;
  assign IBusSimplePlugin_decompressor_flushNext = 1'b0;
  assign IBusSimplePlugin_decompressor_consumeCurrent = 1'b0;
  assign IBusSimplePlugin_decompressor_isInputLowRvc = (IBusSimplePlugin_decompressor_input_payload_rsp_inst[1 : 0] != 2'b11);
  assign IBusSimplePlugin_decompressor_isInputHighRvc = (IBusSimplePlugin_decompressor_input_payload_rsp_inst[17 : 16] != 2'b11);
  assign IBusSimplePlugin_decompressor_throw2Bytes = (IBusSimplePlugin_decompressor_throw2BytesReg || IBusSimplePlugin_decompressor_input_payload_pc[1]);
  assign IBusSimplePlugin_decompressor_unaligned = (IBusSimplePlugin_decompressor_throw2Bytes || IBusSimplePlugin_decompressor_bufferValid);
  assign IBusSimplePlugin_decompressor_bufferValidPatched = (IBusSimplePlugin_decompressor_input_valid ? IBusSimplePlugin_decompressor_bufferValid : IBusSimplePlugin_decompressor_bufferValidLatch);
  assign IBusSimplePlugin_decompressor_throw2BytesPatched = (IBusSimplePlugin_decompressor_input_valid ? IBusSimplePlugin_decompressor_throw2Bytes : IBusSimplePlugin_decompressor_throw2BytesLatch);
  assign IBusSimplePlugin_decompressor_raw = (IBusSimplePlugin_decompressor_bufferValidPatched ? {IBusSimplePlugin_decompressor_input_payload_rsp_inst[15 : 0],IBusSimplePlugin_decompressor_bufferData} : {IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16],(IBusSimplePlugin_decompressor_throw2BytesPatched ? IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16] : IBusSimplePlugin_decompressor_input_payload_rsp_inst[15 : 0])});
  assign IBusSimplePlugin_decompressor_isRvc = (IBusSimplePlugin_decompressor_raw[1 : 0] != 2'b11);
  assign _zz_IBusSimplePlugin_decompressor_decompressed = IBusSimplePlugin_decompressor_raw[15 : 0];
  always @(*) begin
    IBusSimplePlugin_decompressor_decompressed = 32'h00000000;
    case(switch_Misc_l44)
      5'h00 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{{2'b00,_zz_IBusSimplePlugin_decompressor_decompressed[10 : 7]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 11]},_zz_IBusSimplePlugin_decompressor_decompressed[5]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},2'b00},5'h02},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed_2},7'h13};
        if(when_Misc_l47) begin
          IBusSimplePlugin_decompressor_decompressed = 32'h00000000;
        end
      end
      5'h02 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_IBusSimplePlugin_decompressor_decompressed_3,_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed_2},7'h03};
      end
      5'h06 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_3[11 : 5],_zz_IBusSimplePlugin_decompressor_decompressed_2},_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed_3[4 : 0]},7'h23};
      end
      5'h08 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_IBusSimplePlugin_decompressor_decompressed_5,_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h09 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_8[20],_zz_IBusSimplePlugin_decompressor_decompressed_8[10 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_8[11]},_zz_IBusSimplePlugin_decompressor_decompressed_8[19 : 12]},_zz_IBusSimplePlugin_decompressor_decompressed_20},7'h6f};
      end
      5'h0a : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_IBusSimplePlugin_decompressor_decompressed_5,5'h00},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h0b : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7] == 5'h02) ? {{{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_27,_zz_IBusSimplePlugin_decompressor_decompressed_28},_zz_IBusSimplePlugin_decompressor_decompressed_29},_zz_IBusSimplePlugin_decompressor_decompressed[6]},4'b0000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13} : {{_zz_IBusSimplePlugin_decompressor_decompressed_30[31 : 12],_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h37});
      end
      5'h0c : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{((_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] == 2'b10) ? _zz_IBusSimplePlugin_decompressor_decompressed_26 : {{1'b0,(_zz_IBusSimplePlugin_decompressor_decompressed_31 || _zz_IBusSimplePlugin_decompressor_decompressed_32)},5'h00}),(((! _zz_IBusSimplePlugin_decompressor_decompressed[11]) || _zz_IBusSimplePlugin_decompressor_decompressed_22) ? _zz_IBusSimplePlugin_decompressor_decompressed[6 : 2] : _zz_IBusSimplePlugin_decompressor_decompressed_2)},_zz_IBusSimplePlugin_decompressor_decompressed_1},_zz_IBusSimplePlugin_decompressor_decompressed_24},_zz_IBusSimplePlugin_decompressor_decompressed_1},(_zz_IBusSimplePlugin_decompressor_decompressed_22 ? 7'h13 : 7'h33)};
      end
      5'h0d : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_15[20],_zz_IBusSimplePlugin_decompressor_decompressed_15[10 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_15[11]},_zz_IBusSimplePlugin_decompressor_decompressed_15[19 : 12]},_zz_IBusSimplePlugin_decompressor_decompressed_19},7'h6f};
      end
      5'h0e : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_18[12],_zz_IBusSimplePlugin_decompressor_decompressed_18[10 : 5]},_zz_IBusSimplePlugin_decompressor_decompressed_19},_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed_18[4 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_18[11]},7'h63};
      end
      5'h0f : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_18[12],_zz_IBusSimplePlugin_decompressor_decompressed_18[10 : 5]},_zz_IBusSimplePlugin_decompressor_decompressed_19},_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b001},_zz_IBusSimplePlugin_decompressor_decompressed_18[4 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_18[11]},7'h63};
      end
      5'h10 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{7'h00,_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2]},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b001},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h12 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{4'b0000,_zz_IBusSimplePlugin_decompressor_decompressed[3 : 2]},_zz_IBusSimplePlugin_decompressor_decompressed[12]},_zz_IBusSimplePlugin_decompressor_decompressed[6 : 4]},2'b00},_zz_IBusSimplePlugin_decompressor_decompressed_21},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h03};
      end
      5'h14 : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_IBusSimplePlugin_decompressor_decompressed[12 : 2] == 11'h400) ? 32'h00100073 : ((_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2] == 5'h00) ? {{{{12'h000,_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b000},(_zz_IBusSimplePlugin_decompressor_decompressed[12] ? _zz_IBusSimplePlugin_decompressor_decompressed_20 : _zz_IBusSimplePlugin_decompressor_decompressed_19)},7'h67} : {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_33,_zz_IBusSimplePlugin_decompressor_decompressed_34},(_zz_IBusSimplePlugin_decompressor_decompressed_35 ? _zz_IBusSimplePlugin_decompressor_decompressed_36 : _zz_IBusSimplePlugin_decompressor_decompressed_19)},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h33}));
      end
      5'h16 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_37[11 : 5],_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2]},_zz_IBusSimplePlugin_decompressor_decompressed_21},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed_38[4 : 0]},7'h23};
      end
      default : begin
      end
    endcase
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_1 = {2'b01,_zz_IBusSimplePlugin_decompressor_decompressed[9 : 7]};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_2 = {2'b01,_zz_IBusSimplePlugin_decompressor_decompressed[4 : 2]};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_3 = {{{{5'h00,_zz_IBusSimplePlugin_decompressor_decompressed[5]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 10]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},2'b00};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_4 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_5[11] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[10] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[9] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[8] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[7] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[6] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[5] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[4 : 0] = _zz_IBusSimplePlugin_decompressor_decompressed[6 : 2];
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_6 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_7[9] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[8] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[7] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[6] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[5] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[4] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[3] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[2] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[1] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[0] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_8 = {{{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_7,_zz_IBusSimplePlugin_decompressor_decompressed[8]},_zz_IBusSimplePlugin_decompressor_decompressed[10 : 9]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},_zz_IBusSimplePlugin_decompressor_decompressed[7]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[11]},_zz_IBusSimplePlugin_decompressor_decompressed[5 : 3]},1'b0};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_9 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_10[14] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[13] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[12] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[11] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[10] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[9] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[8] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[7] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[6] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[5] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[4] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[3] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[2] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[1] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[0] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_11 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_12[2] = _zz_IBusSimplePlugin_decompressor_decompressed_11;
    _zz_IBusSimplePlugin_decompressor_decompressed_12[1] = _zz_IBusSimplePlugin_decompressor_decompressed_11;
    _zz_IBusSimplePlugin_decompressor_decompressed_12[0] = _zz_IBusSimplePlugin_decompressor_decompressed_11;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_13 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_14[9] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[8] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[7] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[6] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[5] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[4] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[3] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[2] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[1] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[0] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_15 = {{{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_14,_zz_IBusSimplePlugin_decompressor_decompressed[8]},_zz_IBusSimplePlugin_decompressor_decompressed[10 : 9]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},_zz_IBusSimplePlugin_decompressor_decompressed[7]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[11]},_zz_IBusSimplePlugin_decompressor_decompressed[5 : 3]},1'b0};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_16 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_17[4] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[3] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[2] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[1] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[0] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_18 = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_17,_zz_IBusSimplePlugin_decompressor_decompressed[6 : 5]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10]},_zz_IBusSimplePlugin_decompressor_decompressed[4 : 3]},1'b0};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_19 = 5'h00;
  assign _zz_IBusSimplePlugin_decompressor_decompressed_20 = 5'h01;
  assign _zz_IBusSimplePlugin_decompressor_decompressed_21 = 5'h02;
  assign switch_Misc_l44 = {_zz_IBusSimplePlugin_decompressor_decompressed[1 : 0],_zz_IBusSimplePlugin_decompressor_decompressed[15 : 13]};
  assign when_Misc_l47 = (_zz_IBusSimplePlugin_decompressor_decompressed[12 : 2] == 11'h000);
  assign _zz_IBusSimplePlugin_decompressor_decompressed_22 = (_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] != 2'b11);
  assign switch_Misc_l241 = _zz_IBusSimplePlugin_decompressor_decompressed[11 : 10];
  assign switch_Misc_l241_1 = _zz_IBusSimplePlugin_decompressor_decompressed[6 : 5];
  always @(*) begin
    case(switch_Misc_l241_1)
      2'b00 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b000;
      end
      2'b01 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b100;
      end
      2'b10 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b110;
      end
      default : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b111;
      end
    endcase
  end

  always @(*) begin
    case(switch_Misc_l241)
      2'b00 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = 3'b101;
      end
      2'b01 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = 3'b101;
      end
      2'b10 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = 3'b111;
      end
      default : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = _zz_IBusSimplePlugin_decompressor_decompressed_23;
      end
    endcase
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_25 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_26[6] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[5] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[4] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[3] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[2] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[1] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[0] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
  end

  assign IBusSimplePlugin_decompressor_output_valid = (IBusSimplePlugin_decompressor_input_valid && (! ((IBusSimplePlugin_decompressor_throw2Bytes && (! IBusSimplePlugin_decompressor_bufferValid)) && (! IBusSimplePlugin_decompressor_isInputHighRvc))));
  assign IBusSimplePlugin_decompressor_output_payload_pc = IBusSimplePlugin_decompressor_input_payload_pc;
  assign IBusSimplePlugin_decompressor_output_payload_isRvc = IBusSimplePlugin_decompressor_isRvc;
  assign IBusSimplePlugin_decompressor_output_payload_rsp_inst = (IBusSimplePlugin_decompressor_isRvc ? IBusSimplePlugin_decompressor_decompressed : IBusSimplePlugin_decompressor_raw);
  assign IBusSimplePlugin_decompressor_input_ready = (IBusSimplePlugin_decompressor_output_ready && (((! IBusSimplePlugin_iBusRsp_stages_1_input_valid) || IBusSimplePlugin_decompressor_flushNext) || ((! (IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isInputHighRvc)) && (! (((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && IBusSimplePlugin_decompressor_isInputHighRvc)))));
  assign IBusSimplePlugin_decompressor_output_fire = (IBusSimplePlugin_decompressor_output_valid && IBusSimplePlugin_decompressor_output_ready);
  assign IBusSimplePlugin_decompressor_bufferFill = (((((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && (! IBusSimplePlugin_decompressor_isInputHighRvc)) || (IBusSimplePlugin_decompressor_bufferValid && (! IBusSimplePlugin_decompressor_isInputHighRvc))) || ((IBusSimplePlugin_decompressor_throw2Bytes && (! IBusSimplePlugin_decompressor_isRvc)) && (! IBusSimplePlugin_decompressor_isInputHighRvc)));
  assign when_Fetcher_l285 = (IBusSimplePlugin_decompressor_output_ready && IBusSimplePlugin_decompressor_input_valid);
  assign when_Fetcher_l288 = (IBusSimplePlugin_decompressor_output_ready && IBusSimplePlugin_decompressor_input_valid);
  assign when_Fetcher_l293 = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_decompressor_consumeCurrent);
  assign IBusSimplePlugin_decompressor_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_IBusSimplePlugin_injector_decodeInput_valid;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign when_Fetcher_l331 = (! 1'b0);
  assign when_Fetcher_l331_1 = (! execute_arbitration_isStuck);
  assign when_Fetcher_l331_2 = (! memory_arbitration_isStuck);
  assign when_Fetcher_l331_3 = (! writeBack_arbitration_isStuck);
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_0;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_1;
  assign IBusSimplePlugin_pcValids_2 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_pcValids_3 = IBusSimplePlugin_injector_nextPcCalc_valids_3;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @(*) begin
    decode_arbitration_isValid = IBusSimplePlugin_injector_decodeInput_valid;
    case(IBusSimplePlugin_injector_port_state)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      default : begin
      end
    endcase
    if(IBusSimplePlugin_forceNoDecodeCond) begin
      decode_arbitration_isValid = 1'b0;
    end
  end

  assign iBus_cmd_valid = IBusSimplePlugin_cmd_valid;
  assign IBusSimplePlugin_cmd_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_payload_pc;
  assign IBusSimplePlugin_pending_next = (_zz_IBusSimplePlugin_pending_next - _zz_IBusSimplePlugin_pending_next_3);
  assign IBusSimplePlugin_cmdFork_canEmit = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && (IBusSimplePlugin_pending_value != 3'b111));
  assign when_IBusSimplePlugin_l305 = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && ((! IBusSimplePlugin_cmdFork_canEmit) || (! IBusSimplePlugin_cmd_ready)));
  assign IBusSimplePlugin_cmd_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && IBusSimplePlugin_cmdFork_canEmit);
  assign IBusSimplePlugin_cmd_fire = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign IBusSimplePlugin_pending_inc = IBusSimplePlugin_cmd_fire;
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_0_input_payload[31 : 2],2'b00};
  assign iBus_rsp_toStream_valid = iBus_rsp_valid;
  assign iBus_rsp_toStream_payload_error = iBus_rsp_payload_error;
  assign iBus_rsp_toStream_payload_inst = iBus_rsp_payload_inst;
  assign iBus_rsp_toStream_ready = IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  assign IBusSimplePlugin_rspJoin_rspBuffer_flush = ((IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000) || IBusSimplePlugin_iBusRsp_flush);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_valid = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter == 3'b000));
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready = (IBusSimplePlugin_rspJoin_rspBuffer_output_ready || IBusSimplePlugin_rspJoin_rspBuffer_flush);
  assign toplevel_IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_fire = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready);
  assign IBusSimplePlugin_pending_dec = toplevel_IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_fire;
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  always @(*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
    if(when_IBusSimplePlugin_l376) begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  assign when_IBusSimplePlugin_l376 = (! IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_1_output_valid && IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_rspJoin_join_fire = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_valid ? IBusSimplePlugin_rspJoin_join_fire : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_ready = IBusSimplePlugin_rspJoin_join_fire;
  assign _zz_IBusSimplePlugin_iBusRsp_output_valid = (! IBusSimplePlugin_rspJoin_exceptionDetected);
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_IBusSimplePlugin_iBusRsp_output_valid);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_IBusSimplePlugin_iBusRsp_output_valid);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  assign _zz_dBus_cmd_valid = 1'b0;
  always @(*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT) begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_dBus_cmd_payload_data = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_dBus_cmd_payload_data = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_dBus_cmd_payload_data = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_dBus_cmd_payload_data;
  assign when_DBusSimplePlugin_l436 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0001;
      end
      2'b01 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0011;
      end
      default : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b1111;
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_execute_DBusSimplePlugin_formalMask <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign when_DBusSimplePlugin_l490 = (((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_MEMORY_STORE)) && ((! dBus_rsp_ready) || 1'b0));
  always @(*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign switch_Misc_l241_2 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_writeBack_DBusSimplePlugin_rspFormated = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[31] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[30] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[29] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[28] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[27] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[26] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[25] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[24] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[23] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[22] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[21] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[20] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[19] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[18] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[17] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[16] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[15] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[14] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[13] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[12] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[11] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[10] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[9] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[8] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_writeBack_DBusSimplePlugin_rspFormated_2 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[31] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[30] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[29] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[28] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[27] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[26] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[25] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[24] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[23] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[22] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[21] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[20] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[19] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[18] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[17] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[16] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @(*) begin
    case(switch_Misc_l241_2)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_1;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_3;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign when_DBusSimplePlugin_l566 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  always @(*) begin
    when_CsrPlugin_l818 = 1'b0;
    if(CsrPlugin_trigger_decodeBreak_enabled) begin
      if(CsrPlugin_trigger_decodeBreak_timeout_state) begin
        when_CsrPlugin_l818 = 1'b1;
      end
    end
    if(when_CsrPlugin_l1390) begin
      when_CsrPlugin_l818 = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_privilege = _zz_CsrPlugin_privilege;
    if(CsrPlugin_forceMachineWire) begin
      CsrPlugin_privilege = 2'b11;
    end
  end

  assign debugMode = (! CsrPlugin_running);
  assign when_CsrPlugin_l711 = (! CsrPlugin_running);
  always @(*) begin
    debugBus_resume_rsp_valid = 1'b0;
    if(CsrPlugin_doResume) begin
      debugBus_resume_rsp_valid = 1'b1;
    end
  end

  assign debugBus_running = CsrPlugin_running;
  assign debugBus_halted = (! CsrPlugin_running);
  assign debugBus_unavailable = reset_buffercc_io_dataOut;
  assign debugBus_haveReset = _zz_debugBus_haveReset;
  assign CsrPlugin_enterHalt = ((! CsrPlugin_running_aheadValue) && CsrPlugin_running_aheadValue_regNext);
  assign when_CsrPlugin_l729 = ((debugBus_haltReq && debugBus_running) && (! debugMode));
  assign CsrPlugin_forceResume = 1'b0;
  assign CsrPlugin_doResume = (CsrPlugin_forceResume || _zz_CsrPlugin_doResume);
  always @(*) begin
    CsrPlugin_timeout_stateRise = 1'b0;
    if(CsrPlugin_timeout_counter_willOverflow) begin
      CsrPlugin_timeout_stateRise = (! CsrPlugin_timeout_state);
    end
    if(when_CsrPlugin_l735) begin
      CsrPlugin_timeout_stateRise = 1'b0;
    end
    if(CsrPlugin_inject_cmd_valid) begin
      CsrPlugin_timeout_stateRise = 1'b0;
    end
    case(CsrPlugin_dcsr_stepLogic_stateReg)
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : begin
      end
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : begin
        CsrPlugin_timeout_stateRise = 1'b0;
      end
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_timeout_counter_willClear = 1'b0;
    if(when_CsrPlugin_l735) begin
      CsrPlugin_timeout_counter_willClear = 1'b1;
    end
    if(CsrPlugin_inject_cmd_valid) begin
      CsrPlugin_timeout_counter_willClear = 1'b1;
    end
    case(CsrPlugin_dcsr_stepLogic_stateReg)
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : begin
      end
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : begin
        CsrPlugin_timeout_counter_willClear = 1'b1;
      end
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : begin
      end
      default : begin
      end
    endcase
  end

  assign CsrPlugin_timeout_counter_willOverflowIfInc = (CsrPlugin_timeout_counter_value == 3'b110);
  assign CsrPlugin_timeout_counter_willOverflow = (CsrPlugin_timeout_counter_willOverflowIfInc && CsrPlugin_timeout_counter_willIncrement);
  always @(*) begin
    if(CsrPlugin_timeout_counter_willOverflow) begin
      CsrPlugin_timeout_counter_valueNext = 3'b000;
    end else begin
      CsrPlugin_timeout_counter_valueNext = (CsrPlugin_timeout_counter_value + _zz_CsrPlugin_timeout_counter_valueNext);
    end
    if(CsrPlugin_timeout_counter_willClear) begin
      CsrPlugin_timeout_counter_valueNext = 3'b000;
    end
  end

  assign CsrPlugin_timeout_counter_willIncrement = 1'b1;
  assign when_CsrPlugin_l735 = (|{writeBack_arbitration_isValid,{memory_arbitration_isValid,execute_arbitration_isValid}});
  always @(*) begin
    _zz_debugBus_hartToDm_valid = 1'b0;
    if(execute_CsrPlugin_csr_1972) begin
      if(execute_CsrPlugin_writeEnable) begin
        _zz_debugBus_hartToDm_valid = 1'b1;
      end
    end
  end

  assign debugBus_hartToDm_valid = _zz_debugBus_hartToDm_valid;
  assign debugBus_hartToDm_payload_address = 4'b0000;
  assign debugBus_hartToDm_payload_data = execute_SRC1;
  assign when_CsrPlugin_l750 = (debugBus_dmToHart_valid && (debugBus_dmToHart_payload_op == DebugDmToHartOp_DATA));
  assign CsrPlugin_inject_cmd_valid = (debugBus_dmToHart_valid && (((debugBus_dmToHart_payload_op == DebugDmToHartOp_EXECUTE) || (debugBus_dmToHart_payload_op == DebugDmToHartOp_REG_READ)) || (debugBus_dmToHart_payload_op == DebugDmToHartOp_REG_WRITE)));
  assign CsrPlugin_inject_cmd_payload_op = debugBus_dmToHart_payload_op;
  assign CsrPlugin_inject_cmd_payload_address = debugBus_dmToHart_payload_address;
  assign CsrPlugin_inject_cmd_payload_data = debugBus_dmToHart_payload_data;
  assign CsrPlugin_inject_cmd_payload_size = debugBus_dmToHart_payload_size;
  assign CsrPlugin_inject_cmd_toStream_valid = CsrPlugin_inject_cmd_valid;
  assign CsrPlugin_inject_cmd_toStream_payload_op = CsrPlugin_inject_cmd_payload_op;
  assign CsrPlugin_inject_cmd_toStream_payload_address = CsrPlugin_inject_cmd_payload_address;
  assign CsrPlugin_inject_cmd_toStream_payload_data = CsrPlugin_inject_cmd_payload_data;
  assign CsrPlugin_inject_cmd_toStream_payload_size = CsrPlugin_inject_cmd_payload_size;
  always @(*) begin
    CsrPlugin_inject_cmd_toStream_ready = CsrPlugin_inject_buffer_ready;
    if(when_Stream_l369) begin
      CsrPlugin_inject_cmd_toStream_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! CsrPlugin_inject_buffer_valid);
  assign CsrPlugin_inject_buffer_valid = CsrPlugin_inject_cmd_toStream_rValid;
  assign CsrPlugin_inject_buffer_payload_op = CsrPlugin_inject_cmd_toStream_rData_op;
  assign CsrPlugin_inject_buffer_payload_address = CsrPlugin_inject_cmd_toStream_rData_address;
  assign CsrPlugin_inject_buffer_payload_data = CsrPlugin_inject_cmd_toStream_rData_data;
  assign CsrPlugin_inject_buffer_payload_size = CsrPlugin_inject_cmd_toStream_rData_size;
  assign CsrPlugin_injectionPort_valid = (CsrPlugin_inject_buffer_valid && (CsrPlugin_inject_buffer_payload_op == DebugDmToHartOp_EXECUTE));
  assign CsrPlugin_injectionPort_payload = CsrPlugin_inject_buffer_payload_data;
  assign CsrPlugin_injectionPort_fire = (CsrPlugin_injectionPort_valid && CsrPlugin_injectionPort_ready);
  assign CsrPlugin_inject_buffer_ready = CsrPlugin_injectionPort_fire;
  assign debugBus_regSuccess = 1'b0;
  assign when_CsrPlugin_l786 = (CsrPlugin_inject_cmd_valid && (debugBus_dmToHart_payload_op == DebugDmToHartOp_EXECUTE));
  assign when_CsrPlugin_l786_1 = (((debugBus_exception || debugBus_commit) || debugBus_ebreak) || debugBus_redo);
  assign debugBus_redo = (CsrPlugin_inject_pending && CsrPlugin_timeout_state);
  assign CsrPlugin_dcsr_nmip = 1'b0;
  assign CsrPlugin_dcsr_mprven = 1'b1;
  assign CsrPlugin_dcsr_xdebugver = 4'b0100;
  assign CsrPlugin_dcsr_stepLogic_wantExit = 1'b0;
  always @(*) begin
    CsrPlugin_dcsr_stepLogic_wantStart = 1'b0;
    case(CsrPlugin_dcsr_stepLogic_stateReg)
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : begin
      end
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : begin
      end
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : begin
      end
      default : begin
        CsrPlugin_dcsr_stepLogic_wantStart = 1'b1;
      end
    endcase
  end

  assign CsrPlugin_dcsr_stepLogic_wantKill = 1'b0;
  always @(*) begin
    CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_stateReg;
    case(CsrPlugin_dcsr_stepLogic_stateReg)
      CsrPlugin_dcsr_stepLogic_enumDef_IDLE : begin
        if(when_CsrPlugin_l812) begin
          CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_SINGLE;
        end
      end
      CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : begin
        if(when_CsrPlugin_l818) begin
          CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1;
        end
        if(decode_arbitration_isFiring) begin
          CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1;
        end
      end
      CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : begin
        if(when_CsrPlugin_l830) begin
          CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_SINGLE;
        end
      end
      default : begin
      end
    endcase
    if(CsrPlugin_enterHalt) begin
      CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_IDLE;
    end
    if(CsrPlugin_dcsr_stepLogic_wantStart) begin
      CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_IDLE;
    end
    if(CsrPlugin_dcsr_stepLogic_wantKill) begin
      CsrPlugin_dcsr_stepLogic_stateNext = CsrPlugin_dcsr_stepLogic_enumDef_BOOT;
    end
  end

  assign when_CsrPlugin_l812 = (CsrPlugin_dcsr_step && debugBus_resume_rsp_valid);
  assign when_CsrPlugin_l830 = ((! CsrPlugin_doHalt) && CsrPlugin_timeout_state);
  assign when_CsrPlugin_l862 = ((debugMode || CsrPlugin_dcsr_step) || debugBus_haltReq);
  assign CsrPlugin_trigger_tselect_outOfRange = 1'b0;
  always @(*) begin
    CsrPlugin_trigger_decodeBreak_enabled = 1'b0;
    if(CsrPlugin_trigger_slots_0_tdata2_execute_hit) begin
      CsrPlugin_trigger_decodeBreak_enabled = 1'b1;
    end
    if(CsrPlugin_trigger_slots_1_tdata2_execute_hit) begin
      CsrPlugin_trigger_decodeBreak_enabled = 1'b1;
    end
    if(when_CsrPlugin_l958) begin
      CsrPlugin_trigger_decodeBreak_enabled = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_trigger_decodeBreak_timeout_stateRise = 1'b0;
    if(CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflow) begin
      CsrPlugin_trigger_decodeBreak_timeout_stateRise = (! CsrPlugin_trigger_decodeBreak_timeout_state);
    end
    if(when_Utils_l651) begin
      CsrPlugin_trigger_decodeBreak_timeout_stateRise = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_trigger_decodeBreak_timeout_counter_willClear = 1'b0;
    if(when_Utils_l651) begin
      CsrPlugin_trigger_decodeBreak_timeout_counter_willClear = 1'b1;
    end
  end

  assign CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflowIfInc = (CsrPlugin_trigger_decodeBreak_timeout_counter_value == 2'b10);
  assign CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflow = (CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflowIfInc && CsrPlugin_trigger_decodeBreak_timeout_counter_willIncrement);
  always @(*) begin
    if(CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflow) begin
      CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext = 2'b00;
    end else begin
      CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext = (CsrPlugin_trigger_decodeBreak_timeout_counter_value + _zz_CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext);
    end
    if(CsrPlugin_trigger_decodeBreak_timeout_counter_willClear) begin
      CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext = 2'b00;
    end
  end

  assign CsrPlugin_trigger_decodeBreak_timeout_counter_willIncrement = 1'b1;
  assign when_Utils_l651 = ((! CsrPlugin_trigger_decodeBreak_enabled) || (|{writeBack_arbitration_isValid,{memory_arbitration_isValid,execute_arbitration_isValid}}));
  assign CsrPlugin_trigger_slots_0_selected = (CsrPlugin_trigger_tselect_index == 1'b0);
  always @(*) begin
    CsrPlugin_trigger_slots_0_tdata1_read = 32'h00000000;
    if(CsrPlugin_trigger_slots_0_selected) begin
      CsrPlugin_trigger_slots_0_tdata1_read[2 : 2] = CsrPlugin_trigger_slots_0_tdata1_execute;
      CsrPlugin_trigger_slots_0_tdata1_read[3 : 3] = CsrPlugin_trigger_slots_0_tdata1_u;
      CsrPlugin_trigger_slots_0_tdata1_read[4 : 4] = CsrPlugin_trigger_slots_0_tdata1_s;
      CsrPlugin_trigger_slots_0_tdata1_read[6 : 6] = CsrPlugin_trigger_slots_0_tdata1_m;
      CsrPlugin_trigger_slots_0_tdata1_read[27 : 27] = CsrPlugin_trigger_slots_0_tdata1_dmode;
      CsrPlugin_trigger_slots_0_tdata1_read[15 : 12] = CsrPlugin_trigger_slots_0_tdata1_action;
    end
    if(CsrPlugin_trigger_slots_0_selected) begin
      CsrPlugin_trigger_slots_0_tdata1_read[31 : 28] = CsrPlugin_trigger_slots_0_tdata1_tpe;
    end
    if(CsrPlugin_trigger_slots_0_selected) begin
      CsrPlugin_trigger_slots_0_tdata1_read[25 : 20] = 6'h1f;
    end
  end

  assign CsrPlugin_trigger_slots_0_tdata1_tpe = 4'b0010;
  always @(*) begin
    case(CsrPlugin_privilege)
      2'b00 : begin
        _zz_CsrPlugin_trigger_slots_0_tdata1_privilegeHit = CsrPlugin_trigger_slots_0_tdata1_u;
      end
      2'b01 : begin
        _zz_CsrPlugin_trigger_slots_0_tdata1_privilegeHit = CsrPlugin_trigger_slots_0_tdata1_s;
      end
      2'b11 : begin
        _zz_CsrPlugin_trigger_slots_0_tdata1_privilegeHit = CsrPlugin_trigger_slots_0_tdata1_m;
      end
      default : begin
        _zz_CsrPlugin_trigger_slots_0_tdata1_privilegeHit = 1'b0;
      end
    endcase
  end

  assign CsrPlugin_trigger_slots_0_tdata1_privilegeHit = ((! debugMode) && _zz_CsrPlugin_trigger_slots_0_tdata1_privilegeHit);
  assign CsrPlugin_trigger_slots_0_tdata2_execute_enabled = ((((! debugMode) && (CsrPlugin_trigger_slots_0_tdata1_action == 4'b0001)) && CsrPlugin_trigger_slots_0_tdata1_execute) && CsrPlugin_trigger_slots_0_tdata1_privilegeHit);
  assign CsrPlugin_trigger_slots_0_tdata2_execute_hit = (CsrPlugin_trigger_slots_0_tdata2_execute_enabled && (CsrPlugin_trigger_slots_0_tdata2_value == decode_PC));
  assign CsrPlugin_trigger_slots_1_selected = (CsrPlugin_trigger_tselect_index == 1'b1);
  always @(*) begin
    CsrPlugin_trigger_slots_1_tdata1_read = 32'h00000000;
    if(CsrPlugin_trigger_slots_1_selected) begin
      CsrPlugin_trigger_slots_1_tdata1_read[2 : 2] = CsrPlugin_trigger_slots_1_tdata1_execute;
      CsrPlugin_trigger_slots_1_tdata1_read[3 : 3] = CsrPlugin_trigger_slots_1_tdata1_u;
      CsrPlugin_trigger_slots_1_tdata1_read[4 : 4] = CsrPlugin_trigger_slots_1_tdata1_s;
      CsrPlugin_trigger_slots_1_tdata1_read[6 : 6] = CsrPlugin_trigger_slots_1_tdata1_m;
      CsrPlugin_trigger_slots_1_tdata1_read[27 : 27] = CsrPlugin_trigger_slots_1_tdata1_dmode;
      CsrPlugin_trigger_slots_1_tdata1_read[15 : 12] = CsrPlugin_trigger_slots_1_tdata1_action;
    end
    if(CsrPlugin_trigger_slots_1_selected) begin
      CsrPlugin_trigger_slots_1_tdata1_read[31 : 28] = CsrPlugin_trigger_slots_1_tdata1_tpe;
    end
    if(CsrPlugin_trigger_slots_1_selected) begin
      CsrPlugin_trigger_slots_1_tdata1_read[25 : 20] = 6'h1f;
    end
  end

  assign CsrPlugin_trigger_slots_1_tdata1_tpe = 4'b0010;
  always @(*) begin
    case(CsrPlugin_privilege)
      2'b00 : begin
        _zz_CsrPlugin_trigger_slots_1_tdata1_privilegeHit = CsrPlugin_trigger_slots_1_tdata1_u;
      end
      2'b01 : begin
        _zz_CsrPlugin_trigger_slots_1_tdata1_privilegeHit = CsrPlugin_trigger_slots_1_tdata1_s;
      end
      2'b11 : begin
        _zz_CsrPlugin_trigger_slots_1_tdata1_privilegeHit = CsrPlugin_trigger_slots_1_tdata1_m;
      end
      default : begin
        _zz_CsrPlugin_trigger_slots_1_tdata1_privilegeHit = 1'b0;
      end
    endcase
  end

  assign CsrPlugin_trigger_slots_1_tdata1_privilegeHit = ((! debugMode) && _zz_CsrPlugin_trigger_slots_1_tdata1_privilegeHit);
  assign CsrPlugin_trigger_slots_1_tdata2_execute_enabled = ((((! debugMode) && (CsrPlugin_trigger_slots_1_tdata1_action == 4'b0001)) && CsrPlugin_trigger_slots_1_tdata1_execute) && CsrPlugin_trigger_slots_1_tdata1_privilegeHit);
  assign CsrPlugin_trigger_slots_1_tdata2_execute_hit = (CsrPlugin_trigger_slots_1_tdata2_execute_enabled && (CsrPlugin_trigger_slots_1_tdata2_value == decode_PC));
  assign when_CsrPlugin_l958 = (! decode_arbitration_isValid);
  assign CsrPlugin_misa_base = 2'b01;
  assign CsrPlugin_misa_extensions = 26'h0000042;
  assign CsrPlugin_mtvec_mode = 2'b00;
  assign CsrPlugin_mtvec_base = 30'h00000008;
  assign _zz_when_CsrPlugin_l1302 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_when_CsrPlugin_l1302_1 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_when_CsrPlugin_l1302_2 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign when_CsrPlugin_l1259 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1259_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l1259_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l1272 = (|{CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}});
  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign when_CsrPlugin_l1296 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11));
  assign when_CsrPlugin_l1302 = ((_zz_when_CsrPlugin_l1302 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l1302_1 = ((_zz_when_CsrPlugin_l1302_1 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l1302_2 = ((_zz_when_CsrPlugin_l1302_2 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l1315 = (CsrPlugin_dcsr_step && (! CsrPlugin_dcsr_stepie));
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  assign CsrPlugin_lastStageWasWfi = 1'b0;
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid);
  assign when_CsrPlugin_l1335 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1335_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l1335_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l1340 = ((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt);
  always @(*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
    if(when_CsrPlugin_l1346) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign when_CsrPlugin_l1346 = (|{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}});
  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  assign debugBus_commit = (debugMode && writeBack_arbitration_isFiring);
  always @(*) begin
    debugBus_exception = (debugMode && CsrPlugin_hadException);
    if(when_CsrPlugin_l1390) begin
      if(!when_CsrPlugin_l1398) begin
        if(!when_CsrPlugin_l1428) begin
          debugBus_exception = (! CsrPlugin_trapCauseEbreakDebug);
        end
      end
    end
  end

  always @(*) begin
    debugBus_ebreak = 1'b0;
    if(when_CsrPlugin_l1390) begin
      if(!when_CsrPlugin_l1398) begin
        if(!when_CsrPlugin_l1428) begin
          debugBus_ebreak = CsrPlugin_trapCauseEbreakDebug;
        end
      end
    end
  end

  always @(*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException) begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @(*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException) begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @(*) begin
    CsrPlugin_trapCauseEbreakDebug = 1'b0;
    if(CsrPlugin_hadException) begin
      if(when_CsrPlugin_l1373) begin
        if(debugMode) begin
          CsrPlugin_trapCauseEbreakDebug = 1'b1;
        end
        if(when_CsrPlugin_l1375) begin
          CsrPlugin_trapCauseEbreakDebug = 1'b1;
        end
      end
    end
  end

  assign when_CsrPlugin_l1373 = (CsrPlugin_exceptionPortCtrl_exceptionContext_code == 4'b0011);
  assign when_CsrPlugin_l1375 = ((CsrPlugin_privilege == 2'b11) && CsrPlugin_dcsr_ebreakm);
  always @(*) begin
    CsrPlugin_xtvec_mode = 2'bxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_trapEnterDebug = 1'b0;
    if(when_CsrPlugin_l1389) begin
      CsrPlugin_trapEnterDebug = 1'b1;
    end
  end

  assign when_CsrPlugin_l1389 = (((CsrPlugin_doHalt || CsrPlugin_trapCauseEbreakDebug) || ((! CsrPlugin_hadException) && CsrPlugin_doHalt)) || (! CsrPlugin_running));
  assign when_CsrPlugin_l1390 = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign when_CsrPlugin_l1398 = (! CsrPlugin_trapEnterDebug);
  assign when_CsrPlugin_l1428 = (! debugMode);
  assign when_CsrPlugin_l1456 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET));
  assign switch_CsrPlugin_l1460 = writeBack_INSTRUCTION[29 : 28];
  assign when_CsrPlugin_l1468 = (CsrPlugin_mstatus_MPP < 2'b11);
  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign when_CsrPlugin_l1527 = (|{(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == EnvCtrlEnum_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET))}});
  assign execute_CsrPlugin_blockedBySideEffects = ((|{writeBack_arbitration_isValid,memory_arbitration_isValid}) || 1'b0);
  always @(*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    if(execute_CsrPlugin_csr_1972) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_1969) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_1968) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_1952) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_1956) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_1953) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_1954) begin
      if(execute_CSR_WRITE_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_768) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_772) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_834) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(CsrPlugin_csrMapping_allowCsrSignal) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(when_CsrPlugin_l1719) begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(when_CsrPlugin_l1725) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if(when_CsrPlugin_l1547) begin
      if(when_CsrPlugin_l1548) begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @(*) begin
    CsrPlugin_selfException_valid = 1'b0;
    if(when_CsrPlugin_l1565) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_selfException_payload_code = 4'bxxxx;
    if(when_CsrPlugin_l1565) begin
      CsrPlugin_selfException_payload_code = 4'b0011;
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  assign when_CsrPlugin_l1547 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET));
  assign when_CsrPlugin_l1548 = (CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]);
  assign when_CsrPlugin_l1565 = ((execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_EBREAK)) && CsrPlugin_allowEbreakException);
  always @(*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
    if(when_CsrPlugin_l1719) begin
      execute_CsrPlugin_writeInstruction = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
    if(when_CsrPlugin_l1719) begin
      execute_CsrPlugin_readInstruction = 1'b0;
    end
  end

  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck));
  assign CsrPlugin_csrMapping_hazardFree = (! execute_CsrPlugin_blockedBySideEffects);
  assign execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal;
  assign switch_Misc_l241_3 = execute_INSTRUCTION[13];
  always @(*) begin
    case(switch_Misc_l241_3)
      1'b0 : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1;
      end
      default : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal;
  assign when_CsrPlugin_l1587 = (execute_arbitration_isValid && execute_IS_CSR);
  assign when_CsrPlugin_l1591 = (execute_arbitration_isValid && (execute_IS_CSR || 1'b0));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_decode_SRC_LESS_UNSIGNED_1 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050);
  assign _zz_decode_SRC_LESS_UNSIGNED_2 = ((decode_INSTRUCTION & 32'h00006004) == 32'h00002000);
  assign _zz_decode_SRC_LESS_UNSIGNED_3 = ((decode_INSTRUCTION & 32'h00000018) == 32'h00000000);
  assign _zz_decode_SRC_LESS_UNSIGNED_4 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004);
  assign _zz_decode_SRC_LESS_UNSIGNED_5 = ((decode_INSTRUCTION & 32'h00000050) == 32'h00000010);
  assign _zz_decode_SRC_LESS_UNSIGNED_6 = ((decode_INSTRUCTION & 32'h00000048) == 32'h00000048);
  assign _zz_decode_SRC_LESS_UNSIGNED = {(|{_zz_decode_SRC_LESS_UNSIGNED_6,(_zz__zz_decode_SRC_LESS_UNSIGNED == _zz__zz_decode_SRC_LESS_UNSIGNED_1)}),{(|(_zz__zz_decode_SRC_LESS_UNSIGNED_2 == _zz__zz_decode_SRC_LESS_UNSIGNED_3)),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_4),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_5),{_zz__zz_decode_SRC_LESS_UNSIGNED_10,{_zz__zz_decode_SRC_LESS_UNSIGNED_13,_zz__zz_decode_SRC_LESS_UNSIGNED_15}}}}}};
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[1 : 0];
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[6 : 5];
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
  assign _zz_decode_ENV_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[15 : 14];
  assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_2;
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[17 : 16];
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[20 : 19];
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
  assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[23 : 22];
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2;
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[25 : 24];
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL_2;
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h00);
  assign when_RegFilePlugin_l66 = decode_INSTRUCTION[11];
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION[18 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION[23 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_RegFilePlugin_regFile_port0;
  assign decode_RegFilePlugin_rs2Data = _zz_RegFilePlugin_regFile_port1;
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
    if(_zz_5) begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[10 : 7];
    if(_zz_5) begin
      lastStageRegFileWrite_payload_address = 4'b0000;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_lastStageRegFileWrite_payload_data;
    if(_zz_5) begin
      lastStageRegFileWrite_payload_data = 32'h00000000;
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      AluBitwiseCtrlEnum_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
      end
      AluCtrlEnum_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz__zz_execute_REGFILE_WRITE_DATA};
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : begin
        _zz_decode_SRC1 = _zz_decode_to_execute_RS1;
      end
      Src1CtrlEnum_PC_INCREMENT : begin
        _zz_decode_SRC1 = {29'd0, _zz__zz_decode_SRC1};
      end
      Src1CtrlEnum_IMU : begin
        _zz_decode_SRC1 = {decode_INSTRUCTION[31 : 12],12'h000};
      end
      default : begin
        _zz_decode_SRC1 = {27'd0, _zz__zz_decode_SRC1_1};
      end
    endcase
  end

  assign _zz_decode_SRC2 = decode_INSTRUCTION[31];
  always @(*) begin
    _zz_decode_SRC2_1[19] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[18] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[17] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[16] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[15] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[14] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[13] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[12] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[11] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[10] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[9] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[8] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[7] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[6] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[5] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[4] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[3] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[2] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[1] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[0] = _zz_decode_SRC2;
  end

  assign _zz_decode_SRC2_2 = _zz__zz_decode_SRC2_2[11];
  always @(*) begin
    _zz_decode_SRC2_3[19] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[18] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[17] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[16] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[15] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[14] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[13] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[12] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[11] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[10] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[9] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[8] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[7] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[6] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[5] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[4] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[3] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[2] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[1] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[0] = _zz_decode_SRC2_2;
  end

  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : begin
        _zz_decode_SRC2_4 = _zz_decode_to_execute_RS2;
      end
      Src2CtrlEnum_IMI : begin
        _zz_decode_SRC2_4 = {_zz_decode_SRC2_1,decode_INSTRUCTION[31 : 20]};
      end
      Src2CtrlEnum_IMS : begin
        _zz_decode_SRC2_4 = {_zz_decode_SRC2_3,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_decode_SRC2_4 = _zz_decode_to_execute_PC;
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub;
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != ShiftCtrlEnum_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == 4'b0000);
  assign when_ShiftPlugins_l169 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != 5'h00));
  always @(*) begin
    case(execute_SHIFT_CTRL)
      ShiftCtrlEnum_SLL_1 : begin
        _zz_execute_to_memory_REGFILE_WRITE_DATA_1 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_execute_to_memory_REGFILE_WRITE_DATA_1 = _zz__zz_execute_to_memory_REGFILE_WRITE_DATA_1;
      end
    endcase
  end

  assign when_ShiftPlugins_l175 = (! execute_arbitration_isStuckByOthers);
  assign when_ShiftPlugins_l184 = (! execute_LightShifterPlugin_done);
  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        HazardSimplePlugin_src0Hazard = 1'b1;
      end
    end
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l59) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l59_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l59_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0;
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        HazardSimplePlugin_src1Hazard = 1'b1;
      end
    end
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l62) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l62_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l62_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0;
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_lastStageRegFileWrite_payload_data;
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]);
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l59 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l62 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58 = (1'b1 || (! 1'b1));
  assign when_HazardSimplePlugin_l59_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l62_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_1 = (1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign when_HazardSimplePlugin_l59_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l62_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_2 = (1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE);
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE);
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard));
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign switch_Misc_l241_4 = execute_INSTRUCTION[14 : 12];
  always @(*) begin
    case(switch_Misc_l241_4)
      3'b000 : begin
        _zz_execute_BRANCH_DO = execute_BranchPlugin_eq;
      end
      3'b001 : begin
        _zz_execute_BRANCH_DO = (! execute_BranchPlugin_eq);
      end
      3'b101 : begin
        _zz_execute_BRANCH_DO = (! execute_SRC_LESS);
      end
      3'b111 : begin
        _zz_execute_BRANCH_DO = (! execute_SRC_LESS);
      end
      default : begin
        _zz_execute_BRANCH_DO = execute_SRC_LESS;
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : begin
        _zz_execute_BRANCH_DO_1 = 1'b0;
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      default : begin
        _zz_execute_BRANCH_DO_1 = _zz_execute_BRANCH_DO;
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == BranchCtrlEnum_JALR) ? execute_RS1 : execute_PC);
  assign _zz_execute_BranchPlugin_branch_src2 = _zz__zz_execute_BranchPlugin_branch_src2[19];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_3[19] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[18] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[17] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[16] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[15] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[14] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[13] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[12] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[11] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_4 = _zz__zz_execute_BranchPlugin_branch_src2_4[11];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JAL : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {{_zz_execute_BranchPlugin_branch_src2_1,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {_zz_execute_BranchPlugin_branch_src2_3,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {{_zz_execute_BranchPlugin_branch_src2_5,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_execute_BranchPlugin_branch_src2_6;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign ndmreset = debugModule_1_io_ndmreset;
  assign jtag_tdo = debugTransportModuleJtagTap_1_io_jtag_tdo;
  assign debugBus_ackReset = debugModule_1_io_harts_0_ackReset;
  assign debugBus_resume_cmd_valid = debugModule_1_io_harts_0_resume_cmd_valid;
  assign debugBus_haltReq = debugModule_1_io_harts_0_haltReq;
  assign debugBus_dmToHart_valid = toplevel_debugModule_1_io_harts_0_dmToHart_regNext_valid;
  assign debugBus_dmToHart_payload_op = toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op;
  assign debugBus_dmToHart_payload_address = toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_address;
  assign debugBus_dmToHart_payload_data = toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_data;
  assign debugBus_dmToHart_payload_size = toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_size;
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_2 = ((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack));
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_7 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_8 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_9 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck);
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
  assign when_Pipeline_l124_11 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_12 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_13 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_14 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
  assign when_Pipeline_l124_15 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_16 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_17 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_18 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_19 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_20 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_21 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_22 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_23 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL;
  assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL;
  assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL;
  assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1;
  assign when_Pipeline_l124_24 = (! execute_arbitration_isStuck);
  assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL;
  assign when_Pipeline_l124_25 = (! memory_arbitration_isStuck);
  assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL;
  assign when_Pipeline_l124_26 = (! writeBack_arbitration_isStuck);
  assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
  assign when_Pipeline_l124_27 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
  assign when_Pipeline_l124_28 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
  assign when_Pipeline_l124_29 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
  assign when_Pipeline_l124_30 = (! execute_arbitration_isStuck);
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
  assign when_Pipeline_l124_31 = (! execute_arbitration_isStuck);
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
  assign when_Pipeline_l124_32 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_33 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_34 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_35 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_36 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_37 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_38 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_39 = ((! memory_arbitration_isStuck) && (! execute_arbitration_isStuckByOthers));
  assign when_Pipeline_l124_40 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_41 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_42 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_43 = (! writeBack_arbitration_isStuck);
  assign decode_arbitration_isFlushed = ((|{writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}}) || (|{writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}}));
  assign execute_arbitration_isFlushed = ((|{writeBack_arbitration_flushNext,memory_arbitration_flushNext}) || (|{writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}}));
  assign memory_arbitration_isFlushed = ((|writeBack_arbitration_flushNext) || (|{writeBack_arbitration_flushIt,memory_arbitration_flushIt}));
  assign writeBack_arbitration_isFlushed = (1'b0 || (|writeBack_arbitration_flushIt));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt);
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt);
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  always @(*) begin
    CsrPlugin_injectionPort_ready = 1'b0;
    case(IBusSimplePlugin_injector_port_state)
      3'b100 : begin
        CsrPlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign when_Fetcher_l373 = (IBusSimplePlugin_injector_port_state != 3'b000);
  assign when_Fetcher_l391 = (! decode_arbitration_isStuck);
  assign when_Fetcher_l411 = (IBusSimplePlugin_injector_port_state != 3'b000);
  assign when_CsrPlugin_l1669 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_2 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_3 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_4 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_5 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_6 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_7 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_8 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_9 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_10 = (! execute_arbitration_isStuck);
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit = 32'h00000000;
    if(execute_CsrPlugin_csr_1972) begin
      _zz_CsrPlugin_csrMapping_readDataInit[31 : 0] = CsrPlugin_dataCsrw_value_0;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h00000000;
    if(execute_CsrPlugin_csr_1969) begin
      _zz_CsrPlugin_csrMapping_readDataInit_1[31 : 0] = CsrPlugin_dpc;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h00000000;
    if(execute_CsrPlugin_csr_1968) begin
      _zz_CsrPlugin_csrMapping_readDataInit_2[3 : 3] = CsrPlugin_dcsr_nmip;
      _zz_CsrPlugin_csrMapping_readDataInit_2[8 : 6] = CsrPlugin_dcsr_cause;
      _zz_CsrPlugin_csrMapping_readDataInit_2[31 : 28] = CsrPlugin_dcsr_xdebugver;
      _zz_CsrPlugin_csrMapping_readDataInit_2[4 : 4] = CsrPlugin_dcsr_mprven;
      _zz_CsrPlugin_csrMapping_readDataInit_2[1 : 0] = CsrPlugin_dcsr_prv;
      _zz_CsrPlugin_csrMapping_readDataInit_2[2 : 2] = CsrPlugin_dcsr_step;
      _zz_CsrPlugin_csrMapping_readDataInit_2[9 : 9] = CsrPlugin_dcsr_stoptime;
      _zz_CsrPlugin_csrMapping_readDataInit_2[10 : 10] = CsrPlugin_dcsr_stopcount;
      _zz_CsrPlugin_csrMapping_readDataInit_2[11 : 11] = CsrPlugin_dcsr_stepie;
      _zz_CsrPlugin_csrMapping_readDataInit_2[15 : 15] = CsrPlugin_dcsr_ebreakm;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h00000000;
    if(execute_CsrPlugin_csr_1952) begin
      _zz_CsrPlugin_csrMapping_readDataInit_3[0 : 0] = CsrPlugin_trigger_tselect_index;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h00000000;
    if(execute_CsrPlugin_csr_1956) begin
      _zz_CsrPlugin_csrMapping_readDataInit_4[0 : 0] = CsrPlugin_trigger_tselect_outOfRange;
      _zz_CsrPlugin_csrMapping_readDataInit_4[2 : 2] = (! CsrPlugin_trigger_tselect_outOfRange);
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h00000000;
    if(execute_CsrPlugin_csr_1953) begin
      _zz_CsrPlugin_csrMapping_readDataInit_5[31 : 0] = _zz__zz_CsrPlugin_csrMapping_readDataInit_5;
    end
  end

  assign switch_CsrPlugin_l1031 = CsrPlugin_csrMapping_writeDataSignal[12 : 11];
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h00000000;
    if(execute_CsrPlugin_csr_768) begin
      _zz_CsrPlugin_csrMapping_readDataInit_6[7 : 7] = CsrPlugin_mstatus_MPIE;
      _zz_CsrPlugin_csrMapping_readDataInit_6[3 : 3] = CsrPlugin_mstatus_MIE;
      _zz_CsrPlugin_csrMapping_readDataInit_6[12 : 11] = CsrPlugin_mstatus_MPP;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_7 = 32'h00000000;
    if(execute_CsrPlugin_csr_836) begin
      _zz_CsrPlugin_csrMapping_readDataInit_7[11 : 11] = CsrPlugin_mip_MEIP;
      _zz_CsrPlugin_csrMapping_readDataInit_7[7 : 7] = CsrPlugin_mip_MTIP;
      _zz_CsrPlugin_csrMapping_readDataInit_7[3 : 3] = CsrPlugin_mip_MSIP;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_8 = 32'h00000000;
    if(execute_CsrPlugin_csr_772) begin
      _zz_CsrPlugin_csrMapping_readDataInit_8[11 : 11] = CsrPlugin_mie_MEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_8[7 : 7] = CsrPlugin_mie_MTIE;
      _zz_CsrPlugin_csrMapping_readDataInit_8[3 : 3] = CsrPlugin_mie_MSIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_9 = 32'h00000000;
    if(execute_CsrPlugin_csr_834) begin
      _zz_CsrPlugin_csrMapping_readDataInit_9[31 : 31] = CsrPlugin_mcause_interrupt;
      _zz_CsrPlugin_csrMapping_readDataInit_9[3 : 0] = CsrPlugin_mcause_exceptionCode;
    end
  end

  assign CsrPlugin_csrMapping_readDataInit = ((((_zz_CsrPlugin_csrMapping_readDataInit | _zz_CsrPlugin_csrMapping_readDataInit_1) | (_zz_CsrPlugin_csrMapping_readDataInit_2 | _zz_CsrPlugin_csrMapping_readDataInit_3)) | ((_zz_CsrPlugin_csrMapping_readDataInit_4 | _zz_CsrPlugin_csrMapping_readDataInit_5) | (_zz_CsrPlugin_csrMapping_readDataInit_6 | _zz_CsrPlugin_csrMapping_readDataInit_7))) | (_zz_CsrPlugin_csrMapping_readDataInit_8 | _zz_CsrPlugin_csrMapping_readDataInit_9));
  assign when_CsrPlugin_l1702 = ((execute_arbitration_isValid && execute_IS_CSR) && (({execute_CsrPlugin_csrAddress[11 : 2],2'b00} == 12'h3a0) || ({execute_CsrPlugin_csrAddress[11 : 4],4'b0000} == 12'h3b0)));
  assign _zz_when_CsrPlugin_l1709 = (execute_CsrPlugin_csrAddress & 12'hf60);
  assign when_CsrPlugin_l1709 = (((execute_arbitration_isValid && execute_IS_CSR) && (5'h03 <= execute_CsrPlugin_csrAddress[4 : 0])) && (((_zz_when_CsrPlugin_l1709 == 12'hb00) || (((_zz_when_CsrPlugin_l1709 == 12'hc00) && (! execute_CsrPlugin_writeInstruction)) && (CsrPlugin_privilege == 2'b11))) || ((execute_CsrPlugin_csrAddress & 12'hfe0) == 12'h320)));
  always @(*) begin
    when_CsrPlugin_l1719 = CsrPlugin_csrMapping_doForceFailCsr;
    if(when_CsrPlugin_l1717) begin
      when_CsrPlugin_l1719 = 1'b1;
    end
    if(when_CsrPlugin_l1718) begin
      when_CsrPlugin_l1719 = 1'b1;
    end
  end

  assign when_CsrPlugin_l1717 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]);
  assign when_CsrPlugin_l1718 = ((! debugMode) && (_zz_when_CsrPlugin_l1718 == 8'h7b));
  assign when_CsrPlugin_l1725 = ((! execute_arbitration_isValid) || (! execute_IS_CSR));
  assign IBusSimplePlugin_rspJoin_rspBuffer_c_io_flush = 1'b0;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      IBusSimplePlugin_fetchPc_pcReg <= 32'h00000000;
      IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      IBusSimplePlugin_decodePc_pcReg <= 32'h00000000;
      _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid_1 <= 1'b0;
      IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      IBusSimplePlugin_decompressor_throw2BytesReg <= 1'b0;
      _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_pending_value <= 3'b000;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= 3'b000;
      _zz_CsrPlugin_privilege <= 2'b11;
      CsrPlugin_running <= 1'b1;
      CsrPlugin_reseting <= 1'b1;
      _zz_debugBus_haveReset <= 1'b0;
      CsrPlugin_running_aheadValue_regNext <= 1'b0;
      CsrPlugin_doHalt <= 1'b0;
      _zz_CsrPlugin_doResume <= 1'b0;
      CsrPlugin_timeout_state <= 1'b0;
      CsrPlugin_timeout_counter_value <= 3'b000;
      CsrPlugin_inject_cmd_toStream_rValid <= 1'b0;
      CsrPlugin_inject_pending <= 1'b0;
      CsrPlugin_dcsr_prv <= 2'b11;
      CsrPlugin_dcsr_step <= 1'b0;
      CsrPlugin_dcsr_cause <= 3'b000;
      CsrPlugin_dcsr_stoptime <= 1'b0;
      CsrPlugin_dcsr_stopcount <= 1'b0;
      CsrPlugin_dcsr_stepie <= 1'b0;
      CsrPlugin_dcsr_ebreakm <= 1'b0;
      CsrPlugin_dcsr_stepLogic_stateReg <= CsrPlugin_dcsr_stepLogic_enumDef_BOOT;
      stoptime <= 1'b0;
      CsrPlugin_trigger_decodeBreak_timeout_state <= 1'b0;
      CsrPlugin_trigger_decodeBreak_timeout_counter_value <= 2'b00;
      CsrPlugin_trigger_slots_0_tdata1_dmode <= 1'b0;
      CsrPlugin_trigger_slots_0_tdata1_execute <= 1'b0;
      CsrPlugin_trigger_slots_0_tdata1_m <= 1'b0;
      CsrPlugin_trigger_slots_0_tdata1_s <= 1'b0;
      CsrPlugin_trigger_slots_0_tdata1_u <= 1'b0;
      CsrPlugin_trigger_slots_0_tdata1_action <= 4'b0000;
      CsrPlugin_trigger_slots_1_tdata1_dmode <= 1'b0;
      CsrPlugin_trigger_slots_1_tdata1_execute <= 1'b0;
      CsrPlugin_trigger_slots_1_tdata1_m <= 1'b0;
      CsrPlugin_trigger_slots_1_tdata1_s <= 1'b0;
      CsrPlugin_trigger_slots_1_tdata1_u <= 1'b0;
      CsrPlugin_trigger_slots_1_tdata1_action <= 4'b0000;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= 2'b11;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_mcycle <= 64'h0000000000000000;
      CsrPlugin_minstret <= 64'h0000000000000000;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      _zz_5 <= 1'b1;
      execute_LightShifterPlugin_isActive <= 1'b0;
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      IBusSimplePlugin_injector_port_state <= 3'b000;
    end else begin
      if(IBusSimplePlugin_fetchPc_correction) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b1;
      end
      if(IBusSimplePlugin_fetchPc_output_fire) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if(when_Fetcher_l133) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_output_fire) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(when_Fetcher_l133_1) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l160) begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if(when_Fetcher_l182) begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_decodePc_pcPlus;
      end
      if(when_Fetcher_l194) begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_jump_pcLoad_payload;
      end
      if(IBusSimplePlugin_iBusRsp_flush) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid_1 <= 1'b0;
      end
      if(_zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_1_input_valid_1 <= (IBusSimplePlugin_iBusRsp_stages_0_output_valid && (! 1'b0));
      end
      if(IBusSimplePlugin_decompressor_output_fire) begin
        IBusSimplePlugin_decompressor_throw2BytesReg <= ((((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && IBusSimplePlugin_decompressor_isInputHighRvc) || (IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isInputHighRvc));
      end
      if(when_Fetcher_l285) begin
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(when_Fetcher_l288) begin
        if(IBusSimplePlugin_decompressor_bufferFill) begin
          IBusSimplePlugin_decompressor_bufferValid <= 1'b1;
        end
      end
      if(when_Fetcher_l293) begin
        IBusSimplePlugin_decompressor_throw2BytesReg <= 1'b0;
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(decode_arbitration_removeIt) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      end
      if(IBusSimplePlugin_decompressor_output_ready) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= (IBusSimplePlugin_decompressor_output_valid && (! IBusSimplePlugin_externalFlush));
      end
      if(when_Fetcher_l331) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if(when_Fetcher_l331_1) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(when_Fetcher_l331_2) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(when_Fetcher_l331_3) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      IBusSimplePlugin_pending_value <= IBusSimplePlugin_pending_next;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter - _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter);
      if(IBusSimplePlugin_iBusRsp_flush) begin
        IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_pending_value - _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2);
      end
      CsrPlugin_reseting <= 1'b0;
      if(CsrPlugin_reseting) begin
        _zz_debugBus_haveReset <= 1'b1;
      end
      if(debugBus_ackReset) begin
        _zz_debugBus_haveReset <= 1'b0;
      end
      CsrPlugin_running_aheadValue_regNext <= CsrPlugin_running_aheadValue;
      if(when_CsrPlugin_l729) begin
        CsrPlugin_doHalt <= 1'b1;
      end
      if(CsrPlugin_enterHalt) begin
        CsrPlugin_doHalt <= 1'b0;
      end
      if(debugBus_resume_cmd_valid) begin
        _zz_CsrPlugin_doResume <= 1'b1;
      end
      if(debugBus_resume_rsp_valid) begin
        _zz_CsrPlugin_doResume <= 1'b0;
      end
      CsrPlugin_timeout_counter_value <= CsrPlugin_timeout_counter_valueNext;
      if(CsrPlugin_timeout_counter_willOverflow) begin
        CsrPlugin_timeout_state <= 1'b1;
      end
      if(when_CsrPlugin_l735) begin
        CsrPlugin_timeout_state <= 1'b0;
      end
      if(CsrPlugin_inject_cmd_toStream_ready) begin
        CsrPlugin_inject_cmd_toStream_rValid <= CsrPlugin_inject_cmd_toStream_valid;
      end
      if(when_CsrPlugin_l786) begin
        CsrPlugin_inject_pending <= 1'b1;
      end
      if(when_CsrPlugin_l786_1) begin
        CsrPlugin_inject_pending <= 1'b0;
      end
      if(CsrPlugin_inject_cmd_valid) begin
        CsrPlugin_timeout_state <= 1'b0;
      end
      CsrPlugin_dcsr_stepLogic_stateReg <= CsrPlugin_dcsr_stepLogic_stateNext;
      case(CsrPlugin_dcsr_stepLogic_stateReg)
        CsrPlugin_dcsr_stepLogic_enumDef_IDLE : begin
        end
        CsrPlugin_dcsr_stepLogic_enumDef_SINGLE : begin
          CsrPlugin_timeout_state <= 1'b0;
          if(when_CsrPlugin_l818) begin
            CsrPlugin_doHalt <= 1'b1;
          end
        end
        CsrPlugin_dcsr_stepLogic_enumDef_WAIT_1 : begin
          if(!when_CsrPlugin_l830) begin
            if(writeBack_arbitration_isFiring) begin
              CsrPlugin_doHalt <= 1'b1;
            end
          end
        end
        default : begin
        end
      endcase
      stoptime <= (debugMode && CsrPlugin_dcsr_stoptime);
      CsrPlugin_trigger_decodeBreak_timeout_counter_value <= CsrPlugin_trigger_decodeBreak_timeout_counter_valueNext;
      if(CsrPlugin_trigger_decodeBreak_timeout_counter_willOverflow) begin
        CsrPlugin_trigger_decodeBreak_timeout_state <= 1'b1;
      end
      if(when_Utils_l651) begin
        CsrPlugin_trigger_decodeBreak_timeout_state <= 1'b0;
      end
      if(CsrPlugin_trigger_decodeBreak_enabled) begin
        if(CsrPlugin_trigger_decodeBreak_timeout_state) begin
          CsrPlugin_dcsr_cause <= 3'b010;
          CsrPlugin_dcsr_prv <= CsrPlugin_privilege;
          _zz_CsrPlugin_privilege <= 2'b11;
        end
      end
      CsrPlugin_mcycle <= (CsrPlugin_mcycle + _zz_CsrPlugin_mcycle);
      if(writeBack_arbitration_isFiring) begin
        CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001);
      end
      if(when_CsrPlugin_l1259) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if(when_CsrPlugin_l1259_1) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if(when_CsrPlugin_l1259_2) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(when_CsrPlugin_l1296) begin
        if(when_CsrPlugin_l1302) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_1) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_2) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      if(when_CsrPlugin_l1315) begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      if(CsrPlugin_doHalt) begin
        CsrPlugin_interrupt_valid <= 1'b1;
      end
      if(CsrPlugin_pipelineLiberator_active) begin
        if(when_CsrPlugin_l1335) begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
        end
        if(when_CsrPlugin_l1335_1) begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
        end
        if(when_CsrPlugin_l1335_2) begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
        end
      end
      if(when_CsrPlugin_l1340) begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      end
      if(CsrPlugin_interruptJump) begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(when_CsrPlugin_l1390) begin
        if(when_CsrPlugin_l1398) begin
          _zz_CsrPlugin_privilege <= CsrPlugin_targetPrivilege;
          case(CsrPlugin_targetPrivilege)
            2'b11 : begin
              CsrPlugin_mstatus_MIE <= 1'b0;
              CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
              CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
            end
            default : begin
            end
          endcase
        end else begin
          if(when_CsrPlugin_l1428) begin
            CsrPlugin_dcsr_cause <= 3'b011;
            if(CsrPlugin_dcsr_step) begin
              CsrPlugin_dcsr_cause <= 3'b100;
            end
            if(CsrPlugin_trapCauseEbreakDebug) begin
              CsrPlugin_dcsr_cause <= 3'b001;
            end
            CsrPlugin_dcsr_prv <= CsrPlugin_privilege;
          end
          _zz_CsrPlugin_privilege <= 2'b11;
        end
      end
      if(when_CsrPlugin_l1456) begin
        case(switch_CsrPlugin_l1460)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00;
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
            _zz_CsrPlugin_privilege <= CsrPlugin_mstatus_MPP;
          end
          default : begin
          end
        endcase
      end
      if(CsrPlugin_doResume) begin
        _zz_CsrPlugin_privilege <= CsrPlugin_dcsr_prv;
      end
      execute_CsrPlugin_wfiWake <= ((|{_zz_when_CsrPlugin_l1302_2,{_zz_when_CsrPlugin_l1302_1,_zz_when_CsrPlugin_l1302}}) || CsrPlugin_thirdPartyWake);
      _zz_5 <= 1'b0;
      if(when_ShiftPlugins_l169) begin
        if(when_ShiftPlugins_l175) begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done) begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt) begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(IBusSimplePlugin_injector_port_state)
        3'b000 : begin
          if(CsrPlugin_injectionPort_valid) begin
            IBusSimplePlugin_injector_port_state <= 3'b001;
          end
        end
        3'b001 : begin
          IBusSimplePlugin_injector_port_state <= 3'b010;
        end
        3'b010 : begin
          IBusSimplePlugin_injector_port_state <= 3'b011;
        end
        3'b011 : begin
          if(when_Fetcher_l391) begin
            IBusSimplePlugin_injector_port_state <= 3'b100;
          end
        end
        3'b100 : begin
          IBusSimplePlugin_injector_port_state <= 3'b000;
        end
        default : begin
        end
      endcase
      if(execute_CsrPlugin_csr_1968) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_dcsr_prv <= CsrPlugin_csrMapping_writeDataSignal[1 : 0];
          CsrPlugin_dcsr_step <= CsrPlugin_csrMapping_writeDataSignal[2];
          CsrPlugin_dcsr_stoptime <= CsrPlugin_csrMapping_writeDataSignal[9];
          CsrPlugin_dcsr_stopcount <= CsrPlugin_csrMapping_writeDataSignal[10];
          CsrPlugin_dcsr_stepie <= CsrPlugin_csrMapping_writeDataSignal[11];
          CsrPlugin_dcsr_ebreakm <= CsrPlugin_csrMapping_writeDataSignal[15];
        end
      end
      if(execute_CsrPlugin_csr_1953) begin
        if(execute_CsrPlugin_writeEnable) begin
          if(CsrPlugin_trigger_slots_0_selected) begin
            CsrPlugin_trigger_slots_0_tdata1_execute <= CsrPlugin_csrMapping_writeDataSignal[2];
            CsrPlugin_trigger_slots_0_tdata1_u <= CsrPlugin_csrMapping_writeDataSignal[3];
            CsrPlugin_trigger_slots_0_tdata1_s <= CsrPlugin_csrMapping_writeDataSignal[4];
            CsrPlugin_trigger_slots_0_tdata1_m <= CsrPlugin_csrMapping_writeDataSignal[6];
            CsrPlugin_trigger_slots_0_tdata1_dmode <= CsrPlugin_csrMapping_writeDataSignal[27];
            CsrPlugin_trigger_slots_0_tdata1_action <= CsrPlugin_csrMapping_writeDataSignal[15 : 12];
          end
          if(CsrPlugin_trigger_slots_1_selected) begin
            CsrPlugin_trigger_slots_1_tdata1_execute <= CsrPlugin_csrMapping_writeDataSignal[2];
            CsrPlugin_trigger_slots_1_tdata1_u <= CsrPlugin_csrMapping_writeDataSignal[3];
            CsrPlugin_trigger_slots_1_tdata1_s <= CsrPlugin_csrMapping_writeDataSignal[4];
            CsrPlugin_trigger_slots_1_tdata1_m <= CsrPlugin_csrMapping_writeDataSignal[6];
            CsrPlugin_trigger_slots_1_tdata1_dmode <= CsrPlugin_csrMapping_writeDataSignal[27];
            CsrPlugin_trigger_slots_1_tdata1_action <= CsrPlugin_csrMapping_writeDataSignal[15 : 12];
          end
        end
      end
      if(execute_CsrPlugin_csr_768) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3];
          case(switch_CsrPlugin_l1031)
            2'b11 : begin
              CsrPlugin_mstatus_MPP <= 2'b11;
            end
            default : begin
            end
          endcase
        end
      end
      if(execute_CsrPlugin_csr_772) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11];
          CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
      CsrPlugin_running <= CsrPlugin_running_aheadValue;
    end
  end

  always @(posedge clk) begin
    if(IBusSimplePlugin_decompressor_input_valid) begin
      IBusSimplePlugin_decompressor_bufferValidLatch <= IBusSimplePlugin_decompressor_bufferValid;
    end
    if(IBusSimplePlugin_decompressor_input_valid) begin
      IBusSimplePlugin_decompressor_throw2BytesLatch <= IBusSimplePlugin_decompressor_throw2Bytes;
    end
    if(when_Fetcher_l288) begin
      IBusSimplePlugin_decompressor_bufferData <= IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16];
    end
    if(IBusSimplePlugin_decompressor_output_ready) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_pc <= IBusSimplePlugin_decompressor_output_payload_pc;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error <= IBusSimplePlugin_decompressor_output_payload_rsp_error;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= IBusSimplePlugin_decompressor_output_payload_rsp_inst;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc <= IBusSimplePlugin_decompressor_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready) begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_decompressor_raw;
    end
    if(when_CsrPlugin_l750) begin
      if(_zz_when[0]) begin
        CsrPlugin_dataCsrw_value_0 <= debugBus_dmToHart_payload_data;
      end
    end
    if(CsrPlugin_inject_cmd_toStream_ready) begin
      CsrPlugin_inject_cmd_toStream_rData_op <= CsrPlugin_inject_cmd_toStream_payload_op;
      CsrPlugin_inject_cmd_toStream_rData_address <= CsrPlugin_inject_cmd_toStream_payload_address;
      CsrPlugin_inject_cmd_toStream_rData_data <= CsrPlugin_inject_cmd_toStream_payload_data;
      CsrPlugin_inject_cmd_toStream_rData_size <= CsrPlugin_inject_cmd_toStream_payload_size;
    end
    if(CsrPlugin_trigger_decodeBreak_enabled) begin
      if(CsrPlugin_trigger_decodeBreak_timeout_state) begin
        CsrPlugin_dpc <= decode_PC;
      end
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(when_CsrPlugin_l1296) begin
      if(when_CsrPlugin_l1302) begin
        CsrPlugin_interrupt_code <= 4'b0111;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_1) begin
        CsrPlugin_interrupt_code <= 4'b0011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_2) begin
        CsrPlugin_interrupt_code <= 4'b1011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
    end
    if(when_CsrPlugin_l1390) begin
      if(when_CsrPlugin_l1398) begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
            CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
            CsrPlugin_mepc <= writeBack_PC;
            if(CsrPlugin_hadException) begin
              CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
            end
          end
          default : begin
          end
        endcase
      end else begin
        if(when_CsrPlugin_l1428) begin
          CsrPlugin_dpc <= writeBack_PC;
        end
      end
    end
    if(when_ShiftPlugins_l169) begin
      if(when_ShiftPlugins_l175) begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - 5'h01);
      end
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= _zz_decode_to_execute_PC;
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= execute_PC;
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_7) begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_8) begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_memory_to_writeBack_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_9) begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if(when_Pipeline_l124_11) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if(when_Pipeline_l124_12) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_13) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_14) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_15) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_16) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_17) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_18) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if(when_Pipeline_l124_19) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_20) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_21) begin
      decode_to_execute_MEMORY_STORE <= decode_MEMORY_STORE;
    end
    if(when_Pipeline_l124_22) begin
      execute_to_memory_MEMORY_STORE <= execute_MEMORY_STORE;
    end
    if(when_Pipeline_l124_23) begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if(when_Pipeline_l124_24) begin
      decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL;
    end
    if(when_Pipeline_l124_25) begin
      execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL;
    end
    if(when_Pipeline_l124_26) begin
      memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL;
    end
    if(when_Pipeline_l124_27) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
    end
    if(when_Pipeline_l124_28) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if(when_Pipeline_l124_29) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
    end
    if(when_Pipeline_l124_30) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_31) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
    end
    if(when_Pipeline_l124_32) begin
      decode_to_execute_RS1 <= _zz_decode_to_execute_RS1;
    end
    if(when_Pipeline_l124_33) begin
      decode_to_execute_RS2 <= _zz_decode_to_execute_RS2;
    end
    if(when_Pipeline_l124_34) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if(when_Pipeline_l124_35) begin
      decode_to_execute_SRC1 <= decode_SRC1;
    end
    if(when_Pipeline_l124_36) begin
      decode_to_execute_SRC2 <= decode_SRC2;
    end
    if(when_Pipeline_l124_37) begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_38) begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_39) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_execute_to_memory_REGFILE_WRITE_DATA;
    end
    if(when_Pipeline_l124_40) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= memory_REGFILE_WRITE_DATA;
    end
    if(when_Pipeline_l124_41) begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if(when_Pipeline_l124_42) begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if(when_Pipeline_l124_43) begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if(when_Fetcher_l411) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= CsrPlugin_injectionPort_payload;
    end
    if(when_CsrPlugin_l1669) begin
      execute_CsrPlugin_csr_1972 <= (decode_INSTRUCTION[31 : 20] == 12'h7b4);
    end
    if(when_CsrPlugin_l1669_1) begin
      execute_CsrPlugin_csr_1969 <= (decode_INSTRUCTION[31 : 20] == 12'h7b1);
    end
    if(when_CsrPlugin_l1669_2) begin
      execute_CsrPlugin_csr_1968 <= (decode_INSTRUCTION[31 : 20] == 12'h7b0);
    end
    if(when_CsrPlugin_l1669_3) begin
      execute_CsrPlugin_csr_1952 <= (decode_INSTRUCTION[31 : 20] == 12'h7a0);
    end
    if(when_CsrPlugin_l1669_4) begin
      execute_CsrPlugin_csr_1956 <= (decode_INSTRUCTION[31 : 20] == 12'h7a4);
    end
    if(when_CsrPlugin_l1669_5) begin
      execute_CsrPlugin_csr_1953 <= (decode_INSTRUCTION[31 : 20] == 12'h7a1);
    end
    if(when_CsrPlugin_l1669_6) begin
      execute_CsrPlugin_csr_1954 <= (decode_INSTRUCTION[31 : 20] == 12'h7a2);
    end
    if(when_CsrPlugin_l1669_7) begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300);
    end
    if(when_CsrPlugin_l1669_8) begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344);
    end
    if(when_CsrPlugin_l1669_9) begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304);
    end
    if(when_CsrPlugin_l1669_10) begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342);
    end
    if(execute_CsrPlugin_csr_1969) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_dpc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_1952) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_trigger_tselect_index <= CsrPlugin_csrMapping_writeDataSignal[0 : 0];
      end
    end
    if(execute_CsrPlugin_csr_1954) begin
      if(execute_CsrPlugin_writeEnable) begin
        if(CsrPlugin_trigger_slots_0_selected) begin
          CsrPlugin_trigger_slots_0_tdata2_value <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
        end
        if(CsrPlugin_trigger_slots_1_selected) begin
          CsrPlugin_trigger_slots_1_tdata2_value <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
        end
      end
    end
    if(execute_CsrPlugin_csr_836) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3];
      end
    end
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      toplevel_debugModule_1_io_harts_0_dmToHart_regNext_valid <= 1'b0;
    end else begin
      toplevel_debugModule_1_io_harts_0_dmToHart_regNext_valid <= debugModule_1_io_harts_0_dmToHart_valid;
    end
  end

  always @(posedge clk) begin
    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_op <= debugModule_1_io_harts_0_dmToHart_payload_op;
    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_address <= debugModule_1_io_harts_0_dmToHart_payload_address;
    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_data <= debugModule_1_io_harts_0_dmToHart_payload_data;
    toplevel_debugModule_1_io_harts_0_dmToHart_regNext_payload_size <= debugModule_1_io_harts_0_dmToHart_payload_size;
  end


endmodule

module DebugTransportModuleJtagTap (
  input  wire          io_jtag_tms,
  input  wire          io_jtag_tdi,
  output wire          io_jtag_tdo,
  input  wire          io_jtag_tck,
  output wire          io_bus_cmd_valid,
  input  wire          io_bus_cmd_ready,
  output wire          io_bus_cmd_payload_write,
  output wire [31:0]   io_bus_cmd_payload_data,
  output wire [6:0]    io_bus_cmd_payload_address,
  input  wire          io_bus_rsp_valid,
  input  wire          io_bus_rsp_payload_error,
  input  wire [31:0]   io_bus_rsp_payload_data,
  input  wire          clk,
  input  wire          debugReset
);
  localparam DebugCaptureOp_SUCCESS = 2'd0;
  localparam DebugCaptureOp_RESERVED = 2'd1;
  localparam DebugCaptureOp_FAILED = 2'd2;
  localparam DebugCaptureOp_OVERRUN = 2'd3;
  localparam JtagState_RESET = 4'd0;
  localparam JtagState_IDLE = 4'd1;
  localparam JtagState_IR_SELECT = 4'd2;
  localparam JtagState_IR_CAPTURE = 4'd3;
  localparam JtagState_IR_SHIFT = 4'd4;
  localparam JtagState_IR_EXIT1 = 4'd5;
  localparam JtagState_IR_PAUSE = 4'd6;
  localparam JtagState_IR_EXIT2 = 4'd7;
  localparam JtagState_IR_UPDATE = 4'd8;
  localparam JtagState_DR_SELECT = 4'd9;
  localparam JtagState_DR_CAPTURE = 4'd10;
  localparam JtagState_DR_SHIFT = 4'd11;
  localparam JtagState_DR_EXIT1 = 4'd12;
  localparam JtagState_DR_PAUSE = 4'd13;
  localparam JtagState_DR_EXIT2 = 4'd14;
  localparam JtagState_DR_UPDATE = 4'd15;
  localparam DebugUpdateOp_NOP = 2'd0;
  localparam DebugUpdateOp_READ = 2'd1;
  localparam DebugUpdateOp_WRITE = 2'd2;
  localparam DebugUpdateOp_RESERVED = 2'd3;

  wire                logic_jtagLogic_dmiCmd_ccToggle_io_output_valid;
  wire                logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_write;
  wire       [31:0]   logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_data;
  wire       [6:0]    logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_address;
  wire                logic_systemLogic_bus_rsp_ccToggle_io_output_valid;
  wire                logic_systemLogic_bus_rsp_ccToggle_io_output_payload_error;
  wire       [31:0]   logic_systemLogic_bus_rsp_ccToggle_io_output_payload_data;
  wire       [4:0]    _zz_tap_isBypass;
  wire       [1:0]    _zz_tap_instructionShift;
  reg        [1:0]    logic_jtagLogic_dmiStat_value_aheadValue;
  wire       [3:0]    tap_fsm_stateNext;
  reg        [3:0]    tap_fsm_state;
  wire       [3:0]    _zz_tap_fsm_stateNext;
  wire       [3:0]    _zz_tap_fsm_stateNext_1;
  wire       [3:0]    _zz_tap_fsm_stateNext_2;
  wire       [3:0]    _zz_tap_fsm_stateNext_3;
  wire       [3:0]    _zz_tap_fsm_stateNext_4;
  wire       [3:0]    _zz_tap_fsm_stateNext_5;
  wire       [3:0]    _zz_tap_fsm_stateNext_6;
  wire       [3:0]    _zz_tap_fsm_stateNext_7;
  wire       [3:0]    _zz_tap_fsm_stateNext_8;
  wire       [3:0]    _zz_tap_fsm_stateNext_9;
  wire       [3:0]    _zz_tap_fsm_stateNext_10;
  wire       [3:0]    _zz_tap_fsm_stateNext_11;
  wire       [3:0]    _zz_tap_fsm_stateNext_12;
  wire       [3:0]    _zz_tap_fsm_stateNext_13;
  wire       [3:0]    _zz_tap_fsm_stateNext_14;
  wire       [3:0]    _zz_tap_fsm_stateNext_15;
  reg        [3:0]    _zz_tap_fsm_stateNext_16;
  reg        [4:0]    tap_instruction;
  reg        [4:0]    tap_instructionShift;
  reg                 tap_bypass;
  reg                 tap_tdoUnbufferd;
  reg                 tap_tdoDr;
  wire                tap_tdoIr;
  wire                tap_isBypass;
  reg                 tap_tdoUnbufferd_regNext;
  wire                idcodeArea_ctrl_tdi;
  wire                idcodeArea_ctrl_enable;
  wire                idcodeArea_ctrl_capture;
  wire                idcodeArea_ctrl_shift;
  wire                idcodeArea_ctrl_update;
  wire                idcodeArea_ctrl_reset;
  wire                idcodeArea_ctrl_tdo;
  reg        [31:0]   idcodeArea_shifter;
  wire                when_JtagTap_l120;
  wire                logic_jtagLogic_dmiCmd_valid;
  wire                logic_jtagLogic_dmiCmd_payload_write;
  wire       [31:0]   logic_jtagLogic_dmiCmd_payload_data;
  wire       [6:0]    logic_jtagLogic_dmiCmd_payload_address;
  wire                logic_jtagLogic_dmiRsp_valid;
  wire                logic_jtagLogic_dmiRsp_payload_error;
  wire       [31:0]   logic_jtagLogic_dmiRsp_payload_data;
  wire       [31:0]   logic_jtagLogic_dtmcs_captureData;
  wire       [31:0]   logic_jtagLogic_dtmcs_updateData;
  wire                logic_jtagLogic_dtmcs_captureValid;
  wire                logic_jtagLogic_dtmcs_updateValid;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_tdi;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_enable;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_capture;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_shift;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_update;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_reset;
  wire                logic_jtagLogic_dtmcs_logic_ctrl_tdo;
  reg        [31:0]   logic_jtagLogic_dtmcs_logic_store;
  wire       [1:0]    logic_jtagLogic_dmi_captureData_op;
  wire       [31:0]   logic_jtagLogic_dmi_captureData_data;
  wire       [6:0]    logic_jtagLogic_dmi_captureData_padding;
  wire       [1:0]    logic_jtagLogic_dmi_updateData_op;
  wire       [31:0]   logic_jtagLogic_dmi_updateData_data;
  wire       [6:0]    logic_jtagLogic_dmi_updateData_address;
  wire                logic_jtagLogic_dmi_captureValid;
  wire                logic_jtagLogic_dmi_updateValid;
  wire                logic_jtagLogic_dmi_logic_ctrl_tdi;
  wire                logic_jtagLogic_dmi_logic_ctrl_enable;
  wire                logic_jtagLogic_dmi_logic_ctrl_capture;
  wire                logic_jtagLogic_dmi_logic_ctrl_shift;
  wire                logic_jtagLogic_dmi_logic_ctrl_update;
  wire                logic_jtagLogic_dmi_logic_ctrl_reset;
  wire                logic_jtagLogic_dmi_logic_ctrl_tdo;
  reg        [40:0]   logic_jtagLogic_dmi_logic_store;
  wire       [1:0]    _zz_logic_jtagLogic_dmi_updateData_op;
  reg        [1:0]    logic_jtagLogic_dmiStat_value;
  reg                 logic_jtagLogic_dmiStat_failure;
  reg                 logic_jtagLogic_dmiStat_busy;
  reg                 logic_jtagLogic_dmiStat_clear;
  wire                when_DebugTransportModuleJtag_l30;
  reg                 logic_jtagLogic_pending;
  wire                logic_jtagLogic_trigger_dmiHardReset;
  wire                logic_jtagLogic_trigger_dmiReset;
  reg                 logic_jtagLogic_trigger_dmiCmd;
  reg        [31:0]   logic_jtagLogic_rspLogic_buffer;
  wire                when_DebugTransportModuleJtag_l78;
  wire                logic_systemLogic_bus_cmd_valid;
  wire                logic_systemLogic_bus_cmd_ready;
  wire                logic_systemLogic_bus_cmd_payload_write;
  wire       [31:0]   logic_systemLogic_bus_cmd_payload_data;
  wire       [6:0]    logic_systemLogic_bus_cmd_payload_address;
  wire                logic_systemLogic_bus_rsp_valid;
  wire                logic_systemLogic_bus_rsp_payload_error;
  wire       [31:0]   logic_systemLogic_bus_rsp_payload_data;
  wire                debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_valid;
  reg                 debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_ready;
  wire                debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_write;
  wire       [31:0]   debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_data;
  wire       [6:0]    debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_address;
  wire                logic_systemLogic_cmd_valid;
  wire                logic_systemLogic_cmd_ready;
  wire                logic_systemLogic_cmd_payload_write;
  wire       [31:0]   logic_systemLogic_cmd_payload_data;
  wire       [6:0]    logic_systemLogic_cmd_payload_address;
  reg                 debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rValid;
  wire                debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_fire;
  (* async_reg = "true" *) reg                 debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_write;
  (* async_reg = "true" *) reg        [31:0]   debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_data;
  (* async_reg = "true" *) reg        [6:0]    debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_address;
  wire                when_Stream_l369;
  `ifndef SYNTHESIS
  reg [63:0] logic_jtagLogic_dmiStat_value_aheadValue_string;
  reg [79:0] tap_fsm_stateNext_string;
  reg [79:0] tap_fsm_state_string;
  reg [79:0] _zz_tap_fsm_stateNext_string;
  reg [79:0] _zz_tap_fsm_stateNext_1_string;
  reg [79:0] _zz_tap_fsm_stateNext_2_string;
  reg [79:0] _zz_tap_fsm_stateNext_3_string;
  reg [79:0] _zz_tap_fsm_stateNext_4_string;
  reg [79:0] _zz_tap_fsm_stateNext_5_string;
  reg [79:0] _zz_tap_fsm_stateNext_6_string;
  reg [79:0] _zz_tap_fsm_stateNext_7_string;
  reg [79:0] _zz_tap_fsm_stateNext_8_string;
  reg [79:0] _zz_tap_fsm_stateNext_9_string;
  reg [79:0] _zz_tap_fsm_stateNext_10_string;
  reg [79:0] _zz_tap_fsm_stateNext_11_string;
  reg [79:0] _zz_tap_fsm_stateNext_12_string;
  reg [79:0] _zz_tap_fsm_stateNext_13_string;
  reg [79:0] _zz_tap_fsm_stateNext_14_string;
  reg [79:0] _zz_tap_fsm_stateNext_15_string;
  reg [79:0] _zz_tap_fsm_stateNext_16_string;
  reg [63:0] logic_jtagLogic_dmi_captureData_op_string;
  reg [63:0] logic_jtagLogic_dmi_updateData_op_string;
  reg [63:0] _zz_logic_jtagLogic_dmi_updateData_op_string;
  reg [63:0] logic_jtagLogic_dmiStat_value_string;
  `endif


  assign _zz_tap_isBypass = tap_instruction;
  assign _zz_tap_instructionShift = 2'b01;
  FlowCCByToggle logic_jtagLogic_dmiCmd_ccToggle (
    .io_input_valid            (logic_jtagLogic_dmiCmd_valid                                  ), //i
    .io_input_payload_write    (logic_jtagLogic_dmiCmd_payload_write                          ), //i
    .io_input_payload_data     (logic_jtagLogic_dmiCmd_payload_data[31:0]                     ), //i
    .io_input_payload_address  (logic_jtagLogic_dmiCmd_payload_address[6:0]                   ), //i
    .io_output_valid           (logic_jtagLogic_dmiCmd_ccToggle_io_output_valid               ), //o
    .io_output_payload_write   (logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_write       ), //o
    .io_output_payload_data    (logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_data[31:0]  ), //o
    .io_output_payload_address (logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_address[6:0]), //o
    .io_jtag_tck               (io_jtag_tck                                                   ), //i
    .clk                       (clk                                                           ), //i
    .debugReset                (debugReset                                                    )  //i
  );
  FlowCCByToggle_1 logic_systemLogic_bus_rsp_ccToggle (
    .io_input_valid          (logic_systemLogic_bus_rsp_valid                                ), //i
    .io_input_payload_error  (logic_systemLogic_bus_rsp_payload_error                        ), //i
    .io_input_payload_data   (logic_systemLogic_bus_rsp_payload_data[31:0]                   ), //i
    .io_output_valid         (logic_systemLogic_bus_rsp_ccToggle_io_output_valid             ), //o
    .io_output_payload_error (logic_systemLogic_bus_rsp_ccToggle_io_output_payload_error     ), //o
    .io_output_payload_data  (logic_systemLogic_bus_rsp_ccToggle_io_output_payload_data[31:0]), //o
    .clk                     (clk                                                            ), //i
    .debugReset              (debugReset                                                     ), //i
    .io_jtag_tck             (io_jtag_tck                                                    )  //i
  );
  initial begin
  `ifndef SYNTHESIS
    tap_fsm_state = {$urandom};
  `endif
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(logic_jtagLogic_dmiStat_value_aheadValue)
      DebugCaptureOp_SUCCESS : logic_jtagLogic_dmiStat_value_aheadValue_string = "SUCCESS ";
      DebugCaptureOp_RESERVED : logic_jtagLogic_dmiStat_value_aheadValue_string = "RESERVED";
      DebugCaptureOp_FAILED : logic_jtagLogic_dmiStat_value_aheadValue_string = "FAILED  ";
      DebugCaptureOp_OVERRUN : logic_jtagLogic_dmiStat_value_aheadValue_string = "OVERRUN ";
      default : logic_jtagLogic_dmiStat_value_aheadValue_string = "????????";
    endcase
  end
  always @(*) begin
    case(tap_fsm_stateNext)
      JtagState_RESET : tap_fsm_stateNext_string = "RESET     ";
      JtagState_IDLE : tap_fsm_stateNext_string = "IDLE      ";
      JtagState_IR_SELECT : tap_fsm_stateNext_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : tap_fsm_stateNext_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : tap_fsm_stateNext_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : tap_fsm_stateNext_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : tap_fsm_stateNext_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : tap_fsm_stateNext_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : tap_fsm_stateNext_string = "IR_UPDATE ";
      JtagState_DR_SELECT : tap_fsm_stateNext_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : tap_fsm_stateNext_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : tap_fsm_stateNext_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : tap_fsm_stateNext_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : tap_fsm_stateNext_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : tap_fsm_stateNext_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : tap_fsm_stateNext_string = "DR_UPDATE ";
      default : tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(tap_fsm_state)
      JtagState_RESET : tap_fsm_state_string = "RESET     ";
      JtagState_IDLE : tap_fsm_state_string = "IDLE      ";
      JtagState_IR_SELECT : tap_fsm_state_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : tap_fsm_state_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : tap_fsm_state_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : tap_fsm_state_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : tap_fsm_state_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : tap_fsm_state_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : tap_fsm_state_string = "IR_UPDATE ";
      JtagState_DR_SELECT : tap_fsm_state_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : tap_fsm_state_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : tap_fsm_state_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : tap_fsm_state_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : tap_fsm_state_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : tap_fsm_state_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : tap_fsm_state_string = "DR_UPDATE ";
      default : tap_fsm_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext)
      JtagState_RESET : _zz_tap_fsm_stateNext_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_1)
      JtagState_RESET : _zz_tap_fsm_stateNext_1_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_1_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_1_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_1_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_1_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_1_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_1_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_1_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_1_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_1_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_1_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_1_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_1_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_1_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_1_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_1_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_1_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_2)
      JtagState_RESET : _zz_tap_fsm_stateNext_2_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_2_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_2_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_2_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_2_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_2_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_2_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_2_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_2_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_2_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_2_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_2_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_2_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_2_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_2_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_2_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_2_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_3)
      JtagState_RESET : _zz_tap_fsm_stateNext_3_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_3_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_3_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_3_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_3_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_3_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_3_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_3_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_3_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_3_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_3_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_3_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_3_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_3_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_3_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_3_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_3_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_4)
      JtagState_RESET : _zz_tap_fsm_stateNext_4_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_4_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_4_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_4_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_4_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_4_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_4_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_4_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_4_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_4_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_4_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_4_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_4_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_4_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_4_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_4_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_4_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_5)
      JtagState_RESET : _zz_tap_fsm_stateNext_5_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_5_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_5_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_5_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_5_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_5_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_5_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_5_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_5_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_5_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_5_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_5_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_5_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_5_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_5_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_5_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_5_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_6)
      JtagState_RESET : _zz_tap_fsm_stateNext_6_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_6_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_6_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_6_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_6_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_6_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_6_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_6_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_6_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_6_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_6_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_6_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_6_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_6_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_6_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_6_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_6_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_7)
      JtagState_RESET : _zz_tap_fsm_stateNext_7_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_7_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_7_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_7_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_7_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_7_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_7_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_7_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_7_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_7_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_7_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_7_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_7_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_7_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_7_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_7_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_7_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_8)
      JtagState_RESET : _zz_tap_fsm_stateNext_8_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_8_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_8_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_8_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_8_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_8_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_8_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_8_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_8_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_8_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_8_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_8_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_8_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_8_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_8_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_8_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_8_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_9)
      JtagState_RESET : _zz_tap_fsm_stateNext_9_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_9_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_9_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_9_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_9_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_9_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_9_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_9_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_9_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_9_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_9_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_9_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_9_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_9_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_9_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_9_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_9_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_10)
      JtagState_RESET : _zz_tap_fsm_stateNext_10_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_10_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_10_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_10_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_10_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_10_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_10_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_10_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_10_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_10_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_10_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_10_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_10_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_10_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_10_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_10_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_10_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_11)
      JtagState_RESET : _zz_tap_fsm_stateNext_11_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_11_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_11_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_11_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_11_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_11_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_11_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_11_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_11_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_11_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_11_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_11_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_11_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_11_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_11_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_11_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_11_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_12)
      JtagState_RESET : _zz_tap_fsm_stateNext_12_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_12_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_12_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_12_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_12_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_12_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_12_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_12_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_12_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_12_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_12_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_12_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_12_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_12_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_12_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_12_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_12_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_13)
      JtagState_RESET : _zz_tap_fsm_stateNext_13_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_13_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_13_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_13_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_13_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_13_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_13_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_13_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_13_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_13_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_13_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_13_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_13_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_13_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_13_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_13_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_13_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_14)
      JtagState_RESET : _zz_tap_fsm_stateNext_14_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_14_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_14_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_14_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_14_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_14_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_14_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_14_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_14_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_14_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_14_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_14_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_14_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_14_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_14_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_14_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_14_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_15)
      JtagState_RESET : _zz_tap_fsm_stateNext_15_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_15_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_15_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_15_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_15_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_15_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_15_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_15_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_15_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_15_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_15_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_15_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_15_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_15_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_15_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_15_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_15_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_tap_fsm_stateNext_16)
      JtagState_RESET : _zz_tap_fsm_stateNext_16_string = "RESET     ";
      JtagState_IDLE : _zz_tap_fsm_stateNext_16_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_tap_fsm_stateNext_16_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_tap_fsm_stateNext_16_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_tap_fsm_stateNext_16_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_tap_fsm_stateNext_16_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_tap_fsm_stateNext_16_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_tap_fsm_stateNext_16_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_tap_fsm_stateNext_16_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_tap_fsm_stateNext_16_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_tap_fsm_stateNext_16_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_tap_fsm_stateNext_16_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_tap_fsm_stateNext_16_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_tap_fsm_stateNext_16_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_tap_fsm_stateNext_16_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_tap_fsm_stateNext_16_string = "DR_UPDATE ";
      default : _zz_tap_fsm_stateNext_16_string = "??????????";
    endcase
  end
  always @(*) begin
    case(logic_jtagLogic_dmi_captureData_op)
      DebugCaptureOp_SUCCESS : logic_jtagLogic_dmi_captureData_op_string = "SUCCESS ";
      DebugCaptureOp_RESERVED : logic_jtagLogic_dmi_captureData_op_string = "RESERVED";
      DebugCaptureOp_FAILED : logic_jtagLogic_dmi_captureData_op_string = "FAILED  ";
      DebugCaptureOp_OVERRUN : logic_jtagLogic_dmi_captureData_op_string = "OVERRUN ";
      default : logic_jtagLogic_dmi_captureData_op_string = "????????";
    endcase
  end
  always @(*) begin
    case(logic_jtagLogic_dmi_updateData_op)
      DebugUpdateOp_NOP : logic_jtagLogic_dmi_updateData_op_string = "NOP     ";
      DebugUpdateOp_READ : logic_jtagLogic_dmi_updateData_op_string = "READ    ";
      DebugUpdateOp_WRITE : logic_jtagLogic_dmi_updateData_op_string = "WRITE   ";
      DebugUpdateOp_RESERVED : logic_jtagLogic_dmi_updateData_op_string = "RESERVED";
      default : logic_jtagLogic_dmi_updateData_op_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_logic_jtagLogic_dmi_updateData_op)
      DebugUpdateOp_NOP : _zz_logic_jtagLogic_dmi_updateData_op_string = "NOP     ";
      DebugUpdateOp_READ : _zz_logic_jtagLogic_dmi_updateData_op_string = "READ    ";
      DebugUpdateOp_WRITE : _zz_logic_jtagLogic_dmi_updateData_op_string = "WRITE   ";
      DebugUpdateOp_RESERVED : _zz_logic_jtagLogic_dmi_updateData_op_string = "RESERVED";
      default : _zz_logic_jtagLogic_dmi_updateData_op_string = "????????";
    endcase
  end
  always @(*) begin
    case(logic_jtagLogic_dmiStat_value)
      DebugCaptureOp_SUCCESS : logic_jtagLogic_dmiStat_value_string = "SUCCESS ";
      DebugCaptureOp_RESERVED : logic_jtagLogic_dmiStat_value_string = "RESERVED";
      DebugCaptureOp_FAILED : logic_jtagLogic_dmiStat_value_string = "FAILED  ";
      DebugCaptureOp_OVERRUN : logic_jtagLogic_dmiStat_value_string = "OVERRUN ";
      default : logic_jtagLogic_dmiStat_value_string = "????????";
    endcase
  end
  `endif

  always @(*) begin
    logic_jtagLogic_dmiStat_value_aheadValue = logic_jtagLogic_dmiStat_value;
    if(when_DebugTransportModuleJtag_l30) begin
      if(logic_jtagLogic_dmiStat_failure) begin
        logic_jtagLogic_dmiStat_value_aheadValue = DebugCaptureOp_FAILED;
      end
      if(logic_jtagLogic_dmiStat_busy) begin
        logic_jtagLogic_dmiStat_value_aheadValue = DebugCaptureOp_OVERRUN;
      end
    end
    if(logic_jtagLogic_dmiStat_clear) begin
      logic_jtagLogic_dmiStat_value_aheadValue = DebugCaptureOp_SUCCESS;
    end
  end

  assign _zz_tap_fsm_stateNext = (io_jtag_tms ? JtagState_RESET : JtagState_IDLE);
  assign _zz_tap_fsm_stateNext_1 = (io_jtag_tms ? JtagState_DR_SELECT : JtagState_IDLE);
  assign _zz_tap_fsm_stateNext_2 = (io_jtag_tms ? JtagState_RESET : JtagState_IR_CAPTURE);
  assign _zz_tap_fsm_stateNext_3 = (io_jtag_tms ? JtagState_IR_EXIT1 : JtagState_IR_SHIFT);
  assign _zz_tap_fsm_stateNext_4 = (io_jtag_tms ? JtagState_IR_EXIT1 : JtagState_IR_SHIFT);
  assign _zz_tap_fsm_stateNext_5 = (io_jtag_tms ? JtagState_IR_UPDATE : JtagState_IR_PAUSE);
  assign _zz_tap_fsm_stateNext_6 = (io_jtag_tms ? JtagState_IR_EXIT2 : JtagState_IR_PAUSE);
  assign _zz_tap_fsm_stateNext_7 = (io_jtag_tms ? JtagState_IR_UPDATE : JtagState_IR_SHIFT);
  assign _zz_tap_fsm_stateNext_8 = (io_jtag_tms ? JtagState_DR_SELECT : JtagState_IDLE);
  assign _zz_tap_fsm_stateNext_9 = (io_jtag_tms ? JtagState_IR_SELECT : JtagState_DR_CAPTURE);
  assign _zz_tap_fsm_stateNext_10 = (io_jtag_tms ? JtagState_DR_EXIT1 : JtagState_DR_SHIFT);
  assign _zz_tap_fsm_stateNext_11 = (io_jtag_tms ? JtagState_DR_EXIT1 : JtagState_DR_SHIFT);
  assign _zz_tap_fsm_stateNext_12 = (io_jtag_tms ? JtagState_DR_UPDATE : JtagState_DR_PAUSE);
  assign _zz_tap_fsm_stateNext_13 = (io_jtag_tms ? JtagState_DR_EXIT2 : JtagState_DR_PAUSE);
  assign _zz_tap_fsm_stateNext_14 = (io_jtag_tms ? JtagState_DR_UPDATE : JtagState_DR_SHIFT);
  assign _zz_tap_fsm_stateNext_15 = (io_jtag_tms ? JtagState_DR_SELECT : JtagState_IDLE);
  always @(*) begin
    case(tap_fsm_state)
      JtagState_IDLE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_1;
      end
      JtagState_IR_SELECT : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_2;
      end
      JtagState_IR_CAPTURE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_3;
      end
      JtagState_IR_SHIFT : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_4;
      end
      JtagState_IR_EXIT1 : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_5;
      end
      JtagState_IR_PAUSE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_6;
      end
      JtagState_IR_EXIT2 : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_7;
      end
      JtagState_IR_UPDATE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_8;
      end
      JtagState_DR_SELECT : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_9;
      end
      JtagState_DR_CAPTURE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_10;
      end
      JtagState_DR_SHIFT : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_11;
      end
      JtagState_DR_EXIT1 : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_12;
      end
      JtagState_DR_PAUSE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_13;
      end
      JtagState_DR_EXIT2 : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_14;
      end
      JtagState_DR_UPDATE : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext_15;
      end
      default : begin
        _zz_tap_fsm_stateNext_16 = _zz_tap_fsm_stateNext;
      end
    endcase
  end

  assign tap_fsm_stateNext = _zz_tap_fsm_stateNext_16;
  always @(*) begin
    tap_tdoUnbufferd = tap_bypass;
    case(tap_fsm_state)
      JtagState_IR_SHIFT : begin
        tap_tdoUnbufferd = tap_tdoIr;
      end
      JtagState_DR_SHIFT : begin
        if(tap_isBypass) begin
          tap_tdoUnbufferd = tap_bypass;
        end else begin
          tap_tdoUnbufferd = tap_tdoDr;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    tap_tdoDr = 1'b0;
    if(idcodeArea_ctrl_enable) begin
      tap_tdoDr = idcodeArea_ctrl_tdo;
    end
    if(logic_jtagLogic_dtmcs_logic_ctrl_enable) begin
      tap_tdoDr = logic_jtagLogic_dtmcs_logic_ctrl_tdo;
    end
    if(logic_jtagLogic_dmi_logic_ctrl_enable) begin
      tap_tdoDr = logic_jtagLogic_dmi_logic_ctrl_tdo;
    end
  end

  assign tap_tdoIr = tap_instructionShift[0];
  assign tap_isBypass = ($signed(_zz_tap_isBypass) == $signed(5'h1f));
  assign io_jtag_tdo = tap_tdoUnbufferd_regNext;
  assign idcodeArea_ctrl_tdo = idcodeArea_shifter[0];
  assign idcodeArea_ctrl_tdi = io_jtag_tdi;
  assign idcodeArea_ctrl_enable = (tap_instruction == 5'h01);
  assign idcodeArea_ctrl_capture = (tap_fsm_state == JtagState_DR_CAPTURE);
  assign idcodeArea_ctrl_shift = (tap_fsm_state == JtagState_DR_SHIFT);
  assign idcodeArea_ctrl_update = (tap_fsm_state == JtagState_DR_UPDATE);
  assign idcodeArea_ctrl_reset = (tap_fsm_state == JtagState_RESET);
  assign when_JtagTap_l120 = (tap_fsm_state == JtagState_RESET);
  assign logic_jtagLogic_dtmcs_captureValid = ((tap_instruction == 5'h10) && (tap_fsm_state == JtagState_DR_CAPTURE));
  assign logic_jtagLogic_dtmcs_updateValid = ((tap_instruction == 5'h10) && (tap_fsm_state == JtagState_DR_UPDATE));
  assign logic_jtagLogic_dtmcs_logic_ctrl_tdo = logic_jtagLogic_dtmcs_logic_store[0];
  assign logic_jtagLogic_dtmcs_updateData = logic_jtagLogic_dtmcs_logic_store;
  assign logic_jtagLogic_dtmcs_logic_ctrl_tdi = io_jtag_tdi;
  assign logic_jtagLogic_dtmcs_logic_ctrl_enable = (tap_instruction == 5'h10);
  assign logic_jtagLogic_dtmcs_logic_ctrl_capture = (tap_fsm_state == JtagState_DR_CAPTURE);
  assign logic_jtagLogic_dtmcs_logic_ctrl_shift = (tap_fsm_state == JtagState_DR_SHIFT);
  assign logic_jtagLogic_dtmcs_logic_ctrl_update = (tap_fsm_state == JtagState_DR_UPDATE);
  assign logic_jtagLogic_dtmcs_logic_ctrl_reset = (tap_fsm_state == JtagState_RESET);
  assign logic_jtagLogic_dmi_captureValid = ((tap_instruction == 5'h11) && (tap_fsm_state == JtagState_DR_CAPTURE));
  assign logic_jtagLogic_dmi_updateValid = ((tap_instruction == 5'h11) && (tap_fsm_state == JtagState_DR_UPDATE));
  assign logic_jtagLogic_dmi_logic_ctrl_tdo = logic_jtagLogic_dmi_logic_store[0];
  assign _zz_logic_jtagLogic_dmi_updateData_op = logic_jtagLogic_dmi_logic_store[1 : 0];
  assign logic_jtagLogic_dmi_updateData_op = _zz_logic_jtagLogic_dmi_updateData_op;
  assign logic_jtagLogic_dmi_updateData_data = logic_jtagLogic_dmi_logic_store[33 : 2];
  assign logic_jtagLogic_dmi_updateData_address = logic_jtagLogic_dmi_logic_store[40 : 34];
  assign logic_jtagLogic_dmi_logic_ctrl_tdi = io_jtag_tdi;
  assign logic_jtagLogic_dmi_logic_ctrl_enable = (tap_instruction == 5'h11);
  assign logic_jtagLogic_dmi_logic_ctrl_capture = (tap_fsm_state == JtagState_DR_CAPTURE);
  assign logic_jtagLogic_dmi_logic_ctrl_shift = (tap_fsm_state == JtagState_DR_SHIFT);
  assign logic_jtagLogic_dmi_logic_ctrl_update = (tap_fsm_state == JtagState_DR_UPDATE);
  assign logic_jtagLogic_dmi_logic_ctrl_reset = (tap_fsm_state == JtagState_RESET);
  always @(*) begin
    logic_jtagLogic_dmiStat_failure = 1'b0;
    if(logic_jtagLogic_dmi_updateValid) begin
      case(logic_jtagLogic_dmi_updateData_op)
        DebugUpdateOp_NOP : begin
        end
        DebugUpdateOp_READ : begin
        end
        DebugUpdateOp_WRITE : begin
        end
        default : begin
          logic_jtagLogic_dmiStat_failure = 1'b1;
        end
      endcase
    end
    if(logic_jtagLogic_dmiRsp_valid) begin
      if(logic_jtagLogic_dmiRsp_payload_error) begin
        logic_jtagLogic_dmiStat_failure = 1'b1;
      end
    end
  end

  always @(*) begin
    logic_jtagLogic_dmiStat_busy = 1'b0;
    if(when_DebugTransportModuleJtag_l78) begin
      logic_jtagLogic_dmiStat_busy = 1'b1;
    end
  end

  always @(*) begin
    logic_jtagLogic_dmiStat_clear = 1'b0;
    if(logic_jtagLogic_trigger_dmiReset) begin
      logic_jtagLogic_dmiStat_clear = 1'b1;
    end
    if(logic_jtagLogic_trigger_dmiHardReset) begin
      logic_jtagLogic_dmiStat_clear = 1'b1;
    end
  end

  assign when_DebugTransportModuleJtag_l30 = (logic_jtagLogic_dmiStat_value == DebugCaptureOp_SUCCESS);
  assign logic_jtagLogic_trigger_dmiHardReset = ((logic_jtagLogic_dtmcs_updateData[17] && logic_jtagLogic_dtmcs_updateValid) || (tap_fsm_state == JtagState_RESET));
  assign logic_jtagLogic_trigger_dmiReset = ((logic_jtagLogic_dtmcs_updateData[16] && logic_jtagLogic_dtmcs_updateValid) || (tap_fsm_state == JtagState_RESET));
  always @(*) begin
    logic_jtagLogic_trigger_dmiCmd = 1'b0;
    if(logic_jtagLogic_dmi_updateValid) begin
      case(logic_jtagLogic_dmi_updateData_op)
        DebugUpdateOp_NOP : begin
        end
        DebugUpdateOp_READ : begin
          logic_jtagLogic_trigger_dmiCmd = 1'b1;
        end
        DebugUpdateOp_WRITE : begin
          logic_jtagLogic_trigger_dmiCmd = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  assign logic_jtagLogic_dtmcs_captureData = {{{{17'h00000,3'b111},logic_jtagLogic_dmiStat_value},6'h07},4'b0001};
  assign logic_jtagLogic_dmiCmd_valid = logic_jtagLogic_trigger_dmiCmd;
  assign logic_jtagLogic_dmiCmd_payload_write = (logic_jtagLogic_dmi_updateData_op == DebugUpdateOp_WRITE);
  assign logic_jtagLogic_dmiCmd_payload_address = logic_jtagLogic_dmi_updateData_address;
  assign logic_jtagLogic_dmiCmd_payload_data = logic_jtagLogic_dmi_updateData_data;
  assign logic_jtagLogic_dmi_captureData_op = logic_jtagLogic_dmiStat_value_aheadValue;
  assign logic_jtagLogic_dmi_captureData_data = logic_jtagLogic_rspLogic_buffer;
  assign logic_jtagLogic_dmi_captureData_padding = 7'h00;
  assign when_DebugTransportModuleJtag_l78 = (logic_jtagLogic_dmi_captureValid && logic_jtagLogic_pending);
  assign debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_valid = logic_jtagLogic_dmiCmd_ccToggle_io_output_valid;
  assign debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_write = logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_write;
  assign debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_data = logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_data;
  assign debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_address = logic_jtagLogic_dmiCmd_ccToggle_io_output_payload_address;
  assign debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_fire = (debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_valid && debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_ready);
  always @(*) begin
    debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_ready = logic_systemLogic_cmd_ready;
    if(when_Stream_l369) begin
      debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! logic_systemLogic_cmd_valid);
  assign logic_systemLogic_cmd_valid = debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rValid;
  assign logic_systemLogic_cmd_payload_write = debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_write;
  assign logic_systemLogic_cmd_payload_data = debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_data;
  assign logic_systemLogic_cmd_payload_address = debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_address;
  assign logic_systemLogic_bus_cmd_valid = logic_systemLogic_cmd_valid;
  assign logic_systemLogic_cmd_ready = logic_systemLogic_bus_cmd_ready;
  assign logic_systemLogic_bus_cmd_payload_write = logic_systemLogic_cmd_payload_write;
  assign logic_systemLogic_bus_cmd_payload_data = logic_systemLogic_cmd_payload_data;
  assign logic_systemLogic_bus_cmd_payload_address = logic_systemLogic_cmd_payload_address;
  assign logic_jtagLogic_dmiRsp_valid = logic_systemLogic_bus_rsp_ccToggle_io_output_valid;
  assign logic_jtagLogic_dmiRsp_payload_error = logic_systemLogic_bus_rsp_ccToggle_io_output_payload_error;
  assign logic_jtagLogic_dmiRsp_payload_data = logic_systemLogic_bus_rsp_ccToggle_io_output_payload_data;
  assign io_bus_cmd_valid = logic_systemLogic_bus_cmd_valid;
  assign logic_systemLogic_bus_cmd_ready = io_bus_cmd_ready;
  assign io_bus_cmd_payload_write = logic_systemLogic_bus_cmd_payload_write;
  assign io_bus_cmd_payload_data = logic_systemLogic_bus_cmd_payload_data;
  assign io_bus_cmd_payload_address = logic_systemLogic_bus_cmd_payload_address;
  assign logic_systemLogic_bus_rsp_valid = io_bus_rsp_valid;
  assign logic_systemLogic_bus_rsp_payload_error = io_bus_rsp_payload_error;
  assign logic_systemLogic_bus_rsp_payload_data = io_bus_rsp_payload_data;
  always @(posedge io_jtag_tck) begin
    tap_fsm_state <= tap_fsm_stateNext;
    tap_bypass <= io_jtag_tdi;
    case(tap_fsm_state)
      JtagState_IR_CAPTURE : begin
        tap_instructionShift <= {3'd0, _zz_tap_instructionShift};
      end
      JtagState_IR_SHIFT : begin
        tap_instructionShift <= ({io_jtag_tdi,tap_instructionShift} >>> 1'd1);
      end
      JtagState_IR_UPDATE : begin
        tap_instruction <= tap_instructionShift;
      end
      JtagState_DR_SHIFT : begin
        tap_instructionShift <= ({io_jtag_tdi,tap_instructionShift} >>> 1'd1);
      end
      default : begin
      end
    endcase
    if(idcodeArea_ctrl_enable) begin
      if(idcodeArea_ctrl_shift) begin
        idcodeArea_shifter <= ({idcodeArea_ctrl_tdi,idcodeArea_shifter} >>> 1'd1);
      end
    end
    if(idcodeArea_ctrl_capture) begin
      idcodeArea_shifter <= 32'h10002fff;
    end
    if(when_JtagTap_l120) begin
      tap_instruction <= 5'h01;
    end
    if(logic_jtagLogic_dtmcs_logic_ctrl_enable) begin
      if(logic_jtagLogic_dtmcs_logic_ctrl_capture) begin
        logic_jtagLogic_dtmcs_logic_store <= logic_jtagLogic_dtmcs_captureData;
      end
      if(logic_jtagLogic_dtmcs_logic_ctrl_shift) begin
        logic_jtagLogic_dtmcs_logic_store <= ({logic_jtagLogic_dtmcs_logic_ctrl_tdi,logic_jtagLogic_dtmcs_logic_store} >>> 1'd1);
      end
    end
    if(logic_jtagLogic_dmi_logic_ctrl_enable) begin
      if(logic_jtagLogic_dmi_logic_ctrl_capture) begin
        logic_jtagLogic_dmi_logic_store <= {logic_jtagLogic_dmi_captureData_padding,{logic_jtagLogic_dmi_captureData_data,logic_jtagLogic_dmi_captureData_op}};
      end
      if(logic_jtagLogic_dmi_logic_ctrl_shift) begin
        logic_jtagLogic_dmi_logic_store <= ({logic_jtagLogic_dmi_logic_ctrl_tdi,logic_jtagLogic_dmi_logic_store} >>> 1'd1);
      end
    end
    if(logic_jtagLogic_dmiCmd_valid) begin
      logic_jtagLogic_pending <= 1'b1;
    end
    if(logic_jtagLogic_dmiRsp_valid) begin
      logic_jtagLogic_pending <= 1'b0;
    end
    if(logic_jtagLogic_trigger_dmiHardReset) begin
      logic_jtagLogic_pending <= 1'b0;
    end
    if(logic_jtagLogic_dmiRsp_valid) begin
      logic_jtagLogic_rspLogic_buffer <= logic_jtagLogic_dmiRsp_payload_data;
    end
    logic_jtagLogic_dmiStat_value <= logic_jtagLogic_dmiStat_value_aheadValue;
  end

  always @(negedge io_jtag_tck) begin
    tap_tdoUnbufferd_regNext <= tap_tdoUnbufferd;
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rValid <= 1'b0;
    end else begin
      if(debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_ready) begin
        debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rValid <= debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_fire) begin
      debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_write <= debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_write;
      debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_data <= debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_data;
      debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_rData_address <= debugTransportModuleJtagTap_1_logic_jtagLogic_dmiCmd_ccToggle_io_output_toStream_payload_address;
    end
  end


endmodule

module DebugModule (
  input  wire          io_ctrl_cmd_valid,
  output wire          io_ctrl_cmd_ready,
  input  wire          io_ctrl_cmd_payload_write,
  input  wire [31:0]   io_ctrl_cmd_payload_data,
  input  wire [6:0]    io_ctrl_cmd_payload_address,
  output wire          io_ctrl_rsp_valid,
  output wire          io_ctrl_rsp_payload_error,
  output wire [31:0]   io_ctrl_rsp_payload_data,
  output wire          io_ndmreset,
  input  wire          io_harts_0_halted,
  input  wire          io_harts_0_running,
  input  wire          io_harts_0_unavailable,
  input  wire          io_harts_0_exception,
  input  wire          io_harts_0_commit,
  input  wire          io_harts_0_ebreak,
  input  wire          io_harts_0_redo,
  input  wire          io_harts_0_regSuccess,
  output wire          io_harts_0_ackReset,
  input  wire          io_harts_0_haveReset,
  output reg           io_harts_0_resume_cmd_valid,
  input  wire          io_harts_0_resume_rsp_valid,
  output wire          io_harts_0_haltReq,
  output wire          io_harts_0_dmToHart_valid,
  output wire [1:0]    io_harts_0_dmToHart_payload_op,
  output wire [4:0]    io_harts_0_dmToHart_payload_address,
  output wire [31:0]   io_harts_0_dmToHart_payload_data,
  output wire [2:0]    io_harts_0_dmToHart_payload_size,
  input  wire          io_harts_0_hartToDm_valid,
  input  wire [3:0]    io_harts_0_hartToDm_payload_address,
  input  wire [31:0]   io_harts_0_hartToDm_payload_data,
  input  wire          clk,
  input  wire          debugReset
);
  localparam DebugDmToHartOp_DATA = 2'd0;
  localparam DebugDmToHartOp_EXECUTE = 2'd1;
  localparam DebugDmToHartOp_REG_WRITE = 2'd2;
  localparam DebugDmToHartOp_REG_READ = 2'd3;
  localparam DebugModuleCmdErr_NONE = 3'd0;
  localparam DebugModuleCmdErr_BUSY = 3'd1;
  localparam DebugModuleCmdErr_NOT_SUPPORTED = 3'd2;
  localparam DebugModuleCmdErr_EXCEPTION = 3'd3;
  localparam DebugModuleCmdErr_HALT_RESUME = 3'd4;
  localparam DebugModuleCmdErr_BUS_1 = 3'd5;
  localparam DebugModuleCmdErr_OTHER = 3'd6;
  localparam logic_command_enumDef_BOOT = 3'd0;
  localparam logic_command_enumDef_IDLE = 3'd1;
  localparam logic_command_enumDef_DECODE = 3'd2;
  localparam logic_command_enumDef_READ_INT_REG = 3'd3;
  localparam logic_command_enumDef_WRITE_INT_REG = 3'd4;
  localparam logic_command_enumDef_WAIT_DONE = 3'd5;
  localparam logic_command_enumDef_POST_EXEC = 3'd6;
  localparam logic_command_enumDef_POST_EXEC_WAIT = 3'd7;

  wire       [31:0]   _zz_logic_progbufX_mem_port1;
  wire       [0:0]    _zz_logic_dmcontrol_haltSet;
  wire       [0:0]    _zz_logic_dmcontrol_haltClear;
  wire       [0:0]    _zz_logic_dmcontrol_resumeReq;
  wire       [0:0]    _zz_logic_dmcontrol_ackhavereset;
  wire       [14:0]   _zz_when_DebugModule_l143;
  wire       [0:0]    _zz_logic_progbufX_mem_port;
  wire       [0:0]    _zz_logic_abstractAuto_trigger;
  wire       [2:0]    _zz_logic_command_access_notSupported;
  wire       [1:0]    _zz_logic_command_access_notSupported_1;
  wire       [31:0]   _zz_logic_toHarts_payload_data;
  wire       [19:0]   _zz_logic_toHarts_payload_data_1;
  wire       [31:0]   _zz_logic_toHarts_payload_data_2;
  wire       [11:0]   _zz_logic_toHarts_payload_data_3;
  reg                 _zz_1;
  wire                factory_readErrorFlag;
  wire                factory_writeErrorFlag;
  wire                factory_cmdToRsp_valid;
  reg                 factory_cmdToRsp_payload_error;
  reg        [31:0]   factory_cmdToRsp_payload_data;
  reg                 factory_rspBuffer_valid;
  reg                 factory_rspBuffer_payload_error;
  reg        [31:0]   factory_rspBuffer_payload_data;
  wire                factory_askWrite;
  wire                factory_askRead;
  wire                factory_doWrite;
  wire                factory_doRead;
  wire                io_ctrl_cmd_fire;
  reg                 dmactive;
  reg                 logic_dmcontrol_ndmreset;
  wire       [9:0]    logic_dmcontrol_hartSelLoNew;
  wire       [9:0]    logic_dmcontrol_hartSelHiNew;
  wire       [19:0]   logic_dmcontrol_hartSelNew;
  reg        [9:0]    logic_dmcontrol_hartSelLo;
  reg        [9:0]    logic_dmcontrol_hartSelHi;
  wire       [19:0]   logic_dmcontrol_hartSel;
  reg                 logic_dmcontrol_haltSet;
  reg                 when_BusSlaveFactory_l377;
  wire                when_BusSlaveFactory_l379;
  reg                 logic_dmcontrol_haltClear;
  reg                 when_BusSlaveFactory_l391;
  wire                when_BusSlaveFactory_l393;
  reg                 logic_dmcontrol_resumeReq;
  reg                 when_BusSlaveFactory_l377_1;
  wire                when_BusSlaveFactory_l379_1;
  reg                 logic_dmcontrol_ackhavereset;
  reg                 when_BusSlaveFactory_l377_2;
  wire                when_BusSlaveFactory_l379_2;
  wire       [1:0]    logic_dmcontrol_hartSelAarsizeLimit;
  reg                 logic_dmcontrol_harts_0_haltReq;
  wire                when_DebugModule_l102;
  reg                 logic_toHarts_valid;
  reg        [1:0]    logic_toHarts_payload_op;
  reg        [4:0]    logic_toHarts_payload_address;
  reg        [31:0]   logic_toHarts_payload_data;
  reg        [2:0]    logic_toHarts_payload_size;
  wire                logic_fromHarts_valid;
  wire       [3:0]    logic_fromHarts_payload_address;
  wire       [31:0]   logic_fromHarts_payload_data;
  wire                logic_harts_0_sel;
  reg                 _zz_logic_harts_0_resumeReady;
  reg                 _zz_logic_harts_0_resumeReady_1;
  wire                logic_harts_0_resumeReady;
  wire                logic_toHarts_takeWhen_valid;
  wire       [1:0]    logic_toHarts_takeWhen_payload_op;
  wire       [4:0]    logic_toHarts_takeWhen_payload_address;
  wire       [31:0]   logic_toHarts_takeWhen_payload_data;
  wire       [2:0]    logic_toHarts_takeWhen_payload_size;
  reg                 _zz_io_harts_0_ackReset;
  wire                logic_selected_running;
  wire                logic_selected_halted;
  wire                logic_selected_commit;
  wire                logic_selected_regSuccess;
  wire                logic_selected_exception;
  wire                logic_selected_ebreak;
  wire                logic_selected_redo;
  reg        [31:0]   logic_haltsum_value;
  wire                when_DebugModule_l143;
  wire       [3:0]    logic_dmstatus_version;
  wire                logic_dmstatus_authenticated;
  wire                logic_dmstatus_anyHalted;
  wire                logic_dmstatus_allHalted;
  wire                logic_dmstatus_anyRunning;
  wire                logic_dmstatus_allRunning;
  wire                logic_dmstatus_anyUnavail;
  wire                logic_dmstatus_allUnavail;
  wire                logic_dmstatus_anyNonExistent;
  wire                logic_dmstatus_anyResumeAck;
  wire                logic_dmstatus_allResumeAck;
  wire                logic_dmstatus_anyHaveReset;
  wire                logic_dmstatus_allHaveReset;
  wire                logic_dmstatus_impebreak;
  wire       [3:0]    logic_hartInfo_dataaddr;
  wire       [3:0]    logic_hartInfo_datasize;
  wire                logic_hartInfo_dataaccess;
  wire       [3:0]    logic_hartInfo_nscratch;
  wire       [2:0]    logic_sbcs_sbversion;
  wire       [2:0]    logic_sbcs_sbaccess;
  wire                logic_progbufX_trigged;
  reg                 logic_dataX_trigged;
  wire                when_DebugModule_l205;
  wire       [3:0]    logic_abstractcs_dataCount;
  reg        [2:0]    logic_abstractcs_cmdErr;
  reg                 when_BusSlaveFactory_l341;
  wire       [2:0]    _zz_logic_abstractcs_cmdErr;
  reg                 logic_abstractcs_busy;
  wire       [4:0]    logic_abstractcs_progBufSize;
  wire                logic_abstractcs_noError;
  reg        [0:0]    logic_abstractAuto_autoexecdata;
  reg        [1:0]    logic_abstractAuto_autoexecProgbuf;
  wire                logic_abstractAuto_trigger;
  wire                logic_command_wantExit;
  reg                 logic_command_wantStart;
  wire                logic_command_wantKill;
  reg        [0:0]    logic_command_executionCounter;
  reg                 logic_command_commandRequest;
  reg        [31:0]   logic_command_data;
  wire       [15:0]   logic_command_access_args_regno;
  wire                logic_command_access_args_write;
  wire                logic_command_access_args_transfer;
  wire                logic_command_access_args_postExec;
  wire                logic_command_access_args_aarpostincrement;
  wire       [2:0]    logic_command_access_args_aarsize;
  wire       [31:0]   _zz_logic_command_access_args_regno;
  wire                logic_command_access_transferFloat;
  wire                logic_command_access_notSupported;
  wire                logic_command_request;
  wire                when_DebugModule_l260;
  wire                when_DebugModule_l263;
  wire                when_DebugModule_l266;
  reg        [2:0]    logic_command_stateReg;
  reg        [2:0]    logic_command_stateNext;
  wire                when_DebugModule_l275;
  wire                when_DebugModule_l276;
  wire       [7:0]    switch_DebugModule_l287;
  wire                when_DebugModule_l296;
  wire                when_DebugModule_l350;
  wire                when_DebugModule_l366;
  wire                when_DebugModule_l370;
  wire                when_StateMachine_l253;
  wire       [31:0]   _zz_factory_cmdToRsp_payload_data;
  reg        [31:0]   _zz_factory_cmdToRsp_payload_data_1;
  `ifndef SYNTHESIS
  reg [71:0] io_harts_0_dmToHart_payload_op_string;
  reg [71:0] logic_toHarts_payload_op_string;
  reg [71:0] logic_toHarts_takeWhen_payload_op_string;
  reg [103:0] logic_abstractcs_cmdErr_string;
  reg [103:0] _zz_logic_abstractcs_cmdErr_string;
  reg [111:0] logic_command_stateReg_string;
  reg [111:0] logic_command_stateNext_string;
  `endif

  (* ram_style = "distributed" *) reg [31:0] logic_progbufX_mem [0:1];

  assign _zz_logic_dmcontrol_haltSet = 1'b1;
  assign _zz_logic_dmcontrol_haltClear = 1'b1;
  assign _zz_logic_dmcontrol_resumeReq = 1'b1;
  assign _zz_logic_dmcontrol_ackhavereset = 1'b1;
  assign _zz_when_DebugModule_l143 = (logic_dmcontrol_hartSel >>> 3'd5);
  assign _zz_logic_progbufX_mem_port = io_ctrl_cmd_payload_address[0:0];
  assign _zz_logic_abstractAuto_trigger = io_ctrl_cmd_payload_address[0:0];
  assign _zz_logic_command_access_notSupported_1 = (logic_command_access_transferFloat ? 2'b00 : logic_dmcontrol_hartSelAarsizeLimit);
  assign _zz_logic_command_access_notSupported = {1'd0, _zz_logic_command_access_notSupported_1};
  assign _zz_logic_toHarts_payload_data_1 = ({15'd0,logic_command_access_args_regno[4 : 0]} <<< 4'd15);
  assign _zz_logic_toHarts_payload_data = {12'd0, _zz_logic_toHarts_payload_data_1};
  assign _zz_logic_toHarts_payload_data_3 = ({7'd0,logic_command_access_args_regno[4 : 0]} <<< 3'd7);
  assign _zz_logic_toHarts_payload_data_2 = {20'd0, _zz_logic_toHarts_payload_data_3};
  always @(posedge clk) begin
    if(_zz_1) begin
      logic_progbufX_mem[_zz_logic_progbufX_mem_port] <= io_ctrl_cmd_payload_data;
    end
  end

  assign _zz_logic_progbufX_mem_port1 = logic_progbufX_mem[logic_command_executionCounter];
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_harts_0_dmToHart_payload_op)
      DebugDmToHartOp_DATA : io_harts_0_dmToHart_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : io_harts_0_dmToHart_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : io_harts_0_dmToHart_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : io_harts_0_dmToHart_payload_op_string = "REG_READ ";
      default : io_harts_0_dmToHart_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(logic_toHarts_payload_op)
      DebugDmToHartOp_DATA : logic_toHarts_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : logic_toHarts_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : logic_toHarts_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : logic_toHarts_payload_op_string = "REG_READ ";
      default : logic_toHarts_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(logic_toHarts_takeWhen_payload_op)
      DebugDmToHartOp_DATA : logic_toHarts_takeWhen_payload_op_string = "DATA     ";
      DebugDmToHartOp_EXECUTE : logic_toHarts_takeWhen_payload_op_string = "EXECUTE  ";
      DebugDmToHartOp_REG_WRITE : logic_toHarts_takeWhen_payload_op_string = "REG_WRITE";
      DebugDmToHartOp_REG_READ : logic_toHarts_takeWhen_payload_op_string = "REG_READ ";
      default : logic_toHarts_takeWhen_payload_op_string = "?????????";
    endcase
  end
  always @(*) begin
    case(logic_abstractcs_cmdErr)
      DebugModuleCmdErr_NONE : logic_abstractcs_cmdErr_string = "NONE         ";
      DebugModuleCmdErr_BUSY : logic_abstractcs_cmdErr_string = "BUSY         ";
      DebugModuleCmdErr_NOT_SUPPORTED : logic_abstractcs_cmdErr_string = "NOT_SUPPORTED";
      DebugModuleCmdErr_EXCEPTION : logic_abstractcs_cmdErr_string = "EXCEPTION    ";
      DebugModuleCmdErr_HALT_RESUME : logic_abstractcs_cmdErr_string = "HALT_RESUME  ";
      DebugModuleCmdErr_BUS_1 : logic_abstractcs_cmdErr_string = "BUS_1        ";
      DebugModuleCmdErr_OTHER : logic_abstractcs_cmdErr_string = "OTHER        ";
      default : logic_abstractcs_cmdErr_string = "?????????????";
    endcase
  end
  always @(*) begin
    case(_zz_logic_abstractcs_cmdErr)
      DebugModuleCmdErr_NONE : _zz_logic_abstractcs_cmdErr_string = "NONE         ";
      DebugModuleCmdErr_BUSY : _zz_logic_abstractcs_cmdErr_string = "BUSY         ";
      DebugModuleCmdErr_NOT_SUPPORTED : _zz_logic_abstractcs_cmdErr_string = "NOT_SUPPORTED";
      DebugModuleCmdErr_EXCEPTION : _zz_logic_abstractcs_cmdErr_string = "EXCEPTION    ";
      DebugModuleCmdErr_HALT_RESUME : _zz_logic_abstractcs_cmdErr_string = "HALT_RESUME  ";
      DebugModuleCmdErr_BUS_1 : _zz_logic_abstractcs_cmdErr_string = "BUS_1        ";
      DebugModuleCmdErr_OTHER : _zz_logic_abstractcs_cmdErr_string = "OTHER        ";
      default : _zz_logic_abstractcs_cmdErr_string = "?????????????";
    endcase
  end
  always @(*) begin
    case(logic_command_stateReg)
      logic_command_enumDef_BOOT : logic_command_stateReg_string = "BOOT          ";
      logic_command_enumDef_IDLE : logic_command_stateReg_string = "IDLE          ";
      logic_command_enumDef_DECODE : logic_command_stateReg_string = "DECODE        ";
      logic_command_enumDef_READ_INT_REG : logic_command_stateReg_string = "READ_INT_REG  ";
      logic_command_enumDef_WRITE_INT_REG : logic_command_stateReg_string = "WRITE_INT_REG ";
      logic_command_enumDef_WAIT_DONE : logic_command_stateReg_string = "WAIT_DONE     ";
      logic_command_enumDef_POST_EXEC : logic_command_stateReg_string = "POST_EXEC     ";
      logic_command_enumDef_POST_EXEC_WAIT : logic_command_stateReg_string = "POST_EXEC_WAIT";
      default : logic_command_stateReg_string = "??????????????";
    endcase
  end
  always @(*) begin
    case(logic_command_stateNext)
      logic_command_enumDef_BOOT : logic_command_stateNext_string = "BOOT          ";
      logic_command_enumDef_IDLE : logic_command_stateNext_string = "IDLE          ";
      logic_command_enumDef_DECODE : logic_command_stateNext_string = "DECODE        ";
      logic_command_enumDef_READ_INT_REG : logic_command_stateNext_string = "READ_INT_REG  ";
      logic_command_enumDef_WRITE_INT_REG : logic_command_stateNext_string = "WRITE_INT_REG ";
      logic_command_enumDef_WAIT_DONE : logic_command_stateNext_string = "WAIT_DONE     ";
      logic_command_enumDef_POST_EXEC : logic_command_stateNext_string = "POST_EXEC     ";
      logic_command_enumDef_POST_EXEC_WAIT : logic_command_stateNext_string = "POST_EXEC_WAIT";
      default : logic_command_stateNext_string = "??????????????";
    endcase
  end
  `endif

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_progbufX_trigged) begin
      _zz_1 = 1'b1;
    end
  end

  assign factory_readErrorFlag = 1'b0;
  assign factory_writeErrorFlag = 1'b0;
  assign io_ctrl_cmd_ready = 1'b1;
  assign factory_askWrite = (io_ctrl_cmd_valid && io_ctrl_cmd_payload_write);
  assign factory_askRead = (io_ctrl_cmd_valid && (! io_ctrl_cmd_payload_write));
  assign factory_doWrite = (factory_askWrite && io_ctrl_cmd_ready);
  assign factory_doRead = (factory_askRead && io_ctrl_cmd_ready);
  assign io_ctrl_rsp_valid = factory_rspBuffer_valid;
  assign io_ctrl_rsp_payload_error = factory_rspBuffer_payload_error;
  assign io_ctrl_rsp_payload_data = factory_rspBuffer_payload_data;
  assign io_ctrl_cmd_fire = (io_ctrl_cmd_valid && io_ctrl_cmd_ready);
  assign factory_cmdToRsp_valid = io_ctrl_cmd_fire;
  always @(*) begin
    factory_cmdToRsp_payload_error = 1'b0;
    if(logic_progbufX_trigged) begin
      factory_cmdToRsp_payload_error = 1'b0;
    end
    if(when_DebugModule_l205) begin
      factory_cmdToRsp_payload_error = 1'b0;
    end
    case(io_ctrl_cmd_payload_address)
      7'h10 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h40 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h11 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h12 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h38 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h16 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h18 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      7'h17 : begin
        factory_cmdToRsp_payload_error = 1'b0;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    factory_cmdToRsp_payload_data = 32'h00000000;
    if(when_DebugModule_l205) begin
      factory_cmdToRsp_payload_data = _zz_factory_cmdToRsp_payload_data;
    end
    case(io_ctrl_cmd_payload_address)
      7'h10 : begin
        factory_cmdToRsp_payload_data[0 : 0] = dmactive;
        factory_cmdToRsp_payload_data[1 : 1] = logic_dmcontrol_ndmreset;
        factory_cmdToRsp_payload_data[25 : 16] = logic_dmcontrol_hartSelLo;
        factory_cmdToRsp_payload_data[15 : 6] = logic_dmcontrol_hartSelHi;
      end
      7'h40 : begin
        factory_cmdToRsp_payload_data[31 : 0] = logic_haltsum_value;
      end
      7'h11 : begin
        factory_cmdToRsp_payload_data[3 : 0] = logic_dmstatus_version;
        factory_cmdToRsp_payload_data[7 : 7] = logic_dmstatus_authenticated;
        factory_cmdToRsp_payload_data[8 : 8] = logic_dmstatus_anyHalted;
        factory_cmdToRsp_payload_data[9 : 9] = logic_dmstatus_allHalted;
        factory_cmdToRsp_payload_data[10 : 10] = logic_dmstatus_anyRunning;
        factory_cmdToRsp_payload_data[11 : 11] = logic_dmstatus_allRunning;
        factory_cmdToRsp_payload_data[12 : 12] = logic_dmstatus_anyUnavail;
        factory_cmdToRsp_payload_data[13 : 13] = logic_dmstatus_allUnavail;
        factory_cmdToRsp_payload_data[14 : 14] = logic_dmstatus_anyNonExistent;
        factory_cmdToRsp_payload_data[15 : 15] = logic_dmstatus_anyNonExistent;
        factory_cmdToRsp_payload_data[16 : 16] = logic_dmstatus_anyResumeAck;
        factory_cmdToRsp_payload_data[17 : 17] = logic_dmstatus_allResumeAck;
        factory_cmdToRsp_payload_data[18 : 18] = logic_dmstatus_anyHaveReset;
        factory_cmdToRsp_payload_data[19 : 19] = logic_dmstatus_allHaveReset;
        factory_cmdToRsp_payload_data[22 : 22] = logic_dmstatus_impebreak;
      end
      7'h12 : begin
        factory_cmdToRsp_payload_data[3 : 0] = logic_hartInfo_dataaddr;
        factory_cmdToRsp_payload_data[15 : 12] = logic_hartInfo_datasize;
        factory_cmdToRsp_payload_data[16 : 16] = logic_hartInfo_dataaccess;
        factory_cmdToRsp_payload_data[23 : 20] = logic_hartInfo_nscratch;
      end
      7'h38 : begin
        factory_cmdToRsp_payload_data[31 : 29] = logic_sbcs_sbversion;
        factory_cmdToRsp_payload_data[19 : 17] = logic_sbcs_sbaccess;
      end
      7'h16 : begin
        factory_cmdToRsp_payload_data[3 : 0] = logic_abstractcs_dataCount;
        factory_cmdToRsp_payload_data[10 : 8] = logic_abstractcs_cmdErr;
        factory_cmdToRsp_payload_data[12 : 12] = logic_abstractcs_busy;
        factory_cmdToRsp_payload_data[28 : 24] = logic_abstractcs_progBufSize;
      end
      7'h18 : begin
        factory_cmdToRsp_payload_data[0 : 0] = logic_abstractAuto_autoexecdata;
        factory_cmdToRsp_payload_data[17 : 16] = logic_abstractAuto_autoexecProgbuf;
      end
      default : begin
      end
    endcase
  end

  assign logic_dmcontrol_hartSelNew = {logic_dmcontrol_hartSelHiNew,logic_dmcontrol_hartSelLoNew};
  assign logic_dmcontrol_hartSel = {logic_dmcontrol_hartSelHi,logic_dmcontrol_hartSelLo};
  always @(*) begin
    logic_dmcontrol_haltSet = 1'b0;
    if(when_BusSlaveFactory_l377) begin
      if(when_BusSlaveFactory_l379) begin
        logic_dmcontrol_haltSet = _zz_logic_dmcontrol_haltSet[0];
      end
    end
  end

  always @(*) begin
    when_BusSlaveFactory_l377 = 1'b0;
    case(io_ctrl_cmd_payload_address)
      7'h10 : begin
        if(factory_doWrite) begin
          when_BusSlaveFactory_l377 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l379 = io_ctrl_cmd_payload_data[31];
  always @(*) begin
    logic_dmcontrol_haltClear = 1'b0;
    if(when_BusSlaveFactory_l391) begin
      if(when_BusSlaveFactory_l393) begin
        logic_dmcontrol_haltClear = _zz_logic_dmcontrol_haltClear[0];
      end
    end
  end

  always @(*) begin
    when_BusSlaveFactory_l391 = 1'b0;
    case(io_ctrl_cmd_payload_address)
      7'h10 : begin
        if(factory_doWrite) begin
          when_BusSlaveFactory_l391 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l393 = (! io_ctrl_cmd_payload_data[31]);
  always @(*) begin
    logic_dmcontrol_resumeReq = 1'b0;
    if(when_BusSlaveFactory_l377_1) begin
      if(when_BusSlaveFactory_l379_1) begin
        logic_dmcontrol_resumeReq = _zz_logic_dmcontrol_resumeReq[0];
      end
    end
    if(logic_dmcontrol_haltSet) begin
      logic_dmcontrol_resumeReq = 1'b0;
    end
  end

  always @(*) begin
    when_BusSlaveFactory_l377_1 = 1'b0;
    case(io_ctrl_cmd_payload_address)
      7'h10 : begin
        if(factory_doWrite) begin
          when_BusSlaveFactory_l377_1 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l379_1 = io_ctrl_cmd_payload_data[30];
  always @(*) begin
    logic_dmcontrol_ackhavereset = 1'b0;
    if(when_BusSlaveFactory_l377_2) begin
      if(when_BusSlaveFactory_l379_2) begin
        logic_dmcontrol_ackhavereset = _zz_logic_dmcontrol_ackhavereset[0];
      end
    end
  end

  always @(*) begin
    when_BusSlaveFactory_l377_2 = 1'b0;
    case(io_ctrl_cmd_payload_address)
      7'h10 : begin
        if(factory_doWrite) begin
          when_BusSlaveFactory_l377_2 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l379_2 = io_ctrl_cmd_payload_data[28];
  assign logic_dmcontrol_hartSelAarsizeLimit = 2'b10;
  assign io_harts_0_haltReq = logic_dmcontrol_harts_0_haltReq;
  always @(*) begin
    io_harts_0_resume_cmd_valid = 1'b0;
    if(when_DebugModule_l102) begin
      io_harts_0_resume_cmd_valid = logic_dmcontrol_resumeReq;
    end
  end

  assign when_DebugModule_l102 = (logic_dmcontrol_hartSelNew == 20'h00000);
  assign io_ndmreset = logic_dmcontrol_ndmreset;
  always @(*) begin
    logic_toHarts_valid = 1'b0;
    if(when_DebugModule_l205) begin
      if(io_ctrl_cmd_payload_write) begin
        logic_toHarts_valid = 1'b1;
      end
    end
    if(logic_abstractcs_busy) begin
      logic_toHarts_valid = 1'b0;
    end
    case(logic_command_stateReg)
      logic_command_enumDef_IDLE : begin
      end
      logic_command_enumDef_DECODE : begin
      end
      logic_command_enumDef_READ_INT_REG : begin
        logic_toHarts_valid = 1'b1;
      end
      logic_command_enumDef_WRITE_INT_REG : begin
        logic_toHarts_valid = 1'b1;
      end
      logic_command_enumDef_WAIT_DONE : begin
      end
      logic_command_enumDef_POST_EXEC : begin
        logic_toHarts_valid = 1'b1;
      end
      logic_command_enumDef_POST_EXEC_WAIT : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    logic_toHarts_payload_op = (2'bxx);
    if(when_DebugModule_l205) begin
      logic_toHarts_payload_op = DebugDmToHartOp_DATA;
    end
    case(logic_command_stateReg)
      logic_command_enumDef_IDLE : begin
      end
      logic_command_enumDef_DECODE : begin
      end
      logic_command_enumDef_READ_INT_REG : begin
        logic_toHarts_payload_op = DebugDmToHartOp_EXECUTE;
      end
      logic_command_enumDef_WRITE_INT_REG : begin
        logic_toHarts_payload_op = DebugDmToHartOp_EXECUTE;
      end
      logic_command_enumDef_WAIT_DONE : begin
      end
      logic_command_enumDef_POST_EXEC : begin
        logic_toHarts_payload_op = DebugDmToHartOp_EXECUTE;
      end
      logic_command_enumDef_POST_EXEC_WAIT : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    logic_toHarts_payload_address = 5'bxxxxx;
    if(when_DebugModule_l205) begin
      logic_toHarts_payload_address = 5'h00;
    end
  end

  always @(*) begin
    logic_toHarts_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_DebugModule_l205) begin
      logic_toHarts_payload_data = io_ctrl_cmd_payload_data;
    end
    case(logic_command_stateReg)
      logic_command_enumDef_IDLE : begin
      end
      logic_command_enumDef_DECODE : begin
      end
      logic_command_enumDef_READ_INT_REG : begin
        logic_toHarts_payload_data = (32'h7b401073 | _zz_logic_toHarts_payload_data);
      end
      logic_command_enumDef_WRITE_INT_REG : begin
        logic_toHarts_payload_data = (32'h7b402073 | _zz_logic_toHarts_payload_data_2);
      end
      logic_command_enumDef_WAIT_DONE : begin
      end
      logic_command_enumDef_POST_EXEC : begin
        logic_toHarts_payload_data = _zz_logic_progbufX_mem_port1;
      end
      logic_command_enumDef_POST_EXEC_WAIT : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    logic_toHarts_payload_size = 3'bxxx;
    logic_toHarts_payload_size = logic_command_access_args_aarsize;
  end

  assign logic_fromHarts_valid = (|io_harts_0_hartToDm_valid);
  assign logic_fromHarts_payload_address = io_harts_0_hartToDm_payload_address;
  assign logic_fromHarts_payload_data = io_harts_0_hartToDm_payload_data;
  assign logic_harts_0_sel = (logic_dmcontrol_hartSel == 20'h00000);
  assign logic_harts_0_resumeReady = ((! _zz_logic_harts_0_resumeReady) && _zz_logic_harts_0_resumeReady_1);
  assign logic_toHarts_takeWhen_valid = (logic_toHarts_valid && (! ((logic_toHarts_payload_op != DebugDmToHartOp_DATA) && (! logic_harts_0_sel))));
  assign logic_toHarts_takeWhen_payload_op = logic_toHarts_payload_op;
  assign logic_toHarts_takeWhen_payload_address = logic_toHarts_payload_address;
  assign logic_toHarts_takeWhen_payload_data = logic_toHarts_payload_data;
  assign logic_toHarts_takeWhen_payload_size = logic_toHarts_payload_size;
  assign io_harts_0_dmToHart_valid = logic_toHarts_takeWhen_valid;
  assign io_harts_0_dmToHart_payload_op = logic_toHarts_takeWhen_payload_op;
  assign io_harts_0_dmToHart_payload_address = logic_toHarts_takeWhen_payload_address;
  assign io_harts_0_dmToHart_payload_data = logic_toHarts_takeWhen_payload_data;
  assign io_harts_0_dmToHart_payload_size = logic_toHarts_takeWhen_payload_size;
  assign io_harts_0_ackReset = _zz_io_harts_0_ackReset;
  assign logic_selected_running = io_harts_0_running;
  assign logic_selected_halted = io_harts_0_halted;
  assign logic_selected_commit = io_harts_0_commit;
  assign logic_selected_regSuccess = io_harts_0_regSuccess;
  assign logic_selected_exception = io_harts_0_exception;
  assign logic_selected_ebreak = io_harts_0_ebreak;
  assign logic_selected_redo = io_harts_0_redo;
  always @(*) begin
    logic_haltsum_value = 32'h00000000;
    if(when_DebugModule_l143) begin
      logic_haltsum_value[0] = io_harts_0_halted;
    end
  end

  assign when_DebugModule_l143 = (_zz_when_DebugModule_l143 == 15'h0000);
  assign logic_dmstatus_version = 4'b0010;
  assign logic_dmstatus_authenticated = 1'b1;
  assign logic_dmstatus_anyHalted = (|(logic_harts_0_sel && io_harts_0_halted));
  assign logic_dmstatus_allHalted = (&((! logic_harts_0_sel) || io_harts_0_halted));
  assign logic_dmstatus_anyRunning = (|(logic_harts_0_sel && io_harts_0_running));
  assign logic_dmstatus_allRunning = (&((! logic_harts_0_sel) || io_harts_0_running));
  assign logic_dmstatus_anyUnavail = (|(logic_harts_0_sel && io_harts_0_unavailable));
  assign logic_dmstatus_allUnavail = (&((! logic_harts_0_sel) || io_harts_0_unavailable));
  assign logic_dmstatus_anyNonExistent = (20'h00001 <= logic_dmcontrol_hartSel);
  assign logic_dmstatus_anyResumeAck = (|(logic_harts_0_sel && logic_harts_0_resumeReady));
  assign logic_dmstatus_allResumeAck = (&((! logic_harts_0_sel) || logic_harts_0_resumeReady));
  assign logic_dmstatus_anyHaveReset = (|(logic_harts_0_sel && io_harts_0_haveReset));
  assign logic_dmstatus_allHaveReset = (&((! logic_harts_0_sel) || io_harts_0_haveReset));
  assign logic_dmstatus_impebreak = 1'b1;
  assign logic_hartInfo_dataaddr = 4'b0000;
  assign logic_hartInfo_datasize = 4'b0000;
  assign logic_hartInfo_dataaccess = 1'b0;
  assign logic_hartInfo_nscratch = 4'b0000;
  assign logic_sbcs_sbversion = 3'b001;
  assign logic_sbcs_sbaccess = 3'b010;
  assign logic_progbufX_trigged = ((io_ctrl_cmd_valid && io_ctrl_cmd_payload_write) && ((io_ctrl_cmd_payload_address & 7'h70) == 7'h20));
  always @(*) begin
    logic_dataX_trigged = 1'b0;
    if(when_DebugModule_l205) begin
      logic_dataX_trigged = 1'b1;
    end
  end

  assign when_DebugModule_l205 = ((io_ctrl_cmd_valid && (7'h04 <= io_ctrl_cmd_payload_address)) && (io_ctrl_cmd_payload_address < 7'h05));
  assign logic_abstractcs_dataCount = 4'b0001;
  always @(*) begin
    when_BusSlaveFactory_l341 = 1'b0;
    case(io_ctrl_cmd_payload_address)
      7'h16 : begin
        if(factory_doWrite) begin
          when_BusSlaveFactory_l341 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign _zz_logic_abstractcs_cmdErr = (logic_abstractcs_cmdErr & (~ io_ctrl_cmd_payload_data[10 : 8]));
  assign logic_abstractcs_progBufSize = 5'h02;
  assign logic_abstractcs_noError = (logic_abstractcs_cmdErr == DebugModuleCmdErr_NONE);
  assign logic_abstractAuto_trigger = ((logic_progbufX_trigged && logic_abstractAuto_autoexecProgbuf[_zz_logic_abstractAuto_trigger]) || (logic_dataX_trigged && logic_abstractAuto_autoexecdata[0]));
  assign logic_command_wantExit = 1'b0;
  always @(*) begin
    logic_command_wantStart = 1'b0;
    case(logic_command_stateReg)
      logic_command_enumDef_IDLE : begin
      end
      logic_command_enumDef_DECODE : begin
      end
      logic_command_enumDef_READ_INT_REG : begin
      end
      logic_command_enumDef_WRITE_INT_REG : begin
      end
      logic_command_enumDef_WAIT_DONE : begin
      end
      logic_command_enumDef_POST_EXEC : begin
      end
      logic_command_enumDef_POST_EXEC_WAIT : begin
      end
      default : begin
        logic_command_wantStart = 1'b1;
      end
    endcase
  end

  assign logic_command_wantKill = 1'b0;
  always @(*) begin
    logic_command_commandRequest = 1'b0;
    case(io_ctrl_cmd_payload_address)
      7'h17 : begin
        if(factory_doWrite) begin
          logic_command_commandRequest = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign _zz_logic_command_access_args_regno = logic_command_data;
  assign logic_command_access_args_regno = _zz_logic_command_access_args_regno[15 : 0];
  assign logic_command_access_args_write = _zz_logic_command_access_args_regno[16];
  assign logic_command_access_args_transfer = _zz_logic_command_access_args_regno[17];
  assign logic_command_access_args_postExec = _zz_logic_command_access_args_regno[18];
  assign logic_command_access_args_aarpostincrement = _zz_logic_command_access_args_regno[19];
  assign logic_command_access_args_aarsize = _zz_logic_command_access_args_regno[22 : 20];
  assign logic_command_access_transferFloat = logic_command_access_args_regno[5];
  assign logic_command_access_notSupported = (((_zz_logic_command_access_notSupported < logic_command_access_args_aarsize) || logic_command_access_args_aarpostincrement) || (logic_command_access_args_transfer && (logic_command_access_args_regno[15 : 5] != 11'h080)));
  assign logic_command_request = (logic_command_commandRequest || logic_abstractAuto_trigger);
  assign when_DebugModule_l260 = ((logic_command_request && logic_abstractcs_busy) && logic_abstractcs_noError);
  assign when_DebugModule_l263 = (|io_harts_0_exception);
  assign when_DebugModule_l266 = ((logic_abstractcs_busy && (logic_progbufX_trigged || logic_dataX_trigged)) && logic_abstractcs_noError);
  assign logic_dmcontrol_hartSelLoNew = io_ctrl_cmd_payload_data[25 : 16];
  assign logic_dmcontrol_hartSelHiNew = io_ctrl_cmd_payload_data[15 : 6];
  always @(*) begin
    logic_command_stateNext = logic_command_stateReg;
    case(logic_command_stateReg)
      logic_command_enumDef_IDLE : begin
        if(when_DebugModule_l275) begin
          if(!when_DebugModule_l276) begin
            logic_command_stateNext = logic_command_enumDef_DECODE;
          end
        end
      end
      logic_command_enumDef_DECODE : begin
        logic_command_stateNext = logic_command_enumDef_IDLE;
        case(switch_DebugModule_l287)
          8'h00 : begin
            if(!logic_command_access_notSupported) begin
              if(logic_command_access_args_postExec) begin
                logic_command_stateNext = logic_command_enumDef_POST_EXEC;
              end
              if(logic_command_access_args_transfer) begin
                if(when_DebugModule_l296) begin
                  if(logic_command_access_args_write) begin
                    logic_command_stateNext = logic_command_enumDef_WRITE_INT_REG;
                  end else begin
                    logic_command_stateNext = logic_command_enumDef_READ_INT_REG;
                  end
                end
              end
            end
          end
          default : begin
          end
        endcase
      end
      logic_command_enumDef_READ_INT_REG : begin
        logic_command_stateNext = logic_command_enumDef_WAIT_DONE;
      end
      logic_command_enumDef_WRITE_INT_REG : begin
        logic_command_stateNext = logic_command_enumDef_WAIT_DONE;
      end
      logic_command_enumDef_WAIT_DONE : begin
        if(when_DebugModule_l350) begin
          logic_command_stateNext = logic_command_enumDef_IDLE;
          if(logic_command_access_args_postExec) begin
            logic_command_stateNext = logic_command_enumDef_POST_EXEC;
          end
        end
      end
      logic_command_enumDef_POST_EXEC : begin
        logic_command_stateNext = logic_command_enumDef_POST_EXEC_WAIT;
      end
      logic_command_enumDef_POST_EXEC_WAIT : begin
        if(when_DebugModule_l366) begin
          logic_command_stateNext = logic_command_enumDef_IDLE;
        end
        if(when_DebugModule_l370) begin
          logic_command_stateNext = logic_command_enumDef_POST_EXEC;
        end
      end
      default : begin
      end
    endcase
    if(logic_command_wantStart) begin
      logic_command_stateNext = logic_command_enumDef_IDLE;
    end
    if(logic_command_wantKill) begin
      logic_command_stateNext = logic_command_enumDef_BOOT;
    end
  end

  assign when_DebugModule_l275 = (logic_command_request && logic_abstractcs_noError);
  assign when_DebugModule_l276 = (! io_harts_0_halted);
  assign switch_DebugModule_l287 = logic_command_data[31 : 24];
  assign when_DebugModule_l296 = (! logic_command_access_args_regno[5]);
  assign when_DebugModule_l350 = (logic_selected_commit || logic_selected_regSuccess);
  assign when_DebugModule_l366 = ((logic_selected_ebreak || logic_selected_exception) || logic_selected_commit);
  assign when_DebugModule_l370 = (logic_selected_redo || (logic_selected_commit && (logic_command_executionCounter != 1'b1)));
  assign when_StateMachine_l253 = ((! (logic_command_stateReg == logic_command_enumDef_IDLE)) && (logic_command_stateNext == logic_command_enumDef_IDLE));
  assign _zz_factory_cmdToRsp_payload_data = _zz_factory_cmdToRsp_payload_data_1;
  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      factory_rspBuffer_valid <= 1'b0;
      dmactive <= 1'b0;
    end else begin
      factory_rspBuffer_valid <= factory_cmdToRsp_valid;
      case(io_ctrl_cmd_payload_address)
        7'h10 : begin
          if(factory_doWrite) begin
            dmactive <= io_ctrl_cmd_payload_data[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    factory_rspBuffer_payload_error <= factory_cmdToRsp_payload_error;
    factory_rspBuffer_payload_data <= factory_cmdToRsp_payload_data;
  end

  always @(posedge clk or negedge dmactive) begin
    if(!dmactive) begin
      logic_dmcontrol_ndmreset <= 1'b0;
      logic_dmcontrol_hartSelLo <= 10'h000;
      logic_dmcontrol_hartSelHi <= 10'h000;
      logic_dmcontrol_harts_0_haltReq <= 1'b0;
      _zz_logic_harts_0_resumeReady <= 1'b0;
      _zz_logic_harts_0_resumeReady_1 <= 1'b0;
      logic_abstractcs_cmdErr <= DebugModuleCmdErr_NONE;
      logic_abstractcs_busy <= 1'b0;
      logic_abstractAuto_autoexecdata <= 1'b0;
      logic_abstractAuto_autoexecProgbuf <= 2'b00;
      logic_command_stateReg <= logic_command_enumDef_BOOT;
    end else begin
      if(when_DebugModule_l102) begin
        logic_dmcontrol_harts_0_haltReq <= ((logic_dmcontrol_harts_0_haltReq || logic_dmcontrol_haltSet) && (! logic_dmcontrol_haltClear));
      end
      if(io_harts_0_resume_cmd_valid) begin
        _zz_logic_harts_0_resumeReady <= 1'b1;
      end
      if(io_harts_0_resume_rsp_valid) begin
        _zz_logic_harts_0_resumeReady <= 1'b0;
      end
      if(io_harts_0_resume_cmd_valid) begin
        _zz_logic_harts_0_resumeReady_1 <= 1'b1;
      end
      if(when_BusSlaveFactory_l341) begin
        logic_abstractcs_cmdErr <= _zz_logic_abstractcs_cmdErr;
      end
      if(when_DebugModule_l260) begin
        logic_abstractcs_cmdErr <= DebugModuleCmdErr_BUSY;
      end
      if(when_DebugModule_l263) begin
        logic_abstractcs_cmdErr <= DebugModuleCmdErr_EXCEPTION;
      end
      if(when_DebugModule_l266) begin
        logic_abstractcs_cmdErr <= DebugModuleCmdErr_BUSY;
      end
      case(io_ctrl_cmd_payload_address)
        7'h10 : begin
          if(factory_doWrite) begin
            logic_dmcontrol_ndmreset <= io_ctrl_cmd_payload_data[1];
            logic_dmcontrol_hartSelLo <= io_ctrl_cmd_payload_data[25 : 16];
            logic_dmcontrol_hartSelHi <= io_ctrl_cmd_payload_data[15 : 6];
          end
        end
        7'h18 : begin
          if(factory_doWrite) begin
            logic_abstractAuto_autoexecdata <= io_ctrl_cmd_payload_data[0 : 0];
            logic_abstractAuto_autoexecProgbuf <= io_ctrl_cmd_payload_data[17 : 16];
          end
        end
        default : begin
        end
      endcase
      logic_command_stateReg <= logic_command_stateNext;
      case(logic_command_stateReg)
        logic_command_enumDef_IDLE : begin
          if(when_DebugModule_l275) begin
            if(when_DebugModule_l276) begin
              logic_abstractcs_cmdErr <= DebugModuleCmdErr_HALT_RESUME;
            end else begin
              logic_abstractcs_busy <= 1'b1;
            end
          end
        end
        logic_command_enumDef_DECODE : begin
          case(switch_DebugModule_l287)
            8'h00 : begin
              if(logic_command_access_notSupported) begin
                logic_abstractcs_cmdErr <= DebugModuleCmdErr_NOT_SUPPORTED;
              end
            end
            default : begin
              logic_abstractcs_cmdErr <= DebugModuleCmdErr_NOT_SUPPORTED;
            end
          endcase
        end
        logic_command_enumDef_READ_INT_REG : begin
        end
        logic_command_enumDef_WRITE_INT_REG : begin
        end
        logic_command_enumDef_WAIT_DONE : begin
        end
        logic_command_enumDef_POST_EXEC : begin
        end
        logic_command_enumDef_POST_EXEC_WAIT : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l253) begin
        logic_abstractcs_busy <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    _zz_io_harts_0_ackReset <= (logic_harts_0_sel && logic_dmcontrol_ackhavereset);
    case(io_ctrl_cmd_payload_address)
      7'h17 : begin
        if(factory_doWrite) begin
          logic_command_data <= io_ctrl_cmd_payload_data[31 : 0];
        end
      end
      default : begin
      end
    endcase
    case(logic_command_stateReg)
      logic_command_enumDef_IDLE : begin
        logic_command_executionCounter <= 1'b0;
      end
      logic_command_enumDef_DECODE : begin
      end
      logic_command_enumDef_READ_INT_REG : begin
      end
      logic_command_enumDef_WRITE_INT_REG : begin
      end
      logic_command_enumDef_WAIT_DONE : begin
      end
      logic_command_enumDef_POST_EXEC : begin
      end
      logic_command_enumDef_POST_EXEC_WAIT : begin
        if(when_DebugModule_l366) begin
          logic_command_executionCounter <= (logic_command_executionCounter + 1'b1);
        end
      end
      default : begin
      end
    endcase
    if(logic_fromHarts_valid) begin
      _zz_factory_cmdToRsp_payload_data_1 <= logic_fromHarts_payload_data;
    end
  end


endmodule

module BufferCC (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module StreamFifoLowLatency (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_error,
  input  wire [31:0]   io_push_payload_inst,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_error,
  output wire [31:0]   io_pop_payload_inst,
  input  wire          io_flush,
  output wire [0:0]    io_occupancy,
  output wire [0:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire                fifo_io_pop_payload_error;
  wire       [31:0]   fifo_io_pop_payload_inst;
  wire       [0:0]    fifo_io_occupancy;
  wire       [0:0]    fifo_io_availability;

  StreamFifo fifo (
    .io_push_valid         (io_push_valid                 ), //i
    .io_push_ready         (fifo_io_push_ready            ), //o
    .io_push_payload_error (io_push_payload_error         ), //i
    .io_push_payload_inst  (io_push_payload_inst[31:0]    ), //i
    .io_pop_valid          (fifo_io_pop_valid             ), //o
    .io_pop_ready          (io_pop_ready                  ), //i
    .io_pop_payload_error  (fifo_io_pop_payload_error     ), //o
    .io_pop_payload_inst   (fifo_io_pop_payload_inst[31:0]), //o
    .io_flush              (io_flush                      ), //i
    .io_occupancy          (fifo_io_occupancy             ), //o
    .io_availability       (fifo_io_availability          ), //o
    .clk                   (clk                           ), //i
    .reset                 (reset                         )  //i
  );
  assign io_push_ready = fifo_io_push_ready;
  assign io_pop_valid = fifo_io_pop_valid;
  assign io_pop_payload_error = fifo_io_pop_payload_error;
  assign io_pop_payload_inst = fifo_io_pop_payload_inst;
  assign io_occupancy = fifo_io_occupancy;
  assign io_availability = fifo_io_availability;

endmodule

module FlowCCByToggle_1 (
  input  wire          io_input_valid,
  input  wire          io_input_payload_error,
  input  wire [31:0]   io_input_payload_data,
  output wire          io_output_valid,
  output wire          io_output_payload_error,
  output wire [31:0]   io_output_payload_data,
  input  wire          clk,
  input  wire          debugReset,
  input  wire          io_jtag_tck
);

  wire                bufferCC_4_io_dataIn;
  wire                bufferCC_4_io_dataOut;
  wire                inputArea_target_buffercc_io_dataOut;
  wire                debugReset_syncronized;
  reg                 inputArea_target;
  reg                 inputArea_data_error;
  reg        [31:0]   inputArea_data_data;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_error;
  wire       [31:0]   outputArea_flow_payload_data;
  reg                 outputArea_flow_m2sPipe_valid;
  (* async_reg = "true" *) reg                 outputArea_flow_m2sPipe_payload_error;
  (* async_reg = "true" *) reg        [31:0]   outputArea_flow_m2sPipe_payload_data;

  BufferCC_1 bufferCC_4 (
    .io_dataIn   (bufferCC_4_io_dataIn ), //i
    .io_dataOut  (bufferCC_4_io_dataOut), //o
    .io_jtag_tck (io_jtag_tck          ), //i
    .debugReset  (debugReset           )  //i
  );
  BufferCC_2 inputArea_target_buffercc (
    .io_dataIn              (inputArea_target                    ), //i
    .io_dataOut             (inputArea_target_buffercc_io_dataOut), //o
    .io_jtag_tck            (io_jtag_tck                         ), //i
    .debugReset_syncronized (debugReset_syncronized              )  //i
  );
  assign bufferCC_4_io_dataIn = (1'b0 ^ 1'b0);
  assign debugReset_syncronized = bufferCC_4_io_dataOut;
  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_error = inputArea_data_error;
  assign outputArea_flow_payload_data = inputArea_data_data;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_error = outputArea_flow_m2sPipe_payload_error;
  assign io_output_payload_data = outputArea_flow_m2sPipe_payload_data;
  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      inputArea_target <= 1'b0;
    end else begin
      if(io_input_valid) begin
        inputArea_target <= (! inputArea_target);
      end
    end
  end

  always @(posedge clk) begin
    if(io_input_valid) begin
      inputArea_data_error <= io_input_payload_error;
      inputArea_data_data <= io_input_payload_data;
    end
  end

  always @(posedge io_jtag_tck or posedge debugReset_syncronized) begin
    if(debugReset_syncronized) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
      outputArea_hit <= 1'b0;
    end else begin
      outputArea_hit <= outputArea_target;
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end

  always @(posedge io_jtag_tck) begin
    if(outputArea_flow_valid) begin
      outputArea_flow_m2sPipe_payload_error <= outputArea_flow_payload_error;
      outputArea_flow_m2sPipe_payload_data <= outputArea_flow_payload_data;
    end
  end


endmodule

module FlowCCByToggle (
  input  wire          io_input_valid,
  input  wire          io_input_payload_write,
  input  wire [31:0]   io_input_payload_data,
  input  wire [6:0]    io_input_payload_address,
  output wire          io_output_valid,
  output wire          io_output_payload_write,
  output wire [31:0]   io_output_payload_data,
  output wire [6:0]    io_output_payload_address,
  input  wire          io_jtag_tck,
  input  wire          clk,
  input  wire          debugReset
);

  wire                inputArea_target_buffercc_io_dataOut;
  reg                 inputArea_target;
  reg                 inputArea_data_write;
  reg        [31:0]   inputArea_data_data;
  reg        [6:0]    inputArea_data_address;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_write;
  wire       [31:0]   outputArea_flow_payload_data;
  wire       [6:0]    outputArea_flow_payload_address;

  BufferCC_3 inputArea_target_buffercc (
    .io_dataIn  (inputArea_target                    ), //i
    .io_dataOut (inputArea_target_buffercc_io_dataOut), //o
    .clk        (clk                                 ), //i
    .debugReset (debugReset                          )  //i
  );
  initial begin
  `ifndef SYNTHESIS
    inputArea_target = $urandom;
    outputArea_hit = $urandom;
  `endif
  end

  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_write = inputArea_data_write;
  assign outputArea_flow_payload_data = inputArea_data_data;
  assign outputArea_flow_payload_address = inputArea_data_address;
  assign io_output_valid = outputArea_flow_valid;
  assign io_output_payload_write = outputArea_flow_payload_write;
  assign io_output_payload_data = outputArea_flow_payload_data;
  assign io_output_payload_address = outputArea_flow_payload_address;
  always @(posedge io_jtag_tck) begin
    if(io_input_valid) begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_write <= io_input_payload_write;
      inputArea_data_data <= io_input_payload_data;
      inputArea_data_address <= io_input_payload_address;
    end
  end

  always @(posedge clk) begin
    outputArea_hit <= outputArea_target;
  end


endmodule

module StreamFifo (
  input  wire          io_push_valid,
  output reg           io_push_ready,
  input  wire          io_push_payload_error,
  input  wire [31:0]   io_push_payload_inst,
  output reg           io_pop_valid,
  input  wire          io_pop_ready,
  output reg           io_pop_payload_error,
  output reg  [31:0]   io_pop_payload_inst,
  input  wire          io_flush,
  output wire [0:0]    io_occupancy,
  output wire [0:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);

  reg                 oneStage_doFlush;
  wire                oneStage_buffer_valid;
  wire                oneStage_buffer_ready;
  wire                oneStage_buffer_payload_error;
  wire       [31:0]   oneStage_buffer_payload_inst;
  reg                 io_push_rValid;
  reg                 io_push_rData_error;
  reg        [31:0]   io_push_rData_inst;
  wire                when_Stream_l369;
  wire                when_Stream_l1187;

  always @(*) begin
    oneStage_doFlush = io_flush;
    if(when_Stream_l1187) begin
      if(io_pop_ready) begin
        oneStage_doFlush = 1'b1;
      end
    end
  end

  always @(*) begin
    io_push_ready = oneStage_buffer_ready;
    if(when_Stream_l369) begin
      io_push_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! oneStage_buffer_valid);
  assign oneStage_buffer_valid = io_push_rValid;
  assign oneStage_buffer_payload_error = io_push_rData_error;
  assign oneStage_buffer_payload_inst = io_push_rData_inst;
  always @(*) begin
    io_pop_valid = oneStage_buffer_valid;
    if(when_Stream_l1187) begin
      io_pop_valid = io_push_valid;
    end
  end

  assign oneStage_buffer_ready = io_pop_ready;
  always @(*) begin
    io_pop_payload_error = oneStage_buffer_payload_error;
    if(when_Stream_l1187) begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @(*) begin
    io_pop_payload_inst = oneStage_buffer_payload_inst;
    if(when_Stream_l1187) begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign io_occupancy = oneStage_buffer_valid;
  assign io_availability = (! oneStage_buffer_valid);
  assign when_Stream_l1187 = (! oneStage_buffer_valid);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_push_rValid <= 1'b0;
    end else begin
      if(io_push_ready) begin
        io_push_rValid <= io_push_valid;
      end
      if(oneStage_doFlush) begin
        io_push_rValid <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_push_ready) begin
      io_push_rData_error <= io_push_payload_error;
      io_push_rData_inst <= io_push_payload_inst;
    end
  end


endmodule

module BufferCC_2 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          io_jtag_tck,
  input  wire          debugReset_syncronized
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_jtag_tck or posedge debugReset_syncronized) begin
    if(debugReset_syncronized) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_1 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          io_jtag_tck,
  input  wire          debugReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_jtag_tck or posedge debugReset) begin
    if(debugReset) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_3 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk,
  input  wire          debugReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  initial begin
  `ifndef SYNTHESIS
    buffers_0 = $urandom;
    buffers_1 = $urandom;
  `endif
  end

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule
