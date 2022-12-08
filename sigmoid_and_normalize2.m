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
## @deftypefn {} {@var{retval} =} sigmoid_and_normalize2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-12-01

function new_Im = sigmoid_and_normalize2 (Im, cutoff, gain)
  new_Im = 1./(1 + exp(gain .* (cutoff .- Im)));
  #new_Im(new_Im < 0) = max(new_Im(:)); ## passo de critério meu, setando para branco pixels exagerados do sigmóide que podem ferir o resultado da normalização
  new_Im = normalize_img(new_Im, [0, 1]);
endfunction