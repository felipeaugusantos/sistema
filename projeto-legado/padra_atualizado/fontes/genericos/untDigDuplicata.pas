unit untDigDuplicata;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus, untfuncoesSimples,
  ComCtrls, Buttons, ExtCtrls, StrUtils, Menus, AppEvnts, untFuncoesGenerica, untConstantes,
  Uni, BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,DateUtils,
  Math, Data.DB, UniClientDataSet;

type
  TfrmDigDuplicata = class(TfrmPaiSimples)
    pnlBotoesBaixa: TPanel;
    pnlFundo: TPanel;
    pnlDuplics: TPanel;
    lblTotVen: TLabel;
    lblTotDig: TLabel;
    lblVlFalta: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lblCheques: TLabel;
    edtHist02: TEditFocus;
    edtVal12: TEditFocus;
    edtTotVen: TEditFocus;
    edtTotDig: TEditFocus;
    edtVlFalta: TEditFocus;
    edtNumDup1: TEditFocus;
    edtNumDup2: TEditFocus;
    edtNumDup3: TEditFocus;
    edtNumDup4: TEditFocus;
    edtNumDup5: TEditFocus;
    edtNumDup6: TEditFocus;
    edtNumDup7: TEditFocus;
    edtNumDup8: TEditFocus;
    edtNumDup9: TEditFocus;
    edtNumDup10: TEditFocus;
    edtNumDup11: TEditFocus;
    edtNumDup12: TEditFocus;
    edtDtaVen01: TMaskEditFocus;
    edtDtaVen02: TMaskEditFocus;
    edtDtaVen03: TMaskEditFocus;
    edtDtaVen04: TMaskEditFocus;
    edtDtaVen05: TMaskEditFocus;
    edtDtaVen06: TMaskEditFocus;
    edtDtaVen07: TMaskEditFocus;
    edtDtaVen08: TMaskEditFocus;
    edtDtaVen09: TMaskEditFocus;
    edtDtaVen10: TMaskEditFocus;
    edtDtaVen11: TMaskEditFocus;
    edtDtaVen12: TMaskEditFocus;
    edtSeq1: TEditFocus;
    edtSeq2: TEditFocus;
    edtSeq3: TEditFocus;
    edtSeq4: TEditFocus;
    edtSeq5: TEditFocus;
    edtSeq6: TEditFocus;
    edtSeq7: TEditFocus;
    edtSeq8: TEditFocus;
    edtSeq9: TEditFocus;
    edtSeq10: TEditFocus;
    edtSeq11: TEditFocus;
    edtSeq12: TEditFocus;
    edtVal1: TEditFocus;
    edtVal2: TEditFocus;
    edtVal3: TEditFocus;
    edtVal4: TEditFocus;
    edtVal5: TEditFocus;
    edtVal6: TEditFocus;
    edtVal7: TEditFocus;
    edtVal8: TEditFocus;
    edtVal9: TEditFocus;
    edtVal10: TEditFocus;
    edtVal11: TEditFocus;
    edtChq01: TEditFocus;
    edtChq02: TEditFocus;
    edtChq03: TEditFocus;
    edtChq04: TEditFocus;
    edtChq05: TEditFocus;
    edtChq06: TEditFocus;
    edtChq07: TEditFocus;
    edtChq08: TEditFocus;
    edtChq09: TEditFocus;
    edtChq10: TEditFocus;
    edtChq11: TEditFocus;
    edtChq12: TEditFocus;
    btnSairDig: TBitBtnLocked;
    btnSalvar: TBitBtnLocked;
    btnValoresPadrao: TBitBtnLocked;
    btnCCCli: TBitBtnLocked;
    btnHistorico: TBitBtnLocked;
    pnlValPad: TPanel;
    chkValPad: TCheckBox;
    Label3: TLabel;
    Label16: TLabel;
    lblCheques2: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtNumDup13: TEditFocus;
    edtNumDup14: TEditFocus;
    edtNumDup15: TEditFocus;
    edtNumDup16: TEditFocus;
    edtNumDup17: TEditFocus;
    edtNumDup18: TEditFocus;
    edtNumDup19: TEditFocus;
    edtNumDup20: TEditFocus;
    edtNumDup21: TEditFocus;
    edtNumDup22: TEditFocus;
    edtNumDup23: TEditFocus;
    edtNumDup24: TEditFocus;
    edtSeq13: TEditFocus;
    edtSeq14: TEditFocus;
    edtSeq15: TEditFocus;
    edtSeq16: TEditFocus;
    edtSeq17: TEditFocus;
    edtSeq18: TEditFocus;
    edtSeq19: TEditFocus;
    edtSeq20: TEditFocus;
    edtSeq21: TEditFocus;
    edtSeq22: TEditFocus;
    edtSeq23: TEditFocus;
    edtSeq24: TEditFocus;
    edtDtaVen13: TMaskEditFocus;
    edtDtaVen14: TMaskEditFocus;
    edtDtaVen15: TMaskEditFocus;
    edtDtaVen16: TMaskEditFocus;
    edtDtaVen17: TMaskEditFocus;
    edtDtaVen18: TMaskEditFocus;
    edtDtaVen19: TMaskEditFocus;
    edtDtaVen20: TMaskEditFocus;
    edtDtaVen21: TMaskEditFocus;
    edtDtaVen22: TMaskEditFocus;
    edtDtaVen23: TMaskEditFocus;
    edtDtaVen24: TMaskEditFocus;
    edtVal24: TEditFocus;
    edtVal23: TEditFocus;
    edtVal22: TEditFocus;
    edtVal21: TEditFocus;
    edtVal20: TEditFocus;
    edtVal19: TEditFocus;
    edtVal18: TEditFocus;
    edtVal17: TEditFocus;
    edtVal16: TEditFocus;
    edtVal15: TEditFocus;
    edtVal14: TEditFocus;
    edtVal13: TEditFocus;
    edtChq13: TEditFocus;
    edtChq14: TEditFocus;
    edtChq15: TEditFocus;
    edtChq16: TEditFocus;
    edtChq17: TEditFocus;
    edtChq18: TEditFocus;
    edtChq19: TEditFocus;
    edtChq20: TEditFocus;
    edtChq21: TEditFocus;
    edtChq22: TEditFocus;
    edtChq23: TEditFocus;
    edtChq24: TEditFocus;
    btnRepHist: TBitBtnLocked;
    procedure edtVal1Exit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDtaVen01Exit(Sender: TObject);
    procedure edtDtaVen02Exit(Sender: TObject);
    procedure btnValoresPadraoClick(Sender: TObject);
    procedure edtVal1Enter(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure edtHist02Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNumDup1Enter(Sender: TObject);
    procedure edtSeq1Enter(Sender: TObject);
    procedure edtDtaVen01Enter(Sender: TObject);
    procedure edtChq01Enter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCCCliClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkValPadClick(Sender: TObject);
    procedure btnRepHistClick(Sender: TObject);
    procedure btnRepHistExit(Sender: TObject);
  private
    { Private declarations }
    strValAnt: String;
    edtOrigem: TEdit;
    arrDuplic: Array[0..23] Of TArrDigDuplic;
    arrDuplicatasBkp: TArrDigDuplicArray;

    blnCarregando: Boolean;

    FPais: TPais;

    fltTotalCredito: Double;
    stlDupCredito: TStringList;
    stlDupCreditoX: TStringList;
    stlLckDup: TStringList;

    arrVenOri : Array[1..24] Of String;

    procedure pFormataValores;
    procedure pSomaValor(edtBase: TEditFocus);
    procedure pCarDuplicatas;
    procedure pSalvaDados;
    procedure pSalvaDadosVeri;
    procedure pHabilita;

    procedure pRateiaValorDigitado(edtBase: TEditFocus);

    procedure pAtualizaHist02;

    procedure pValorPadrao;

    procedure pCarregaValoresPadrao;

    function fSomaTotalAcima(edtBase: TEditFocus; blnInclusive: Boolean): Double;
    function fSomaTotalAbaixo(edtBase: TEditFocus; blnInclusive: Boolean): Double;

    function fValidaEdtsValor(intEdtVaSel: Integer = 0): Boolean;
    function fValidaEdtsData: Boolean;

    function fAlterouVenctos : Boolean;
    procedure pCarregaVenctosOriginais;
    function fValidaVencimentos: Boolean;
    procedure pReplicarHistoricoParaTodasAsParcelas(strHistorico: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    blnMostrarOpcaoPadrao: Boolean;

    pMostraContaCorrente: TPrcMostraContaCorrente;
    intQtdPar : Integer;
    curTotalPed: Currency;
    blnEditavel : Boolean;
    blnHabEditDup: Boolean;
    blnHabEditValor: Boolean;
    blnConfirma: Boolean;
    blnPergConf: Boolean;
    strCndPag: String;
    dtaDtaBas: TDateTime;
    blnDupsRedondas: Boolean;
    blnFaturamento: Boolean;
    blnAgrupVeio: Boolean;
    strEspDoc: String;
    strCodCli: String;
    blnPerRep: Boolean;
    fltValRec: Double;
    AFormVeio: String;
    blnTelaAgrupamento: Boolean;

    strCodCnd,
    strCodVen: String;
    fSenVar: TGenericFunctionWithArrayParam;

    arrDuplicataPadrao: TarrDuplicata;
    arrDuplicata: TarrDuplicataPointer;
  end;


implementation

uses untPai, untDuplicatas;

{$R *.dfm}

procedure TfrmDigDuplicata.pSomaValor(edtBase: TEditFocus);
  Var
    curValor : Currency;
begin
  pFormataValores;
  pRateiaValorDigitado(edtBase);

  curValor := 0;
  curValor := curValor + fStrToFloat(edtVal1.Text);
  curValor := curValor + fStrToFloat(edtVal2.Text);
  curValor := curValor + fStrToFloat(edtVal3.Text);
  curValor := curValor + fStrToFloat(edtVal4.Text);
  curValor := curValor + fStrToFloat(edtVal5.Text);
  curValor := curValor + fStrToFloat(edtVal6.Text);
  curValor := curValor + fStrToFloat(edtVal7.Text);
  curValor := curValor + fStrToFloat(edtVal8.Text);
  curValor := curValor + fStrToFloat(edtVal9.Text);
  curValor := curValor + fStrToFloat(edtVal10.Text);
  curValor := curValor + fStrToFloat(edtVal11.Text);
  curValor := curValor + fStrToFloat(edtVal12.Text);
  curValor := curValor + fStrToFloat(edtVal13.Text);
  curValor := curValor + fStrToFloat(edtVal14.Text);
  curValor := curValor + fStrToFloat(edtVal15.Text);
  curValor := curValor + fStrToFloat(edtVal16.Text);
  curValor := curValor + fStrToFloat(edtVal17.Text);
  curValor := curValor + fStrToFloat(edtVal18.Text);
  curValor := curValor + fStrToFloat(edtVal19.Text);
  curValor := curValor + fStrToFloat(edtVal20.Text);
  curValor := curValor + fStrToFloat(edtVal21.Text);
  curValor := curValor + fStrToFloat(edtVal22.Text);
  curValor := curValor + fStrToFloat(edtVal23.Text);
  curValor := curValor + fStrToFloat(edtVal24.Text);

  If FPais = opcParaguai Then
  Begin
    edtTotDig.Text  := 'G$ ' + FormatFloat('#,##0.00', curValor);
    edtVlFalta.Text := 'G$ ' + FormatFloat('#,##0.00', (curTotalPed - curValor));
  End
  Else
  Begin
    edtTotDig.Text  := FloatToStrf(curValor, ffFixed, 10, 2);
    edtVlFalta.Text := FloatToStrf((curTotalPed - curValor), ffFixed, 10, 2);
  End;

end;

procedure TfrmDigDuplicata.pCarDuplicatas;
  Var
    intQtdDia: Integer;
begin
  {************************************************}
  {* CASO SEJA TROCA/DEVOLUÇÃO INCLUI QTD DE DIAS *}
  {* EM CADA PARCELA DO CONTAS A RECEBER          *}
  {*********************************************RV*}
  If blnEditavel Then
    intQtdDia := IIF(Pos(strEspDoc, 'DV_TR_') > 0, fCfgSis('QTTRDV'), 0)
  Else
    intQtdDia := 0;

	// Parcela 1
	If ArrDuplicata[0].strSequen <> '' Then
  Begin
    If ArrDuplicata[0].intNumDup <> 0 Then
  	  edtNumDup1.Text := IntToStr(ArrDuplicata[0].intNumDup)
    Else
      edtNumDup1.Text := '';

    edtSeq1.Text     := ArrDuplicata[0].strSequen;

    If StrToDateDef((ArrDuplicata[0].dtaDtaVen), 0) > 0 Then
      edtDtaVen01.Text := DateToStr(StrToDate((ArrDuplicata[0].dtaDtaVen)) + intQtdDia);

    edtVal1.Text  := fFormataFloat(ArrDuplicata[0].curValor, 2).ToString;
    edtChq01.Text := 'N';
  End
  Else
  Begin
    edtDtaVen01.Enabled := False;
    edtDtaVen01.Clear;
    edtVal1.Enabled  := False;
    edtVal1.Text := '0,00';
    edtChq01.Enabled := False;
  End;
	// Parcela 2
	If ArrDuplicata[1].strSequen <> '' Then
  Begin
    If ArrDuplicata[1].intNumDup <> 0 Then
  	  edtNumDup2.Text := IntToStr(ArrDuplicata[1].intNumDup)
    Else
      edtNumDup2.Text := '';

    edtSeq2.Text     := ArrDuplicata[1].strSequen;

    If StrToDateDef((ArrDuplicata[1].dtaDtaVen), 0) > 0 Then
      edtDtaVen02.Text := DateToStr(StrToDate((ArrDuplicata[1].dtaDtaVen)) + intQtdDia);

    edtVal2.Text  := fFormataFloat(ArrDuplicata[1].curValor, 2).ToString;
    edtChq02.Text := 'N';
  End
  Else
  Begin
    edtDtaVen02.Enabled := False;
    edtDtaVen02.Clear;
    edtVal2.Enabled := False;
    edtVal2.Text := '0,00';
    edtChq02.Enabled := False;
  End;
	// Parcela 3
	If ArrDuplicata[2].strSequen <> '' Then
  Begin
    If ArrDuplicata[2].intNumDup <> 0 Then
      edtNumDup3.Text := IntToStr(ArrDuplicata[2].intNumDup)
    Else
      edtNumDup3.Text := '';

    edtSeq3.Text     := ArrDuplicata[2].strSequen;

    If StrToDateDef((ArrDuplicata[2].dtaDtaVen), 0) > 0 Then
      edtDtaVen03.Text := DateToStr(StrToDate((ArrDuplicata[2].dtaDtaVen)) + intQtdDia);

    edtVal3.Text  := fFormataFloat(ArrDuplicata[2].curValor, 2).ToString;
    edtChq03.Text := 'N';
  End
  Else
  Begin
    edtDtaVen03.Enabled := False;
    edtDtaVen03.Clear;
    edtVal3.Enabled := False;
    edtVal3.Text := '0,00';
    edtChq03.Enabled := False;
  End;
	// Parcela 4
	If ArrDuplicata[3].strSequen <> '' Then
  Begin
    If ArrDuplicata[3].intNumDup <> 0 Then
  	  edtNumDup4.Text := IntToStr(ArrDuplicata[3].intNumDup)
    Else
      edtNumDup4.Text := '';

    edtSeq4.Text     := ArrDuplicata[3].strSequen;

    If StrToDateDef((ArrDuplicata[3].dtaDtaVen), 0) > 0 Then
      edtDtaVen04.Text := DateToStr(StrToDate((ArrDuplicata[3].dtaDtaVen)) + intQtdDia);

    edtVal4.Text  := fFormataFloat(ArrDuplicata[3].curValor, 2).ToString;
    edtChq04.Text := 'N';
  End
  Else
  Begin
    edtDtaVen04.Enabled := False;
    edtDtaVen04.Clear;
    edtVal4.Enabled := False;
    edtVal4.Text := '0,00';
    edtChq04.Enabled := False;
  End;
	// Parcela 5
	If ArrDuplicata[4].strSequen <> '' Then
  Begin
    If ArrDuplicata[4].intNumDup <> 0 Then
  	  edtNumDup5.Text := IntToStr(ArrDuplicata[4].intNumDup)
    Else
      edtNumDup5.Text := '';

    edtSeq5.Text     := ArrDuplicata[4].strSequen;

    If StrToDateDef((ArrDuplicata[4].dtaDtaVen), 0) > 0 Then
      edtDtaVen05.Text := DateToStr(StrToDate((ArrDuplicata[4].dtaDtaVen)) + intQtdDia);

    edtVal5.Text  := fFormataFloat(ArrDuplicata[4].curValor, 2).ToString;
    edtChq05.Text := 'N';
  End
  Else
  Begin
    edtDtaVen05.Enabled := False;
    edtDtaVen05.Clear;
    edtVal5.Enabled := False;
    edtVal5.Text := '0,00';
    edtChq05.Enabled := False;
  End;
	// Parcela 6
	If ArrDuplicata[5].strSequen <> '' Then
  Begin
    If ArrDuplicata[5].intNumDup <> 0 Then
  	  edtNumDup6.Text := IntToStr(ArrDuplicata[5].intNumDup)
    Else
      edtNumDup6.Text := '';

    edtSeq6.Text     := ArrDuplicata[5].strSequen;

    If StrToDateDef((ArrDuplicata[5].dtaDtaVen), 0) > 0 Then
      edtDtaVen06.Text := DateToStr(StrToDate((ArrDuplicata[5].dtaDtaVen)) + intQtdDia);

    edtVal6.Text  := fFormataFloat(ArrDuplicata[5].curValor, 2).ToString;
    edtChq06.Text := 'N';
  End
  Else
  Begin
    edtDtaVen06.Enabled := False;
    edtDtaVen06.Clear;
    edtVal6.Enabled := False;
    edtVal6.Text := '0,00';
    edtChq06.Enabled := False;
  End;
	// Parcela 7
	If ArrDuplicata[6].strSequen <> '' Then
  Begin
    If ArrDuplicata[6].intNumDup <> 0 Then
  	  edtNumDup7.Text := IntToStr(ArrDuplicata[6].intNumDup)
    Else
      edtNumDup7.Text := '';

    edtSeq7.Text     := ArrDuplicata[6].strSequen;

    If StrToDateDef((ArrDuplicata[6].dtaDtaVen), 0) > 0 Then
      edtDtaVen07.Text := DateToStr(StrToDate((ArrDuplicata[6].dtaDtaVen)) + intQtdDia);

    edtVal7.Text  := fFormataFloat(ArrDuplicata[6].curValor, 2).ToString;
    edtChq07.Text := 'N';
  End
  Else
  Begin
    edtDtaVen07.Enabled := False;
    edtDtaVen07.Clear;
    edtVal7.Enabled := False;
    edtVal7.Text := '0,00';
    edtChq07.Enabled := False;
  End;
	// Parcela 8
	If ArrDuplicata[7].strSequen <> '' Then
  Begin
    If ArrDuplicata[7].intNumDup <> 0 Then
  	  edtNumDup8.Text := IntToStr(ArrDuplicata[7].intNumDup)
    Else
      edtNumDup8.Text := '';

    edtSeq8.Text     := ArrDuplicata[7].strSequen;

    If StrToDateDef((ArrDuplicata[7].dtaDtaVen), 0) > 0 Then
      edtDtaVen08.Text := DateToStr(StrToDate((ArrDuplicata[7].dtaDtaVen)) + intQtdDia);

    edtVal8.Text  := fFormataFloat(ArrDuplicata[7].curValor, 2).ToString;
    edtChq08.Text := 'N';
  End
  Else
  Begin
    edtDtaVen08.Enabled := False;
    edtDtaVen08.Clear;
    edtVal8.Enabled := False;
    edtVal8.Text := '0,00';
    edtChq08.Enabled := False;
  End;
	// Parcela 9
	If ArrDuplicata[8].strSequen <> '' Then
  Begin
    If ArrDuplicata[8].intNumDup <> 0 Then
      edtNumDup9.Text := IntToStr(ArrDuplicata[8].intNumDup)
    Else
      edtNumDup9.Text := '';

    edtSeq9.Text     := ArrDuplicata[8].strSequen;

    If StrToDateDef((ArrDuplicata[8].dtaDtaVen), 0) > 0 Then
      edtDtaVen09.Text := DateToStr(StrToDate((ArrDuplicata[8].dtaDtaVen)) + intQtdDia);

    edtVal9.Text  := fFormataFloat(ArrDuplicata[8].curValor, 2).ToString;
    edtChq09.Text := 'N';
  End
  Else
  Begin
    edtDtaVen09.Enabled := False;
    edtDtaVen09.Clear;
    edtVal9.Enabled := False;
    edtVal9.Text := '0,00';
    edtChq09.Enabled := False;
  End;
	// Parcela 10
	If ArrDuplicata[9].strSequen <> '' Then
  Begin
    If ArrDuplicata[9].intNumDup <> 0 Then
      edtNumDup10.Text := IntToStr(ArrDuplicata[9].intNumDup)
    Else
      edtNumDup10.Text := '';

    edtSeq10.Text    := ArrDuplicata[9].strSequen;

    If StrToDateDef((ArrDuplicata[9].dtaDtaVen), 0) > 0 Then
      edtDtaVen10.Text := DateToStr(StrToDate((ArrDuplicata[9].dtaDtaVen)) + intQtdDia);

    edtVal10.Text := fFormataFloat(ArrDuplicata[9].curValor, 2).ToString;
    edtChq10.Text := 'N';
  End
  Else
  Begin
    edtDtaVen10.Enabled := False;
    edtDtaVen10.Clear;
    edtVal10.Enabled := False;
    edtVal10.Text := '0,00';
    edtChq10.Enabled := False;
  End;
	// Parcela 11
	If ArrDuplicata[10].strSequen <> '' Then
  Begin
    If ArrDuplicata[10].intNumDup <> 0 Then
  	  edtNumDup11.Text := IntToStr(ArrDuplicata[10].intNumDup)
    Else
      edtNumDup11.Text := '';

    edtSeq11.Text    := ArrDuplicata[10].strSequen;

    If StrToDateDef((ArrDuplicata[10].dtaDtaVen), 0) > 0 Then
      edtDtaVen11.Text := DateToStr(StrToDate((ArrDuplicata[10].dtaDtaVen)) + intQtdDia);

    edtVal11.Text := fFormataFloat(ArrDuplicata[10].curValor, 2).ToString;
    edtChq11.Text := 'N';
  End
  Else
  Begin
    edtDtaVen11.Enabled := False;
    edtDtaVen11.Clear;
    edtVal11.Enabled := False;
    edtVal11.Text := '0,00';
    edtChq11.Enabled := False;
  End;
	// Parcela 12
	If ArrDuplicata[11].strSequen <> '' Then
  Begin
    If ArrDuplicata[11].intNumDup <> 0 Then
	    edtNumDup12.Text := IntToStr(ArrDuplicata[11].intNumDup)
    Else
      edtNumDup12.Text := '';

    edtSeq12.Text    := ArrDuplicata[11].strSequen;

    If StrToDateDef((ArrDuplicata[11].dtaDtaVen), 0) > 0 Then
      edtDtaVen12.Text := DateToStr(StrToDate((ArrDuplicata[11].dtaDtaVen)) + intQtdDia);

    edtVal12.Text := fFormataFloat(ArrDuplicata[11].curValor, 2).ToString;
    edtChq12.Text := 'N';
  End
  Else
  Begin
    edtDtaVen12.Enabled := False;
    edtDtaVen12.Clear;
    edtVal12.Enabled := False;
    edtVal12.Text := '0,00';
    edtChq12.Enabled := False;
  End;
	// Parcela 13
	If ArrDuplicata[12].strSequen <> '' Then
  Begin
    If ArrDuplicata[12].intNumDup <> 0 Then
	    edtNumDup13.Text := IntToStr(ArrDuplicata[12].intNumDup)
    Else
      edtNumDup13.Text := '';

    edtSeq13.Text    := ArrDuplicata[12].strSequen;
    edtDtaVen13.Text := DateToStr(StrToDate((ArrDuplicata[12].dtaDtaVen)) + intQtdDia);
    edtVal13.Text    := fFormataFloat(ArrDuplicata[12].curValor, 2).ToString;
    edtChq13.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen13.Enabled := False;
    edtDtaVen13.Clear;
    edtVal13.Enabled := False;
    edtVal13.Text := '0,00';
    edtChq13.Enabled := False;
  End;

	// Parcela 14
	If ArrDuplicata[13].strSequen <> '' Then
  Begin
    If ArrDuplicata[13].intNumDup <> 0 Then
	    edtNumDup14.Text := IntToStr(ArrDuplicata[13].intNumDup)
    Else
      edtNumDup14.Text := '';

    edtSeq14.Text    := ArrDuplicata[13].strSequen;
    edtDtaVen14.Text := DateToStr(StrToDate((ArrDuplicata[13].dtaDtaVen)) + intQtdDia);
    edtVal14.Text    := fFormataFloat(ArrDuplicata[13].curValor, 2).ToString;
    edtChq14.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen14.Enabled := False;
    edtDtaVen14.Clear;
    edtVal14.Enabled := False;
    edtVal14.Text := '0,00';
    edtChq14.Enabled := False;
  End;

	// Parcela 15
	If ArrDuplicata[14].strSequen <> '' Then
  Begin
    If ArrDuplicata[14].intNumDup <> 0 Then
	    edtNumDup15.Text := IntToStr(ArrDuplicata[14].intNumDup)
    Else
      edtNumDup15.Text := '';

    edtSeq15.Text    := ArrDuplicata[14].strSequen;
    edtDtaVen15.Text := DateToStr(StrToDate((ArrDuplicata[14].dtaDtaVen)) + intQtdDia);
    edtVal15.Text    := fFormataFloat(ArrDuplicata[14].curValor, 2).ToString;
    edtChq15.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen15.Enabled := False;
    edtDtaVen15.Clear;
    edtVal15.Enabled := False;
    edtVal15.Text := '0,00';
    edtChq15.Enabled := False;
  End;

	// Parcela 16
	If ArrDuplicata[15].strSequen <> '' Then
  Begin
    If ArrDuplicata[15].intNumDup <> 0 Then
	    edtNumDup16.Text := IntToStr(ArrDuplicata[15].intNumDup)
    Else
      edtNumDup16.Text := '';

    edtSeq16.Text    := ArrDuplicata[15].strSequen;
    edtDtaVen16.Text := DateToStr(StrToDate((ArrDuplicata[15].dtaDtaVen)) + intQtdDia);
    edtVal16.Text    := fFormataFloat(ArrDuplicata[15].curValor, 2).ToString;
    edtChq16.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen16.Enabled := False;
    edtDtaVen16.Clear;
    edtVal16.Enabled := False;
    edtVal16.Text := '0,00';
    edtChq16.Enabled := False;
  End;

	// Parcela 17
	If ArrDuplicata[16].strSequen <> '' Then
  Begin
    If ArrDuplicata[16].intNumDup <> 0 Then
	    edtNumDup17.Text := IntToStr(ArrDuplicata[16].intNumDup)
    Else
      edtNumDup17.Text := '';

    edtSeq17.Text    := ArrDuplicata[16].strSequen;
    edtDtaVen17.Text := DateToStr(StrToDate((ArrDuplicata[16].dtaDtaVen)) + intQtdDia);
    edtVal17.Text    := fFormataFloat(ArrDuplicata[16].curValor, 2).ToString;
    edtChq17.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen17.Enabled := False;
    edtDtaVen17.Clear;
    edtVal17.Enabled := False;
    edtVal17.Text := '0,00';
    edtChq17.Enabled := False;
  End;

	// Parcela 18
	If ArrDuplicata[17].strSequen <> '' Then
  Begin
    If ArrDuplicata[17].intNumDup <> 0 Then
	    edtNumDup18.Text := IntToStr(ArrDuplicata[17].intNumDup)
    Else
      edtNumDup18.Text := '';

    edtSeq18.Text    := ArrDuplicata[17].strSequen;
    edtDtaVen18.Text := DateToStr(StrToDate((ArrDuplicata[17].dtaDtaVen)) + intQtdDia);
    edtVal18.Text    := fFormataFloat(ArrDuplicata[17].curValor, 2).ToString;
    edtChq18.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen18.Enabled := False;
    edtDtaVen18.Clear;
    edtVal18.Enabled := False;
    edtVal18.Text := '0,00';
    edtChq18.Enabled := False;
  End;

	// Parcela 19
	If ArrDuplicata[18].strSequen <> '' Then
  Begin
    If ArrDuplicata[18].intNumDup <> 0 Then
	    edtNumDup19.Text := IntToStr(ArrDuplicata[18].intNumDup)
    Else
      edtNumDup19.Text := '';

    edtSeq19.Text    := ArrDuplicata[18].strSequen;
    edtDtaVen19.Text := DateToStr(StrToDate((ArrDuplicata[18].dtaDtaVen)) + intQtdDia);
    edtVal19.Text    := fFormataFloat(ArrDuplicata[18].curValor, 2).ToString;
    edtChq19.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen19.Enabled := False;
    edtDtaVen19.Clear;
    edtVal19.Enabled := False;
    edtVal19.Text := '0,00';
    edtChq19.Enabled := False;
  End;

	// Parcela 20
	If ArrDuplicata[19].strSequen <> '' Then
  Begin
    If ArrDuplicata[19].intNumDup <> 0 Then
	    edtNumDup20.Text := IntToStr(ArrDuplicata[19].intNumDup)
    Else
      edtNumDup20.Text := '';

    edtSeq20.Text    := ArrDuplicata[19].strSequen;
    edtDtaVen20.Text := DateToStr(StrToDate((ArrDuplicata[19].dtaDtaVen)) + intQtdDia);
    edtVal20.Text    := fFormataFloat(ArrDuplicata[19].curValor, 2).ToString;
    edtChq20.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen20.Enabled := False;
    edtDtaVen20.Clear;
    edtVal20.Enabled := False;
    edtVal20.Text := '0,00';
    edtChq20.Enabled := False;
  End;

	// Parcela 21
	If ArrDuplicata[20].strSequen <> '' Then
  Begin
    If ArrDuplicata[20].intNumDup <> 0 Then
	    edtNumDup21.Text := IntToStr(ArrDuplicata[20].intNumDup)
    Else
      edtNumDup21.Text := '';

    edtSeq21.Text    := ArrDuplicata[20].strSequen;
    edtDtaVen21.Text := DateToStr(StrToDate((ArrDuplicata[20].dtaDtaVen)) + intQtdDia);
    edtVal21.Text    := fFormataFloat(ArrDuplicata[20].curValor, 2).ToString;
    edtChq21.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen21.Enabled := False;
    edtDtaVen21.Clear;
    edtVal21.Enabled := False;
    edtVal21.Text := '0,00';
    edtChq21.Enabled := False;
  End;

	// Parcela 22
	If ArrDuplicata[21].strSequen <> '' Then
  Begin
    If ArrDuplicata[21].intNumDup <> 0 Then
	    edtNumDup22.Text := IntToStr(ArrDuplicata[21].intNumDup)
    Else
      edtNumDup22.Text := '';

    edtSeq22.Text    := ArrDuplicata[21].strSequen;
    edtDtaVen22.Text := DateToStr(StrToDate((ArrDuplicata[21].dtaDtaVen)) + intQtdDia);
    edtVal22.Text    := fFormataFloat(ArrDuplicata[21].curValor, 2).ToString;
    edtChq22.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen22.Enabled := False;
    edtDtaVen22.Clear;
    edtVal22.Enabled := False;
    edtVal22.Text := '0,00';
    edtChq22.Enabled := False;
  End;

	// Parcela 23
	If ArrDuplicata[22].strSequen <> '' Then
  Begin
    If ArrDuplicata[22].intNumDup <> 0 Then
	    edtNumDup23.Text := IntToStr(ArrDuplicata[22].intNumDup)
    Else
      edtNumDup23.Text := '';

    edtSeq23.Text    := ArrDuplicata[22].strSequen;
    edtDtaVen23.Text := DateToStr(StrToDate((ArrDuplicata[22].dtaDtaVen)) + intQtdDia);
    edtVal23.Text    := fFormataFloat(ArrDuplicata[22].curValor, 2).ToString;
    edtChq23.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen23.Enabled := False;
    edtDtaVen23.Clear;
    edtVal23.Enabled := False;
    edtVal23.Text := '0,00';
    edtChq23.Enabled := False;
  End;

	// Parcela 24
	If ArrDuplicata[23].strSequen <> '' Then
  Begin
    If ArrDuplicata[23].intNumDup <> 0 Then
	    edtNumDup24.Text := IntToStr(ArrDuplicata[23].intNumDup)
    Else
      edtNumDup24.Text := '';

    edtSeq24.Text    := ArrDuplicata[23].strSequen;
    edtDtaVen24.Text := DateToStr(StrToDate((ArrDuplicata[23].dtaDtaVen)) + intQtdDia);
    edtVal24.Text    := fFormataFloat(ArrDuplicata[23].curValor, 2).ToString;
    edtChq24.Text    := 'N';
  End
  Else
  Begin
    edtDtaVen24.Enabled := False;
    edtDtaVen24.Clear;
    edtVal24.Enabled := False;
    edtVal24.Text := '0,00';
    edtChq24.Enabled := False;
  End;

  edtNumDup1.Enabled  := blnHabEditDup;
  edtNumDup2.Enabled  := blnHabEditDup;
  edtNumDup3.Enabled  := blnHabEditDup;
  edtNumDup4.Enabled  := blnHabEditDup;
  edtNumDup5.Enabled  := blnHabEditDup;
  edtNumDup6.Enabled  := blnHabEditDup;
  edtNumDup7.Enabled  := blnHabEditDup;
  edtNumDup8.Enabled  := blnHabEditDup;
  edtNumDup9.Enabled  := blnHabEditDup;
  edtNumDup10.Enabled := blnHabEditDup;
  edtNumDup11.Enabled := blnHabEditDup;
  edtNumDup12.Enabled := blnHabEditDup;
  edtNumDup13.Enabled  := blnHabEditDup;
  edtNumDup14.Enabled  := blnHabEditDup;
  edtNumDup15.Enabled  := blnHabEditDup;
  edtNumDup16.Enabled  := blnHabEditDup;
  edtNumDup17.Enabled  := blnHabEditDup;
  edtNumDup18.Enabled  := blnHabEditDup;
  edtNumDup19.Enabled  := blnHabEditDup;
  edtNumDup20.Enabled  := blnHabEditDup;
  edtNumDup21.Enabled  := blnHabEditDup;
  edtNumDup22.Enabled := blnHabEditDup;
  edtNumDup23.Enabled := blnHabEditDup;
  edtNumDup24.Enabled := blnHabEditDup;

  If Not blnHabEditValor Then
  Begin
    edtVal1.Enabled  := False;
    edtVal2.Enabled  := False;
    edtVal3.Enabled  := False;
    edtVal4.Enabled  := False;
    edtVal5.Enabled  := False;
    edtVal6.Enabled  := False;
    edtVal7.Enabled  := False;
    edtVal8.Enabled  := False;
    edtVal9.Enabled  := False;
    edtVal10.Enabled := False;
    edtVal11.Enabled := False;
    edtVal12.Enabled := False;
    edtVal13.Enabled  := False;
    edtVal14.Enabled  := False;
    edtVal15.Enabled  := False;
    edtVal16.Enabled  := False;
    edtVal17.Enabled  := False;
    edtVal18.Enabled  := False;
    edtVal19.Enabled  := False;
    edtVal20.Enabled  := False;
    edtVal21.Enabled  := False;
    edtVal22.Enabled := False;
    edtVal23.Enabled := False;
    edtVal24.Enabled := False;

    btnValoresPadrao.Visible := False;
  End;

end;

procedure TfrmDigDuplicata.pCarregaVenctosOriginais;
  Var
    intCnt : Integer;
    strTmpDat : String;
begin
  For intCnt := 1 To 24 Do
  Begin
    strTmpDat := TMaskEditFocus(FindComponent('edtDtaVen' + fStrZero(intCnt, 2))).Text;
    If (Trim(strTmpDat) <> '/  /') Then
      arrVenOri[intCnt] := strTmpDat
    Else
      arrVenOri[intCnt] := '';
  End;
end;

procedure TfrmDigDuplicata.pSalvaDados;
begin
	// Parcela 1
	If ArrDuplicata[0].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[0].intNumDup := StrToInt(edtNumDup1.Text);

    ArrDuplicata[0].strSequen := edtSeq1.Text;
    ArrDuplicata[0].dtaDtaVen := edtDtaVen01.Text;
    ArrDuplicata[0].curValor  := StringToFloat(edtVal1.Text);
    ArrDuplicata[0].strUsaChq := edtChq01.Text;
  End;
	// Parcela 2
	If ArrDuplicata[1].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[1].intNumDup := StrToInt(edtNumDup2.Text);
      
    ArrDuplicata[1].strSequen := edtSeq2.Text;
    ArrDuplicata[1].dtaDtaVen := edtDtaVen02.Text;
    ArrDuplicata[1].curValor  := StringToFloat(edtVal2.Text);
    ArrDuplicata[1].strUsaChq := edtChq02.Text;
  End;
	// Parcela 3
	If ArrDuplicata[2].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[2].intNumDup := StrToInt(edtNumDup3.Text);

    ArrDuplicata[2].strSequen := edtSeq3.Text;
    ArrDuplicata[2].dtaDtaVen := edtDtaVen03.Text;
    ArrDuplicata[2].curValor  := StringToFloat(edtVal3.Text);
    ArrDuplicata[2].strUsaChq := edtChq03.Text;
  End;
	// Parcela 4
	If ArrDuplicata[3].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[3].intNumDup := StrToInt(edtNumDup4.Text);

    ArrDuplicata[3].strSequen := edtSeq4.Text;
    ArrDuplicata[3].dtaDtaVen := edtDtaVen04.Text;
    ArrDuplicata[3].curValor  := StringToFloat(edtVal4.Text);
    ArrDuplicata[3].strUsaChq := edtChq04.Text;
  End;
	// Parcela 5
	If ArrDuplicata[4].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[4].intNumDup := StrToInt(edtNumDup5.Text);

    ArrDuplicata[4].strSequen := edtSeq5.Text;
    ArrDuplicata[4].dtaDtaVen := edtDtaVen05.Text;
    ArrDuplicata[4].curValor  := StringToFloat(edtVal5.Text);
    ArrDuplicata[4].strUsaChq := edtChq05.Text;
  End;
	// Parcela 6
	If ArrDuplicata[5].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[5].intNumDup := StrToInt(edtNumDup6.Text);

    ArrDuplicata[5].strSequen := edtSeq6.Text;
    ArrDuplicata[5].dtaDtaVen := edtDtaVen06.Text;
    ArrDuplicata[5].curValor  := StringToFloat(edtVal6.Text);
    ArrDuplicata[5].strUsaChq := edtChq06.Text;
  End;
	// Parcela 7
	If ArrDuplicata[6].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[6].intNumDup := StrToInt(edtNumDup7.Text);

    ArrDuplicata[6].strSequen := edtSeq7.Text;
    ArrDuplicata[6].dtaDtaVen := edtDtaVen07.Text;
    ArrDuplicata[6].curValor  := StringToFloat(edtVal7.Text);
    ArrDuplicata[6].strUsaChq := edtChq07.Text;
  End;
	// Parcela 8
	If ArrDuplicata[7].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[7].intNumDup := StrToInt(edtNumDup8.Text);

    ArrDuplicata[7].strSequen := edtSeq8.Text;
    ArrDuplicata[7].dtaDtaVen := edtDtaVen08.Text;
    ArrDuplicata[7].curValor  := StringToFloat(edtVal8.Text);
    ArrDuplicata[7].strUsaChq := edtChq08.Text;
  End;
	// Parcela 9
	If ArrDuplicata[8].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[8].intNumDup := StrToInt(edtNumDup9.Text);

    ArrDuplicata[8].strSequen := edtSeq9.Text;
    ArrDuplicata[8].dtaDtaVen := edtDtaVen09.Text;
    ArrDuplicata[8].curValor  := StringToFloat(edtVal9.Text);
    ArrDuplicata[8].strUsaChq := edtChq09.Text;
  End;
	// Parcela 10
	If ArrDuplicata[9].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[9].intNumDup := StrToInt(edtNumDup10.Text);

    ArrDuplicata[9].strSequen := edtSeq10.Text;
    ArrDuplicata[9].dtaDtaVen := edtDtaVen10.Text;
    ArrDuplicata[9].curValor  := StringToFloat(edtVal10.Text);
    ArrDuplicata[9].strUsaChq := edtChq10.Text;
  End;
	// Parcela 11
	If ArrDuplicata[10].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[10].intNumDup := StrToInt(edtNumDup11.Text);

    ArrDuplicata[10].strSequen := edtSeq11.Text;
    ArrDuplicata[10].dtaDtaVen := edtDtaVen11.Text;
    ArrDuplicata[10].curValor  := StringToFloat(edtVal11.Text);
    ArrDuplicata[10].strUsaChq := edtChq11.Text;
  End;
	// Parcela 12
	If ArrDuplicata[11].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[11].intNumDup := StrToInt(edtNumDup12.Text);

    ArrDuplicata[11].strSequen := edtSeq12.Text;
    ArrDuplicata[11].dtaDtaVen := edtDtaVen12.Text;
    ArrDuplicata[11].curValor  := StringToFloat(edtVal12.Text);
    ArrDuplicata[11].strUsaChq := edtChq12.Text;
  End;
	// Parcela 13
	If ArrDuplicata[12].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[12].intNumDup := StrToInt(edtNumDup13.Text);

    ArrDuplicata[12].strSequen := edtSeq13.Text;
    ArrDuplicata[12].dtaDtaVen := edtDtaVen13.Text;
    ArrDuplicata[12].curValor  := StringToFloat(edtVal13.Text);
    ArrDuplicata[12].strUsaChq := edtChq13.Text;
  End;
	// Parcela 14
	If ArrDuplicata[13].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[13].intNumDup := StrToInt(edtNumDup14.Text);

    ArrDuplicata[13].strSequen := edtSeq14.Text;
    ArrDuplicata[13].dtaDtaVen := edtDtaVen14.Text;
    ArrDuplicata[13].curValor  := StringToFloat(edtVal14.Text);
    ArrDuplicata[13].strUsaChq := edtChq14.Text;
  End;
	// Parcela 15
	If ArrDuplicata[14].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[14].intNumDup := StrToInt(edtNumDup15.Text);

    ArrDuplicata[14].strSequen := edtSeq15.Text;
    ArrDuplicata[14].dtaDtaVen := edtDtaVen15.Text;
    ArrDuplicata[14].curValor  := StringToFloat(edtVal15.Text);
    ArrDuplicata[14].strUsaChq := edtChq15.Text;
  End;
	// Parcela 16
	If ArrDuplicata[15].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[15].intNumDup := StrToInt(edtNumDup16.Text);

    ArrDuplicata[15].strSequen := edtSeq16.Text;
    ArrDuplicata[15].dtaDtaVen := edtDtaVen16.Text;
    ArrDuplicata[15].curValor  := StringToFloat(edtVal16.Text);
    ArrDuplicata[15].strUsaChq := edtChq16.Text;
  End;
	// Parcela 17
	If ArrDuplicata[16].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[16].intNumDup := StrToInt(edtNumDup17.Text);

    ArrDuplicata[16].strSequen := edtSeq17.Text;
    ArrDuplicata[16].dtaDtaVen := edtDtaVen17.Text;
    ArrDuplicata[16].curValor  := StringToFloat(edtVal17.Text);
    ArrDuplicata[16].strUsaChq := edtChq17.Text;
  End;
	// Parcela 18
	If ArrDuplicata[17].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[17].intNumDup := StrToInt(edtNumDup18.Text);

    ArrDuplicata[17].strSequen := edtSeq18.Text;
    ArrDuplicata[17].dtaDtaVen := edtDtaVen18.Text;
    ArrDuplicata[17].curValor  := StringToFloat(edtVal18.Text);
    ArrDuplicata[17].strUsaChq := edtChq18.Text;
  End;
	// Parcela 19
	If ArrDuplicata[18].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[18].intNumDup := StrToInt(edtNumDup19.Text);

    ArrDuplicata[18].strSequen := edtSeq19.Text;
    ArrDuplicata[18].dtaDtaVen := edtDtaVen19.Text;
    ArrDuplicata[18].curValor  := StringToFloat(edtVal19.Text);
    ArrDuplicata[18].strUsaChq := edtChq19.Text;
  End;
	// Parcela 20
	If ArrDuplicata[19].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[19].intNumDup := StrToInt(edtNumDup20.Text);

    ArrDuplicata[19].strSequen := edtSeq20.Text;
    ArrDuplicata[19].dtaDtaVen := edtDtaVen20.Text;
    ArrDuplicata[19].curValor  := StringToFloat(edtVal20.Text);
    ArrDuplicata[19].strUsaChq := edtChq20.Text;
  End;
	// Parcela 21
	If ArrDuplicata[20].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[20].intNumDup := StrToInt(edtNumDup21.Text);

    ArrDuplicata[20].strSequen := edtSeq21.Text;
    ArrDuplicata[20].dtaDtaVen := edtDtaVen21.Text;
    ArrDuplicata[20].curValor  := StringToFloat(edtVal21.Text);
    ArrDuplicata[20].strUsaChq := edtChq21.Text;
  End;
	// Parcela 22
	If ArrDuplicata[21].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[21].intNumDup := StrToInt(edtNumDup22.Text);

    ArrDuplicata[21].strSequen := edtSeq22.Text;
    ArrDuplicata[21].dtaDtaVen := edtDtaVen22.Text;
    ArrDuplicata[21].curValor  := StringToFloat(edtVal22.Text);
    ArrDuplicata[21].strUsaChq := edtChq22.Text;
  End;
	// Parcela 23
	If ArrDuplicata[22].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[22].intNumDup := StrToInt(edtNumDup23.Text);

    ArrDuplicata[22].strSequen := edtSeq23.Text;
    ArrDuplicata[22].dtaDtaVen := edtDtaVen23.Text;
    ArrDuplicata[22].curValor  := StringToFloat(edtVal23.Text);
    ArrDuplicata[22].strUsaChq := edtChq23.Text;
  End;
	// Parcela 24
	If ArrDuplicata[23].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  ArrDuplicata[23].intNumDup := StrToInt(edtNumDup24.Text);

    ArrDuplicata[23].strSequen := edtSeq24.Text;
    ArrDuplicata[23].dtaDtaVen := edtDtaVen24.Text;
    ArrDuplicata[23].curValor  := StringToFloat(edtVal24.Text);
    ArrDuplicata[23].strUsaChq := edtChq24.Text;
  End;
end;

procedure TfrmDigDuplicata.pSalvaDadosVeri;
begin
	// Parcela 1
	If arrDuplicata[0].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[0].intNumDup := StrToInt(edtNumDup1.Text);

    arrDuplic[0].strSequen := edtSeq1.Text;
    arrDuplic[0].dtaDtaVen := edtDtaVen01.Text;
    arrDuplic[0].curValor  := StringToFloat(edtVal1.Text);
    arrDuplic[0].strUsaChq := edtChq01.Text;
  End;
	// Parcela 2
	If arrDuplicata[1].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[1].intNumDup := StrToInt(edtNumDup2.Text);

    arrDuplic[1].strSequen := edtSeq2.Text;
    arrDuplic[1].dtaDtaVen := edtDtaVen02.Text;
    arrDuplic[1].curValor  := StringToFloat(edtVal2.Text);
    arrDuplic[1].strUsaChq := edtChq02.Text;
  End;
	// Parcela 3
	If arrDuplicata[2].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[2].intNumDup := StrToInt(edtNumDup3.Text);

    arrDuplic[2].strSequen := edtSeq3.Text;
    arrDuplic[2].dtaDtaVen := edtDtaVen03.Text;
    arrDuplic[2].curValor  := StringToFloat(edtVal3.Text);
    arrDuplic[2].strUsaChq := edtChq03.Text;
  End;
	// Parcela 4
	If arrDuplicata[3].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[3].intNumDup := StrToInt(edtNumDup4.Text);

    arrDuplic[3].strSequen := edtSeq4.Text;
    arrDuplic[3].dtaDtaVen := edtDtaVen04.Text;
    arrDuplic[3].curValor  := StringToFloat(edtVal4.Text);
    arrDuplic[3].strUsaChq := edtChq04.Text;
  End;
	// Parcela 5
	If arrDuplicata[4].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[4].intNumDup := StrToInt(edtNumDup5.Text);

    arrDuplic[4].strSequen := edtSeq5.Text;
    arrDuplic[4].dtaDtaVen := edtDtaVen05.Text;
    arrDuplic[4].curValor  := StringToFloat(edtVal5.Text);
    arrDuplic[4].strUsaChq := edtChq05.Text;
  End;
	// Parcela 6
	If arrDuplicata[5].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[5].intNumDup := StrToInt(edtNumDup6.Text);

    arrDuplic[5].strSequen := edtSeq6.Text;
    arrDuplic[5].dtaDtaVen := edtDtaVen06.Text;
    arrDuplic[5].curValor  := StringToFloat(edtVal6.Text);
    arrDuplic[5].strUsaChq := edtChq06.Text;
  End;
	// Parcela 7
	If arrDuplicata[6].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[6].intNumDup := StrToInt(edtNumDup7.Text);

    arrDuplic[6].strSequen := edtSeq7.Text;
    arrDuplic[6].dtaDtaVen := edtDtaVen07.Text;
    arrDuplic[6].curValor  := StringToFloat(edtVal7.Text);
    arrDuplic[6].strUsaChq := edtChq07.Text;
  End;
	// Parcela 8
	If arrDuplicata[7].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[7].intNumDup := StrToInt(edtNumDup8.Text);

    arrDuplic[7].strSequen := edtSeq8.Text;
    arrDuplic[7].dtaDtaVen := edtDtaVen08.Text;
    arrDuplic[7].curValor  := StringToFloat(edtVal8.Text);
    arrDuplic[7].strUsaChq := edtChq08.Text;
  End;
	// Parcela 9
	If arrDuplicata[8].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[8].intNumDup := StrToInt(edtNumDup9.Text);

    arrDuplic[8].strSequen := edtSeq9.Text;
    arrDuplic[8].dtaDtaVen := edtDtaVen09.Text;
    arrDuplic[8].curValor  := StringToFloat(edtVal9.Text);
    arrDuplic[8].strUsaChq := edtChq09.Text;
  End;
	// Parcela 10
	If arrDuplicata[9].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[9].intNumDup := StrToInt(edtNumDup10.Text);

    arrDuplic[9].strSequen := edtSeq10.Text;
    arrDuplic[9].dtaDtaVen := edtDtaVen10.Text;
    arrDuplic[9].curValor  := StringToFloat(edtVal10.Text);
    arrDuplic[9].strUsaChq := edtChq10.Text;
  End;
	// Parcela 11
	If arrDuplicata[10].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[10].intNumDup := StrToInt(edtNumDup11.Text);

    arrDuplic[10].strSequen := edtSeq11.Text;
    arrDuplic[10].dtaDtaVen := edtDtaVen11.Text;
    arrDuplic[10].curValor  := StringToFloat(edtVal11.Text);
    arrDuplic[10].strUsaChq := edtChq11.Text;
  End;
	// Parcela 12
	If arrDuplicata[11].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[11].intNumDup := StrToInt(edtNumDup12.Text);

    arrDuplic[11].strSequen := edtSeq12.Text;
    arrDuplic[11].dtaDtaVen := edtDtaVen12.Text;
    arrDuplic[11].curValor  := StringToFloat(edtVal12.Text);
    arrDuplic[11].strUsaChq := edtChq12.Text;
  End;
	// Parcela 13
	If arrDuplicata[12].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[12].intNumDup := StrToInt(edtNumDup13.Text);

    arrDuplic[12].strSequen := edtSeq13.Text;
    arrDuplic[12].dtaDtaVen := edtDtaVen13.Text;
    arrDuplic[12].curValor  := StringToFloat(edtVal13.Text);
    arrDuplic[12].strUsaChq := edtChq13.Text;
  End;
	// Parcela 14
	If arrDuplicata[13].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[13].intNumDup := StrToInt(edtNumDup14.Text);

    arrDuplic[13].strSequen := edtSeq14.Text;
    arrDuplic[13].dtaDtaVen := edtDtaVen14.Text;
    arrDuplic[13].curValor  := StringToFloat(edtVal14.Text);
    arrDuplic[13].strUsaChq := edtChq14.Text;
  End;
	// Parcela 15
	If arrDuplicata[14].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[14].intNumDup := StrToInt(edtNumDup15.Text);

    arrDuplic[14].strSequen := edtSeq15.Text;
    arrDuplic[14].dtaDtaVen := edtDtaVen15.Text;
    arrDuplic[14].curValor  := StringToFloat(edtVal15.Text);
    arrDuplic[14].strUsaChq := edtChq15.Text;
  End;
	// Parcela 16
	If arrDuplicata[15].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[15].intNumDup := StrToInt(edtNumDup16.Text);

    arrDuplic[15].strSequen := edtSeq16.Text;
    arrDuplic[15].dtaDtaVen := edtDtaVen16.Text;
    arrDuplic[15].curValor  := StringToFloat(edtVal16.Text);
    arrDuplic[15].strUsaChq := edtChq16.Text;
  End;
	// Parcela 17
	If arrDuplicata[16].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[16].intNumDup := StrToInt(edtNumDup17.Text);

    arrDuplic[16].strSequen := edtSeq17.Text;
    arrDuplic[16].dtaDtaVen := edtDtaVen17.Text;
    arrDuplic[16].curValor  := StringToFloat(edtVal17.Text);
    arrDuplic[16].strUsaChq := edtChq17.Text;
  End;
	// Parcela 18
	If arrDuplicata[17].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[17].intNumDup := StrToInt(edtNumDup18.Text);

    arrDuplic[17].strSequen := edtSeq18.Text;
    arrDuplic[17].dtaDtaVen := edtDtaVen18.Text;
    arrDuplic[17].curValor  := StringToFloat(edtVal18.Text);
    arrDuplic[17].strUsaChq := edtChq18.Text;
  End;
	// Parcela 19
	If arrDuplicata[18].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[18].intNumDup := StrToInt(edtNumDup19.Text);

    arrDuplic[18].strSequen := edtSeq19.Text;
    arrDuplic[18].dtaDtaVen := edtDtaVen19.Text;
    arrDuplic[18].curValor  := StringToFloat(edtVal19.Text);
    arrDuplic[18].strUsaChq := edtChq19.Text;
  End;
	// Parcela 20
	If arrDuplicata[19].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[19].intNumDup := StrToInt(edtNumDup20.Text);

    arrDuplic[19].strSequen := edtSeq20.Text;
    arrDuplic[19].dtaDtaVen := edtDtaVen20.Text;
    arrDuplic[19].curValor  := StringToFloat(edtVal20.Text);
    arrDuplic[19].strUsaChq := edtChq20.Text;
  End;
	// Parcela 21
	If arrDuplicata[20].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[20].intNumDup := StrToInt(edtNumDup21.Text);

    arrDuplic[20].strSequen := edtSeq21.Text;
    arrDuplic[20].dtaDtaVen := edtDtaVen21.Text;
    arrDuplic[20].curValor  := StringToFloat(edtVal21.Text);
    arrDuplic[20].strUsaChq := edtChq21.Text;
  End;
	// Parcela 22
	If arrDuplicata[21].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[21].intNumDup := StrToInt(edtNumDup22.Text);

    arrDuplic[21].strSequen := edtSeq22.Text;
    arrDuplic[21].dtaDtaVen := edtDtaVen22.Text;
    arrDuplic[21].curValor  := StringToFloat(edtVal22.Text);
    arrDuplic[21].strUsaChq := edtChq22.Text;
  End;
	// Parcela 23
	If arrDuplicata[22].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[22].intNumDup := StrToInt(edtNumDup23.Text);

    arrDuplic[22].strSequen := edtSeq23.Text;
    arrDuplic[22].dtaDtaVen := edtDtaVen23.Text;
    arrDuplic[22].curValor  := StringToFloat(edtVal23.Text);
    arrDuplic[22].strUsaChq := edtChq23.Text;
  End;
	// Parcela 24
	If arrDuplicata[23].strSequen <> '' Then
  Begin
    If blnHabEditDup Then
  	  arrDuplic[23].intNumDup := StrToInt(edtNumDup24.Text);

    arrDuplic[23].strSequen := edtSeq24.Text;
    arrDuplic[23].dtaDtaVen := edtDtaVen24.Text;
    arrDuplic[23].curValor  := StringToFloat(edtVal24.Text);
    arrDuplic[23].strUsaChq := edtChq24.Text;
  End;
end;

procedure TfrmDigDuplicata.pHabilita;
begin
	edtDtaVen01.Enabled := blnEditavel;
	edtDtaVen02.Enabled := blnEditavel;
	edtDtaVen03.Enabled := blnEditavel;
	edtDtaVen04.Enabled := blnEditavel;
	edtDtaVen05.Enabled := blnEditavel;
	edtDtaVen06.Enabled := blnEditavel;
	edtDtaVen07.Enabled := blnEditavel;
	edtDtaVen08.Enabled := blnEditavel;
	edtDtaVen09.Enabled := blnEditavel;
	edtDtaVen10.Enabled := blnEditavel;
	edtDtaVen11.Enabled := blnEditavel;
	edtDtaVen12.Enabled := blnEditavel;
	edtDtaVen13.Enabled := blnEditavel;
	edtDtaVen14.Enabled := blnEditavel;
	edtDtaVen15.Enabled := blnEditavel;
	edtDtaVen16.Enabled := blnEditavel;
	edtDtaVen17.Enabled := blnEditavel;
	edtDtaVen18.Enabled := blnEditavel;
	edtDtaVen19.Enabled := blnEditavel;
	edtDtaVen20.Enabled := blnEditavel;
	edtDtaVen21.Enabled := blnEditavel;
	edtDtaVen22.Enabled := blnEditavel;
	edtDtaVen23.Enabled := blnEditavel;
	edtDtaVen24.Enabled := blnEditavel;
end;

procedure TfrmDigDuplicata.edtVal1Exit(Sender: TObject);
begin
  inherited;

  If (btnSairDig.Focused Or btnValoresPadrao.Focused) And blnMostrarOpcaoPadrao Then
    Exit;

  If blnCarregando Then
    Exit;

  fValidaEdtsValor(StrToInt(RightStr(TEditFocus(Sender).Name, 1)));
  pSomaValor(TEditFocus(Sender));
end;

procedure TfrmDigDuplicata.btnSalvarClick(Sender: TObject);
  Var
    intContador: Integer;
    arrDatas   : TDateArray;
    strCndTmp  : String;
    strSen     : String;
    blnAltMais,
    blnAltMenos: Boolean;
    dtaDtaTmp : TDateTime;
    fltRestante: Double;
    curValor : Currency;
    AData1, AData2: TDateTime;
    AQuantidadeDias: Integer;
begin
  inherited;

  if blnAgrupVeio then
  begin
    curValor := 0;
    curValor := curValor + fStrToFloat(edtVal1.Text);
    curValor := curValor + fStrToFloat(edtVal2.Text);
    curValor := curValor + fStrToFloat(edtVal3.Text);
    curValor := curValor + fStrToFloat(edtVal4.Text);
    curValor := curValor + fStrToFloat(edtVal5.Text);
    curValor := curValor + fStrToFloat(edtVal6.Text);
    curValor := curValor + fStrToFloat(edtVal7.Text);
    curValor := curValor + fStrToFloat(edtVal8.Text);
    curValor := curValor + fStrToFloat(edtVal9.Text);
    curValor := curValor + fStrToFloat(edtVal10.Text);
    curValor := curValor + fStrToFloat(edtVal11.Text);
    curValor := curValor + fStrToFloat(edtVal12.Text);
    curValor := curValor + fStrToFloat(edtVal13.Text);
    curValor := curValor + fStrToFloat(edtVal14.Text);
    curValor := curValor + fStrToFloat(edtVal15.Text);
    curValor := curValor + fStrToFloat(edtVal16.Text);
    curValor := curValor + fStrToFloat(edtVal17.Text);
    curValor := curValor + fStrToFloat(edtVal18.Text);
    curValor := curValor + fStrToFloat(edtVal19.Text);
    curValor := curValor + fStrToFloat(edtVal20.Text);
    curValor := curValor + fStrToFloat(edtVal21.Text);
    curValor := curValor + fStrToFloat(edtVal22.Text);
    curValor := curValor + fStrToFloat(edtVal23.Text);
    curValor := curValor + fStrToFloat(edtVal24.Text);

    fltRestante := curTotalPed - curValor;

    If (fltRestante < 0.0) Then
    Begin
      fMensagem('', 'Valor não permitido para parcelamento em ' + IntToStr(intQtdPar) + ' vezes!', ['&Ok']);
      Exit;
    End;

    //SOMANDO DATAS PARA CALCULAR O PRAZO MÉDIO
    //SOMENTE SE FOR DO AGRUPAMENTO
    if AFormVeio = 'AGRUPAMENTO' then
    begin
      intContador := 1;
      AQuantidadeDias := 0;
      AData1 := 0;
      AData2 := 0;

      while intContador <= intQtdPar Do
      Begin
        case intContador Of
          1:begin
            AData1 := VS_Date;
            AData2 := StrToDateTime(edtDtaVen01.Text);
          end;

          2:begin
            AData1 := StrToDateTime(edtDtaVen01.Text);
            AData2 := StrToDateTime(edtDtaVen02.Text);
          end;

          3:begin
            AData1 := StrToDateTime(edtDtaVen02.Text);
            AData2 := StrToDateTime(edtDtaVen03.Text);
          end;

          4:begin
            AData1 := StrToDateTime(edtDtaVen03.Text);
            AData2 := StrToDateTime(edtDtaVen04.Text);
          end;

          5:begin
            AData1 := StrToDateTime(edtDtaVen04.Text);
            AData2 := StrToDateTime(edtDtaVen05.Text);
          end;

          6:begin
            AData1 := StrToDateTime(edtDtaVen05.Text);
            AData2 := StrToDateTime(edtDtaVen06.Text);
          end;

          7:begin
            AData1 := StrToDateTime(edtDtaVen06.Text);
            AData2 := StrToDateTime(edtDtaVen07.Text);
          end;

          8:begin
            AData1 := StrToDateTime(edtDtaVen07.Text);
            AData2 := StrToDateTime(edtDtaVen08.Text);
          end;

          9:begin
            AData1 := StrToDateTime(edtDtaVen08.Text);
            AData2 := StrToDateTime(edtDtaVen09.Text);
          end;

          10:begin
            AData1 := StrToDateTime(edtDtaVen09.Text);
            AData2 := StrToDateTime(edtDtaVen10.Text);
          end;

          11:begin
            AData1 := StrToDateTime(edtDtaVen10.Text);
            AData2 := StrToDateTime(edtDtaVen11.Text);
          end;

          12:begin
            AData1 := StrToDateTime(edtDtaVen11.Text);
            AData2 := StrToDateTime(edtDtaVen12.Text);
          end;

          13:begin
            AData1 := StrToDateTime(edtDtaVen12.Text);
            AData2 := StrToDateTime(edtDtaVen13.Text);
          end;
          14:begin
            AData1 := StrToDateTime(edtDtaVen13.Text);
            AData2 := StrToDateTime(edtDtaVen14.Text);
          end;
          15:begin
            AData1 := StrToDateTime(edtDtaVen14.Text);
            AData2 := StrToDateTime(edtDtaVen15.Text);
          end;
          16:begin
            AData1 := StrToDateTime(edtDtaVen15.Text);
            AData2 := StrToDateTime(edtDtaVen16.Text);
          end;
          17:begin
            AData1 := StrToDateTime(edtDtaVen16.Text);
            AData2 := StrToDateTime(edtDtaVen17.Text);
          end;
          18:begin
            AData1 := StrToDateTime(edtDtaVen17.Text);
            AData2 := StrToDateTime(edtDtaVen18.Text);
          end;
          19:begin
            AData1 := StrToDateTime(edtDtaVen18.Text);
            AData2 := StrToDateTime(edtDtaVen19.Text);
          end;
          20:begin
            AData1 := StrToDateTime(edtDtaVen19.Text);
            AData2 := StrToDateTime(edtDtaVen20.Text);
          end;
          21:begin
            AData1 := StrToDateTime(edtDtaVen20.Text);
            AData2 := StrToDateTime(edtDtaVen21.Text);
          end;
          22:begin
            AData1 := StrToDateTime(edtDtaVen21.Text);
            AData2 := StrToDateTime(edtDtaVen22.Text);
          end;
          23:begin
            AData1 := StrToDateTime(edtDtaVen22.Text);
            AData2 := StrToDateTime(edtDtaVen23.Text);
          end;
          24:begin
            AData1 := StrToDateTime(edtDtaVen23.Text);
            AData2 := StrToDateTime(edtDtaVen24.Text);
          end;


        End;

        Inc(intContador);
        AQuantidadeDias := AQuantidadeDias + DaysBetween(AData1, AData2);
      end;


      if Not (CalculaPrazoMedioCondicaoPagamento('', AQuantidadeDias, intQtdPar, blnTelaAgrupamento))
      And Not (blnTelaAgrupamento) Then
        Exit;
    end;
  end;

  If Not fVerificaCampos Then
    Exit;

  If Not fValidaEdtsValor Then
    Exit;

  If Not fValidaEdtsData Then
    Exit;

  If blnFaturamento Then
  Begin
    intContador := 0;
    pSalvaDadosVeri;

    If Not fValidaVencimentos Then
      Exit;

    {*****************************************}
    {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
    {**************************************AF*}
    While (arrDuplic[intContador].dtaDtaVen <> '') And
          (intContador < 24)                       Do
    Begin

      SetLength(arrDatas, intContador+1);
      arrDatas[intContador] := StrToDate(arrDuplic[intContador].dtaDtaVen);
      Inc(intContador);

    End;

    dtaDtaTmp := VS_Date;
    If (Pos(strEspDoc, 'OR_PD_') > 0) Then
      dtaDtaTmp := dtaDtaBas;

    strCndTmp := fRetornaCndPag(arrDatas, dtaDtaTmp);

    If (blnEditavel) And (Trim(strCndTmp) <> Trim(strCndPag)) And (fAlterouVenctos) Then
    Begin
      blnAltMais := fCalcMediaPagto(strCndTmp) > fCalcMediaPagto(strCndPag);
      blnAltMenos := fCalcMediaPagto(strCndTmp) < fCalcMediaPagto(strCndPag);

      {*************************************************************************}
      {* VERIFICA SENHA QUE PERMITE ALTERAR VENCIMENTO PARA MAIS OU PARA MENOS *}
      {**********************************************************************AL*}
      If ((blnAltMais)  And (Not fEmptyStr(fCfgSis('SENVNM')))) Or
         ((blnAltMenos) And (Not fEmptyStr(fCfgSis('SENVNC')))) Then
      Begin
        If ffrmSenha(strSen, IIF(blnAltMais, 'Alterar cond.pag. para mais', 'Alterar cond.pag. para menos')) Then
        Begin
          If (blnAltMenos) And (strSen <> fCfgSis('SENVNC')) Then
            Exit;

          If (blnAltMais)  And (strSen <> fCfgSis('SENVNM')) Then
            Exit;
        End
        Else
          Exit;
      End;
    End;
  End;

  If StringToFloat(edtVlFalta.Text) = 0 Then
  Begin
    If (blnPergConf) Then
    Begin
      If (fMensagem('','Confirma Dados? ',['&Sim', '&Não']) = 1)  Then
      Begin
        pSalvaDados;
        blnConfirma := True;
        Close;
      End;
    End
    Else
    Begin
      pSalvaDados;
      blnConfirma := True;
      Close;
    End;
  End
  Else
  Begin
    fMensagem('','Valor digitado tem que ser igual ao valor do pedido.', ['&O k']);
    pSetFocus(edtVal1);
  End;
end;

procedure TfrmDigDuplicata.pFormataValores;
begin
  If fEmptyStr(edtVal1.Text) Then
    edtVal1.Text := '0,00';

  If fEmptyStr(edtVal2.Text) Then
    edtVal2.Text := '0,00';

  If fEmptyStr(edtVal3.Text) Then
    edtVal3.Text := '0,00';

  If fEmptyStr(edtVal4.Text) Then
    edtVal4.Text := '0,00';

  If fEmptyStr(edtVal5.Text) Then
    edtVal5.Text := '0,00';

  If fEmptyStr(edtVal6.Text) Then
    edtVal6.Text := '0,00';

  If fEmptyStr(edtVal7.Text) Then
    edtVal7.Text := '0,00';

  If fEmptyStr(edtVal8.Text) Then
    edtVal8.Text := '0,00';

  If fEmptyStr(edtVal9.Text) Then
    edtVal9.Text := '0,00';

  If fEmptyStr(edtVal10.Text) Then
    edtVal10.Text := '0,00';

  If fEmptyStr(edtVal11.Text) Then
    edtVal11.Text := '0,00';

  If fEmptyStr(edtVal12.Text) Then
    edtVal12.Text := '0,00';

  If fEmptyStr(edtVal13.Text) Then
    edtVal13.Text := '0,00';

  If fEmptyStr(edtVal14.Text) Then
    edtVal14.Text := '0,00';

  If fEmptyStr(edtVal15.Text) Then
    edtVal15.Text := '0,00';

  If fEmptyStr(edtVal16.Text) Then
    edtVal16.Text := '0,00';

  If fEmptyStr(edtVal17.Text) Then
    edtVal17.Text := '0,00';

  If fEmptyStr(edtVal18.Text) Then
    edtVal18.Text := '0,00';

  If fEmptyStr(edtVal19.Text) Then
    edtVal9.Text := '0,00';

  If fEmptyStr(edtVal20.Text) Then
    edtVal20.Text := '0,00';

  If fEmptyStr(edtVal21.Text) Then
    edtVal21.Text := '0,00';

  If fEmptyStr(edtVal22.Text) Then
    edtVal22.Text := '0,00';

  If fEmptyStr(edtVal23.Text) Then
    edtVal23.Text := '0,00';

  If fEmptyStr(edtVal24.Text) Then
    edtVal24.Text := '0,00';

  edtVal1.Text  := FloatToStrF(fStrToFloat(edtVal1.Text), ffNumber, 14, 2);
  edtVal2.Text  := FloatToStrF(fStrToFloat(edtVal2.Text), ffNumber, 14, 2);
  edtVal3.Text  := FloatToStrF(fStrToFloat(edtVal3.Text), ffNumber, 14, 2);
  edtVal4.Text  := FloatToStrF(fStrToFloat(edtVal4.Text), ffNumber, 14, 2);
  edtVal5.Text  := FloatToStrF(fStrToFloat(edtVal5.Text), ffNumber, 14, 2);
  edtVal6.Text  := FloatToStrF(fStrToFloat(edtVal6.Text), ffNumber, 14, 2);
  edtVal7.Text  := FloatToStrF(fStrToFloat(edtVal7.Text), ffNumber, 14, 2);
  edtVal8.Text  := FloatToStrF(fStrToFloat(edtVal8.Text), ffNumber, 14, 2);
  edtVal9.Text  := FloatToStrF(fStrToFloat(edtVal9.Text), ffNumber, 14, 2);
  edtVal10.Text := FloatToStrF(fStrToFloat(edtVal10.Text), ffNumber, 14, 2);
  edtVal11.Text := FloatToStrF(fStrToFloat(edtVal11.Text), ffNumber, 14, 2);
  edtVal12.Text := FloatToStrF(fStrToFloat(edtVal12.Text), ffNumber, 14, 2);
  edtVal13.Text := FloatToStrF(fStrToFloat(edtVal13.Text), ffNumber, 14, 2);
  edtVal14.Text := FloatToStrF(fStrToFloat(edtVal14.Text), ffNumber, 14, 2);
  edtVal15.Text := FloatToStrF(fStrToFloat(edtVal15.Text), ffNumber, 14, 2);
  edtVal16.Text := FloatToStrF(fStrToFloat(edtVal16.Text), ffNumber, 14, 2);
  edtVal17.Text := FloatToStrF(fStrToFloat(edtVal17.Text), ffNumber, 14, 2);
  edtVal18.Text := FloatToStrF(fStrToFloat(edtVal18.Text), ffNumber, 14, 2);
  edtVal19.Text := FloatToStrF(fStrToFloat(edtVal19.Text), ffNumber, 14, 2);
  edtVal20.Text := FloatToStrF(fStrToFloat(edtVal20.Text), ffNumber, 14, 2);
  edtVal21.Text := FloatToStrF(fStrToFloat(edtVal21.Text), ffNumber, 14, 2);
  edtVal22.Text := FloatToStrF(fStrToFloat(edtVal22.Text), ffNumber, 14, 2);
  edtVal23.Text := FloatToStrF(fStrToFloat(edtVal23.Text), ffNumber, 14, 2);
  edtVal24.Text := FloatToStrF(fStrToFloat(edtVal24.Text), ffNumber, 14, 2);
end;

procedure TfrmDigDuplicata.btnSairClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmDigDuplicata.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
  blnConfirma := False;
  blnHabEditValor := True;
  blnTelaAgrupamento := False;
  pMostraContaCorrente := Nil;
  fSenVar := Nil;

  blnCarregando := False;
  blnMostrarOpcaoPadrao := False;

  fltTotalCredito := 0;
  stlDupCredito  := TStringList.Create;
  stlDupCreditoX := TStringList.Create;
  stlLckDup := TStringList.Create;
end;

procedure TfrmDigDuplicata.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlLckDup);
end;

procedure TfrmDigDuplicata.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SetLength(arrDuplicatasBkp, 0);
  If Not blnConfirma Then
    pZeraDigDuplic(arrDuplicata^);
end;

procedure TfrmDigDuplicata.edtDtaVen01Exit(Sender: TObject);
begin
  inherited;

  If (btnSairDig.Focused Or btnValoresPadrao.Focused) And blnMostrarOpcaoPadrao Then
    Exit;

  If blnCarregando Then
    Exit;

  If fEmptyStr(fTiraCaracEspeciais(edtDtaVen01.Text)) Then
  Begin
    fMensagem('', 'Todas as datas devem ser digitadas!', ['&O k']);
    pSetFocus(edtDtaVen01);
  End
  Else If (StrToDateDef(edtDtaVen01.Text, 0) = 0) Then
  Begin
    fMensagem('', edtDtaVen01.Text + ' não é uma data válida!', ['&Ok']);
    pSetFocus(edtDtaVen01);
  End
  Else If (StrToDateDef(edtDtaVen01.Text, 0) < dtaDtaBas) Then
  Begin
    fMensagem('', 'A data inicial deve ser maior que ' + DateToStr(dtaDtaBas), ['&Ok']);
    pSetFocus(edtDtaVen01);
  End;

end;

procedure TfrmDigDuplicata.edtDtaVen02Exit(Sender: TObject);
  Var
    strEditAnt: String;
    mskAtual: TMaskEdit;
    mskTemp : TMaskEdit;
    blnConfirma: Boolean;

    dtaDtaAnt: TDateTime;
    dtaDtaAtu: TDateTime;
begin
  inherited;

  If (btnSairDig.Focused Or btnValoresPadrao.Focused) And blnMostrarOpcaoPadrao Then
    Exit;

  If blnCarregando Then
    Exit;

  blnConfirma := True;
  mskAtual    := (Sender As TMaskEdit);

  strEditAnt  :=  fStrZero(IntToStr(StrToInt(RightStr(mskAtual.Name, 2)) - 1), 2);
  mskTemp     := (fComponentByName(pnlDuplics, 'edtDtaVen' + strEditAnt) As TMaskEdit);

  If fEmptyStr(fTiraCaracEspeciais(mskTemp.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Todas as datas devem ser preenchidas!', ['&O k']);
    blnConfirma := False;
    pSetFocus(mskTemp);
  End
  Else If fEmptyStr(fTiraCaracEspeciais(mskAtual.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Todas as datas devem ser preenchidas!', ['&O k']);
    blnConfirma := False;
    pSetFocus(mskAtual);
  End
  Else If (StrToDateDef(mskAtual.Text, 0) = 0) Then
  Begin
    fMensagem('', mskAtual.Text + ' não é uma data válida!', ['&Ok']);
    blnConfirma := False;
    pSetFocus(mskAtual);
  End;

  If blnConfirma Then
  Begin
    dtaDtaAnt := StrToDateDef(mskTemp.Text,  0);
    dtaDtaAtu := StrToDateDef(mskAtual.Text, 0);

    {**************************************************}
    {* VERIFICA SE PERMITE REPETIR O MESMO VENCIMENTO *}
    {***********************************************PZ*}
    If (blnPerRep) And (dtaDtaAnt > dtaDtaAtu) Then
    Begin
      fMensagem('', 'A data digitada não deve ser menor que a data do vencimento anterior!', ['&Ok']);
      pSetFocus(mskAtual);
    End
    Else If (Not blnPerRep) And (dtaDtaAnt >= dtaDtaAtu) Then
    Begin
      fMensagem('', 'A data digitada deve ser maior que a data do vencimento anterior!', ['&Ok']);
      pSetFocus(mskAtual);
    End;

  End;

end;

{***********************************************}
{* SOMA OS VALORES DIGITADOS ABAIXO DE edtBase *}
{* SE blnInclusive FOR VERDADEIRO, O VALOR DE  *}
{* edtBase ENTRA NO TOTAL                      *}
{********************************************MV*}
function TfrmDigDuplicata.fSomaTotalAbaixo(edtBase: TEditFocus;
  blnInclusive: Boolean): Double;
  Var
    intContador: Integer;
    intBase: Integer;
    strBase: String;
    edtAtual: TEditFocus;
begin

  strBase := RightStr(edtBase.Name, 2);
  If (Not fIsNumber(strBase)) Then
    strBase := RightStr(strBase, 1);

  intBase := StrToInt(strBase);
  If (Not blnInclusive) Then
    Inc(intBase);

  Result := 0.0;
  For intContador := intBase To intQtdPar Do
  Begin

    edtAtual := TEditFocus(fComponentByName(pnlDuplics, 'edtVal' + IntToStr(intContador)));
    If (edtAtual = Nil) Then
    Begin
      Continue;
    End;

    If (fEmptyStr(edtAtual.Text)) Then
    Begin
      Continue;
    End;

    Result := Result + fStrToFloat(edtAtual.Text);

  End;

end;

function TfrmDigDuplicata.fSomaTotalAcima(edtBase: TEditFocus;
  blnInclusive: Boolean): Double;
  Var
    intContador: Integer;
    intBase: Integer;
    strBase: String;
    edtAtual: TEditFocus;
begin

  strBase := RightStr(edtBase.Name, 2);
  If (Not fIsNumber(strBase)) Then
    strBase := RightStr(strBase, 1);

  intBase := StrToInt(strBase);
  If (Not blnInclusive) Then
    Dec(intBase);

  Result := 0.0;
  For intContador := intBase DownTo 1 Do
  Begin

    edtAtual := TEditFocus(fComponentByName(pnlDuplics, 'edtVal' + IntToStr(intContador)));
    If (edtAtual = Nil) Then
    Begin
      Continue;
    End;

    If (Not edtAtual.Enabled) Then
    Begin
      Continue;
    End;

    If (fEmptyStr(edtAtual.Text)) Then
    Begin
      Continue;
    End;

    Result := Result + fStrToFloat(edtAtual.Text);

  End;

end;

{********************************************************}
{* PARA CADA VALOR DIGITADO, SE O VALOR TOTAL FOR MAIOR *}
{* QUE O TOTAL, O VALOR RESTANTE É REATEADO ENTRE OS    *}
{* VALORES RESTANTES                                    *}
{*****************************************************MV*}
procedure TfrmDigDuplicata.pRateiaValorDigitado(edtBase: TEditFocus);
  Var
    edtAtual: TEditFocus;
    fltTotTmp: Double;
    fltTotalAcima: Double;
    fltTotalAbaixo: Double;
    fltValorRestante: Double;
    fltValorParcela: Double;
    strBase: String;
    intBase: Integer;
    intBase2: Integer;
    intContador: Integer;
    intDivisor: Integer;
    blnInclusiveAbaixo: Boolean;
begin

  If (edtBase = Nil) Then
    Exit;

  If (strValAnt = TEdit(edtBase).Text) Then
  Begin
    Exit;
  End;

  If ((ActiveControl) Is TEditFocus) Or ((ActiveControl) Is TMaskEditFocus) Then
  Begin

    If (Pos('edtVal', ActiveControl.Name) > 0)    Or
       (Pos('edtDtaVen', ActiveControl.Name) > 0) Then
    Begin

      strBase := RightStr(ActiveControl.Name, 2);
      If (Not fIsNumber(strBase)) Then
        strBase := RightStr(strBase, 1);

      intBase := StrToInt(strBase);

      strBase := RightStr(edtBase.Name, 2);
      If (Not fIsNumber(strBase)) Then
        strBase := RightStr(strBase, 1);

      intBase2 := StrToInt(strBase);

      If (intBase <= intBase2) Then
        Exit;

      If (Pos('edtDtaVen', ActiveControl.Name) > 0) Then
        If (intBase = intBase2) Then
          Exit;

    End;

  End;

  fltTotalAcima  := fSomaTotalAcima(edtBase, True);

  strBase := RightStr(edtBase.Name, 2);
  If (Not fIsNumber(strBase)) Then
    strBase := RightStr(strBase, 1);

  intBase := StrToInt(strBase) + 1;

  fltValorRestante := fStrToFloat(FloatToStrF((curTotalPed - fltTotalAcima), ffFixed,12,2));

  If (fltValorRestante < 0.0) Then
  Begin
    blnInclusiveAbaixo := True;
    Dec(intBase);
    fltValorRestante := RoundTo(curTotalPed - fSomaTotalAcima(edtBase, False), -2);
    fltTotTmp := fSomaTotalAbaixo(edtBase, False);

    intDivisor := (intQtdPar - intBase);
    If (intDivisor <= 0) Then
      intDivisor := 1;

    fltTotTmp := (fltTotTmp / intDivisor) * intBase;
    fltValorParcela := fltTotTmp / StrToInt(strBase);
    fMensagem('', 'Valor não permitido para parcelamento em ' + IntToStr(intQtdPar) + ' vezes!', ['&Ok']);
    pSetFocus(edtBase);
  End
  Else
  Begin
    blnInclusiveAbaixo := False;
    intDivisor         := (intQtdPar - StrToInt(strBase));
    If (intDivisor <= 0) Then
      intDivisor := 1;

    fltValorParcela := fltValorRestante / intDivisor;
  End;

  For intContador := intBase To intQtdPar Do
  Begin
    edtAtual := TEditFocus(fComponentByName(pnlDuplics, 'edtVal' + IntToStr(intContador)));

    If (edtAtual = Nil) Then
    Begin
      Continue;
    End;

    edtAtual.Text := FloatToStrF(fltValorParcela, ffFixed, 12, 2);
  End;

  fltTotalAbaixo := fFormataFloat(fSomaTotalAbaixo(edtBase, blnInclusiveAbaixo), 2);
  If (fltTotalAbaixo < fltValorRestante) Then
  Begin

    If intQtdPar < intBase Then
      Inc(intBase,-1);

    edtAtual := TEditFocus(fComponentByName(pnlDuplics, 'edtVal' + IntToStr(intBase)));
    edtAtual.Text := FloatToStrF(fStrToFloat(edtAtual.Text) + fltValorRestante - fltTotalAbaixo, ffFixed, 12, 2);
  End
  Else If (fltTotalAbaixo > fltValorRestante) Then
  Begin
    edtAtual := TEditFocus(fComponentByName(pnlDuplics, 'edtVal' + IntToStr(intBase)));
    edtAtual.Text := FloatToStrF(fStrToFloat(edtAtual.Text) - (fltTotalAbaixo - fltValorRestante) , ffFixed, 12, 2);
  End;

end;

procedure TfrmDigDuplicata.btnValoresPadraoClick(Sender: TObject);
begin
  inherited;

  pValorPadrao;

  If blnMostrarOpcaoPadrao Then
  Begin
    pCarregaValoresPadrao;
  End;
end;

procedure TfrmDigDuplicata.chkValPadClick(Sender: TObject);
begin
  inherited;

  If chkValPad.Checked Then
    pCarregaValoresPadrao;

  pnlDuplics.Enabled := Not chkValPad.Checked;

  btnValoresPadrao.Visible := (Not chkValPad.Checked) And pnlValPad.Visible;
end;

procedure TfrmDigDuplicata.pCarregaValoresPadrao;
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrDuplicata^) To High(arrDuplicata^) Do
    arrDuplicata[intContador] := arrDuplicataPadrao[intContador];

  pCarDuplicatas;
End;

procedure TfrmDigDuplicata.edtVal1Enter(Sender: TObject);
begin
  inherited;
  strValAnt := TEdit(Sender).Text;
  edtOrigem := TEdit(Sender);
  pAtualizaHist02;
end;

function TfrmDigDuplicata.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtChq01) Then
    Begin
      If edtChq01.Enabled Then
      Begin
        If fEmptyStr(edtChq01.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq01.Text <> 'S') And (edtChq01.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq02) Then
    Begin
      If edtChq02.Enabled Then
      Begin
        If fEmptyStr(edtChq02.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq02.Text <> 'S') And (edtChq02.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq03) Then
    Begin
      If edtChq03.Enabled Then
      Begin
        If fEmptyStr(edtChq03.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq03.Text <> 'S') And (edtChq03.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq04) Then
    Begin
      If edtChq04.Enabled Then
      Begin
        If fEmptyStr(edtChq04.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq04.Text <> 'S') And (edtChq04.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq05) Then
    Begin
      If edtChq05.Enabled Then
      Begin
        If fEmptyStr(edtChq05.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq05.Text <> 'S') And (edtChq05.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq06) Then
    Begin
      If edtChq06.Enabled Then
      Begin
        If fEmptyStr(edtChq06.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq06.Text <> 'S') And (edtChq06.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq07) Then
    Begin
      If edtChq07.Enabled Then
      Begin
        If fEmptyStr(edtChq07.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq07.Text <> 'S') And (edtChq07.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq08) Then
    Begin
      If edtChq08.Enabled Then
      Begin
        If fEmptyStr(edtChq08.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq08.Text <> 'S') And (edtChq08.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq09) Then
    Begin
      If edtChq09.Enabled Then
      Begin
        If fEmptyStr(edtChq09.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq09.Text <> 'S') And (edtChq09.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq10) Then
    Begin
      If edtChq10.Enabled Then
      Begin
        If fEmptyStr(edtChq10.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq10.Text <> 'S') And (edtChq10.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq11) Then
    Begin
      If edtChq11.Enabled Then
      Begin
        If fEmptyStr(edtChq11.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq11.Text <> 'S') And (edtChq11.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq12) Then
    Begin
      If edtChq12.Enabled Then
      Begin
        If fEmptyStr(edtChq12.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq12.Text <> 'S') And (edtChq12.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq13) Then
    Begin
      If edtChq13.Enabled Then
      Begin
        If fEmptyStr(edtChq13.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq13.Text <> 'S') And (edtChq13.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq14) Then
    Begin
      If edtChq14.Enabled Then
      Begin
        If fEmptyStr(edtChq14.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq14.Text <> 'S') And (edtChq14.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq15) Then
    Begin
      If edtChq15.Enabled Then
      Begin
        If fEmptyStr(edtChq15.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq15.Text <> 'S') And (edtChq15.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq16) Then
    Begin
      If edtChq16.Enabled Then
      Begin
        If fEmptyStr(edtChq16.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq16.Text <> 'S') And (edtChq16.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq17) Then
    Begin
      If edtChq17.Enabled Then
      Begin
        If fEmptyStr(edtChq17.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq17.Text <> 'S') And (edtChq17.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq18) Then
    Begin
      If edtChq18.Enabled Then
      Begin
        If fEmptyStr(edtChq18.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq18.Text <> 'S') And (edtChq18.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq19) Then
    Begin
      If edtChq19.Enabled Then
      Begin
        If fEmptyStr(edtChq19.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq19.Text <> 'S') And (edtChq19.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq20) Then
    Begin
      If edtChq20.Enabled Then
      Begin
        If fEmptyStr(edtChq20.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq20.Text <> 'S') And (edtChq20.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq21) Then
    Begin
      If edtChq21.Enabled Then
      Begin
        If fEmptyStr(edtChq21.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq21.Text <> 'S') And (edtChq21.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq22) Then
    Begin
      If edtChq22.Enabled Then
      Begin
        If fEmptyStr(edtChq22.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq22.Text <> 'S') And (edtChq22.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq23) Then
    Begin
      If edtChq23.Enabled Then
      Begin
        If fEmptyStr(edtChq23.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq23.Text <> 'S') And (edtChq23.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtChq24) Then
    Begin
      If edtChq24.Enabled Then
      Begin
        If fEmptyStr(edtChq24.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        If (edtChq24.Text <> 'S') And (edtChq24.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Cheques deve conter somente S ou N!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else
    If (blnHabEditDup) And (Sender = edtNumDup1) Then
    Begin
      If fEmptyStr(edtNumDup1.Text) and (fStrToFloat(edtVal1.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 1 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup2) Then
    Begin
      If fEmptyStr(edtNumDup2.Text) and (fStrToFloat(edtVal2.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 2 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup3) Then
    Begin
      If fEmptyStr(edtNumDup3.Text) and (fStrToFloat(edtVal3.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 3 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup4) Then
    Begin
      If fEmptyStr(edtNumDup4.Text) and (fStrToFloat(edtVal4.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 4 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup5) Then
    Begin
      If fEmptyStr(edtNumDup5.Text) and (fStrToFloat(edtVal5.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 5 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup6) Then
    Begin
      If fEmptyStr(edtNumDup6.Text) and (fStrToFloat(edtVal6.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 6 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup7) Then
    Begin
      If fEmptyStr(edtNumDup7.Text) and (fStrToFloat(edtVal7.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 7 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup8) Then
    Begin
      If fEmptyStr(edtNumDup8.Text) and (fStrToFloat(edtVal8.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 8 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup9) Then
    Begin
      If fEmptyStr(edtNumDup9.Text) and (fStrToFloat(edtVal9.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 9 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup10) Then
    Begin
      If fEmptyStr(edtNumDup10.Text) and (fStrToFloat(edtVal10.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 10 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup11) Then
    Begin
      If fEmptyStr(edtNumDup11.Text) and (fStrToFloat(edtVal11.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 11 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup12) Then
    Begin
      If fEmptyStr(edtNumDup12.Text) and (fStrToFloat(edtVal12.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 12 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup13) Then
    Begin
      If fEmptyStr(edtNumDup13.Text) and (fStrToFloat(edtVal13.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 13 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup14) Then
    Begin
      If fEmptyStr(edtNumDup14.Text) and (fStrToFloat(edtVal14.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 14 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup15) Then
    Begin
      If fEmptyStr(edtNumDup15.Text) and (fStrToFloat(edtVal15.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 15 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup16) Then
    Begin
      If fEmptyStr(edtNumDup16.Text) and (fStrToFloat(edtVal16.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 16 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup17) Then
    Begin
      If fEmptyStr(edtNumDup17.Text) and (fStrToFloat(edtVal17.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 17 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup18) Then
    Begin
      If fEmptyStr(edtNumDup18.Text) and (fStrToFloat(edtVal18.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 18 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup19) Then
    Begin
      If fEmptyStr(edtNumDup19.Text) and (fStrToFloat(edtVal19.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 19 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup20) Then
    Begin
      If fEmptyStr(edtNumDup20.Text) and (fStrToFloat(edtVal20.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 20 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup21) Then
    Begin
      If fEmptyStr(edtNumDup21.Text) and (fStrToFloat(edtVal21.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 21 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup22) Then
    Begin
      If fEmptyStr(edtNumDup22.Text) and (fStrToFloat(edtVal22.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 22 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup23) Then
    Begin
      If fEmptyStr(edtNumDup23.Text) and (fStrToFloat(edtVal23.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 23 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end

    Else
    If (blnHabEditDup) And (Sender = edtNumDup24) Then
    Begin
      If fEmptyStr(edtNumDup24.Text) and (fStrToFloat(edtVal24.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Nº Duplic 24 deve ser preenchido!',['&OK']);
        Result := False;
      end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDigDuplicata.btnCCCliClick(Sender: TObject);
begin
  inherited;

  If Not btnCCCli.Visible Then
    Exit;

  If Assigned(pMostraContaCorrente) Then
    pMostraContaCorrente;

end;

procedure TfrmDigDuplicata.btnHistoricoClick(Sender: TObject);
begin
  inherited;
  If (Not btnHistorico.Visible) Or (Not btnHistorico.Enabled) Then
    Exit;

  btnHistorico.Enabled := False;
  edtHist02.Enabled := True;
  btnRepHist.Enabled := True;
  pSetFocus(edtHist02);
end;

procedure TfrmDigDuplicata.btnRepHistClick(Sender: TObject);
begin
  inherited;

  if (fMensagem('', 'Deseja replicar o histórico para todas as parcelas?', ['&Sim','&Não']) = 1) then
    pReplicarHistoricoParaTodasAsParcelas(edtHist02.Text);

  pSetFocus(btnSalvar);
end;

procedure TfrmDigDuplicata.btnRepHistExit(Sender: TObject);
begin
  inherited;
  btnRepHist.Enabled := False;
end;

procedure TfrmDigDuplicata.pReplicarHistoricoParaTodasAsParcelas(strHistorico: String);
  var
    intCont: Integer;
begin
  for intCont := Low(arrDuplicata^) to High(arrDuplicata^) do
  begin
    if (not fEmptyStr(ArrDuplicata[intCont].strSequen)) then
      ArrDuplicata[intCont].strHist02 := strHistorico;
  end;
end;

procedure TfrmDigDuplicata.edtHist02Exit(Sender: TObject);
  Var
    intIndOri: Integer;
    strIndOri: String;
    blnGravaHist: Boolean;
begin
  inherited;

  blnGravaHist := True;
  intIndOri    := 0;

  If Not Assigned(edtOrigem) Then
    Exit;

  strIndOri := RightStr(edtOrigem.Name, 2);

  If (fIsNumber(strIndOri)) Then
    intIndOri := StrToInt(strIndOri)
  Else
  Begin
    strIndOri := RightStr(edtOrigem.Name, 1);
    If (fIsNumber(strIndOri)) Then
      intIndOri := StrToInt(strIndOri)
    Else
    Begin
      blnGravaHist := False;
    End;
  End;

  btnHistorico.Enabled := True;

  If (blnGravaHist) Then;
    ArrDuplicata[intIndOri-1].strHist02 := edtHist02.Text;

  edtHist02.Enabled := False;

  if not (Self.ActiveControl.Equals(btnRepHist)) then
    btnRepHist.Enabled := False;
end;

procedure TfrmDigDuplicata.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnHistorico.Click;
    VK_F3: btnCCCli.Click;
  End;
end;

procedure TfrmDigDuplicata.pValorPadrao;
  Var
    intContador: Integer;
begin
  SetLength(arrDuplicatasBkp, Length(arrDuplicata^));
  For intContador := Low(arrDuplicata^) To High(arrDuplicata^) Do
    arrDuplicatasBkp[intContador] := ArrDuplicata[intContador];
End;

procedure TfrmDigDuplicata.FormShow(Sender: TObject);
begin
  inherited;

  pValorPadrao;

  pnlValPad.Visible := blnMostrarOpcaoPadrao And blnEditavel;

  If pnlValPad.Visible Then
  Begin
    btnValoresPadrao.Visible := Not chkValPad.Checked;
    btnValoresPadrao.Caption := 'Calc. &Valores Padrão';
    btnSairDig.Caption       := 'Cancel&a';
  End Else
  Begin
    ClientHeight := ClientHeight - pnlValPad.Height;
  End;

end;

procedure TfrmDigDuplicata.edtNumDup1Enter(Sender: TObject);
begin
  inherited;
  edtOrigem := TEdit(Sender);
  pAtualizaHist02;
end;

procedure TfrmDigDuplicata.edtSeq1Enter(Sender: TObject);
begin
  inherited;
  edtOrigem := TEdit(Sender);
  pAtualizaHist02;
end;

procedure TfrmDigDuplicata.edtDtaVen01Enter(Sender: TObject);
begin
  inherited;
  edtOrigem := TEdit(Sender);
  pAtualizaHist02;
end;

procedure TfrmDigDuplicata.edtChq01Enter(Sender: TObject);
begin
  inherited;
  edtOrigem := TEdit(Sender);
  pAtualizaHist02;
end;

procedure TfrmDigDuplicata.pAtualizaHist02;
  Var
    intIndOri: Integer;
    strIndOri: String;
begin
  inherited;

  intIndOri    := -1;
  strIndOri := RightStr(edtOrigem.Name, 2);

  If (fIsNumber(strIndOri)) Then
    intIndOri := StrToInt(strIndOri)
  Else
  Begin
    strIndOri := RightStr(edtOrigem.Name, 1);
    If (fIsNumber(strIndOri)) Then
      intIndOri := StrToInt(strIndOri)

  End;
  If (intIndOri > -1) Then
    edtHist02.Text := ArrDuplicata[intIndOri-1].strHist02;

end;

procedure TfrmDigDuplicata.FormActivate(Sender: TObject);
begin
  inherited;

  blnCarregando := True;

  curTotalPed := fFormataFloat(curTotalPed, 2);
  If FPais = opcParaguai Then
    edtTotVen.Text := 'G$ ' + FormatFloat('#,##0.00', curTotalPed)
  Else
    edtTotVen.Text := FloatToStrf(curTotalPed, ffFixed, 10, 2);

  pHabilita;
  pCarDuplicatas;
  pSomaValor(Nil);

  If blnEditavel Then
    pSetFocus(edtDtaVen01)
  Else
    pSetFocus(btnSalvar);

  btnSairDig.Top := btnSalvar.Top;
  btnCCCli.Visible := Assigned(pMostraContaCorrente);

  If (Not edtChq01.Visible) Then
  begin
    edtHist02.Width := edtHist02.Width - edtChq01.Width - 10;
    btnRepHist.Left := edtHist02.Left + edtHist02.Width + 2;
  end;

  pCarregaVenctosOriginais;

  blnCarregando := False;
end;

function TfrmDigDuplicata.fAlterouVenctos: Boolean;
  Var
    intCnt : Integer;
    strTmpDat : String;
begin
  For intCnt := 1 To 24 Do
  Begin
    strTmpDat := TMaskEditFocus(FindComponent('edtDtaVen' + fStrZero(intCnt, 2))).Text;
    If (Trim(strTmpDat) = '/  /') Then
      strTmpDat := '';
    Result := (arrVenOri[intCnt] <> strTmpDat);
    If (Result) Then
      Break;
  End;
end;

function TfrmDigDuplicata.fValidaEdtsValor(intEdtVaSel: Integer = 0): Boolean;
  Var
    intCont: Integer;

  function fValida(intParcel: Integer): Boolean;
    Var
      edtTmp: TEditFocus;
  begin
    Result := True;
    edtTmp := TEditFocus(fComponentByName(pnlDuplics, 'edtVal' + IntToStr(intParcel)));

    If (Not (Self.FormState = [fsShowing,fsModal])) And (edtTmp.Enabled) And (fStrToFloat(edtTmp.Text) = 0.0) Then
    Begin
      pSetFocus(edtTmp);
      fMensagem('','O valor da ' + IntToStr(intParcel) + 'º parcela deve ser diferente de zero ou '+
                   'será necessário refazer a condiçao de pagamento!' ,['&Ok']);
      Result := False;
    End;
  end;

begin

  Result := True;

  If intEdtVaSel = 0 Then
  Begin
    For intCont := 1 To 24 Do
    Begin
      If Not fValida(intCont) Then
      Begin
        Result := False;
        Break;
      End;
    End;
  End
  Else
    Result := fValida(intEdtVaSel);

end;

function TfrmDigDuplicata.fValidaVencimentos: Boolean;
  Var
    intCont,
    intContador: Integer;
    dtaDtaTmp  : TDateTime;
    arrDatasTmp: TDateArray;
    strCndAtu,
    strCndOri  : String;
begin
  Result := True;

  If (Not fEmptyStr(strCodCnd))                                   And
     (Not fEmptyStr(strCodVen))                                   And
     (Assigned(fSenVar))                                          And
     fUtilizaCondicaoPagtoPorVendedor(True, strCodCnd, strCodVen) Then
  Begin
    strCndAtu := '';
    strCndOri := '';

    For intCont := Low(arrDuplic) To High(arrDuplic) Do
    Begin
      If arrDuplicatasBkp[intCont].dtaDtaVen <> arrDuplic[intCont].dtaDtaVen Then
      Begin
        intContador := 0;
        dtaDtaTmp   := VS_Date;

        If (Pos(strEspDoc, 'OR_PD_') > 0) Then
          dtaDtaTmp := dtaDtaBas;

        While (arrDuplic[intContador].dtaDtaVen <> '') And
              (intContador < 24)                       Do
        Begin
          SetLength(arrDatasTmp, intContador+1);
          arrDatasTmp[intContador] := StrToDate(arrDuplic[intContador].dtaDtaVen);
          Inc(intContador);
        End;

       strCndAtu := fRetornaCndPag(arrDatasTmp, dtaDtaTmp);

        intContador := 0;
        SetLength(arrDatasTmp, 0);

        While (arrDuplicatasBkp[intContador].dtaDtaVen <> '') And
              (intContador < 24)                             Do
        Begin
          SetLength(arrDatasTmp, intContador+1);
          arrDatasTmp[intContador] := StrToDate(arrDuplicatasBkp[intContador].dtaDtaVen);
          Inc(intContador);
        End;

        strCndOri := fRetornaCndPag(arrDatasTmp, dtaDtaTmp);

        Break;
      End;
    End;

    If Not SameText(strCndAtu, strCndOri) Then
      Result := fSenVar([strCndOri, strCndAtu]);
  End;
end;

function TfrmDigDuplicata.fValidaEdtsData: Boolean;
  Var
    intCont: Integer;
Begin

  Result := True;
  For intCont := 1 To 24 Do
  Begin

    Try
      If TMaskEdit(fComponentByName(pnlDuplics,'edtDtaVen' + fStrZero(intCont, 2))).Enabled Then
        StrToDate(TMaskEdit(fComponentByName(pnlDuplics,'edtDtaVen' + fStrZero(intCont, 2))).Text);
    Except
      fMensagem('','Favor preencher uma data válida!',['&OK']);
      Result := False;
      Break;
    End;

  End;

  If Not Result Then
    if (fComponentByName(pnlDuplics,'edtDtaVen' + fStrZero(intCont, 2)) is TWinControl) then
      pSetFocus(TWinControl(fComponentByName(pnlDuplics,'edtDtaVen' + fStrZero(intCont, 2))));

End;

end.
