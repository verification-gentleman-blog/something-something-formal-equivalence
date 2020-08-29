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


module dummy_props(
    input bit PCLK,
    input bit PRESETn,
    input bit PADDR,
    input bit PSEL,
    input bit PENABLE,
    input bit PWRITE,
    input bit [31:0] PWDATA,
    input bit PREADY,
    input bit [31:0] PRDATA,
    input bit PSLVERR);

  default clocking @(posedge PCLK);
  endclocking

  default disable iff (!PRESETn);


  always_ready: assert property (PREADY);

  error_for_unknown_addresses: assert property (
      PADDR != 0 && PSEL && PENABLE && PREADY |-> PSLVERR);

  no_error_for_known_addresses: assert property (
      PADDR == 0 && PSEL && PENABLE && PREADY |-> !PSLVERR);

  writen_data_can_be_read_back: assert property (
      PADDR == 0 && PSEL && PENABLE && PWRITE && PWDATA == 'hdead_beef && PREADY
         ##1 !PSEL [*]
         ##1 PADDR == 0 && PSEL && PENABLE && !PWRITE && PREADY
         |-> PRDATA == 'hdead_beef);

endmodule



bind dummy dummy_props props(.*);
