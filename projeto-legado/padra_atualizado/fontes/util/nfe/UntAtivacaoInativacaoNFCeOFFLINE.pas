unit UntAtivacaoInativacaoNFCeOFFLINE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, untFuncoesSimples,
  BitBtnLockedIncrem;

type
  TFrmAtivacaoInativacaoNFCeOFFLINE = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    RdGrpCFG_USAOFF: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrmAtivacaoInativacaoNFCeOFFLINE.btnConfirmaClick(Sender: TObject);
var
  strValCFG: string;
begin
  strValCFG := '';

  case RdGrpCFG_USAOFF.ItemIndex of
    0: strValCFG := 'S';
    1: strValCFG := 'N';
  end;

  If (Assigned(dicConfiguracoes)) and (dicConfiguracoes['USAOFF'+VS_strCodEmp] <> Null) Then
  begin
    dicConfiguracoes['USAOFF'+VS_strCodEmp] := strValCFG;
  end;

  fAtuCfgSis('USAOFF', strValCFG);
end;

procedure TFrmAtivacaoInativacaoNFCeOFFLINE.FormCreate(Sender: TObject);
begin
  IF fCfgSis('USAOFF',varBoolean) then
  begin
    RdGrpCFG_USAOFF.ItemIndex := 0;
  end
  else
  begin
    RdGrpCFG_USAOFF.ItemIndex := 1;
  end;
end;

procedure TFrmAtivacaoInativacaoNFCeOFFLINE.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F10 then
    btnConfirma.Click;
  If (Key = VK_Escape) Then
    Begin
      Close;
    End;
end;

end.
