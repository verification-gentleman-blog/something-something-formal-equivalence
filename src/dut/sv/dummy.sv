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


module dummy(
    input bit PCLK,
    input bit PRESETn,
    input bit PADDR,
    input bit PSEL,
    input bit PENABLE,
    input bit PWRITE,
    input bit [31:0] PWDATA,
    input bit [3:0] PSTRB,
    output bit PREADY,
    output bit [31:0] PRDATA,
    output bit PSLVERR);

  assign PREADY = 1;
  assign PSLVERR = (PADDR != 0);


  bit [31:0] sfr0;

  always @(posedge PCLK or negedge PRESETn)
    if (!PRESETn)
      sfr0 <= 0;
    else if (PSEL && PENABLE && PWRITE)
      if (PADDR == 0)
        sfr0 <= PWDATA; // Bug: doesn't consider write strobes

  assign PRDATA = sfr0;

endmodule
