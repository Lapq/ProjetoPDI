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
## @deftypefn {} {@var{retval} =} calculate_CM (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-12-08

function statistic_indexes = calculate_CM (diff)
  TN = sum(diff(:) == 0);
  FN = sum(diff(:) == 1);
  FP = sum(diff(:) == 2);
  TP = sum(diff(:) == 3);
  TOTAL = TN + TP + FN + FP;
  
  percTP = TP/TOTAL;
  percFP = FP/TOTAL;
  percFN = FN/TOTAL;
  percTN = TN/TOTAL;
  acc = (TN+TP)/TOTAL;
  jac = TP/(TP+FP+FN);
  dice = 2*TP/(2*TP+FP+FN);
  sens = TP/(TP+FN);
  spec = TN/(TN+FP);
  
  strTP = [char(10) "TP = " num2str(percTP)];
  strFP = [" FP = " num2str(percFP)];
  strFN = [" FN = " num2str(percFN)];
  strTN = [" TN = " num2str(percTN)];
  strACC = [" ACC = " num2str(acc)];
  strJAC = [" JAC = " num2str(jac)];
  strDICE = [" DICE = " num2str(dice)];
  strSENS = [" SENS = " num2str(sens)];
  strSPEC = [" SPEC = " num2str(spec)];
  
  statistic_indexes = [strTP strFP strFN strTN strACC strJAC strDICE strSENS strSPEC];
endfunction
