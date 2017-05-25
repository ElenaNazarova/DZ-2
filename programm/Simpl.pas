unit Simpl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

 type
  TMetod_simplex = class
    Procedure Poisk_Stroki();
    Procedure Poisk_Stolbca();
  //  Procedure Opor_resh();
 //   Procedure Optim_resh();
 //   Procedure Pereschot();

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Metod: TMetod_simplex;



implementation
uses  Simplex;

Procedure TMetod_simplex.Poisk_Stroki();  // Поиск разрешающей строки
var
i,j:integer;
t:real;
begin
 for j:=1 to 3 do
        c[1,j]:=strtofloat(Simplex.Form1.Simpleks_Table.Cells[1,j]);
      for j:=1 to 3 do
        Simplex.c[2,j]:=strtofloat(Simplex.Form1.Simpleks_Table.Cells[Simplex.i_max,j]);
      for j:=1 to 3 do
        if (Simplex.c[1,j]=0) or (Simplex.c[2,j]=0) then  Simplex.c[3,j]:=0
        else Simplex.c[3,j]:=Simplex.c[1,j]/Simplex.c[2,j];

      for i:=1 to 3 do
        for j:=1 to 4 do
          Simplex.Form1.Otnashenie_Table.Cells[i,j]:=floattostr(Simplex.c[j,i]);

      t:=abs(Simplex.c[3,1]);
      Simplex.j_min:=1;
      for i:=1 to 3 do
        begin
          if (Simplex.c[3,i]<>0) then
            if (t>abs(Simplex.c[3,i]))and(Simplex.c[4,i]<>0) then
              begin
                t:=abs(Simplex.c[3,i]);
                Simplex.j_min:=i;
              end;
        end;
      Simplex.Form1.Simpleks_Table.Refresh;
      Simplex.c[4,j_min]:=0;

end;

Procedure TMetod_simplex.Poisk_Stolbca();  // Поиск разрешающей столбца
var
i,j:integer;
t,max,min:real;
begin
max:=Simplex.a2[4,1];
  for i:=1 to 4 do
    if Simplex.a2[4,i]>=max then
      begin
        max:=Simplex.a2[4,i];
        Simplex.i_max:=i;
      end;
min:=Simplex.a3[4,1];
  for i:=1 to 4 do
    if Simplex.a3[4,i]<=min then
      begin
        min:=Simplex.a3[4,i];
        Simplex.i_stol:=i;
      end;
end;

{procedure TMetod_simplex.Opor_resh();  // проверка опорного решения
var
  i,j,r,g:integer;
  t,max,min:real;
begin
j_str:=-1;
for i:=1 to 3 do
    if a3[i,1]<0 then
                begin
                  Simplex.i_stol:=0;
                  for r:=2 to 4 do
                    if Simplex.i_stol=0 then
                      for j:=1 to 3 do
                        if Simplex.a3[j,r]<0 then
                           begin
                              Simplex.i_stol:=r;
                              break;
                            end;
                  for j:=1 to 3 do
                      begin
                        if Simplex.a3[j,1]>0 then Simplex.c2[j,2]:=0;

                        Simplex.c2[j,1]:=Simplex.a3[j,1]/Simplex.a3[j,i_stol];

                      end;

                  min:=100;
                  for j:=1 to 3 do
                    if (Simplex.c2[j,1]<=min)and(Simplex.c2[j,2]=1) then
                            begin
                              min:=Simplex.c2[j,1];
                              Simplex.j_str:=j;
                            end;
                   for j:=1 to 3 do
                      Simplex.c2[j,2]:=1;
                   Simplex.c2[j_str,2]:=0;

                  break;
                end;
   Form1.Dual_table.Refresh;
end;

procedure TMetod_simplex.Optim_resh();  // проверка оптимального решения
var
  i,j,r:integer;
  t,max,min:real;

begin
Simplex.j_str:=-1;
for i:=1 to 3 do
                begin
                  if Simplex.e= 1 then
                    for j:=1 to 3 do
                      begin
                        Simplex.c2[j,2]:=1;
                        Simplex.e:=0;
                      end;
                  max:=-1;
                  for r:=2 to 4 do
                        if (Simplex.a3[4,r]>max)and(Simplex.a3[4,r]>0) then
                           begin
                              max:=Simplex.a3[4,r];
                              Simplex.i_stol:=r;
                            end;
                  if max=-1 then Form1.Dual.Enabled:=false;
                  for j:=1 to 3 do
                      begin

                        Simplex.c2[j,1]:=Simplex.a3[j,1]/Simplex.a3[j,Simplex.i_stol];

                      end;

                  min:=100;
                  for j:=1 to 3 do
                    if (Simplex.c2[j,1]<=min)and(Simplex.c2[j,2]=1) then
                            begin
                              min:=Simplex.c2[j,1];
                              Simplex.j_str:=j;
                            end;
                   for j:=1 to 3 do
                      Simplex.c2[j,2]:=1;
                   Simplex.c2[Simplex.j_str,2]:=0;

                  break;
                end;
   Form1.Dual_table.Refresh;
end;

Procedure TMetod_simplex.Pereschot();
var
  i,j:integer;
  b:array [1..4,1..4] of real;
  s:string;
begin
if Simplex.a3[Simplex.j_str,Simplex.i_stol]<>0 then
        for i:=1 to 4 do
          for j:=1 to 4 do
            begin
              if (Simplex.j_str<>i)and(Simplex.i_stol<>j) then  b[i,j]:=a3[i,j]-((Simplex.a3[Simplex.j_str,j]*a3[i,Simplex.i_stol])/Simplex.a3[Simplex.j_str,Simplex.i_stol])
              else if (Simplex.j_str=i)and(Simplex.i_stol<>j)then b[i,j]:=Simplex.a3[i,j]/a3[Simplex.j_str,Simplex.i_stol]
              else if (Simplex.j_str<>i)and(Simplex.i_stol=j)then b[i,j]:=Simplex.a3[i,j]/(-1*Simplex.a3[Simplex.j_str,Simplex.i_stol])
              else if (Simplex.j_str=i)and(Simplex.i_stol=j)then  b[i,j]:=1/Simplex.a3[Simplex.j_str,Simplex.i_stol];
            end
      else b[i,j]:=Simplex.a3[i,j];
s:=Form1.Dual_table.Cells[i_stol,0];
Form1.Dual_table.Cells[i_stol,0]:=Form1.Dual_table.Cells[0,j_str];
Form1.Dual_table.Cells[0,j_str]:=s;


for i:=1 to 4 do
  for j:=1 to 4 do
    begin
      Simplex.a3[i,j]:=b[i,j];
      Form1.Dual_table.Cells[j,i]:=floattostr(Simplex.a3[i,j]);
    end;
     Form1.Dual_table.Refresh;
end;              }

end.

