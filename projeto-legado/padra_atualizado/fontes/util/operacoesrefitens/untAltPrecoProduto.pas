{***********************}
{* qryConIte -> CADITE *}
{********************JB*}

unit untAltPrecoProduto;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons, Uni, ExtCtrls, Menus,
  AppEvnts, QColorLabel, cxControls, cxContainer, cxEdit, cxGroupBox, untFatorPreco,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  frxClass, frxExportCSVTestabilidade, untPreAlt_Trigger, untClassPanelCx,
  untTGerenciaItegerPermiteEdicao, MemoFocus;

type
  TfrmAltPrecoProduto = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlPrecos: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlBotoesEnt: TPanel;
    edtLinGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtDesUni: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    pnlPrecos1: TPanel;
    Label13: TLabel;
    edtPreCom: TEditFocus;
    Label24: TLabel;
    edtSubsti: TEditFocus;
    Label43: TLabel;
    Label14: TLabel;
    edtDesf01: TEditFocus;
    Label33: TLabel;
    Label26: TLabel;
    edtPreCus: TEditFocus;
    Label15: TLabel;
    edtDesf02: TEditFocus;
    Label34: TLabel;
    Label25: TLabel;
    edtIcmSai: TEditFocus;
    Label44: TLabel;
    Label16: TLabel;
    edtDesf03: TEditFocus;
    Label35: TLabel;
    Label6: TLabel;
    edtImpFed: TEditFocus;
    Label4: TLabel;
    Label17: TLabel;
    edtDesf04: TEditFocus;
    Label36: TLabel;
    Label32: TLabel;
    edtDesOpe: TEditFocus;
    lblDesOpePer: TLabel;
    Label18: TLabel;
    edtDesf05: TEditFocus;
    Label37: TLabel;
    Label19: TLabel;
    edtDesf06: TEditFocus;
    Label38: TLabel;
    Label20: TLabel;
    edtIcmEnt: TEditFocus;
    Label39: TLabel;
    Label21: TLabel;
    edtIpiEnt: TEditFocus;
    Label40: TLabel;
    edtFreEnt: TEditFocus;
    Label41: TLabel;
    Label23: TLabel;
    edtAcrFin: TEditFocus;
    Label42: TLabel;
    pnlPrecos2: TPanel;
    pnlDesconto: TPanel;
    lblDesMax: TLabel;
    edtDesMax: TEditFocus;
    lblDesMaxPor: TLabel;
    lblDesMge: TLabel;
    edtDesMGe: TEditFocus;
    lblDesMgePor: TLabel;
    lblMarMin: TLabel;
    edtMarMin: TEditFocus;
    lblMarMinPor: TLabel;
    lblImpLis: TLabel;
    edtImpLis: TEditFocus;
    clrImpLis: TColorLabel;
    lblIteAti: TLabel;
    edtIteAti: TEditFocus;
    clrIteAti: TColorLabel;
    edtValFre: TEditFocus;
    lblDesAdi: TLabel;
    Label31: TLabel;
    edtDesAdb: TEditFocus;
    Label45: TLabel;
    edtSubFed: TEditFocus;
    Label46: TLabel;
    lblOutVal: TLabel;
    edtOutVal: TEditFocus;
    pnlTab1: TPanel;
    gpbTabPre01: TcxGroupBox;
    lblTitMarBr1: TLabel;
    lblTitPreVe1: TLabel;
    lblMarBr1: TLabel;
    lblTitComTb1: TLabel;
    lblPerComTb1: TLabel;
    edtComTb1: TEditFocus;
    edtMarBr1: TEditFocus;
    edtPreVe1: TEditFocus;
    gpbTabPre02: TcxGroupBox;
    lblTitMarBr2: TLabel;
    lblTitPreVe2: TLabel;
    lblMarBr2: TLabel;
    lblTitComTb2: TLabel;
    lblPerComTb2: TLabel;
    edtComTb2: TEditFocus;
    edtMarBr2: TEditFocus;
    edtPreVe2: TEditFocus;
    gpbTabPre03: TcxGroupBox;
    lblMarBr3: TLabel;
    lblTitMarBr3: TLabel;
    lblTitPreVe3: TLabel;
    lblTitComTb3: TLabel;
    lblPerComTb3: TLabel;
    edtComTb3: TEditFocus;
    edtMarBr3: TEditFocus;
    edtPreVe3: TEditFocus;
    lblTabPre: TLabel;
    gpbTabPre07: TcxGroupBox;
    Label125: TLabel;
    Label126: TLabel;
    Label123: TLabel;
    lblTitComTb7: TLabel;
    lblPerComTb7: TLabel;
    edtComTb7: TEditFocus;
    edtMarBr7: TEditFocus;
    edtPreVe7: TEditFocus;
    gpbTabPre06: TcxGroupBox;
    Label63: TLabel;
    lblMarBr6: TLabel;
    Label65: TLabel;
    lblTitComTb6: TLabel;
    lblPerComTb6: TLabel;
    edtComTb6: TEditFocus;
    edtMarBr6: TEditFocus;
    edtPreVe6: TEditFocus;
    gpbTabPre05: TcxGroupBox;
    Label54: TLabel;
    lblMarBr5: TLabel;
    Label61: TLabel;
    lblTitComTb5: TLabel;
    lblPerComTb5: TLabel;
    edtComTb5: TEditFocus;
    edtMarBr5: TEditFocus;
    edtPreVe5: TEditFocus;
    pnl1: TPanel;
    gpbTabPre04: TcxGroupBox;
    lblTitMarBr4: TLabel;
    Label10: TLabel;
    lblTitPreVe4: TLabel;
    lblTitComTb4: TLabel;
    lblPerComTb4: TLabel;
    edtComTb4: TEditFocus;
    edtMarBr4: TEditFocus;
    edtPreVe4: TEditFocus;
    rdgTipAlt: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    chkPreDol: TCheckBox;
    lblDesMSu: TLabel;
    edtDesMSu: TEditFocus;
    lblDesMSuPor: TLabel;
    lblCodFab: TLabel;
    edtCodFab: TEditFocus;
    pnlSuframa: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label47: TLabel;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    edtFatReg: TEditFocus;
    edtDeICMS: TEditFocus;
    edtDePiCo: TEditFocus;
    edtTSCust: TEditFocus;
    edtTCIFCu: TEditFocus;
    lblValFre: TLabel;
    Label8: TLabel;
    edtAplica: TMemoFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure chkPreDolClick(Sender: TObject);
    procedure edtMarBr1Exit(Sender: TObject);
    procedure edtMarBr1Enter(Sender: TObject);
  private
    { Private declarations }
    qryConIte, qryPreAlt: TUniQuery;

    strAgrupadorPreAlt: String;

    strDesValFre: String;

    blnMarNeg,
    blnInfMat: Boolean;

    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    intDecUni: Integer;
    blnFatPre: Boolean;
    objFatPre: TFatorPreco;

    procedure pLimpaPanel(pnlPrecos: TPanel);
    procedure pRecalculaPrecos;
    procedure pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
    procedure pLimpaEdits;

    Function fAlteraItem: Boolean;
    procedure pAlteraPrecoItem(blnResFor: Boolean);

    function fRetPrecoCusto: Double;
    function fRetPrecoVenda(intOpcao, intNumPreVen: Integer): Double;
    function fInativarProduto: Boolean;
    procedure pAtualizaImpLisLojas;
    Procedure pAjustaFatorPreco(blnDesabilita: Boolean);
    Procedure pRecalculaPrecosFator;

    function fEdtFocus(strNome: String): TEditFocus;

    Function fTemMargemNegativa: Boolean;

    procedure pTravaPrecos;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pCarregaItem;
  end;

var
  frmAltPrecoProduto: TfrmAltPrecoProduto;

implementation

uses untFuncoesSimples, untConstantes, untZClient,
     untParCalculaPrecoCusto, StrUtils, untPreAlt, untFuncoesAuxiliares,
     untConsultas, untTConfiguracao, untTypesSistema,
     untProdMargemNegativa, Data.Db;
{$R *.dfm}

function TfrmAltPrecoProduto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomEdt: String;
begin

  Result := True;

  strNomEdt := UpperCase(Sender.Name);

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pCarregaItem;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pHabilitaCampos(pnlPrecos, True);
          btnConfirma.Enabled := True;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA O PREÇO DE COMPRA              *}
    {**************************************MV*}
    Else If (Sender = edtPreCom) Then
    Begin
      If fEmptyStr(edtPreCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtPreCom.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pRecalculaPrecos;
      End;
    End

    Else If (Sender = edtDesf01) Or
            (Sender = edtDesf02) Or
            (Sender = edtDesf03) Or
            (Sender = edtDesf04) Or
            (Sender = edtDesf05) Or
            (Sender = edtDesf06) Then
    Begin
      If Not fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        If Not fValidaEscala((Sender As TEditFocus).Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        (Sender As TEditFocus).Text := '0,00';
      End;
    End

    Else If (Sender = edtOutVal) Then
    Begin
      If fStrToFloat(edtOutVal.Text) < 0 Then
      Begin
        fMensagem('','O Valor do campo ' + LowerCase(fCfgSis('DOVCPP')) + ' deve ser maior ou igual à zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtImpFed) Then
    Begin
      If Not fEmptyStr(edtImpFed.Text) Then
      Begin
        If Not fValidaEscala(edtImpFed.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Imposto Federal deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtImpFed.Text := '0';
      End;
    End

    Else If (Sender = edtIcmEnt) And (edtIcmEnt.Enabled) Then
    Begin
      If Not fEmptyStr(edtIcmEnt.Text) Then
      Begin
        If Not fValidaEscala(edtIcmEnt.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
      Begin
        edtIcmEnt.Text := '0,00';
      End;
    End

    Else If (Sender = edtSubFed) And (edtSubFed.Enabled) Then
    Begin
      If Not fEmptyStr(edtSubFed.Text) Then
      Begin
        If Not fValidaEscala(edtSubFed.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
      Begin
        edtSubFed.Text := '0,00';
      End;
    End

    Else If (Sender = edtIcmSai) And (edtIcmSai.Enabled) Then
    Begin
      If Not fEmptyStr(edtIcmSai.Text) Then
      Begin
        If Not fValidaEscala(edtIcmSai.Text, 0, 100) Then
        Begin
          Result := False;
        End;
      End
      Else
      Begin
        edtIcmSai.Text := '0,00';
      End;

    End

    Else If (Sender = edtIpiEnt) Then
    Begin
      If Not fEmptyStr(edtIpiEnt.Text) Then
      Begin
        If Not fValidaEscala(edtIpiEnt.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O IPI de entrada deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtIpiEnt.Text := '0,00';
      End;

    End

    Else If (Sender = edtFreEnt) Then
    Begin
      If Not fEmptyStr(edtFreEnt.Text) Then
      Begin
        If Not fValidaEscala(edtFreEnt.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Frete deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtFreEnt.Text := '0,00';
      End;

    End

    Else If (Sender = edtValFre) Then
    Begin
      If Not fEmptyStr(edtValFre.Text) Then
      Begin
        If fStrToFloat(edtValFre.Text) < 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + strDesValFre + '" deve ser maior ou igual a  zero!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtValFre.Text := '0,00';
      End;
    End

    Else If (Sender = edtAcrFin) Then
    Begin
      If Not fEmptyStr(edtAcrFin.Text) Then
      Begin
        If Not fValidaEscala(edtAcrFin.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Acrescimo final deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtAcrFin.Text := '0,00';
      End;

    End

    Else If (Sender = edtDesMax) Then
    Begin
      If Not fEmptyStr(edtDesMax.Text) Then
      Begin
        If Not fValidaEscala(edtDesMax.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto máximo deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesMax.Text := '0,00';
      End;

    End

    Else If (Sender = edtDesMGe) Then
    Begin
      If Not fEmptyStr(edtDesMGe.Text) Then
      Begin
        If Not fValidaEscala(edtDesMGe.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto máximo do Gerente deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesMGe.Text := '0,00';
      End;

    End

    Else If (Sender = edtDesMSu) Then
    Begin
      If Not fEmptyStr(edtDesMSu.Text) Then
      Begin
        If Not fValidaEscala(edtDesMSu.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Desconto máximo do Sub-Gerente deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesMSu.Text := '0,00';
      End;

    End

    Else If (Sender = edtSubsti) Then
    Begin
      If Not fEmptyStr(edtSubsti.Text) Then
      Begin
        If Not fValidaEscala(edtSubsti.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Substituição Tributária deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtSubsti.Text := '0,00';
      End;

    End

    Else If (Sender = edtDesAdb) Then
    Begin
      If Not fEmptyStr(edtDesAdb.Text) Then
      Begin
        If Not fValidaEscala(edtDesAdb.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O ' + fCfgSis('DESADI') + ' deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtDesAdb.Text := '0,00';
      End;

    End

    Else If (Sender = edtDesOpe) Then
    Begin

      If Not fEmptyStr(edtDesOpe.Text) Then
      Begin
        (*If VS_intDesOpe = 1 Then
        Begin
          If (fStrToFloat(edtDesOpe.Text) < 0.0) Then
          Begin
            fMensagem('ATENÇÃO!', 'O valor de Despesas Operacionais deve ser maior ou igual a Zero!', ['&Ok']);
            Result := False;
          End;
        End
        Else *)
        Begin
          If Not fValidaEscala(edtDesOpe.Text, 0, 100) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Campo Despesas Operacionais deve estar entre 0 e 100!', ['&Ok']);
            Result := False;
          End;
        End;

      End
      Else
      Begin
        edtDesOpe.Text := '0.0';
      End;
    End

    Else If (Sender = edtTCIFCu) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtTCIFCu.Text) Then
      Begin
        If Not fValidaEscala(edtTCIFCu.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo TCIF deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtTCIFCu.Text := '0,00';
      End;

    End

    Else If (Sender = edtTSCust) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtTSCust.Text) Then
      Begin
        If Not fValidaEscala(edtTSCust.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo TS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtTSCust.Text := '0,00';
      End;

    End

    Else If (Sender = edtDePiCo) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtDePiCo.Text) Then
      Begin
        If Not fValidaEscala(edtDePiCo.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo desconto PIS/COFINS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtDePiCo.Text := '0,00';
      End;

    End

    Else If (Sender = edtDeICMS) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtDeICMS.Text) Then
      Begin
        If Not fValidaEscala(edtDeICMS.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo desconto ICMS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtDeICMS.Text := '0,00';
      End;

    End

    Else If (Sender = edtFatReg) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtFatReg.Text) Then
      Begin
        If Not fValidaEscala(edtFatReg.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo fator regional deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtFatReg.Text := '0,00';
      End;

    End

    Else If (Sender Is TEditFocus) And (Pos('EDTMARBR', strNomEdt) > 0) Then
    Begin
      If Not fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        If fStrToFloat(TEditFocus(Sender).Text) > MAX_VALMON Then
        Begin
          TEditFocus(Sender).Text := FloatToStr(MAX_VALMON);
        End;
      End;

      If Result And (blnBuscaPorChave Or (rdgTipAlt.ItemIndex = 0)) Then
      Begin
        fEdtFocus('edtPreVe' + RightStr(strNomEdt, 1)).Text := FloatToStrF(fRetPrecoVenda(1, StrToInt(RightStr(strNomEdt, 1))), ffFixed, 12, fCfgSis('DECUNI', varInteger));
        pRecalculaPrecosFator;
      End;
    End

    Else If (Sender Is TEditFocus) And (Pos('EDTCOMTB', strNomEdt) > 0) Then
    Begin
      If Not fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        If Not fValidaEscala(TEditFocus(Sender).Text, 0, 100) Then
        Begin
          fMensagem('','O percentual de comissão deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        TEditFocus(Sender).Text := '0,00';

      If Result Then
      Begin
        If rdgTipAlt.ItemIndex = 0 Then
          fEdtFocus('edtPreVe' + RightStr(strNomEdt, 1)).Text := FloatToStrF(fRetPrecoVenda(1, StrToInt(RightStr(strNomEdt, 1))), ffFixed, 12, fCfgSis('DECUNI', varInteger))
        Else
          fEdtFocus('edtMarBr' + RightStr(strNomEdt, 1)).Text := FloatToStrF(fRetPrecoVenda(2, StrToInt(RightStr(strNomEdt, 1))), ffFixed, 12, fRetPrecisaoMargemItem);

        pRecalculaPrecosFator;
      End;
    End

    Else If (Sender Is TEditFocus) And (Pos('EDTPREVE', strNomEdt) > 0) Then
    Begin
      If blnBuscaPorChave Or (rdgTipAlt.ItemIndex = 1) Then
      Begin
        fEdtFocus('edtMarBr' + RightStr(strNomEdt, 1)).Text := FloatToStrF(fRetPrecoVenda(2, StrToInt(RightStr(strNomEdt, 1))), ffFixed, 12, fRetPrecisaoMargemItem);
        pRecalculaPrecosFator;
      End;
    End

    Else If (Sender = edtIteAti) Or (Sender = edtImpLis) Then
    Begin
      If Sender.Enabled Then
      Begin
        If Not fValidoSimNao((Sender As TEditFocus).Text) Then
          Result := False;

        If (Sender = edtIteAti) Then
          if Not fInativarProduto Then
            Result := False;
      End;
    End;

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End
  Else If blnBuscaPorChave Then
  Begin
    pRecalculaPrecos;
  End;

end;

procedure TfrmAltPrecoProduto.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlPrecos) Then
  Begin
    pHabilitaCampos(pnlPrecos, False);
    pHabilitaCampos(pnlCabecalho, True);
    btnConfirma.Enabled := False;
    pSetFocus(edtCodIte);
    pLimpaEdits;
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmAltPrecoProduto.pCarregaItem;
  Var
    strSQL: String;
    intCont: Integer;
    GerenciaItegerPermiteEdicao: TGerenciaItegerPermiteEdicao;
begin
  GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;

  Try
    GerenciaItegerPermiteEdicao.pSetaEmpresa(VS_StrCodEmp, '');

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE AS "ITE_CODITE", ';
    strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU", ';
    strSQL := strSQL + '  P.GRU_DESGRU AS "GRU_DESGRU", ';
    strSQL := strSQL + '  I.ITE_DESITE AS "ITE_DESITE", ';
    strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE", ';
    strSQL := strSQL + '  I.ITE_CODFAB AS "ITE_CODFAB", ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI", ';
    strSQL := strSQL + '  I.ITE_APLICA AS "ITE_APLICA", ';
    strSQL := strSQL + '  U.UNI_DESUNI AS "UNI_DESUNI", ';
    strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR", ';
    strSQL := strSQL + '  M.MAR_DESMAR AS "MAR_DESMAR", ';
    strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR", ';
    strSQL := strSQL + '  F.FOR_NOMFOR AS "FOR_NOMFOR", ';
    strSQL := strSQL + '  G.ITE_SALDOS AS "ITE_SALDOS", ';
    strSQL := strSQL + '  G.ITE_SALBAL AS "ITE_SALBAL", ';
    strSQL := strSQL + '  G.ITE_DTABAL AS "ITE_DTABAL", ';

    strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM", ';
    strSQL := strSQL + '  G.ITE_PREDOL AS "ITE_PREDOL", ';
    strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01", ';
    strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02", ';
    strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03", ';
    strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04", ';
    strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05", ';
    strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06", ';
    strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT", ';
    strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED", ';
    strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT", ';
    strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT", ';
    strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE", ';
    strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN", ';
    strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI", ';
    strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB", ';
    strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL", ';
    strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED", ';
    strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE", ';
    strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS", ';
    strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI", ';
    strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX", ';
    strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE", ';
    strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU", ';
    strSQL := strSQL + '  G.ITE_TCIFCU AS "ITE_TCIFCU", ';
    strSQL := strSQL + '  G.ITE_TSCUST AS "ITE_TSCUST", ';
    strSQL := strSQL + '  G.ITE_DEPICO AS "ITE_DEPICO", ';
    strSQL := strSQL + '  G.ITE_DEICMS AS "ITE_DEICMS", ';
    strSQL := strSQL + '  G.ITE_FATREG AS "ITE_FATREG", ';

    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intCont) + ' AS "ITE_MARBR' + IntToStr(intCont) + '", ';
      strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(intCont) + ' AS "ITE_PREVE' + IntToStr(intCont) + '", ';
      strSQL := strSQL + '  G.ITE_COMTB' + IntToStr(intCont) + ' AS "ITE_COMTB' + IntToStr(intCont) + '", ';
    End;

    strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN", ';
    strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS", ';
    strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI"  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  CADUNI U, ';
    strSQL := strSQL + '  CADMAR M, ';
    strSQL := strSQL + '  CADFOR F, ';
    strSQL := strSQL + '  CADGRU P, ';
    strSQL := strSQL + '  ITEGER G ';
    strSQL := strSQL + 'WHERE ';

    If Length(edtCodIte.Text) <= fTamCodIte Then
    Begin
      strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    End
    Else
    Begin
      strSQL := strSQL + '  I.ITE_CODBAR = :CODITE AND '
    End;

    strSQL := strSQL + '  G.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';      //Empresa Atual
    strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODGRU = P.GRU_CODGRU AND ';
    strSQL := strSQL + '  I.ITE_CODFOR = F.FOR_CODFOR ';

    With qryConIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodIte.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      edtCodIte.Text    := FieldByName('ITE_CODITE').AsString;
      edtLinGru.Text    := FieldByName('ITE_CODGRU').AsString + ' - ' + FieldByName('GRU_DESGRU').AsString;
      edtDesIte.Text    := FieldByName('ITE_DESITE').AsString;
      edtRefere.Text    := FieldByName('ITE_REFERE').AsString;
      edtCodFab.Text    := FieldByName('ITE_CODFAB').AsString;
      edtDesUni.Text    := FieldByName('ITE_CODUNI').AsString;
      edtDesMar.Text    := FieldByName('ITE_CODMAR').AsString + ' - ' + FieldByName('MAR_DESMAR').AsString;
      edtNomFor.Text    := FieldByName('ITE_CODFOR').AsString + ' - ' + FieldByName('FOR_NOMFOR').AsString;
      edtAplica.Text    := FieldByName('ITE_APLICA').AsString;
      chkPreDol.Checked := FieldByName('ITE_PREDOL').AsString = 'S';

      edtPreCom.Text    := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), FieldByName('ITE_PRECOM').AsFloat);
      edtPreCom.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PRECOM');

      edtDesf01.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESF01').AsFloat);
      edtDesf01.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF01');

      edtDesf02.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESF02').AsFloat);
      edtDesf02.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF02');

      edtDesf03.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESF03').AsFloat);
      edtDesf03.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF03');

      edtDesf04.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESF04').AsFloat);
      edtDesf04.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF04');

      edtDesf05.Text := FormatFloat('#,##0.00', FieldByName('ITE_DESF05').AsFloat);
      edtDesf05.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF05');

      edtDesf06.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESF06').AsFloat);
      edtDesf06.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF06');

      edtIcmEnt.Text    := FormatFloat('#,##0.00', FieldByName('ITE_ICMENT').AsFloat);
      edtIcmEnt.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMENT');

      edtSubFed.Text    := FormatFloat('#,##0.00', FieldByName('ITE_SUBFED').AsFloat);
      edtSubFed.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBFED');

      edtIpiEnt.Text    := FormatFloat('#,##0.00', FieldByName('ITE_IPIENT').AsFloat);
      edtIpiEnt.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPIENT');

      edtFreEnt.Text    := FormatFloat('#,##0.00', FieldByName('ITE_FREENT').AsFloat);
      edtFreEnt.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_FREENT');

      edtValFre.Text    := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), FieldByName('ITE_VALFRE').AsFloat);
      edtValFre.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_VALFRE');

      edtAcrFin.Text    := FormatFloat('#,##0.00', FieldByName('ITE_ACRFIN').AsFloat);
      edtAcrFin.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ACRFIN');

      edtSubsti.Text    := FormatFloat('#,##0.00', FieldByName('ITE_SUBSTI').AsFloat);
      edtSubsti.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBSTI');

      edtDesAdb.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESADB').AsFloat);
      edtDesAdb.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESADB');

      edtOutVal.Text    := FormatFloat('#,##0.000',FieldByName('ITE_OUTVAL').AsFloat);
      edtOutVal.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_OUTVAL');

      edtImpFed.Text    := FormatFloat('#,##0.00', FieldByName('ITE_IMPFED').AsFloat);
      edtImpFed.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IMPFED');

      edtDesOpe.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DESOPE').AsFloat);
      edtDesOpe.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESOPE');

      edtPreCus.Text    := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), FieldByName('ITE_PRECUS').AsFloat);

      edtIcmSai.Text    := FormatFloat('#,##0.00', FieldByName('ITE_ICMSAI').AsFloat);
      edtIcmSai.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMSAI');

      edtDesMax.Text := FormatFloat('#,##0.00', FieldByName('ITE_DESMAX').AsFloat);
      edtDesMGe.Text := FormatFloat('#,##0.00', FieldByName('ITE_DESMGE').AsFloat);
      edtDesMSu.Text := FormatFloat('#,##0.00', FieldByName('ITE_DESMSU').AsFloat);

      edtTCIFCu.Text    := FormatFloat('#,##0.00', FieldByName('ITE_TCIFCU').AsFloat);
      edtTCIFCu.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_TCIFCU');

      edtTSCust.Text    := FormatFloat('#,##0.00', FieldByName('ITE_TSCUST').AsFloat);
      edtTSCust.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_TSCUST');

      edtDePiCo.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DEPICO').AsFloat);
      edtDePiCo.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DEPICO');

      edtDeICMS.Text    := FormatFloat('#,##0.00', FieldByName('ITE_DEICMS').AsFloat);
      edtDeICMS.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DEICMS');

      edtFatReg.Text    := FormatFloat('#,##0.00', FieldByName('ITE_FATREG').AsFloat);
      edtFatReg.Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_FATREG');

      For intCont := 1 To Length(VS_strTabPrc) Do
      Begin
        fEdtFocus('edtMarBr' + IntToStr(intCont)).Text    := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), FieldByName('ITE_MARBR' + IntToStr(intCont)).AsFloat);
        fEdtFocus('edtMarBr' + IntToStr(intCont)).Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_MARBR' + IntToStr(intCont));

        fEdtFocus('edtComTb' + IntToStr(intCont)).Text    := FormatFloat('#,##0.00', FieldByName('ITE_COMTB' + IntToStr(intCont)).AsFloat);
        fEdtFocus('edtComTb' + IntToStr(intCont)).Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_COMTB' + IntToStr(intCont));

        fEdtFocus('edtPreVe' + IntToStr(intCont)).Text    := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), FieldByName('ITE_PREVE' + IntToStr(intCont)).AsFloat);
        fEdtFocus('edtPreVe' + IntToStr(intCont)).Enabled := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PREVE' + IntToStr(intCont));
      End;

      edtMarMin.Text := FormatFloat('#,##0.00', FieldByName('ITE_MARMIN').AsFloat);
      edtImpLis.Text := FieldByName('ITE_IMPLIS').AsString;
      edtIteAti.Text := FieldByName('ITE_ITEATI').AsString;
    End;

  Finally
     FreeAndNil(GerenciaItegerPermiteEdicao);
  End;

end;

procedure TfrmAltPrecoProduto.pRecalculaPrecos;
begin
  edtPreCus.Text := FloatToStrF(fRetPrecoCusto, ffFixed, 12, fCfgSis('DECUNI', varInteger));
  Case rdgTipAlt.ItemIndex Of
  0: Begin
      edtPreVe1.Text := FloatToStrF(fRetPrecoVenda(1, 1), ffFixed, 12, fCfgSis('DECUNI', varInteger));
      edtPreVe2.Text := FloatToStrF(fRetPrecoVenda(1, 2), ffFixed, 12, fCfgSis('DECUNI', varInteger));
      edtPreVe3.Text := FloatToStrF(fRetPrecoVenda(1, 3), ffFixed, 12, fCfgSis('DECUNI', varInteger));
      edtPreVe4.Text := FloatToStrF(fRetPrecoVenda(1, 4), ffFixed, 12, fCfgSis('DECUNI', varInteger));
      edtPreVe5.Text := FloatToStrF(fRetPrecoVenda(1, 5), ffFixed, 12, fCfgSis('DECUNI', varInteger));
      edtPreVe6.Text := FloatToStrF(fRetPrecoVenda(1, 6), ffFixed, 12, fCfgSis('DECUNI', varInteger));
      edtPreVe7.Text := FloatToStrF(fRetPrecoVenda(1, 7), ffFixed, 12, fCfgSis('DECUNI', varInteger));
     End;
  1: Begin
      edtMarBr1.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 1)));
      edtMarBr2.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 2)));
      edtMarBr3.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 3)));
      edtMarBr4.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 4)));
      edtMarBr5.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 5)));
      edtMarBr6.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 6)));
      edtMarBr7.Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), (fRetPrecoVenda(2, 7)));
     End;
  End;
  pRecalculaPrecosFator;
end;

function TfrmAltPrecoProduto.fRetPrecoCusto: Double;
 Var
    cpcParams: TParCalculaPrecoCusto;
    blnUtilizarConversorDeMoedas : Boolean;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      curPreCom := fStrToFloat(edtPreCom.Text);
      curDesF01 := fStrToFloat(edtDesf01.Text);
      curDesF02 := fStrToFloat(edtDesf02.Text);
      curDesF03 := fStrToFloat(edtDesf03.Text);
      curDesF04 := fStrToFloat(edtDesf04.Text);
      curDesF05 := fStrToFloat(edtDesf05.Text);
      curDesF06 := fStrToFloat(edtDesf06.Text);
      curICMSEnt:= fStrToFloat(edtIcmEnt.Text);
      curIPIEnt := fStrToFloat(edtIpiEnt.Text);
      curFrete  := fStrToFloat(edtFreEnt.Text);
      curValFre := fStrToFloat(edtValFre.Text);
      curAcrFin := fStrToFloat(edtAcrFin.Text);
      curSubsti := fStrToFloat(edtSubsti.Text);
      curDesAdb := fStrToFloat(edtDesAdb.Text);
      curSubFed := fStrToFloat(edtSubFed.Text);
      //curImpFed := fStrToFloat(edtImpFed.Text);
      //curDesOpe := fStrToFloat(edtDesOpe.Text);

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fStrToFloat(edtTCIFCu.Text);
        curTSCust := fStrToFloat(edtTSCust.Text);
        curDePiCo := fStrToFloat(edtDePiCo.Text);
        curDeICMS := fStrToFloat(edtDeICMS.Text);
        curFatReg := fStrToFloat(edtFatReg.Text);
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    blnUtilizarConversorDeMoedas := chkPreDol.Checked;

    Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);

  Finally
    FreeAndNil(cpcParams);
  End;

end;

function TfrmAltPrecoProduto.fRetPrecoVenda(intOpcao, intNumPreVen: Integer): Double;
  Var
    intCont: Integer;
begin

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    If fEmptyStr(fEdtFocus('edtPreVe' + IntToStr(intCont)).Text) Then
      fEdtFocus('edtPreVe' + IntToStr(intCont)).Text := FloatToStrF(0.0, ffFixed, 12, fCfgSis('DECUNI', varInteger));

    If fEmptyStr(fEdtFocus('edtMarBr' + IntToStr(intCont)).Text) Then
      fEdtFocus('edtMarBr' + IntToStr(intCont)).Text := '0,00';

    If fEmptyStr(fEdtFocus('edtComTb' + IntToStr(intCont)).Text) Then
      fEdtFocus('edtComTb' + IntToStr(intCont)).Text := '0,00';
  End;

  If intNumPreVen In [1..Length(VS_strTabPrc)] Then
  Begin
    If (intOpcao = 2 {Margem}) Or (Not blnFatPre Or (Not objFatPre.fTabelaAtiva(intNumPreVen))) Or (intNumPreVen = 1) Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fStrToFloat(edtPreCus.Text) + fStrToFloat(edtOutVal.Text),
                                   fStrToFloat(fEdtFocus('edtPreVe' + IntToStr(intNumPreVen)).Text),
                                   fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intNumPreVen)).Text),
                                   fStrToFloat(edtIcmSai.Text),
                                   fStrToFloat(edtImpFed.Text),
                                   fStrToFloat(edtDesOpe.Text),
                                   fStrToFloat(fEdtFocus('edtComTb' + IntToStr(intNumPreVen)).Text))

    Else If intOpcao = 1 Then
      Result := fStrToFloat(fEdtFocus('edtPreVe' + IntToStr(intNumPreVen)).Text)

    Else Result := fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intNumPreVen)).Text);

  End
  Else
  Begin
    Result := -1;
    fMensagem('', 'fRetPrecoVenda: Escolha a Opção 1 a 7!', ['&O k']);
  End;

end;

procedure TfrmAltPrecoProduto.pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
  Var
    intContador: Integer;
    edtTemp: TEdit;
begin

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin

    If (Owner.Controls[intContador] Is TEdit) Then
    Begin

      edtTemp := (Owner.Controls[intContador] As TEdit);
      If edtTemp.Tag = 99 Then
      Begin
        edtTemp.Enabled := blnHabilita;
      End;

    End;

  End;

end;


procedure TfrmAltPrecoProduto.FormShow(Sender: TObject);
Var
  intTabPre : Integer;
  blnPerCom : Boolean;
begin
  inherited;

  If (Pos(fCfgSis('MARMKP'), '1_5_') = 0) Then
  Begin
    For intTabPre := 1 To Length(VS_strTabPrc) Do
      If Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre)) <> Nil Then
        TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre))).Caption := 'Markup:';
  End;

  pHabilitaCampos(pnlPrecos, False);

  lblOutVal.Caption := fCfgSis('DOVCPP') + ' (+):';
  lblDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';

  lblValFre.Caption := strDesValFre + ' (+):';

  blnPerCom := (fCfgSis('PCMPRO') = '2');

  edtPreCom.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtPreCus.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    TEditFocus(Self.FindComponent('edtMarBr' + IntToStr(intTabPre))).EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
    TEditFocus(Self.FindComponent('edtPreVe' + IntToStr(intTabPre))).EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

    If VS_strTabPrc[intTabPre] = 'S' Then
    Begin
      TcxGroupBox(Self.FindComponent('gpbTabPre0' + IntToStr(intTabPre))).Visible := True;

      If Not blnPerCom Then
      Begin
        TEditFocus(Self.FindComponent('edtComTb'    + IntToStr(intTabPre))).Visible := False;
        TLabel    (Self.FindComponent('lblTitComTb' + IntToStr(intTabPre))).Visible := False;
        TLabel    (Self.FindComponent('lblPerComTb' + IntToStr(intTabPre))).Visible := False;
      End;
    End;
  End;

  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    pnlSuframa.Visible := True;
  end
  else
  begin
    pnlSuframa.Visible := False;
  end;
  pSetFocus(edtCodIte);
end;

procedure TfrmAltPrecoProduto.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
//    stlCamIndIte, stlDesIndIte: TStringList;
//    strSQL: String;
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True,  pnlPanelItemPrecoProduto, 'Consulta de Itens', '1') Then
  Begin
    pCarregaItem;

    pHabilitaCampos(pnlPrecos, True);
    btnConfirma.Enabled := True;
    pSetFocus(edtPreCom);
  End;

end;

procedure TfrmAltPrecoProduto.edtMarBr1Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TEdit Then
    pSelectAll(TEdit(Sender));
end;

procedure TfrmAltPrecoProduto.edtMarBr1Exit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(TEditFocus(Sender).Text) Then
    TEditFocus(Sender).SelStart := 1;
end;

procedure TfrmAltPrecoProduto.pLimpaPanel(pnlPrecos: TPanel);
  Var
    intContador: Integer;
    edtTemp: TEdit;

    procedure pLimpaPrecos(objObjeto: TWinControl);
      Var
        intAux: Integer;
    begin
      for intAux := 0 To objObjeto.ControlCount -1 Do
        If (objObjeto.Controls[intAux] is TEdit) Then
          (objObjeto.Controls[intAux] As TEdit).Clear;
    end;

Begin
  For intContador := 0 To pnlPrecos.ControlCount -1 Do
  Begin

    If (pnlPrecos.Controls[intContador] Is TEdit) Then
    Begin
      edtTemp := (pnlPrecos.Controls[intContador] As TEdit);
      edtTemp.Clear;
    End
    Else If (pnlPrecos.Controls[intContador] Is TcxGroupBox) Then
      pLimpaPrecos(pnlPrecos.Controls[intContador] As TWinControl);

  End;
End;

procedure TfrmAltPrecoProduto.pLimpaEdits;
begin

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtCodFab.Clear;
  edtDesUni.Clear;
  edtDesMar.Clear;
  edtNomFor.Clear;
  edtLinGru.Clear;
  edtTCIFCu.Clear;
  edtTSCust.Clear;
  edtDePiCo.Clear;
  edtDeICMS.Clear;
  edtFatReg.Clear;
  edtAplica.Clear;
  chkPreDol.Checked := False;

  pLimpaPanel(pnlTab1);
  pLimpaPanel(pnlPrecos1);
  pLimpaPanel(pnlPrecos2);
  pLimpaPanel(pnlDesconto);

end;

procedure TfrmAltPrecoProduto.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

Function TfrmAltPrecoProduto.fTemMargemNegativa: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[intContador] = 'S') And (fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intContador)).Text) < 0) Then
    Begin
      Result := True;
      Exit;
    End;

End;

procedure TfrmAltPrecoProduto.btnConfirmaClick(Sender: TObject);
  Var
    cdsItem: TZClient;
    intNumPreVen: Integer;
    blnConfirma: Boolean;
begin
  inherited;

  If Not btnConfirma.Enabled Then
    Exit;

  If fVerificaCampos Then
  Begin
    pRecalculaPrecos;

    blnConfirma := True;

    If blnMarNeg And fTemMargemNegativa Then
    Begin

      cdsItem := TProdMargemNegativa.fCriaDadosItem(edtCodIte.Text);

      With cdsItem Do
      If Not IsEmpty Then
      Begin
        Edit;

        FieldByName('ITE_PRECUS').AsFloat := fStrToFloat(edtPreCus.Text);

        For intNumPreVen := 1 To 7 Do
        Begin
          FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat := fStrToFloat(fEdtFocus('edtPreVe' + IntToStr(intNumPreVen)).Text);
          FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat := fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intNumPreVen)).Text);
        End;

        Post;

        blnConfirma := TProdMargemNegativa.fLiberaMargemNegativa(cdsItem, cdsItem, rotCadProdutos);
      End;

    End;

    If blnConfirma Then
    Begin
      fAlteraItem;

      pHabilitaCampos(pnlPrecos, False);
      btnConfirma.Enabled := False;

      pSetFocus(edtCodIte);
      Application.ProcessMessages;
      pLimpaEdits;
    End;

    FreeAndNil(cdsItem);
  End;
end;


procedure TfrmAltPrecoProduto.chkPreDolClick(Sender: TObject);
begin
  inherited;

  pRecalculaPrecos;
end;

procedure TfrmAltPrecoProduto.pAlteraPrecoItem(blnResFor: Boolean);
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
    strEmpresas: String;
    intCont: Integer;
Begin
  strEmpresas := fRetEmpresasUsamPrecoMatriz;
  qryGenIte := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  ITE_PRECOM = :PRECOM, ';
  strSQL := strSQL + '  ITE_PREDOL = :PREDOL, ';
  strSQL := strSQL + '  ITE_DESF01 = :DESF01, ';
  strSQL := strSQL + '  ITE_DESF02 = :DESF02, ';
  strSQL := strSQL + '  ITE_DESF03 = :DESF03, ';
  strSQL := strSQL + '  ITE_DESF04 = :DESF04, ';
  strSQL := strSQL + '  ITE_DESF05 = :DESF05, ';
  strSQL := strSQL + '  ITE_DESF06 = :DESF06, ';
  strSQL := strSQL + '  ITE_ICMENT = :ICMENT, ';
  strSQL := strSQL + '  ITE_SUBFED = :SUBFED, ';
  strSQL := strSQL + '  ITE_IPIENT = :IPIENT, ';
  strSQL := strSQL + '  ITE_FREENT = :FREENT, ';
  strSQL := strSQL + '  ITE_VALFRE = :VALFRE, ';
  strSQL := strSQL + '  ITE_ACRFIN = :ACRFIN, ';
  strSQL := strSQL + '  ITE_SUBSTI = :SUBSTI, ';
  strSQL := strSQL + '  ITE_DESADB = :DESADB, ';
  strSQL := strSQL + '  ITE_PREALT = :PREALT, ';
  strSQL := strSQL + '  ITE_PRECUS = :PRECUS, ';
  strSQL := strSQL + '  ITE_TCIFCU = :TCIFCU, ';
  strSQL := strSQL + '  ITE_TSCUST = :TSCUST, ';
  strSQL := strSQL + '  ITE_DEPICO = :DEPICO, ';
  strSQL := strSQL + '  ITE_DEICMS = :DEICMS, ';
  strSQL := strSQL + '  ITE_FATREG = :FATREG  ';

  If Not blnResFor Then
  Begin
    strSQL := strSQL + ', ';

    If blnInfMat And (intInfSai = 1) Then
      strSQL := strSQL + '  ITE_ICMSAI = IF(:EMPLOG = ITE_CODEMP, :ICMSAI, ITE_ICMSAI), '
    Else
      strSQL := strSQL + '  ITE_ICMSAI = :ICMSAI, ';

    If blnInfMat And (intInfFed = 1) Then
      strSQL := strSQL + '  ITE_IMPFED = IF(:EMPLOG = ITE_CODEMP, :IMPFED, ITE_IMPFED), '
    Else
      strSQL := strSQL + '  ITE_IMPFED = :IMPFED, ';

    If blnInfMat And (intInfOpe = 1) Then
      strSQL := strSQL + '  ITE_DESOPE = IF(:EMPLOG = ITE_CODEMP, :DESOPE, ITE_DESOPE), '
    Else
      strSQL := strSQL + '  ITE_DESOPE = :DESOPE, ';

    strSQL := strSQL + '  ITE_OUTVAL = :OUTVAL, ';
    strSQL := strSQL + '  ITE_DESMAX = :DESMAX, ';
    strSQL := strSQL + '  ITE_DESMGE = :DESMGE, ';
    strSQL := strSQL + '  ITE_DESMSU = :DESMSU, ';

    For IntCont := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '  ITE_MARBR' + IntToStr(IntCont) + ' = :MARBR' + IntToStr(IntCont) + ', ';
      strSQL := strSQL + '  ITE_PREVE' + IntToStr(IntCont) + ' = :PREVE' + IntToStr(IntCont) + ', ';
      strSQL := strSQL + '  ITE_COMTB' + IntToStr(IntCont) + ' = :COMTB' + IntToStr(IntCont) + ', ';
    End;

    strSQL := strSQL + '  ITE_MARMIN = :MARMIN, ';
    strSQL := strSQL + '  ITE_IMPLIS = :IMPLIS  ';
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';

  If blnResFor Then
    strSQL := strSQL + '  LOCATE(ITE_CODEMP,:CODEMP) = 0 '
  Else
    strSQL := strSQL + '  LOCATE(ITE_CODEMP,:CODEMP) > 0 ';

  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('PREDOL').AsString := IIF(chkPreDol.Checked, 'S', 'N');
    ParamByName('PRECOM').AsFloat  := fStrToFloat(edtPreCom.Text);
    ParamByName('DESF01').AsFloat  := fStrToFloat(edtDesf01.Text);
    ParamByName('DESF02').AsFloat  := fStrToFloat(edtDesf02.Text);
    ParamByName('DESF03').AsFloat  := fStrToFloat(edtDesf03.Text);
    ParamByName('DESF04').AsFloat  := fStrToFloat(edtDesf04.Text);
    ParamByName('DESF05').AsFloat  := fStrToFloat(edtDesf05.Text);
    ParamByName('DESF06').AsFloat  := fStrToFloat(edtDesf06.Text);
    ParamByName('ICMENT').AsFloat  := fStrToFloat(edtIcmEnt.Text);
    ParamByName('SUBFED').AsFloat  := fStrToFloat(edtSubFed.Text);
    ParamByName('IPIENT').AsFloat  := fStrToFloat(edtIpiEnt.Text);
    ParamByName('FREENT').AsFloat  := fStrToFloat(edtFreEnt.Text);
    ParamByName('VALFRE').AsFloat  := fStrToFloat(edtValFre.Text);
    ParamByName('ACRFIN').AsFloat  := fStrToFloat(edtAcrFin.Text);
    ParamByName('SUBSTI').AsFloat  := fStrToFloat(edtSubsti.Text);
    ParamByName('DESADB').AsFloat  := fStrToFloat(edtDesAdb.Text);
    ParamByName('PRECUS').AsFloat  := fStrToFloat(edtPrecus.Text);
    ParamByName('TCIFCU').AsFloat  := fStrToFloat(edtTCIFCu.Text);
    ParamByName('TSCUST').AsFloat  := fStrToFloat(edtTSCust.Text);
    ParamByName('DEPICO').AsFloat  := fStrToFloat(edtDePiCo.Text);
    ParamByName('DEICMS').AsFloat  := fStrToFloat(edtDeICMS.Text);
    ParamByName('FATREG').AsFloat  := fStrToFloat(edtFatReg.Text);
    ParamByName('PREALT').AsString := strAgrupadorPreAlt;

    If Not blnResFor Then
    Begin

      ParamByName('OUTVAL').AsFloat  := fStrToFloat(edtOutVal.Text);
      ParamByName('IMPFED').AsFloat  := fStrToFloat(edtImpFed.Text);
      ParamByName('DESOPE').AsFloat  := fStrToFloat(edtDesOpe.Text);
      ParamByName('ICMSAI').AsFloat  := fStrToFloat(edtIcmSai.Text);

      ParamByName('DESMAX').AsFloat  := fStrToFloat(edtDesMax.Text);
      ParamByName('DESMGE').AsFloat  := fStrToFloat(edtDesMGe.Text);
      ParamByName('DESMSU').AsFloat  := fStrToFloat(edtDesMSu.Text);

      For IntCont := 1 To Length(VS_strTabPrc) Do
      Begin
        ParamByName('MARBR' + IntToStr(IntCont)).AsFloat := fStrToFloat(fEdtFocus('edtMarbr' + IntToStr(IntCont)).Text);
        ParamByName('PREVE' + IntToStr(IntCont)).AsFloat := fStrToFloat(fEdtFocus('edtPreve' + IntToStr(IntCont)).Text);
        ParamByName('COMTB' + IntToStr(IntCont)).AsFloat := fStrToFloat(fEdtFocus('edtComTb' + IntToStr(IntCont)).Text);
      End;

      ParamByName('MARMIN').AsFloat  := fStrToFloat(edtMarMin.Text);
      ParamByName('IMPLIS').AsString := edtImpLis.Text;

    End;

    ParamByName('CODITE').AsString := edtCodIte.Text;
    ParamByName('CODEMP').AsString := strEmpresas;

    If Params.FindParam('EMPLOG') <> Nil Then
      ParamByName('EMPLOG').AsString := VS_strCodEmp;

    ExecSQL;
    Close;

  End;

  If blnInfMat Then
    pRecalculaItensResponsavelFornecedor(strEmpresas, edtCodIte.Text, blnResFor);

  FreeAndNil(qryGenIte);
End;

Function TfrmAltPrecoProduto.fAlteraItem: Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

begin
  Try
    fStartTransaction;
    strAgrupadorPreAlt := '';
    pPreAltDefineVariaveisAltPre(fNow, 'ALTERACAO DE PRECOS POR PRODUTO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    pAlteraPrecoItem(False);

    If blnInfMat And fEhEmpresaResponsavelFornecedor(qryConIte.FieldByName('ITE_CODFOR').AsString) Then
      pAlteraPrecoItem(True);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'SET ';

    If (edtIteAti.Text = 'N') And (qryConIte.FieldByName('ITE_ITEATI').AsString = 'S') Then
      strSQL := strSQL + ' ITE_DTAINA = CURDATE(), '

    Else If (edtIteAti.Text = 'S') And (qryConIte.FieldByName('ITE_ITEATI').AsString = 'N') Then
      strSQL := strSQL + ' ITE_DTAINA = NULL, ';

    strSQL := strSQL + '  ITE_ITEATI = :ITEATI, ';
    strSQL := strSQL + '  ITE_DTAALT = :DTAALT  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    qryGenIte := fCriaQuery(Self);

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITEATI').AsString := edtIteAti.Text;
      ParamByName('CODITE').AsString := edtCodIte.Text;
      ParamByName('DTAALT').AsDate   := fNow;
      ExecSQL;
      Close;
    End;

    If Not fCfgSis('ILIEMP', varBoolean) Then
    Begin
      pAtualizaImpLisLojas;
    End;

    {*****************************************}
    {* GRAVA PREALT                          *}
    {**************************************MV*}
    If (Not VS_blnPreAltViaTrigger) Then
      Result := fGravaPreAlt(edtCodIte.Text,
                 qryConIte.FieldByName('ITE_PRECUS').AsFloat,
                 fStrToFloat(edtPrecus.Text),

                 qryConIte.FieldByName('ITE_PREVE1').AsFloat,
                 fStrToFloat(edtPreve1.Text),
                 qryConIte.FieldByName('ITE_MARBR1').AsFloat,
                 fStrToFloat(edtMarbr1.Text),

                 qryConIte.FieldByName('ITE_PREVE2').AsFloat,
                 fStrToFloat(edtPreve2.Text),
                 qryConIte.FieldByName('ITE_MARBR2').AsFloat,
                 fStrToFloat(edtMarbr2.Text),

                 qryConIte.FieldByName('ITE_PREVE3').AsFloat,
                 fStrToFloat(edtPreve3.Text),
                 qryConIte.FieldByName('ITE_MARBR3').AsFloat,
                 fStrToFloat(edtMarbr3.Text),

                 qryConIte.FieldByName('ITE_PREVE4').AsFloat,
                 fStrToFloat(edtPreve4.Text),
                 qryConIte.FieldByName('ITE_MARBR4').AsFloat,
                 fStrToFloat(edtMarbr4.Text),

                 qryConIte.FieldByName('ITE_PREVE5').AsFloat,
                 fStrToFloat(edtPreve5.Text),
                 qryConIte.FieldByName('ITE_MARBR5').AsFloat,
                 fStrToFloat(edtMarbr5.Text),

                 qryConIte.FieldByName('ITE_PREVE6').AsFloat,
                 fStrToFloat(edtPreve6.Text),
                 qryConIte.FieldByName('ITE_MARBR6').AsFloat,
                 fStrToFloat(edtMarbr6.Text),

                 qryConIte.FieldByName('ITE_PREVE7').AsFloat,
                 fStrToFloat(edtPreve7.Text),
                 qryConIte.FieldByName('ITE_MARBR7').AsFloat,
                 fStrToFloat(edtMarbr7.Text),

                 qryConIte.FieldByName('ITE_PRECOM').AsFloat,
                 fStrToFloat(edtPreCom.Text),

                 'ALTERACAO DE PRECOS POR PRODUTO',

                 Nil,
                 '',
                 strLoginUsuarioLogado)
    Else
      Result := True;


    pAtualizaItensGrupoPrecos(edtCodIte.Text, 'ALTERACAO DE PRECOS POR PRODUTO', strAgrupadorPreAlt);

    FreeAndNil(qryGenIte);

    If Result Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      strAgrupadorPreAlt := '';
      pMensagensErro(E.Message, '[TfrmAltPrecoProduto.fAlteraItem]');
    End;
  End;

end;

procedure TfrmAltPrecoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) And (ActiveControl.Parent = rdgTipAlt) Then
    SelectNext(ActiveControl, True, True);

  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
    Key := 0;
  End;
end;

procedure TfrmAltPrecoProduto.FormCreate(Sender: TObject);
begin
  inherited;

  blnMarNeg := fCfgSis('MARNEG', varBoolean);

  If fCfgSis('VENMAR', varInteger) = 2 Then
    rdgTipAlt.ItemIndex := 1;

  If fCfgSis('BLOPRE', varBoolean) Then
  Begin
    rdgTipAlt.Enabled := False;
    rdgTipAlt.Controls[0].Enabled := False;
    rdgTipAlt.Controls[1].Enabled := False;
    rdgTipAlt.ItemIndex := 1;
  End;

  qryConIte := fCriaQuery(Self);

  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);

  intDecUni := fCfgSis('DECUNI', varInteger);
  objFatPre := Nil;
  blnFatPre := fCfgSis('FATPRE', varBoolean);

  blnInfMat := fCfgSis('INFMAT', varBoolean);

  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);

  If blnFatPre Then
    objFatPre := TFatorPreco.Create;

  pAjustaFatorPreco(True);

  pTravaPrecos;

  strDesValFre := fCfgSis('DESVFR');
end;

procedure TfrmAltPrecoProduto.pTravaPrecos;
  Var
    intIndex: Integer;
Begin
  If fCfgSis('BLOPRE', VarBoolean) Then
  For intIndex := 1 to Length(VS_strTabPrc) do
  Begin
    fEdtFocus('edtMarBr' + IntToStr(intIndex)).ReadOnly    := True;
    fEdtFocus('edtMarBr' + IntToStr(intIndex)).TabStop     := False;
    fEdtFocus('edtMarBr' + IntToStr(intIndex)).Color       := $00FFDFB8;
    fEdtFocus('edtMarBr' + IntToStr(intIndex)).FocusColor  := $00FFDFB8;
    fEdtFocus('edtMarBr' + IntToStr(intIndex)).NormalColor := $00FFDFB8;

    fEdtFocus('edtPreVe' + IntToStr(intIndex)).ReadOnly    := True;
    fEdtFocus('edtPreVe' + IntToStr(intIndex)).TabStop     := False;
    fEdtFocus('edtPreVe' + IntToStr(intIndex)).Color       := $00FFDFB8;
    fEdtFocus('edtPreVe' + IntToStr(intIndex)).FocusColor  := $00FFDFB8;
    fEdtFocus('edtPreVe' + IntToStr(intIndex)).NormalColor := $00FFDFB8;
  End;
End;

procedure TfrmAltPrecoProduto.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);

end;

procedure TfrmAltPrecoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryPreAlt);
end;

function TfrmAltPrecoProduto.fInativarProduto: Boolean;
  Var
    qryTmpIteger: TUniQuery;
    strSQL      : String;
    strCodEmp   : String;
begin
  inherited;
  Result := True;

  If edtIteAti.Text = 'N' Then
  Begin
    qryTmpIteger := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' ITE_CODEMP, ITE_SALDOS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_SALDOS > 0 ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  ITE_CODEMP ';

    With qryTmpIteger Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodIte.Text;
      Open;

      strCodEmp := '';
      While Not Eof Do
      Begin
        strCodEmp := strCodEmp + FieldByName('ITE_CODEMP').AsString + ', ';
        Next;
      End;
      Close;
      FreeAndNil(qryTmpIteger);
    End;

    If strCodEmp <> '' Then
    Begin
      strCodEmp := Copy(strCodEmp, 1, Length(strCodEmp) - 2);
      fMensagem('', 'Este produto possui saldo na(s) empresa(s): ' + strCodEmp + '. ' + #13 + 'Não é possível inativa - lo !', ['&O K']);
      pSetFocus(edtIteAti);
      Result := False;
    End;
  End;

end;

procedure TfrmAltPrecoProduto.pAtualizaImpLisLojas;
  Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_IMPLIS = :IMPLIS ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  qryUpd.ParamByName('IMPLIS').AsString := edtImpLis.Text;
  qryUpd.ParamByName('CODITE').AsString := edtCodIte.Text;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

function TfrmAltPrecoProduto.fEdtFocus(strNome: String): TEditFocus;
begin
  Result := TEditFocus(Self.FindComponent(strNome));
end;

procedure pAtivarCampo(dbeEdit: TEditFocus; blnSomenteLeitura: Boolean = True);
Begin
  dbeEdit.ReadOnly := blnSomenteLeitura;
  dbeEdit.TabStop  := Not blnSomenteLeitura;
End;

Procedure TfrmAltPrecoProduto.pAjustaFatorPreco(blnDesabilita: Boolean);
Begin
  If blnFatPre Then
  Begin
    pAtivarCampo(edtMarBr2, objFatPre.fTabelaAtiva(2));
    pAtivarCampo(edtMarBr3, objFatPre.fTabelaAtiva(3));
    pAtivarCampo(edtMarBr4, objFatPre.fTabelaAtiva(4));
    pAtivarCampo(edtMarBr5, objFatPre.fTabelaAtiva(5));
    pAtivarCampo(edtMarBr6, objFatPre.fTabelaAtiva(6));
    pAtivarCampo(edtMarBr7, objFatPre.fTabelaAtiva(7));

    pAtivarCampo(edtPreVe2, objFatPre.fTabelaAtiva(2));
    pAtivarCampo(edtPreVe3, objFatPre.fTabelaAtiva(3));
    pAtivarCampo(edtPreVe4, objFatPre.fTabelaAtiva(4));
    pAtivarCampo(edtPreVe5, objFatPre.fTabelaAtiva(5));
    pAtivarCampo(edtPreVe6, objFatPre.fTabelaAtiva(6));
    pAtivarCampo(edtPreVe7, objFatPre.fTabelaAtiva(7));

    pAtivarCampo(edtComTb2, objFatPre.fTabelaAtiva(2));
    pAtivarCampo(edtComTb3, objFatPre.fTabelaAtiva(3));
    pAtivarCampo(edtComTb4, objFatPre.fTabelaAtiva(4));
    pAtivarCampo(edtComTb5, objFatPre.fTabelaAtiva(5));
    pAtivarCampo(edtComTb6, objFatPre.fTabelaAtiva(6));
    pAtivarCampo(edtComTb7, objFatPre.fTabelaAtiva(7));

    If blnDesabilita Then
    Begin
      edtMarBr2.Enabled := False;
      edtMarBr3.Enabled := False;
      edtMarBr4.Enabled := False;
      edtMarBr5.Enabled := False;
      edtMarBr6.Enabled := False;
      edtMarBr7.Enabled := False;

      edtPreVe2.Enabled := False;
      edtPreVe3.Enabled := False;
      edtPreVe4.Enabled := False;
      edtPreVe5.Enabled := False;
      edtPreVe6.Enabled := False;
      edtPreVe7.Enabled := False;

      edtComTb2.Enabled := False;
      edtComTb3.Enabled := False;
      edtComTb4.Enabled := False;
      edtComTb5.Enabled := False;
      edtComTb6.Enabled := False;
      edtComTb7.Enabled := False;
    End;

  End;
End;

Procedure TfrmAltPrecoProduto.pRecalculaPrecosFator;
  Var
    intContador: Integer;
Begin
  If Not blnFatPre Then
    Exit;

  For intContador := 2 To 7 Do
  Begin
    If Not objFatPre.fTabelaAtiva(intContador) Then
      Continue;

    fEdtFocus('edtPreVe' + IntToStr(intContador)).Text :=
      FormatFloat(fMskDigitos(intDecUni),
         objFatPre.fCalculaPrecoVendaFator(fStrToFloat(edtPreVe1.Text), intContador));

    fEdtFocus('edtMarBr' + IntToStr(intContador)).Text :=
      FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),
         fCalculaPrecoVenda(2,
                            fStrToFloat(edtPreCus.Text) + fStrToFloat(edtOutVal.Text),
                            fStrToFloat(fEdtFocus('edtPreVe' + IntToStr(intContador)).Text),
                            fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intContador)).Text),
                            fStrToFloat(edtIcmSai.Text),
                            fStrToFloat(edtImpFed.Text),
                            fStrToFloat(edtDesOpe.Text),
                            fStrToFloat(fEdtFocus('edtComTb' + IntToStr(intContador)).Text)));

  End;
End;

end.


