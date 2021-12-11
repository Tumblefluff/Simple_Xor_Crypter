unit Xor_source;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, shellapi;

type
  TGUI = class(TForm)
    Xor_Image: TImage;
    Key_Image: TImage;
    File_Image: TImage;
    Output_Image: TImage;
    L_Source: TLabel;
    L_Key: TLabel;
    Get_Source: TOpenDialog;
    Get_Key: TOpenDialog;
    Save_Output: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    procedure File_ImageClick(Sender: TObject);
    procedure L_SourceClick(Sender: TObject);
    procedure Key_ImageClick(Sender: TObject);
    procedure L_KeyClick(Sender: TObject);
    procedure Output_ImageClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure pick_file;
    procedure pick_key;
    procedure run_xor;
    { Public declarations }
  end;

var
  GUI: TGUI;
  src, dst, key : file of byte;
  sb,db,kb : byte;
  sfn,kfn: string;

implementation

{$R *.dfm}

procedure TGUI.pick_file;
begin
  Get_Source.Execute();
  sfn:=Get_Source.FileName;
  if sfn='' then L_Source.Caption:='[No Source File Selected]'
  else L_Source.Caption:=sfn;
end;

procedure TGUI.pick_key;
begin
  Get_Key.Execute();
  kfn:=Get_Key.FileName;
  if kfn='' then L_Key.Caption:='[No Key Selected]'
  else L_Key.Caption:=kfn;
end;

procedure TGUI.run_xor;
begin
  if sfn='' then
    begin
      showmessage('No Source File Selected');
      exit;
    end;
  if kfn='' then
    begin
      showmessage('No Key File Selected');
      exit;
    end;
  assignfile(src,sfn);
  assignfile(key,kfn);
  Save_Output.Execute();
  assignfile(dst,Save_Output.FileName);
  reset(src);
  reset(key);
  rewrite(dst);
  while not eof(src) do
    begin
      Read(src,sb);
      Read(key,kb);
      db:=sb xor kb;
      write(dst,db);
      if eof(key) then reset(key);
    end;
  closefile(src);
  closefile(key);
  closefile(dst);
  showmessage('Xor Encryption Complete');
end;


procedure TGUI.File_ImageClick(Sender: TObject); {File Image Click}
begin
  pick_file;
end;

procedure TGUI.Key_ImageClick(Sender: TObject);  {Key Image Click}
begin
  pick_key;
end;

procedure TGUI.Label2Click(Sender: TObject);
begin
  ShellExecute(self.WindowHandle,'open','https://github.com/Tumblefluff/Simple_Xor_Crypter',nil,nil, SW_SHOWNORMAL);
end;

procedure TGUI.L_KeyClick(Sender: TObject);  {Key Name Click}
begin
  pick_key;
end;

procedure TGUI.L_SourceClick(Sender: TObject);  {File Name Click}
begin
  pick_file;
end;

procedure TGUI.Output_ImageClick(Sender: TObject);  {Output Image Click}
begin
  run_xor;
end;

Begin
end.
