unit untMensagemSonora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MMSystem, Registry, StrUtils, untFuncoesSimples;

type
  TfrmMensagemSonora = class(TForm)
    lblMensagem: TLabel;
    lblRodape: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strPathSomAlerta : String;
    mmsArqvSomAlerta : TMemoryStream;
    class procedure pTocar(strPathSomAlerta: String=''; mmsArqvSomAlerta: TMemoryStream=Nil);
  end;

var
  frmMensagemSonora: TfrmMensagemSonora;

implementation

{$R *.dfm}

{ TfrmMensagemSonora }

class procedure TfrmMensagemSonora.pTocar(strPathSomAlerta: String=''; mmsArqvSomAlerta: TMemoryStream=Nil);
  Var
    reg: TRegistry;
    strSom: String;
    strPathWin: Array[0..254] Of Char;
    intContador: Integer;
    blnTSPlus: Boolean;
begin
  blnTSPlus := (fArqIni(0, 'GERAL', 'TSPLUS', '') = 'S');

  If (Assigned(mmsArqvSomAlerta)) Then
  Begin
    pPlaySound(mmsArqvSomAlerta);
  End
  Else If (strPathSomAlerta <> '') Then
  Begin
    pPlaySound(strPathSomAlerta);
  End
  Else If (Not blnTSPlus) Then
  Begin
    reg := TRegistry.Create;
    Try
      reg.RootKey := HKEY_CURRENT_USER;
      reg.OpenKey('AppEvents\Schemes\Apps\.Default\SystemHand\.Current', False);
      strSom := reg.ReadString('');

      For intContador := 0 To 254 Do
        strPathWin[intContador] := #0;

      GetWindowsDirectory(strPathWin, 255);

      strSom := AnsiReplaceText(strSom, '%SystemRoot%', StrPas(strPathWin));

      pPlaySound(strSom);
    Finally
      FreeAndNil(reg);
    End
  End;
end;

procedure TfrmMensagemSonora.FormCreate(Sender: TObject);
begin
  strPathSomAlerta := '';
  mmsArqvSomAlerta := Nil;
end;

procedure TfrmMensagemSonora.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    pTocar
  Else If Key In [VK_ESCAPE, VK_SPACE] Then
    Close;
end;

procedure TfrmMensagemSonora.FormShow(Sender: TObject);
begin
  fRegistraCallStackSeEstiverEmTransacao(Nil, 'Mensagem onde aconteceu: '+lblMensagem.Caption);
end;

procedure TfrmMensagemSonora.FormActivate(Sender: TObject);
begin
  Sleep(100);
  pTocar(strPathSomAlerta, mmsArqvSomAlerta);
end;

end.
