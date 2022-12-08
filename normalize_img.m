## Copyright (C) 2022 USUARIO
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} normalize_img (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-12-01

function new_I = normalize_img (I, interval)
  min_val = min(I(:));
  shift = min_val - interval(1);
  new_I = I .- shift;
  max_val = max(new_I(:));
  new_I = (new_I .* interval(2))./max_val;
endfunction
