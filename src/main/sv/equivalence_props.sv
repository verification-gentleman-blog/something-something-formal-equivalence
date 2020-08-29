// Copyright 2020 Tudor Timisescu (verificationgentleman.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


module equivalence_props(
    input bit PCLK,
    input bit PRESETn);

  default clocking @(posedge PCLK);
  endclocking

  default disable iff (!PRESETn);

  psel_equivalent: assume property (duts[0].dut.PSEL == duts[1].dut.PSEL);
  penable_equivalent: assume property (duts[0].dut.PENABLE == duts[1].dut.PENABLE);
  pwrite_equivalent: assume property (duts[0].dut.PWRITE == duts[1].dut.PWRITE);
  pwdata_equivalent: assume property (duts[0].dut.PWDATA == duts[1].dut.PWDATA);
  pstrb_equivalent: assume property (duts[0].dut.PSTRB == duts[1].dut.PSTRB);

  pready_equivalent: assert property (duts[0].dut.PREADY == duts[1].dut.PREADY);
  prdata_equivalent: assert property (duts[0].dut.PRDATA == duts[1].dut.PRDATA);
  pslverr_equivalent: assert property (duts[0].dut.PSLVERR == duts[1].dut.PSLVERR);

  for (genvar i = 0; i < 2; i++) begin: covers
    can_access_dut: cover property (sigs[i].PSEL && sigs[i].PENABLE);
    can_write_to_dut: cover property (sigs[i].PSEL && sigs[i].PENABLE && sigs[i].PWRITE);
  end

endmodule



bind equivalence_tb equivalence_props props(.*);
