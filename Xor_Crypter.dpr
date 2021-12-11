program Xor_Crypter;

uses
  Vcl.Forms,
  Xor_source in 'Xor_source.pas' {GUI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Simple Xor Crypter';
  Application.CreateForm(TGUI, GUI);
  Application.Run;
end.
