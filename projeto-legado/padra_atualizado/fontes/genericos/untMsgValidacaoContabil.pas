unit untMsgValidacaoContabil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, untFuncoesSimples, frxClass, frxExportCSVTestabilidade;

type
  TfrmMsgValidacaoContabil = class(TfrmPaiEdit)
    mmoMsg: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strEstEmp: String;
  public
    { Public declarations }
    strClaSub: String;
    blnEntMercadorias: Boolean;
  end;

var
  frmMsgValidacaoContabil: TfrmMsgValidacaoContabil;

implementation

{$R *.dfm}

procedure TfrmMsgValidacaoContabil.FormCreate(Sender: TObject);
begin
  inherited;

  strEstEmp := fCadEmp('ESTADO');
  strClaSub := fRegimeSubstituicaoTributaria;

  blnEntMercadorias := True;
end;

procedure TfrmMsgValidacaoContabil.FormShow(Sender: TObject);
begin
  inherited;

  If blnEntMercadorias Then
  Begin
    mmoMsg.Lines.Clear;
    mmoMsg.Lines.Add('');
    mmoMsg.Lines.Add('    Os valores digitados devem seguir uma das seguintes regras:');
    mmoMsg.Lines.Add('       1) <Valor Contábil> = <Base ICMS> + <Valor do IPI> + <Valor do ICMS Substituido> + <Valor FCP ST> + <Valor de Isentas> + <Valor de Outras>.');
    mmoMsg.Lines.Add('');
    mmoMsg.Lines.Add('       2) <Valor Contábil> = <Base ICMS> + <Valor do ICMS Substituido> + <Valor FCP ST> + <Valor de Isentas> + <Valor de Outras>.');

    mmoMsg.Lines.Add('');
    mmoMsg.Lines.Add('    No caso de Classificações de Bonificação (1910/2910) também é válido:');
    mmoMsg.Lines.Add('       3) <Valor Contábil> = <Base ICMS> / 2 + <Valor do IPI> + <Valor do ICMS Substituido> + <Valor FCP ST> + <Valor de Isentas> + <Valor de Outras>.');

    If fConsideraICMSDesoneradoComDesconto(strEstEmp) Then
      mmoMsg.Lines.Add('       4) <Valor Contábil> = <Base ICMS> - <Valor do Desconto> + <Valor do IPI> + <Valor do ICMS Substituido> + <Valor FCP ST> + <Valor de Isentas> + <Valor de Outras>.');

  End;
end;

end.
