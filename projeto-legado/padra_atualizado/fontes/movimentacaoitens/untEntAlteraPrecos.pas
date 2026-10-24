unit untEntAlteraPrecos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  Grids, DBGridCitel, DBGrids, Mask, DBCtrls, EditFocus, {Qt,} DB, Menus,
  AppEvnts, cxControls, cxContainer, cxEdit, cxGroupBox, untFatorPreco,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, frxClass, frxExportCSVTestabilidade;


type
  TfrmEntAlteraPrecos = class(TfrmPaiSimples)
    pnlPrecos: TPanel;
    pnlBotoesEnt: TPanel;
    dbgItens: TDBGridCitel;
    pnlTitulo: TPanel;
    pnlTipAlt: TPanel;
    rdgTipAlt: TRadioGroup;
    Panel1: TPanel;
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
    Label16: TLabel;
    edtDesf03: TEditFocus;
    Label35: TLabel;
    Label1: TLabel;
    edtImpFed: TEditFocus;
    Label2: TLabel;
    Label17: TLabel;
    edtDesf04: TEditFocus;
    Label36: TLabel;
    Label6: TLabel;
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
    Label22: TLabel;
    edtFreEnt: TEditFocus;
    Label41: TLabel;
    Label23: TLabel;
    edtAcrFin: TEditFocus;
    Label42: TLabel;
    Panel2: TPanel;
    Panel6: TPanel;
    lblDesMax: TLabel;
    edtDesMax: TEditFocus;
    lblMarMin: TLabel;
    edtMarMin: TEditFocus;
    gpbUltCompra: TGroupBox;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label94: TLabel;
    Label93: TLabel;
    edtUltCom: TEditFocus;
    edtQtdUco: TEditFocus;
    edtPreUlt: TEditFocus;
    edtPreMed: TEditFocus;
    edtNomUltFor: TEditFocus;
    lblValFre: TLabel;
    edtValFre: TEditFocus;
    lblDesAdi: TLabel;
    Label9: TLabel;
    edtDesAdb: TEditFocus;
    Label10: TLabel;
    edtSubFed: TEditFocus;
    Label11: TLabel;
    lblOutVal: TLabel;
    edtOutVal: TEditFocus;
    lblTabPre: TLabel;
    gpbTabPre05: TcxGroupBox;
    Label54: TLabel;
    lblMarBr5: TLabel;
    Label61: TLabel;
    lblTitComTb5: TLabel;
    lblPerComTb5: TLabel;
    gpbTabPre06: TcxGroupBox;
    Label63: TLabel;
    lblMarBr6: TLabel;
    Label65: TLabel;
    lblTitComTb6: TLabel;
    lblPerComTb6: TLabel;
    gpbTabPre07: TcxGroupBox;
    Label125: TLabel;
    Label126: TLabel;
    Label123: TLabel;
    lblTitComTb7: TLabel;
    lblPerComTb7: TLabel;
    pnl1: TPanel;
    Panel3: TPanel;
    gpbTabPre01: TcxGroupBox;
    lblTitMarBr1: TLabel;
    lblTitPreVe1: TLabel;
    lblMarBr1: TLabel;
    lblTitComTb1: TLabel;
    lblPerComTb1: TLabel;
    gpbTabPre02: TcxGroupBox;
    lblTitMarBr2: TLabel;
    lblTitPreVe2: TLabel;
    lblMarBr2: TLabel;
    lblTitComTb2: TLabel;
    lblPerComTb2: TLabel;
    gpbTabPre03: TcxGroupBox;
    lblMarBr3: TLabel;
    lblTitMarBr3: TLabel;
    lblTitPreVe3: TLabel;
    lblTitComTb3: TLabel;
    lblPerComTb3: TLabel;
    gpbTabPre04: TcxGroupBox;
    lblTitMarBr4: TLabel;
    lblMarBr4: TLabel;
    lblTitPreVe4: TLabel;
    lblTitComTb4: TLabel;
    lblPerComTb4: TLabel;
    edtComTb1: TEditFocus;
    edtMarBr1: TEditFocus;
    edtPreVe1: TEditFocus;
    edtComTb2: TEditFocus;
    edtMarBr2: TEditFocus;
    edtPreVe2: TEditFocus;
    edtComTb3: TEditFocus;
    edtMarBr3: TEditFocus;
    edtPreVe3: TEditFocus;
    edtComTb4: TEditFocus;
    edtMarBr4: TEditFocus;
    edtPreVe4: TEditFocus;
    edtComTb5: TEditFocus;
    edtMarBr5: TEditFocus;
    edtPreVe5: TEditFocus;
    edtComTb6: TEditFocus;
    edtMarBr6: TEditFocus;
    edtPreVe6: TEditFocus;
    edtComTb7: TEditFocus;
    edtMarBr7: TEditFocus;
    edtPreVe7: TEditFocus;
    Label4: TLabel;
    edtClaIpi: TEditFocus;
    Label137: TLabel;
    edtComLiq: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnUltCmp: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    pnlSuframa: TPanel;
    edtFatReg: TEditFocus;
    edtDeICMS: TEditFocus;
    edtDePiCo: TEditFocus;
    edtTSCust: TEditFocus;
    edtTCIFCu: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnUltCmpClick(Sender: TObject);
    procedure edtMarBr1Exit(Sender: TObject);
    procedure edtMarBr1Enter(Sender: TObject);
  private
    { Private declarations }
    strDesValFre: String;

    blnPrecoJaMultiplicado,
    blnConvertePreco: Boolean;
    intDecUni: Integer;
    blnFatPre: Boolean;
    objFatPre: TFatorPreco;

    procedure pRecalculaPrecos(intPreMar: Integer);
    Procedure pRecalculaPrecosFator;

    procedure pAtualizaTabela;
    procedure pAtualizaEdits(DataSet: TDataSet);
    procedure pLimpaEdits;

    procedure pAtualizaItem;

    procedure pDadosUltimaCompra(strCodite: String);

    function fRetPrecoCusto(fltPreCom: Double): Double;
    function fRetPrecoVenda(intOpcao, intNumPreVen: Integer): Double;
    procedure pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);

    function fEdtFocus(strNome: String): TEditFocus;
    procedure pAtualizaDecUni;
    Procedure pAjustaFatorPreco(blnDesabilita: Boolean);

    procedure pTravaPrecos;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodFor: String;
    qryEntMer: TUniQuery;
    dtsEntMer: TDataSource;
  end;


implementation

uses untfuncoesSimples, untConstantes,
     untParCalculaPrecoCusto, untTConfiguracao, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmEntAlteraPrecos }

function TfrmEntAlteraPrecos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O PREÇO DE COMPRA              *}
    {**************************************MV*}
    If (Sender = edtPreCom) Then
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
        (Sender As TEditFocus).Text := '0';
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
        edtIcmEnt.Text := '0';
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
        edtSubFed.Text := '0';
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
        edtIcmSai.Text := '0';
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
        edtIpiEnt.Text := '0';
      End;

    End

    Else If (Sender = edtFreEnt) Then
    Begin
      If Not fEmptyStr(edtFreEnt.Text) Then
      Begin
        If Not fValidaEscala(edtFreEnt.Text, 0, 1000) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Frete deve estar entre 0 e 1000!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtFreEnt.Text := '0';
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
        edtValFre.Text := '0';
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
        edtAcrFin.Text := '0';
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
        edtDesMax.Text := '0';
      End;

    End

    Else If (Sender = edtClaIpi) Then
    Begin
      If Not fEmptyStr(edtClaIpi.Text) And (Length(edtClaIpi.Text) <> MAX_CLAIPI) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
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
        edtSubsti.Text := '0';
      End;

    End

    Else If (Sender = edtDesAdb) Then
    Begin
      If Not fEmptyStr(edtDesAdb.Text) Then
      Begin
        If Not fValidaEscala(edtDesAdb.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo ' + fCfgSis('DESADI') + ' deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        edtDesAdb.Text := '0';
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
          fMensagem('ATENÇÃO!', 'O TCIF deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtTCIFCu.Text := '0';
      End;

    End

    Else If (Sender = edtTSCust) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtTSCust.Text) Then
      Begin
        If Not fValidaEscala(edtTSCust.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O TS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtTSCust.Text := '0';
      End;

    End

    Else If (Sender = edtDePiCo) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtDePiCo.Text) Then
      Begin
        If Not fValidaEscala(edtDePiCo.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O desconto PIS/COFINS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDePiCo.Text := '0';
      End;

    End

    Else If (Sender = edtDeICMS) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtDeICMS.Text) Then
      Begin
        If Not fValidaEscala(edtDeICMS.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O desconto ICMS deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDeICMS.Text := '0';
      End;

    End

    Else If (Sender = edtFatReg) And (pnlSuframa.Visible) Then
    Begin
      If Not fEmptyStr(edtFatReg.Text) Then
      Begin
        If Not fValidaEscala(edtFatReg.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O fator regional deve estar entre 0 e 100!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtFatReg.Text := '0';
      End;

    End

    Else If (Sender Is TEditFocus) And
            (Pos('EDTMARBR', UpperCase(TEditFocus(Sender).Name)) > 0) Then
    Begin
      If Not fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        If fStrToFloat(TEditFocus(Sender).Text) > MAX_VALMON Then
        Begin
          TEditFocus(Sender).Text := FloatToStr(MAX_VALMON);
        End;
      End;

      If Result Then
      Begin
        If rdgTipAlt.ItemIndex In [0] Then
          //TEditFocus(Sender).Text := FloatToStrF(fRetPrecoVenda(1, XX), ffFixed, 12, 2);
      End;

    End

    Else If (Sender Is TEditFocus) And
            (Pos('EDTCOMTB', UpperCase(TEditFocus(Sender).Name)) > 0) And
            (fCfgSis('PCMPRO') <> '1') Then
    Begin
      If Not fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        If Not fValidaEscala(TEditFocus(Sender).Text, 0, 100) Then
        Begin
          if fCfgSis('PCMPRO') = '2' Then {Comissão}
            fMensagem('','O percentual de comissão deve estar entre 0 e 100!', ['&Ok'])
          else if fCfgSis('PCMPRO') = '3' Then {Acrescimo}
            fMensagem('','O percentual de ' + fCfgSis('TCOMTB') + ' deve estar entre 0 e 100!', ['&Ok']);

          Result := False;
        End;
      End
      Else
        TEditFocus(Sender).Text := '0,00';
    End

    Else If (Sender Is TEditFocus) And
            (Pos('EDTPREVE', UpperCase(TEditFocus(Sender).Name)) > 0) Then
    Begin
      If rdgTipAlt.ItemIndex In [1] Then
        //TEditFocus(Sender).Text := FloatToStrF(fRetPrecoVenda(2, XX), ffFixed, 12, 2);
    End;

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End
  Else 
  Begin
    pRecalculaPrecos(rdgTipAlt.ItemIndex);
  End;
end;

procedure TfrmEntAlteraPrecos.pRecalculaPrecos(intPreMar: Integer);
  Var
    intTabPre: Integer;
begin

  If intPreMar In [0,1] Then
    edtPreCus.Text := FloatToStrF(fRetPrecoCusto(fStrToFloat(edtPreCom.Text)), ffFixed, 12, intDecUni);

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    Case intPreMar Of
      0: fEdtFocus('edtPreVe' + IntToStr(intTabPre)).Text := FloatToStrF(fRetPrecoVenda(1, intTabPre), ffFixed, 12, intDecUni);
      1: fEdtFocus('edtMarBr' + IntToStr(intTabPre)).Text := FloatToStrF(fRetPrecoVenda(2, intTabPre), ffFixed, 12, fRetPrecisaoMargemItem);
    End;
  End;

  pRecalculaPrecosFator;

  edtComLiq.Text := FormatFloat(fMskDigitos(intDecUni),
                    fCalculaPrecoCompraLiq(fStrToFloat(edtPreCom.Text),
                                   fStrToFloat(edtDesf01.Text),
                                   fStrToFloat(edtDesf02.Text),
                                   fStrToFloat(edtDesf03.Text),
                                   fStrToFloat(edtDesf04.Text),
                                   fStrToFloat(edtDesf05.Text),
                                   fStrToFloat(edtDesf06.Text)));
  
end;

function TfrmEntAlteraPrecos.fRetPrecoVenda(intOpcao, intNumPreVen: Integer): Double;
  Var
    intTabPre: Integer;
begin

  For intTabPre := 0 To Length(VS_strTabPrc) Do
  Begin
    If fEmptyStr(fEdtFocus('edtPreVe' + IntToStr(intTabPre)).Text) Then
      fEdtFocus('edtPreVe' + IntToStr(intTabPre)).Text := '0,00';

    If fEmptyStr(fEdtFocus('edtMarBr' + IntToStr(intTabPre)).Text) Then
      fEdtFocus('edtMarBr' + IntToStr(intTabPre)).Text := '0,00';

    If fEmptyStr(fEdtFocus('edtComTb' + IntToStr(intTabPre)).Text) Then
      fEdtFocus('edtComTb' + IntToStr(intTabPre)).Text := '0,00';

  End;

  If intNumPreVen In [1..Length(VS_strTabPrc)] Then
  Begin
    If (intOpcao = 2 {Margem}) Or (Not blnFatPre) Or (intNumPreVen = 1) Then
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

function TfrmEntAlteraPrecos.fRetPrecoCusto(fltPreCom: Double): Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fStrToFloat(edtDesf01.Text);
      curDesF02 := fStrToFloat(edtDesf02.Text);
      curDesF03 := fStrToFloat(edtDesf03.Text);
      curDesF04 := fStrToFloat(edtDesf04.Text);
      curDesF05 := fStrToFloat(edtDesf05.Text);
      curDesF06 := fStrToFloat(edtDesf06.Text);
      curICMSEnt:= fStrToFloat(edtIcmEnt.Text);
      curIPIEnt := fStrToFloat(edtIpiEnt.Text);
      curFrete  := fStrToFloat(edtFreEnt.Text);
      curAcrFin := fStrToFloat(edtAcrFin.Text);
      curSubsti := fStrToFloat(edtSubsti.Text);
      curValFre := fStrToFloat(edtValFre.Text);
      curDesAdb := fStrToFloat(edtDesAdb.Text);
      curSubFed := fStrToFloat(edtSubFed.Text);

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
    Result := cpcParams.fCalculaPrecoCusto();

  Finally
    FreeAndNil(cpcParams);
  End;

end;

procedure TfrmEntAlteraPrecos.pAtualizaEdits(DataSet: TDataSet);
  Var
    intTabPre: Integer;  
    fltUnitar: Double;  
begin
  blnConvertePreco       := False;
  blnPrecoJaMultiplicado := False;

  With qryEntMer Do
  Begin

    If (Not fCfgSis('ALTPEN', varBoolean)) Then
    Begin
      // PODE TER VINDO O PREÇO DO CADASTRO DE PRODUTO OU O PREÇO DIGITADO NA ENTRADA DE MERCADORIAS
      blnPrecoJaMultiplicado := fCfgSis('ATPRAU', varBoolean) And ((Pos(strCodFor, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean)));
      edtPreCom.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('ENT_PRECOM').AsFloat);
    End Else
    Begin
      fltUnitar := FieldByName('ENT_UNITAR').AsFloat;

      If (FieldByName('ENT_EMBALA').AsFloat > 0) And (fCfgSis('CNVEMB') <> 'N') Then
      Begin
        fltUnitar := fltUnitar / FieldByName('ENT_EMBALA').AsFloat;
        blnConvertePreco := True;
      End;

      edtPreCom.Text := FormatFloat(fMskDigitos(intDecUni), fltUnitar);
    End;

    edtDesf01.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESF01').AsFloat);
    edtDesf02.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESF02').AsFloat);
    edtDesf03.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESF03').AsFloat);
    edtDesf04.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESF04').AsFloat);
    edtDesf05.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESF05').AsFloat);
    edtDesf06.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESF06').AsFloat);
    edtIcmEnt.Text := FormatFloat('#,##0.00',  FieldByName('ENT_ICMENT').AsFloat);
    edtSubFed.Text := FormatFloat('#,##0.00',  FieldByName('ENT_SUBFED').AsFloat);
    edtIpiEnt.Text := FormatFloat('#,##0.00',  FieldByName('ENT_IPIENT').AsFloat);
    edtFreEnt.Text := FormatFloat('#,##0.00',  FieldByName('ENT_FREENT').AsFloat);
    edtValFre.Text := FormatFloat(fMskDigitos(intDecUni),  FieldByName('ENT_FREITE').AsFloat);
    edtAcrFin.Text := FormatFloat('#,##0.00',  FieldByName('ENT_ACRFIN').AsFloat);
    edtSubsti.Text := FormatFloat('#,##0.00',  FieldByName('ENT_SUBSTI').AsFloat);
    edtDesAdb.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESADB').AsFloat);
    edtOutVal.Text := FormatFloat('#,##0.000', FieldByName('ENT_OUTVAL').AsFloat);
    edtImpFed.Text := FormatFloat('#,##0.00',  FieldByName('ENT_IMPFED').AsFloat);
    edtDesOpe.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESOPE').AsFloat);
    edtIcmSai.Text := FormatFloat('#,##0.00',  FieldByName('ENT_ICMSAI').AsFloat);
    edtDesMax.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DESMAX').AsFloat);
    edtMarMin.Text := FormatFloat('#,##0.00',  FieldByName('ENT_MARMIN').AsFloat);
    edtTCIFCu.Text := FormatFloat('#,##0.00',  FieldByName('ENT_TCIFCU').AsFloat);
    edtTSCust.Text := FormatFloat('#,##0.00',  FieldByName('ENT_TSCUST').AsFloat);
    edtDePiCo.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DEPICO').AsFloat);
    edtDeICMS.Text := FormatFloat('#,##0.00',  FieldByName('ENT_DEICMS').AsFloat);
    edtFatReg.Text := FormatFloat('#,##0.00',  FieldByName('ENT_FATREG').AsFloat);

    edtClaIpi.Text := FieldByName('ENT_CLAIPI').AsString;

    If blnConvertePreco Then
    Begin
      edtPreCus.Text := FormatFloat(fMskDigitos(intDecUni), fRetPrecoCusto(fStrToFloat(edtPreCom.Text)));
    End Else
    Begin
      edtPreCus.Text := FormatFloat(fMskDigitos(intDecUni),  FieldByName('ENT_PRECUS').AsFloat);
    End;

    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      fEdtFocus('edtMarBr' + IntToStr(intTabPre)).Text := FormatFloat(fMskDigitos(fRetPrecisaoMargemItem),  FieldByName('ENT_MARBR' + IntToStr(intTabPre)).AsFloat);
      fEdtFocus('edtPreVe' + IntToStr(intTabPre)).Text := FormatFloat(fMskDigitos(intDecUni),  FieldByName('ENT_PREVE' + IntToStr(intTabPre)).AsFloat);
      fEdtFocus('edtComTb' + IntToStr(intTabPre)).Text := FormatFloat('#,##0.00',  FieldByName('ENT_COMTB' + IntToStr(intTabPre)).AsFloat);
    End;

    pDadosUltimaCompra(FieldByName('ENT_CODITE').AsString);

    edtComLiq.Text := FormatFloat(fMskDigitos(intDecUni),
                      fCalculaPrecoCompraLiq(fStrToFloat(edtPreCom.Text),
                                             FieldByName('ENT_DESF01').AsFloat,
                                             FieldByName('ENT_DESF02').AsFloat,
                                             FieldByName('ENT_DESF03').AsFloat,
                                             FieldByName('ENT_DESF04').AsFloat,
                                             FieldByName('ENT_DESF05').AsFloat,
                                             FieldByName('ENT_DESF06').AsFloat));

    If blnConvertePreco Then
      pRecalculaPrecos(0);

  End;

end;

procedure TfrmEntAlteraPrecos.pAtualizaItem;
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;
    intTabPre: Integer;
begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ENT_PRECOM = :PRECOM , ';
    strSQL := strSQL + '  ENT_DESF01 = :DESF01 , ';
    strSQL := strSQL + '  ENT_DESF02 = :DESF02 , ';
    strSQL := strSQL + '  ENT_DESF03 = :DESF03 , ';
    strSQL := strSQL + '  ENT_DESF04 = :DESF04 , ';
    strSQL := strSQL + '  ENT_DESF05 = :DESF05 , ';
    strSQL := strSQL + '  ENT_DESF06 = :DESF06 , ';
    strSQL := strSQL + '  ENT_ICMENT = :ICMENT , ';
    strSQL := strSQL + '  ENT_SUBFED = :SUBFED , ';
    strSQL := strSQL + '  ENT_IPIENT = :IPIENT , ';
    strSQL := strSQL + '  ENT_FREENT = :FREENT , ';
    strSQL := strSQL + '  ENT_FREITE = :VALFRE , ';
    strSQL := strSQL + '  ENT_ACRFIN = :ACRFIN , ';
    strSQL := strSQL + '  ENT_SUBSTI = :SUBSTI , ';
    strSQL := strSQL + '  ENT_DESADB = :DESADB , ';
    strSQL := strSQL + '  ENT_OUTVAL = :OUTVAL , ';    
    strSQL := strSQL + '  ENT_IMPFED = :IMPFED , ';
    strSQL := strSQL + '  ENT_DESOPE = :DESOPE , ';
    strSQL := strSQL + '  ENT_PRECUS = :PRECUS , ';
    strSQL := strSQL + '  ENT_ICMSAI = :ICMSAI , ';
    strSQL := strSQL + '  ENT_DESMAX = :DESMAX , ';
    strSQL := strSQL + '  ENT_TCIFCU = :TCIFCU , ';
    strSQL := strSQL + '  ENT_TSCUST = :TSCUST , ';
    strSQL := strSQL + '  ENT_DEPICO = :DEPICO , ';
    strSQL := strSQL + '  ENT_DEICMS = :DEICMS , ';
    strSQL := strSQL + '  ENT_FATREG = :FATREG , ';

    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '  ENT_MARBR' + IntToStr(intTabPre) + ' = :MARBR' + IntToStr(intTabPre) + ' , ';
      strSQL := strSQL + '  ENT_PREVE' + IntToStr(intTabPre) + ' = :PREVE' + IntToStr(intTabPre) + ' , ';
      strSQL := strSQL + '  ENT_COMTB' + IntToStr(intTabPre) + ' = :COMTB' + IntToStr(intTabPre) + ' , ';      
    End;

    strSQL := strSQL + '  ENT_MARMIN = :MARMIN , ';
    strSQL := strSQL + '  ENT_CLAIPI = :CLAIPI , ';
    strSQL := strSQL + '  ENT_ITE_F5 = :ITE_F5,  ';
    strSQL := strSQL + '  ENT_EMB_F5 = :EMB_F5   ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    With qryGenMer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      {*****************************************}
      {* DADOS QUE SERÃO ATUALIZADOS           *}
      {**************************************MV*}
      // O PREÇO DE COMPRA SERÁ DIVIDIDO NOVAMENTE ANTES DA GRAVAÇÃO
      If blnConvertePreco Then
      Begin
        ParamByName('PRECOM').AsFloat  := fStrToFloat(edtPreCom.Text) * qryEntMer.FieldByName('ENT_EMBALA').AsFloat;
        ParamByName('EMB_F5').AsString := 'S';
      End Else
      Begin
        ParamByName('PRECOM').AsFloat := fStrToFloat(edtPreCom.Text);
        If blnPrecoJaMultiplicado Then
          ParamByName('EMB_F5').AsString := 'S'
        Else
          ParamByName('EMB_F5').AsString := 'N';
      End;

      ParamByName('DESF01').AsFloat := fStrToFloat(edtDesf01.Text);
      ParamByName('DESF02').AsFloat := fStrToFloat(edtDesf02.Text);
      ParamByName('DESF03').AsFloat := fStrToFloat(edtDesf03.Text);
      ParamByName('DESF04').AsFloat := fStrToFloat(edtDesf04.Text);
      ParamByName('DESF05').AsFloat := fStrToFloat(edtDesf05.Text);
      ParamByName('DESF06').AsFloat := fStrToFloat(edtDesf06.Text);
      ParamByName('ICMENT').AsFloat := fStrToFloat(edtIcmEnt.Text);
      ParamByName('SUBFED').AsFloat := fStrToFloat(edtSubFed.Text);
      ParamByName('IPIENT').AsFloat := fStrToFloat(edtIpiEnt.Text);
      ParamByName('FREENT').AsFloat := fStrToFloat(edtFreEnt.Text);
      ParamByName('VALFRE').AsFloat := fStrToFloat(edtValFre.Text);
      ParamByName('ACRFIN').AsFloat := fStrToFloat(edtAcrFin.Text);
      ParamByName('SUBSTI').AsFloat := fStrToFloat(edtSubsti.Text);
      ParamByName('DESADB').AsFloat := fStrToFloat(edtDesAdb.Text);
      ParamByName('OUTVAL').AsFloat := fStrToFloat(edtOutVal.Text);
      ParamByName('IMPFED').AsFloat := fStrToFloat(edtImpFed.Text);
      ParamByName('DESOPE').AsFloat := fStrToFloat(edtDesOpe.Text);
      ParamByName('TCIFCU').AsFloat := fStrToFloat(edtTCIFCu.Text);
      ParamByName('TSCUST').AsFloat := fStrToFloat(edtTSCust.Text);
      ParamByName('DEPICO').AsFloat := fStrToFloat(edtDePiCo.Text);
      ParamByName('DEICMS').AsFloat := fStrToFloat(edtDeICMS.Text);
      ParamByName('FATREG').AsFloat := fStrToFloat(edtFatReg.Text);

      If blnConvertePreco Then
      Begin
        ParamByName('PRECUS').AsFloat := fRetPrecoCusto(ParamByName('PRECOM').AsFloat / qryEntMer.FieldByName('ENT_EMBALA').AsFloat);
      End Else
      Begin
        ParamByName('PRECUS').AsFloat := fStrToFloat(edtPreCus.Text);
      End;
      
      ParamByName('ICMSAI').AsFloat := fStrToFloat(edtIcmSai.Text);
      ParamByName('DESMAX').AsFloat := fStrToFloat(edtDesMax.Text);

      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        ParamByName('MARBR' + IntToStr(intTabPre)).AsFloat := fStrToFloat(fedtFocus('edtMarBr' + IntToStr(intTabPre)).Text);

        If blnConvertePreco Then
        Begin
          ParamByName('PREVE' + IntToStr(intTabPre)).AsFloat :=
                    fCalculaPrecoVenda(1,
                                       ParamByName('PRECUS').AsFloat + fStrToFloat(edtOutVal.Text),
                                       0,
                                       fStrToFloat(fEdtFocus('edtMarBr' + IntToStr(intTabPre)).Text),
                                       fStrToFloat(edtIcmSai.Text),
                                       fStrToFloat(edtImpFed.Text),
                                       fStrToFloat(edtDesOpe.Text),
                                       fStrToFloat(fEdtFocus('edtComTb' + IntToStr(intTabPre)).Text));
        End Else
        Begin
          ParamByName('PREVE' + IntToStr(intTabPre)).AsFloat := fStrToFloat(fedtFocus('edtPreVe' + IntToStr(intTabPre)).Text);
        End;

        ParamByName('COMTB' + IntToStr(intTabPre)).AsFloat := fStrToFloat(fedtFocus('edtComTb' + IntToStr(intTabPre)).Text);
      End;

      ParamByName('MARMIN').AsFloat  := fStrToFloat(edtMarMin.Text);
      ParamByName('CLAIPI').AsString := edtClaIpi.Text;
      ParamByName('ITE_F5').AsString := qryEntMer.FieldByName('ENT_CODITE').AsString;

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      ParamByName('AUTINC').AsInteger := qryEntMer.FieldByName('AUTOINCREM').AsInteger;
      ExecSQL;
      Close;

    End;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntAlteraPrecos.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pHabilitaCampos(pnlPrecos, True);
    pSetFocus((rdgTipAlt.Controls[rdgTipAlt.ItemIndex] As TWinControl));
  End
  Else If (Key = VK_Escape) Then
  Begin
    Close;
  End;
end;

procedure TfrmEntAlteraPrecos.edtMarBr1Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TEdit Then
    pSelectAll(TEdit(Sender));
end;

procedure TfrmEntAlteraPrecos.edtMarBr1Exit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(TEditFocus(Sender).Text) Then
    TEditFocus(Sender).SelStart := 1;
end;

procedure TfrmEntAlteraPrecos.btnConfirmaClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;
  Screen.Cursor := crHourGlass;
  intRecNo      := qryEntMer.RecNo;

  If fVerificaCampos Then
  Begin

    pRecalculaPrecos(rdgTipAlt.ItemIndex);
    pAtualizaItem;
    pLimpaEdits;
    pAtualizaTabela;
    pSetFocus(dbgItens);
    pHabilitaCampos(pnlPrecos, False);

    qryEntMer.RecNo := intRecNo;

  End;

  Screen.Cursor := crDefault;
end;

procedure TfrmEntAlteraPrecos.btnUltCmpClick(Sender: TObject);
begin

  inherited;

  If fItemEstrutura(qryEntMer.FieldByName('ENT_CODITE').AsString) Then
  Begin
    pMensagemOk('Item Estrutura');
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(194, 7491, [],
                        ['CODITE','CODFOR','CODEMP'],
                        [qryEntMer.FieldByName('ENT_CODITE').AsString,
                        strCodFor,
                        VS_strCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmEntAlteraPrecos.pLimpaEdits;
  Var
    intTabPre: Integer;
begin
  edtPreCom.Clear;
  edtDesf01.Clear;
  edtDesf02.Clear;
  edtDesf03.Clear;
  edtDesf04.Clear;
  edtDesf05.Clear;
  edtDesf06.Clear;
  edtIcmEnt.Clear;
  edtSubFed.Clear;
  edtIpiEnt.Clear;
  edtFreEnt.Clear;
  edtValFre.Clear;
  edtAcrFin.Clear;
  edtSubsti.Clear;
  edtDesAdb.Clear;
  edtImpFed.Clear;
  edtOutVal.Clear;
  edtDesOpe.Clear;
  edtPreCus.Clear;
  edtIcmSai.Clear;
  edtDesMax.Clear;
  edtTCIFCu.Clear;
  edtTSCust.Clear;
  edtDePiCo.Clear;
  edtDeICMS.Clear;
  edtFatReg.Clear;

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    fEdtFocus('edtMarBr' + IntToStr(intTabPre)).Clear;
    fEdtFocus('edtPreVe' + IntToStr(intTabPre)).Clear;
    fEdtFocus('edtComTb' + IntToStr(intTabPre)).Clear;    
  End;

  edtUltCom.Clear;
  edtQtdUco.Clear;
  edtPreUlt.Clear;
  edtPreMed.Clear;
  edtNomUltFor.Clear;
end;

procedure TfrmEntAlteraPrecos.pEscapePressed;
begin

  If dbgItens.Focused Then
  Begin
    inherited;
  End
  Else
  Begin
    pSetFocus(dbgItens);
    pHabilitaCampos(pnlPrecos, False);
    pAtualizaEdits(Nil);
  End;
end;

procedure TfrmEntAlteraPrecos.pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
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


procedure TfrmEntAlteraPrecos.FormShow(Sender: TObject);
  Var
    intTabPre: Integer;
    blnPerCom,
    blnPerAcres : Boolean;
begin
  inherited;

  If Pos(fCfgSis('MARMKP'), '1_5_') = 0 Then
  Begin
    For intTabPre := 1 To Length(VS_strTabPrc) Do
      If Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre)) <> Nil Then
        TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre))).Caption := 'Markup:';
  End;

  pHabilitaCampos(pnlPrecos, False);

  {******************************************}
  {* QUANDO UTILIZAR ESSE RECURSO, NÃO      *}
  {* ESQUECER DE "LIMPAR" O EVENTO, OU SEJA *}
  {* ATRIBUIR NIL AO EVENTO. VER (*) NO E-  *}
  {* VENTO "OnClose"                        *}
  {* AO FAZE-LO, FAVOR COLOCAR ESSE COMEN-  *}
  {* TARIO                                  *}
  {***************************************MV*}
  {* A QUERY"qryEntMer" NAO PODE SER CRIADA *}
  {* NESTE FORM, POIS ESTA SENDO ATRIBUIDA  *}
  {* PELO FORM "frmEntMercadorias"          *}
  {***************************************AN*}
  qryEntMer.AfterScroll := pAtualizaEdits;
  dtsEntMer := fCriaDataSource(qryEntMer);
  dbgItens.DataSource := dtsEntMer;
  pAtualizaEdits(Nil);


  If fCfgSis('BLOPRE', varBoolean) Then
  Begin
    rdgTipAlt.Enabled := False;
    rdgTipAlt.Controls[0].Enabled := False;
    rdgTipAlt.Controls[1].Enabled := False;
    rdgTipAlt.ItemIndex := 1;
  End Else
  Begin
    rdgTipAlt.ItemIndex := 0;
  End;

  blnPerCom   := (fCfgSis('PCMPRO') = '2');
  blnPerAcres := (fCfgSis('PCMPRO') = '3');

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTabPre] = 'S' Then
    Begin
      If blnPerCom Then
        TLabel     (Self.FindComponent('lblTitComTb' + IntToStr(intTabPre))).Caption := 'Comissão:'
      Else If blnPerAcres Then
        TLabel     (Self.FindComponent('lblTitComTb' + IntToStr(intTabPre))).Caption := fCfgSis('TCOMTB') + ':';
      TcxGroupBox(Self.FindComponent('gpbTabPre0' + IntToStr(intTabPre))).Visible := True;

      If (Not blnPerCom) And (not blnPerAcres) Then
      Begin
        TEditFocus(Self.FindComponent('edtComTb'    + IntToStr(intTabPre))).Visible := False;
        TLabel    (Self.FindComponent('lblTitComTb' + IntToStr(intTabPre))).Visible := False;
        TLabel    (Self.FindComponent('lblPerComTb' + IntToStr(intTabPre))).Visible := False;
      End;
    End;
  End;

  lblOutVal.Caption := fCfgSis('DOVCPP') + ' (+):';

  lblDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';

  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    pnlSuframa.Visible := True;
  end
  else
  begin
    pnlSuframa.Visible := False;
  end;

  lblValFre.Caption := strDesValFre + ' (+):';
end;

procedure TfrmEntAlteraPrecos.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmEntAlteraPrecos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  {*****************************************}
  {* (*) LIMPA EVENTO                      *}
  {**************************************MV*}
  qryEntMer.AfterScroll := Nil;
end;

procedure TfrmEntAlteraPrecos.FormCreate(Sender: TObject);
begin
  inherited;

  intDecUni := fCfgSis('DECUNI', varInteger);
  pAtualizaDecUni;

  strDesValFre := fCfgSis('DESVFR');

  objFatPre := Nil;
  blnFatPre := fCfgSis('FATPRE', varBoolean);

  If blnFatPre Then
    objFatPre := TFatorPreco.Create;

  pAjustaFatorPreco(True);

  blnConvertePreco := False;
  blnPrecoJaMultiplicado := False;
  
  If fCfgSis('ALTPEN', varBoolean) Then
  Begin
    edtPreCom.ReadOnly    := True;
    edtPreCom.TabStop     := False;
    edtPreCom.NormalColor := $00FFDFB8;
  End;

  pTravaPrecos;
end;

procedure TfrmEntAlteraPrecos.pTravaPrecos;
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

procedure TfrmEntAlteraPrecos.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);

end;

procedure TfrmEntAlteraPrecos.pAtualizaTabela;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_ENTMER ';

  With qryEntMer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

end;

procedure TfrmEntAlteraPrecos.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(pnlPrecos, True);
  pSetFocus((rdgTipAlt.Controls[rdgTipAlt.ItemIndex] As TWinControl));

  {pSetFocus(edtPreCom);}

end;

procedure TfrmEntAlteraPrecos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F8) Then
  Begin
    Key := 0;
    btnUltCmp.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End

  Else If Key = VK_Return Then
  Begin
    If ActiveControl Is TRadioButton Then
      SelectNext(ActiveControl,True,True);
  End

  Else If Key = VK_Escape Then
  Begin

    If ActiveControl Is TRadioButton Then
    Begin
      pSetFocus(dbgItens);
      pHabilitaCampos(pnlPrecos, False);
      pAtualizaEdits(Nil);
    End;

  End;

end;

procedure TfrmEntAlteraPrecos.pDadosUltimaCompra(strCodIte: String);
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE, ';
  strSQL := strSQL + '   ITE_PREULT, ';
  strSQL := strSQL + '   ITE_QTDUCO, ';
  strSQL := strSQL + '   ITE_DTAULT, ';
  strSQL := strSQL + '   ITE_FORULT, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   ITE_PREMED  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITEGER, ';
  strSQL := strSQL + '   CADFOR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ITE_FORULT = FOR_CODFOR AND ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '   ITE_CODEMP = :CODEMP ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodite;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    edtUltCom.Text := fieldbyname('ITE_DTAULT').AsString;
    edtQtdUco.Text := FormatFloat('#,##0.000', fieldbyname('ITE_QTDUCO').AsFloat);
    edtPreUlt.Text := FormatFloat('#,####0.0000', fieldbyname('ITE_PREULT').AsFloat);
    edtPreMed.Text := FormatFloat('#,####0.0000', fieldbyname('ITE_PREMED').AsFloat);
    edtNomUltFor.Text := fieldbyname('ITE_FORULT').AsString + '-'+ fieldbyname('FOR_NOMFOR').AsString;

  End;

  FreeAndNil(qryGen);
End;

function TfrmEntAlteraPrecos.fEdtFocus(strNome: String): TEditFocus;
begin
  Result := TEditFocus(Self.FindComponent(strNome));
end;

procedure TfrmEntAlteraPrecos.pAtualizaDecUni;
begin
  edtPreVe1.EditFormat := fMskDigitos(intDecUni);
  edtPreVe2.EditFormat := fMskDigitos(intDecUni);
  edtPreVe3.EditFormat := fMskDigitos(intDecUni);
  edtPreVe4.EditFormat := fMskDigitos(intDecUni);
  edtPreVe5.EditFormat := fMskDigitos(intDecUni);
  edtPreVe6.EditFormat := fMskDigitos(intDecUni);
  edtPreVe7.EditFormat := fMskDigitos(intDecUni);

  edtMarBr1.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr2.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr3.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr4.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr5.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr6.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
  edtMarBr7.EditFormat := fMskDigitos(fRetPrecisaoMargemItem);

  edtPreCom.EditFormat := fMskDigitos(intDecUni);
  edtPreCus.EditFormat := fMskDigitos(intDecUni);
end;

Procedure TfrmEntAlteraPrecos.pAjustaFatorPreco(blnDesabilita: Boolean);
Begin
  If blnFatPre Then
  Begin
    edtMarBr2.ReadOnly := True;
    edtMarBr2.TabStop  := False;

    edtMarBr3.ReadOnly := True;
    edtMarBr3.TabStop  := False;

    edtMarBr4.ReadOnly := True;
    edtMarBr4.TabStop  := False;

    edtMarBr5.ReadOnly := True;
    edtMarBr5.TabStop  := False;

    edtMarBr6.ReadOnly := True;
    edtMarBr6.TabStop  := False;

    edtMarBr7.ReadOnly := True;
    edtMarBr7.TabStop  := False;

    edtPreVe2.ReadOnly := True;
    edtPreVe2.TabStop  := False;

    edtPreVe3.ReadOnly := True;
    edtPreVe3.TabStop  := False;

    edtPreVe4.ReadOnly := True;
    edtPreVe4.TabStop  := False;

    edtPreVe5.ReadOnly := True;
    edtPreVe5.TabStop  := False;

    edtPreVe6.ReadOnly := True;
    edtPreVe6.TabStop  := False;

    edtPreVe7.ReadOnly := True;
    edtPreVe7.TabStop  := False;

    edtComTb2.ReadOnly := True;
    edtComTb2.TabStop  := False;

    edtComTb3.ReadOnly := True;
    edtComTb3.TabStop  := False;

    edtComTb4.ReadOnly := True;
    edtComTb4.TabStop  := False;

    edtComTb5.ReadOnly := True;
    edtComTb5.TabStop  := False;

    edtComTb6.ReadOnly := True;
    edtComTb6.TabStop  := False;

    edtComTb7.ReadOnly := True;
    edtComTb7.TabStop  := False;

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

Procedure TfrmEntAlteraPrecos.pRecalculaPrecosFator;
  Var
    intContador: Integer;
Begin
  If Not blnFatPre Then
    Exit;

  For intContador := 2 To 7 Do
  Begin
    If objFatPre.fTabelaAtiva(intContador) Then
    begin
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
End;


end.


