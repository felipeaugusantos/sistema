unit untCadDadosComPromocao;

interface

uses
  Classes, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, EditFocus, Menus,
  Uni, AppEvnts,

  BitBtnLockedIncrem, Controls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadDadosComPromocao = class(TfrmPaiSimples)
    pnlDadosCons: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    Label6: TLabel;
    Label14: TLabel;
    lbl8: TLabel;
    edtComVar: TEditFocus;
    edtComAta: TEditFocus;
    edtComDis: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);

  private
    { Private declarations }

  protected

  public
    { Public declarations }
    blnConfirma : Boolean;
  end;


implementation

uses Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadDadosComPromocao.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  Close;
end;

procedure TfrmCadDadosComPromocao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  blnConfirma := True;

  {*****************************}
  {* COMISSÃO VENDEDOR INTERNO *}
  {**************************MM*}  
  If (blnConfirma) And (fStrToFloat(edtComVar.Text) < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'A comissão do "vendedor interno" deve ser maior ou igual a Zero!', ['&Ok']);
    blnConfirma := False;
    pSetFocus(edtComVar);
  End;

  {*******************************}
  {* COMISSÃO REPRESENTANTE LOJA *}
  {****************************MM*}
  If (blnConfirma) And (fStrToFloat(edtComAta.Text) < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'A comissão do "representante externo loja" deve ser maior ou igual a Zero!', ['&Ok']);
    blnConfirma := False;
    pSetFocus(edtComAta);
  End;

  {***************************************}
  {* COMISSÃO REPRESENTANTE DISTRIBUIÇÃO *}
  {************************************MM*}
  If (blnConfirma) And (fStrToFloat(edtComDis.Text) < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'A comissão do "representante externo distribuidor" deve ser maior ou igual a Zero!', ['&Ok']);
    blnConfirma := False;
    pSetFocus(edtComDis);    
  End;

  If blnConfirma Then
    Close
  Else
    Exit;
end;

end.

