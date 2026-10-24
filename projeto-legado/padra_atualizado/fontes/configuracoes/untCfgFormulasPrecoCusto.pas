unit untCfgFormulasPrecoCusto;

interface

uses
  Windows, Classes, Controls, Forms, untPai, StdCtrls, ExtCtrls, AppEvnts, Menus,
  Buttons, QColorLabel, EditFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFormulaCustoProduto, Vcl.ComCtrls;

type
  TfrmFormulaCalcPCusto = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pagFormulas: TPageControl;
    tbsFormula1: TTabSheet;
    tbsFormula2: TTabSheet;
    tbsFormula3: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    pnlTail: TPanel;
    lblTipoFormula: TColorLabel;
    edtTipoFormula: TEditFocus;
    tbsFormula4: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTipoFormulaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    objFormula1: TFormulaCustoProduto;
    objFormula2: TFormulaCustoProduto;
    objFormula3: TFormulaCustoProduto;
    objFormula4: TFormulaCustoProduto;

    function fValidaFormula : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulaCalcPCusto: TfrmFormulaCalcPCusto;
  intTipoFormula : Integer;
implementation

uses SysUtils, untFuncoesSimples, StrUtils;

{$R *.dfm}

procedure TfrmFormulaCalcPCusto.FormCreate(Sender: TObject);
  Var
    strDesValFre: String;
begin
  inherited;

  objFormula1 := TFormulaCustoProduto.Create(Self, 1, True);
  objFormula2 := TFormulaCustoProduto.Create(Self, 2, True);
  objFormula3 := TFormulaCustoProduto.Create(Self, 3, True);
  objFormula4 := TFormulaCustoProduto.Create(Self, 4, True);

  Memo1.Text := AnsiReplaceStr(Memo1.Text, 'DESCONTO ADICIONAL BOLETO', fCfgSis('DESADI'));
  Memo2.Text := AnsiReplaceStr(Memo2.Text, 'DESCONTO ADICIONAL BOLETO', fCfgSis('DESADI'));
  Memo3.Text := AnsiReplaceStr(Memo3.Text, 'DESCONTO ADICIONAL BOLETO', fCfgSis('DESADI'));

  strDesValFre := fCfgSis('DESVFR');
  Memo1.Text := AnsiReplaceStr(Memo1.Text, 'VALOR_FRETE', strDesValFre);
  Memo2.Text := AnsiReplaceStr(Memo2.Text, 'VALOR_FRETE', strDesValFre);
  Memo3.Text := AnsiReplaceStr(Memo3.Text, 'VALOR_FRETE', strDesValFre);
end;

procedure TfrmFormulaCalcPCusto.FormDestroy(Sender: TObject);
begin
  objFormula1.pLiberaTela;
  objFormula2.pLiberaTela;
  objFormula3.pLiberaTela;
  objFormula4.pLiberaTela;

  inherited;
end;

procedure TfrmFormulaCalcPCusto.FormShow(Sender: TObject);
begin
  inherited;

  objFormula1.pPedeDadosFormula(tbsFormula1);
  objFormula2.pPedeDadosFormula(tbsFormula2);
  objFormula3.pPedeDadosFormula(tbsFormula3);
  objFormula4.pPedeDadosFormula(tbsFormula4);

  pSetFocus(edtTipoFormula);

  pagFormulas.TabIndex := StrToIntDef(edtTipoFormula.Text, 1) - 1;
end;

procedure TfrmFormulaCalcPCusto.btnSairClick(Sender: TObject);
begin
  inherited;

  If edtTipoFormula.Text = '4' Then
    objFormula4.CancelUpdates;

end;

procedure TfrmFormulaCalcPCusto.edtTipoFormulaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If StrToIntDef(edtTipoFormula.Text, 0) In [1, 2, 3, 4] Then
    pagFormulas.TabIndex := StrToIntDef(edtTipoFormula.Text, 1) - 1;

end;

function TfrmFormulaCalcPCusto.fValidaFormula: Boolean;
begin
  Result := False;
  With edtTipoFormula Do
  If Pos(Text, '1_2_3_4') = 0 Then
  Begin
    fMensagem('AVISO','Digite um valor válido (1, 2, 3 ou 4)',['&O K']);
    Text := '';
    SetFocus;
  End
  Else
  Result := True;
end;

procedure TfrmFormulaCalcPCusto.btnConfirmaClick(Sender: TObject);
  Var
    blSalvouFormula: Boolean;
begin
  inherited;

  If fValidaFormula And ((edtTipoFormula.Text <> '4') Or (objFormula4.fFormulaValida(edtTipoFormula.Text))) Then
  Begin
    blSalvouFormula := objFormula4.fSalva;

    If blSalvouFormula Or (edtTipoFormula.Text <> '4') Then
    Begin
      intTipoFormula := StrToInt(edtTipoFormula.text);
      btnSair.Click;
    End;
  End
end;

end.
