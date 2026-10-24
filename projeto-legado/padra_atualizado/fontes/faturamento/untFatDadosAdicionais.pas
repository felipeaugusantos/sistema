unit untFatDadosAdicionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untTypesSistema, untTPerfilDespachanteAduaneiro;

type
  TfrmFatDadosAdicionais = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    Label2: TLabel;
    edtImpMer: TEditFocus;
    Label1: TLabel;
    edtImpSeg: TEditFocus;
    Label4: TLabel;
    edtImpPro: TEditFocus;
    Label5: TLabel;
    edtImpTax: TEditFocus;
    Label6: TLabel;
    edtImpPis: TEditFocus;
    Label7: TLabel;
    edtImpCof: TEditFocus;
    Label11: TLabel;
    edtImpIC1: TEditFocus;
    edtImpIC2: TEditFocus;
    Label3: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtImpImp: TEditFocus;
    edtBaseII: TEditFocus;
    edtDesAdu: TEditFocus;
    edtValIOF: TEditFocus;
    btnDespesasAduaneiras: TBitBtnLocked;
    Label8: TLabel;
    edtAFRMM: TEditFocus;
    Label9: TLabel;
    edtTotDes: TEditFocus;
    btnHlpImp: TBitBtnLocked;
    Label10: TLabel;
    Label15: TLabel;
    edtFreImp: TEditFocus;
    edtSegImp: TEditFocus;
    procedure btnDespesasAduaneirasClick(Sender: TObject);
    procedure edtImpTaxChange(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    recDespesasAduaneiras: TDespesasAduaneiras;
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
  end;

var
  frmFatDadosAdicionais: TfrmFatDadosAdicionais;

implementation

uses untFuncoesSimples, untFuncoes, untFatDadosFiscais;

{$R *.dfm}

procedure TfrmFatDadosAdicionais.btnDespesasAduaneirasClick(Sender: TObject);
begin
  inherited;
  TfrmFatDadosFiscais.fInformouDespesasAduaneiras(recDespesasAduaneiras, True);
end;

procedure TfrmFatDadosAdicionais.btnHlpImpClick(Sender: TObject);
var strMensagem: string;
begin
  inherited;
  If Assigned(PerfilDespachanteAduaneiro) then
  begin
    strMensagem := '';
    If tcvoSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor da Taxa Sicomex: %s' + #13, [edtImpTax.Text]);

    If tcvoPIS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor PIS: %s' + #13, [edtImpPis.Text]);

    If tcvoCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor COFINS: %s' + #13, [edtImpCof.Text]);

    If tcvoIOF in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor IOF: %s' + #13, [edtValIOF.Text]);

    If tcvoDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor Despesas Aduaneiras: %s' + #13, [edtDesAdu.Text]);

    If tcvoAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor A.F.R.M.M: %s' + #13 , [edtAFRMM.Text]);

    strMensagem := strMensagem + Format('Total de Outros: %s',[edtTotDes.Text]);

    fMensagemEx('Outros', strMensagem, ['&OK']
                ,1
                ,False
                ,1
                ,0
                ,False
                ,0
                ,False
                ,False
                ,False
                ,0
                ,0
                ,6
               );
  end;



end;

procedure TfrmFatDadosAdicionais.edtImpTaxChange(Sender: TObject);
Var
  curTotDes: Currency;
begin
  inherited;
  curTotDes := 0;
  If Assigned(PerfilDespachanteAduaneiro) then
  begin
    curTotDes := curTotDes + IIF(tcvoPIS in PerfilDespachanteAduaneiro.ComposicaoValorOutras, fStrToFloat(edtImpPis.Text), 0);
    curTotDes := curTotDes + IIF(tcvoCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorOutras, fStrToFloat(edtImpCof.Text), 0);
    curTotDes := curTotDes + IIF(tcvoSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorOutras, fStrToFloat(edtImpTax.Text), 0);
    curTotDes := curTotDes + IIF(tcvoAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorOutras, fStrToFloat(edtAFRMM.Text), 0);
    curTotDes := curTotDes + IIF(tcvoIOF in PerfilDespachanteAduaneiro.ComposicaoValorOutras, fStrToFloat(edtValIOF.Text), 0);
    curTotDes := curTotDes + IIF(tcvoDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorOutras, fStrToFloat(edtDesAdu.Text), 0);
  end;
  edtTotDes.Text := FormatFloat('#,##0.00', curTotDes);
end;

function TfrmFatDadosAdicionais.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.
