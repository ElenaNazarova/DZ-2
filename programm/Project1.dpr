program Project1;

uses
  Forms,
  Simplex in 'Simplex.pas' {Form1},
  Simpl in 'Simpl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
