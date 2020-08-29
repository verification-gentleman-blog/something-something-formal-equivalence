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


  prdata_equivalent: assert property (duts[0].dut.PRDATA == duts[1].dut.PRDATA);

  for (genvar i = 0; i < 2; i++) begin: covers
    can_access_dut: cover property (sigs[i].PSEL && sigs[i].PENABLE);
    can_write_to_dut: cover property (sigs[i].PSEL && sigs[i].PENABLE && sigs[i].PWRITE);
  end

endmodule



bind equivalence_tb equivalence_props props(.*);
