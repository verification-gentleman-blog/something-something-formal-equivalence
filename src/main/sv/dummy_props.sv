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
    input bit PADDR,
    input bit PSEL,
    input bit PENABLE,
    input bit PREADY,
    input bit PSLVERR);

  default clocking @(posedge PCLK);
  endclocking


  always_ready: assert property (PREADY);

  error_for_unknown_addresses: assert property (
      PADDR != 0 && PSEL && PENABLE && PREADY |-> PSLVERR);

  no_error_for_known_addresses: assert property (
      PADDR == 0 && PSEL && PENABLE && PREADY |-> !PSLVERR);

endmodule



bind dummy dummy_props props(.*);
