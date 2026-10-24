unit untImportTabPrecosIteger;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, Math, untTypesSistema,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  untParCalculaPrecoCusto, Grids, untTValidaExcel, Datasnap.DBClient, untLayoutDinamico,
  EditFocus;

type
  TRecTabPrecos = Record
    fltPreVen,
    fltMarBru,
    fltComiss: Double;
  End;

  TArrRecPrecos = Array[1..7] Of TRecTabPrecos;

  TTipoCampo = (tcCodIte, tcCodBar, tcCodFab, tcCodFor, tcPreCom, tcDesF01,
                tcDesF02, tcDesF03, tcDesF04, tcDesF05, tcDesF06, tcIcmEnt,
                tcSubFed, tcIpiEnt, tcFreEnt, tcValFre, tcAcrFin, tcSubSti,
                tcDesAbd, tcOutVal, tcIcmSai, tcImpFed, tcDesOpe,
                tcTCIFCu, tcTSCust, tcDePiCo, tcDeICMS, tcFatReg, tcMarId1,
                tcMarId2, tcMarId3, tcMarId4, tcMarId5, tcMarId6, tcMarId7);

  TTipoPesquisa = (pesCodIte, pesCodBar, pesCodFab);

  TfrmImportTabPrecosIteger = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    btnGravar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    rdgIteAti: TRadioGroup;
    gpbRecalcular: TGroupBox;
    rdbMargem: TRadioButton;
    rdbPreVen: TRadioButton;
    frxSuframa: TfrxReport;
    cdsCampos: TUniClientDataSet;
    cdsCamposDESCRI: TStringField;
    cdsCamposCOLUNA: TStringField;
    cdsCamposMARDES: TStringField;
    cdsCamposINDEX: TIntegerField;
    cdsCamposFIELD: TStringField;
    btnConfigura: TBitBtnLocked;
    pgbGeral: TProgressBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edtDecUni: TEditFocus;
    chkArrMai: TCheckBox;
    lblLayoutSelecionado: TLabel;
    Label4: TLabel;
    chkCalcST: TCheckBox;
    procedure pCriarCds;
    procedure pLimparCDS;
    procedure pFormatarCampo(strCampo: string; blnTem_ITE: boolean = False);
    procedure btnGravarClick(Sender: TObject);
    procedure pInsereItensCDS(intLinha: integer);

    function fSQLIteger(pesTipPes: TTipoPesquisa): String;

    function  fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
    function  fTemTitulo: boolean;
    function  fCriarCdsLocalizaItens: TZClient;
    function  fLocalizaItemIteger(qryLocaliza: TUniQuery; intLinha: Integer): boolean;
    function  fVerificaIteAti(qryLocaliza: TUniQuery): boolean;
    function fConvetVazioToNull(texto: string): Variant;

    Procedure pCalcularPrecos(cdsIte: TZClient; Var recPrecos: TArrRecPrecos);
    function  fRetPrecoCusto(fltPreCom,
                             fltDesF01,
                             fltDesF02,
                             fltDesF03,
                             fltDesF04,
                             fltDesF05,
                             fltDesF06,
                             fltICMEnt,
                             fltSubFed,
                             fltIpiEnt,
                             fltFreEnt,
                             fltAcrFin,
                             fltSubsti,
                             fltDesAdb,
                             fltVrFret: Double;
                             blnPreDol: Boolean;
                             fltTCIFCu,
                             fltTSCust,
                             fltDePiCo,
                             fltDeICMS,
                             fltFatReg: Double): Double;
    function fSqlBase(blnCamposVariacao: Boolean): string;
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    function fGetCampoCSV(tcCampo: TTipoCampo; intLinha: Integer): Variant;
    procedure FormDestroy(Sender: TObject);
    procedure btnConfiguraClick(Sender: TObject);
    procedure lblLayoutSelecionadoClick(Sender: TObject);
    procedure chkArrMaiClick(Sender: TObject);

  private
    FUltimoFornecedor: String;
    stlArqCsv: TStringList;
    blnArqCsv: Boolean;
    Excel : Variant;
    objFatPre: TFatorPreco;
    cdsItens : TZClient;
    qryItensEncontrados: TUniQuery;
    cpcParams: TParCalculaPrecoCusto;
    arrValores: Array Of String;
    recPrecos: TArrRecPrecos;

    LayoutDinamico: TLayoutDinamico;
    LayoutPadrao: TLayoutPadrao;

    strEstadoFornecedor,
    FTipoAbfFornecedor,
    FCSTFornecedor: String;
    FAliquotaBaseRetICMSFornecedor,
    FAlqFundoCombatePobreza,
    FBaseIcmFornecedor,
    FIVAFornecedor,
    FBaseRetICMSFornecedor,
    FAliquotaBaseFornecedor: Double;

    objValidaExcel : TValidadorExcel;

    intDecUni: Integer;
    strMarMkp,
    strPcmPro: String;

    strList   : TStringGrid;

    strEstEmp : String;

    cCodIte : String; // 'A';
    cCodBar : String; // 'B';
    cCodFab : String; // 'C';
    cCodFor : String; // 'D';
    cPrComp : String; // 'E';
    cDesFo1 : String; // 'F';
    cDesFo2 : String; // 'G';
    cDesFo3 : String; // 'H';
    cDesFo4 : String; // 'I';
    cDesFo5 : String; // 'J';
    cDesFo6 : String; // 'K';
    cIcmEnt : String; // 'L';
    cSubFed : String; // 'M';
    cIpiEnt : String; // 'N';
    cFrete_ : String; // 'O';
    cVrFret : String; // 'P';
    cAcrFin : String; // 'Q';
    cSubSti : String; // 'R';
    cDesAdc : String; // 'S';
    cOutros : String; // 'T';
    cIcmSai : String; // 'U';
    cImpFed : String; // 'V';
    cDesOpe : String; // 'W';
    cTCIFCu : String; // 'X';
    cTSCust : String; // 'Y';
    cDePico : String; // 'Z';
    cDeICMS : String; // 'AA';
    cFatReg : String; // 'AB';
    cMarId1 : String; // 'AC';
    cMarId2 : String; // 'AD';
    cMarId3 : String; // 'AE';
    cMarId4 : String; // 'AF';
    cMarId5 : String; // 'AG';
    cMarId6 : String; // 'AH';
    cMarId7 : String; // 'AI';

    const cQtdColunas = 35;

    const
      cDesCodIte = 'Código do Item';
      cDesCodBar = 'Código de Barras';
      cDesCodFab = 'Código de Fábrica';
      cDesCodFor = 'Código do Fornecedor';
      cDesPrComp = 'Preço de Compra';
      cDesDesFo1 = 'Desconto do Fornecedor 01';
      cDesDesFo2 = 'Desconto do Fornecedor 02';
      cDesDesFo3 = 'Desconto do Fornecedor 03';
      cDesDesFo4 = 'Desconto do Fornecedor 04';
      cDesDesFo5 = 'Desconto do Fornecedor 05';
      cDesDesFo6 = 'Desconto do Fornecedor 06';
      cDesIcmEnt = 'Icms de Entrda';
      cDesSubFed = '% Impostos Federais (-)';
      cDesIpiEnt = '% IPI Entrada (+)';
      cDesFrete_ = '% Frete (+)';
      cDesVrFret = 'Valor de Frete (+)';
      cDesAcrFin = '% Acrecimo Financeiro (+)';
      cDesSubSti = '% Sub.Tributaria (+)';
      cDesDesAdc = '';
      cDesOutros = '';
      cDesIcmSai = '% ICMS Saída (+)';
      cDesImpFed = '% Impostos Federais (+)';
      cDesDesOpe = '% Despesas Operacionais (+)';
      cDesTCIFCu = 'TCIF (+)';
      cDesTSCust = 'TS (+)';
      cDesDePico = 'Desconto de PIS/COFINS (-)';
      cDesDeICMS = 'Desconto ICMS (-)';
      cDesFatReg = 'Fator Regional (+)';
      cDesMarId1 = 'Margem Ideal 1';
      cDesMarId2 = 'Margem Ideal 2';
      cDesMarId3 = 'Margem Ideal 3';
      cDesMarId4 = 'Margem Ideal 4';
      cDesMarId5 = 'Margem Ideal 5';
      cDesMarId6 = 'Margem Ideal 6';
      cDesMarId7 = 'Margem Ideal 7';

      iCodIte = 1;
      iCodBar = 2;
      iCodFab = 3;
      iCodFor = 4;
      iPreCom = 5;
      iDesF01 = 6;
      iDesF02 = 7;
      iDesF03 = 8;
      iDesF04 = 9;
      iDesF05 = 10;
      iDesF06 = 11;
      iIcmEnt = 12;
      iSubFed = 13;
      iIpiEnt = 14;
      iFreEnt = 15;
      iValFre = 16;
      iAcrFin = 17;
      iSubSti = 18;
      iDesAdc = 19;
      iOutVal = 20;
      iIcmSai = 21;
      iImpFed = 22;
      iDesOpe = 23;
      iTCIFCu = 24;
      iTSCust = 25;
      iDePiCo = 26;
      iDeICMS = 27;
      iFatReg = 28;
      iMarId1 = 29;
      iMarId2 = 30;
      iMarId3 = 31;
      iMarId4 = 32;
      iMarId5 = 33;
      iMarId6 = 34;
      iMarId7 = 35;

    Procedure pGetCodigos(Var strCodIte, strCodBar, strCodFor, strCodFab: String; intLinha: Integer);
    function XlsToStringGrid (AGrid :TStringGrid; AXLSFile :String) :boolean;
    function fCampoAltera(strColuna: String): Boolean;
    procedure pPopulaCDS;
    procedure pSetaColunasVariaveis;

    function fCalculaST(AfltPrecoCompraLiquido: Double; ACSTFornecedor: String; AAliquotaBaseRetICMSFornecedor, AAlqFundoCombatePobreza,
       ABaseIcmFornecedor, AIPIEntrada, AIVAFornecedor, AAliquotaBaseFornecedor, ABaseRetICMSFornecedor: Double): Double;


  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    { Private declarations }
  public
    { Public declarations }
  end;

  var
  frmImportTabPrecosIteger: TfrmImportTabPrecosIteger;

implementation

{$R *.dfm}

uses untTConfiguracao, untImportTabPrecosItegerConfirma, untImportComisVendTabPrecoConfirma,
  untIcmsSTParteVenda, untImportCadProdutoCamposAtualiza, untConstantes;

{ TfrmImportTabPrecosIteger }

procedure TfrmImportTabPrecosIteger.btnConfiguraClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmImportCadProdutoCamposAtualiza, frmImportCadProdutoCamposAtualiza);
  Try
    frmImportCadProdutoCamposAtualiza.cdsCampos.Data := cdsCampos.Data;

    If (frmImportCadProdutoCamposAtualiza.ShowModal = mrOk) then
      cdsCampos.Data := frmImportCadProdutoCamposAtualiza.cdsCampos.Data;

  Finally
    pFreeAndNil(frmImportCadProdutoCamposAtualiza);
  End;
end;

procedure TfrmImportTabPrecosIteger.btnGravarClick(Sender: TObject);
Var
  intValIni, intContador : Integer;
  dteInicio, dteFim: TDateTime;
begin
  inherited;
  FUltimoFornecedor := '';



  strEstadoFornecedor := '';
  FTipoAbfFornecedor := '';
  FAliquotaBaseRetICMSFornecedor := 0;
  FCSTFornecedor := '000';
  FBaseIcmFornecedor := 0;
  FAliquotaBaseFornecedor := 0;
  FBaseRetICMSFornecedor := 0;
  FAlqFundoCombatePobreza := 0;
  FIVAFornecedor := 0;

  {*******************************}
  { VERIRICA SE O ARQUIVO EXISTE  }
  {****************************LU*}
  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;


  objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCodIte, '', 0);

  try

    If fVerificaCampos Then
    Begin
      btnHlpImp.Enabled     := False;
      btnGravar.Enabled     := False;
      btnSair.Enabled       := False;
      edtPath.Enabled       := False;
      gpbRecalcular.Enabled := False;


      pnlInfo.Caption       := 'Aguarde... Carregando cadastro de Produtos...';

      Mouse.SettingChanged(10);
      qryItensEncontrados := fCriaQuery();

      pnlInfo.Caption       := 'Aguarde... Importando Tabela de Preços...';

      edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

      Try
        pCriarCds;


        blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

        If Not blnArqCsv Then
        Begin
          {**************************************}
          {* ABRE EXCEL E ARQUIVO XLS           *}
          {***********************************LU*}
          Excel := CreateOleObject('Excel.Application');
          Excel.Visible       := False;
          Excel.DisplayAlerts := False;
          Excel.WorkBooks.Open(Filename := edtPath.Text);

          {****************************************}
          {* VAI PARA A ULTIMA CELULA COM DADOS   *}
          {* PARA PEGAR A QUANTIDADE DE REGISTROS *}
          {*************************************LU*}

          {xlCellTypeLastCell. A última célula no intervalo usado}
          Excel.Selection.SpecialCells(11).Select;

          pgbGeral.Max := Excel.ActiveCell.Row -1;

          strList := TStringGrid.Create(Self);
          XlsToStringGrid(strList, edtPath.Text);
        End
        Else
        Begin
          pgbGeral.Max := objValidaExcel.ArquivoCSV.Count;
        End;

        pgbGeral.Position := 0;

        pLimparCDS;

        dteInicio := fNow();

        intValIni := IIf(fTemTitulo, 1 , 0);


        For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
        Begin

          If blnArqCsv Then
          Begin
            If intContador > objValidaExcel.ArquivoCSV.Count Then
              Continue;
          End;

          pInsereItensCDS(intContador);
          pgbGeral.StepBy(1);

          dteFim := fNow();

          pnlInfo.Caption := 'Importando: ' + IntToStr(intContador) + ' de ' + IntToStr(pgbGeral.Max + 1)
          + ' - Tempo Rest.: '
          + IntToStr(Trunc((pgbGeral.Max-IntContador)/(intcontador / ((((dteFim - dteInicio) * 86400)) / 60))+1)) +' min. (' +IntToStr(Trunc((intcontador / ((((dteFim - dteInicio) * 86400)) / 60)))) +'/min)';

          pnlInfo.Refresh;
        End;

        Try
          If not cdsItens.IsEmpty Then
          Begin
            pCriarFormularios(TfrmImportTabPrecosItegerConfirma, frmImportTabPrecosItegerConfirma);
            frmImportTabPrecosItegerConfirma.strEstEmp := strEstEmp;
            If chkArrMai.Checked Then
              frmImportTabPrecosItegerConfirma.intArredondamento := StrToInt(edtDecUni.Text);
            frmImportTabPrecosItegerConfirma.lblAlerta.Visible := chkCalcST.Checked;

            frmImportTabPrecosItegerConfirma.blnPrecoVenda := rdbPreVen.Checked;
            frmImportTabPrecosItegerConfirma.cdsCampos := cdsCampos;
            frmImportTabPrecosItegerConfirma.ShowModal(cdsItens);
          End;
        Finally
          FreeAndNil(frmImportTabPrecosItegerConfirma);
        End;

        SetForegroundWindow(Handle);

        edtPath.Clear;
        btnHlpImp.Enabled     := True;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;
        gpbRecalcular.Enabled := True;
        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);
        cdsItens.Close;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmImportTabPrecosIteger.btnGravarClick]');
          btnHlpImp.Enabled     := True;
          btnGravar.Enabled     := True;
          btnSair.Enabled       := True;
          edtPath.Enabled       := True;
          gpbRecalcular.Enabled := True;
          pnlInfo.Caption       := '';
          pgbGeral.Position     := 0;
          pSetFocus(btnSair);
        End;
      End;

    End;

    If Not blnArqCsv Then
    Begin
      Excel.WorkBooks.Close;
      Excel.Quit;
    End
    Else
      FreeAndNil(stlArqCsv);
  Finally
    FreeAndNil(qryItensEncontrados);
    FreeAndNil(objValidaExcel);
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;
    gpbRecalcular.Enabled := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
  End
end;

procedure TfrmImportTabPrecosIteger.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    frxSuframa.DotMatrixReport           := False;
    frxSuframa.PrintOptions.PrintMode    := pmScale;
    frxSuframa.PrintOptions.PrintOnSheet := 9;
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxSuframa);
  end
  else
  begin
    frxHelp.DotMatrixReport           := False;
    frxHelp.PrintOptions.PrintMode    := pmScale;
    frxHelp.PrintOptions.PrintOnSheet := 9;
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
  end;
end;


procedure TfrmImportTabPrecosIteger.chkArrMaiClick(Sender: TObject);
begin
  inherited;
  edtDecUni.Enabled := chkArrMai.Checked;
end;

function TfrmImportTabPrecosIteger.fCalculaST(AfltPrecoCompraLiquido: Double; ACSTFornecedor: String;
                                      AAliquotaBaseRetICMSFornecedor, AAlqFundoCombatePobreza,
                                      ABaseIcmFornecedor, AIPIEntrada, AIVAFornecedor,
                                      AAliquotaBaseFornecedor, ABaseRetICMSFornecedor: Double): Double;
var fltBCICMS: Double;
    fltBCST: Double;
    fltValorDebito: Double;
    fltValorCredito: Double;
    fltValorIcmsSubst: Double;
    fltValIpi: Double;

  fltAliquotaBaseRetICMSFornecedorInt: Double;
begin
  If Pos(ACSTFornecedor, CST_SUBSTITUICAO) <= 0  Then
    Exit(0);

  AfltPrecoCompraLiquido := RoundTo(AfltPrecoCompraLiquido,   intDecUni);

  fltValIpi := (AfltPrecoCompraLiquido * AIPIEntrada) / 100;

  fltAliquotaBaseRetICMSFornecedorInt := AAliquotaBaseRetICMSFornecedor + AAlqFundoCombatePobreza;

  fltBCICMS := AfltPrecoCompraLiquido -((AfltPrecoCompraLiquido * (100-ABaseIcmFornecedor)) /100);
//   select (210+21) *60/100 *1.35;

//    select ((210 *50/100)+21) *1.35;
//                  210                      10%                  210                       1.35

  If fCampoTabela('FOR_BSTXML', 'CADFOR', ['FOR_CODFOR'], [FUltimoFornecedor]) = 1 Then // IPI Fora
    fltBCST   := (((AfltPrecoCompraLiquido * ABaseRetICMSFornecedor)/100) + fltValIpi) * FIVAFornecedor
  Else
    fltBCST   := (fltValIpi + AfltPrecoCompraLiquido) * ABaseRetICMSFornecedor/100 * FIVAFornecedor;

  fltValorDebito := (fltBCST * fltAliquotaBaseRetICMSFornecedorInt) / 100;
  fltValorCredito := (fltBCICMS * AAliquotaBaseFornecedor) / 100;
  fltValorIcmsSubst := fltValorDebito - fltValorCredito;
  Result := fFormataFloat(((fltValorIcmsSubst/AfltPrecoCompraLiquido )* 100), 2);

  If Result < 0 Then
    Result := 0;
end;


Procedure TfrmImportTabPrecosIteger.pCalcularPrecos(cdsIte: TZClient; Var recPrecos: TArrRecPrecos);
  var
   fltPreCus,
   fltOutVal,
   fltIcmSai,
   fltDesOpe,
   fltImpFed: Double;
   i, intTabela: integer;
   strCodSit : String;
   blnCalcSt : Boolean;
   fltPreComLiq : Double;
   fltIcmsST : Double;
   strTipFor: String;




begin

  strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstEmp]);
  if cdsItens.FieldByName('IMPORT').AsInteger = 1 Then
  Begin
    If chkCalcST.Checked Then
    Begin
      If FUltimoFornecedor <> cdsItens.FieldByName('CODFOR').Value Then
      Begin
        FUltimoFornecedor :=  cdsItens.FieldByName('CODFOR').Value;
        strEstadoFornecedor := fEstadoFornecedor(cdsItens.FieldByName('CODFOR').AsString);
        FTipoAbfFornecedor := fGetTipoAbfFornecedor(cdsItens.FieldByName('CODFOR').Value, strTipFor);
        FAliquotaBaseRetICMSFornecedor := fCampoTabela('ABF_ALQRET' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
        FCSTFornecedor := fCampoTabela('ABF_CODSIT' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
        FBaseIcmFornecedor := fCampoTabela('ABF_BASICM' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
        FAliquotaBaseFornecedor := fCampoTabela('ABF_ALQICM' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
        FBaseRetICMSFornecedor  := fCampoTabela('ABF_BASRET' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
        FAlqFundoCombatePobreza := fCampoTabela('ABF_ALQFCP' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
        FIVAFornecedor := fCampoTabela('ABF_IVA_ST' + FTipoAbfFornecedor, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsItens.FieldByName('CODABF').AsString, strEstadoFornecedor]);
      End;

      cdsItens.FieldByName('ITE_SUBSTI_NOV').AsFloat := fCalculaST(500, FCSTFornecedor,
                                                                    FAliquotaBaseRetICMSFornecedor, FAlqFundoCombatePobreza,
                                                                    FBaseIcmFornecedor,
                                                                    IfThen(cdsItens.FieldByName('ITE_IPIENT_NOV').IsNull, cdsItens.FieldByName('ITE_IPIENT').AsFloat, cdsItens.FieldByName('ITE_IPIENT_NOV').AsFloat),
                                                                    FIVAFornecedor,
                                                                    FAliquotaBaseFornecedor,
                                                                    FBaseRetICMSFornecedor);
    End;
  End;


  fltPreCus := fRetPrecoCusto(IfThen(cdsItens.FieldByName('ITE_PRECOM_NOV').IsNull, cdsItens.FieldByName('ITE_PRECOM').AsFloat, cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF01_NOV').IsNull, cdsItens.FieldByName('ITE_DESF01').AsFloat, cdsItens.FieldByName('ITE_DESF01_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF02_NOV').IsNull, cdsItens.FieldByName('ITE_DESF02').AsFloat, cdsItens.FieldByName('ITE_DESF02_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF03_NOV').IsNull, cdsItens.FieldByName('ITE_DESF03').AsFloat, cdsItens.FieldByName('ITE_DESF03_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF04_NOV').IsNull, cdsItens.FieldByName('ITE_DESF04').AsFloat, cdsItens.FieldByName('ITE_DESF04_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF05_NOV').IsNull, cdsItens.FieldByName('ITE_DESF05').AsFloat, cdsItens.FieldByName('ITE_DESF05_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF06_NOV').IsNull, cdsItens.FieldByName('ITE_DESF06').AsFloat, cdsItens.FieldByName('ITE_DESF06_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_ICMENT_NOV').IsNull, cdsItens.FieldByName('ITE_ICMENT').AsFloat, cdsItens.FieldByName('ITE_ICMENT_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_SUBFED_NOV').IsNull, cdsItens.FieldByName('ITE_SUBFED').AsFloat, cdsItens.FieldByName('ITE_SUBFED_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_IPIENT_NOV').IsNull, cdsItens.FieldByName('ITE_IPIENT').AsFloat, cdsItens.FieldByName('ITE_IPIENT_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_FREENT_NOV').IsNull, cdsItens.FieldByName('ITE_FREENT').AsFloat, cdsItens.FieldByName('ITE_FREENT_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_ACRFIN_NOV').IsNull, cdsItens.FieldByName('ITE_ACRFIN').AsFloat, cdsItens.FieldByName('ITE_ACRFIN_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_SUBSTI_NOV').IsNull, cdsItens.FieldByName('ITE_SUBSTI').AsFloat, cdsItens.FieldByName('ITE_SUBSTI_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESADB_NOV').IsNull, cdsItens.FieldByName('ITE_DESADB').AsFloat, cdsItens.FieldByName('ITE_DESADB_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_VALFRE_NOV').IsNull, cdsItens.FieldByName('ITE_VALFRE').AsFloat, cdsItens.FieldByName('ITE_VALFRE_NOV').AsFloat),
                              cdsItens.FieldByName('ITE_PREDOL').AsString = 'S',
                              IfThen(cdsItens.FieldByName('ITE_TCIFCU_NOV').IsNull, cdsItens.FieldByName('ITE_TCIFCU').AsFloat, cdsItens.FieldByName('ITE_TCIFCU_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_TSCUST_NOV').IsNull, cdsItens.FieldByName('ITE_TSCUST').AsFloat, cdsItens.FieldByName('ITE_TSCUST_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DEPICO_NOV').IsNull, cdsItens.FieldByName('ITE_DEPICO').AsFloat, cdsItens.FieldByName('ITE_DEPICO_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DEICMS_NOV').IsNull, cdsItens.FieldByName('ITE_DEICMS').AsFloat, cdsItens.FieldByName('ITE_DEICMS_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_FATREG_NOV').IsNull, cdsItens.FieldByName('ITE_FATREG').AsFloat, cdsItens.FieldByName('ITE_FATREG_NOV').AsFloat));


  cdsItens.FieldByName('ITE_PRECUS_NOV').AsFloat := fltPreCus;

  fltOutVal := IfThen(cdsItens.FieldByName('ITE_OUTVAL_NOV').IsNull, cdsItens.FieldByName('ITE_OUTVAL').AsFloat, cdsItens.FieldByName('ITE_OUTVAL_NOV').AsFloat);
  fltIcmSai := IfThen(cdsItens.FieldByName('ITE_ICMSAI_NOV').IsNull, cdsItens.FieldByName('ITE_ICMSAI').AsFloat, cdsItens.FieldByName('ITE_ICMSAI_NOV').AsFloat);
  fltDesOpe := IfThen(cdsItens.FieldByName('ITE_DESOPE_NOV').IsNull, cdsItens.FieldByName('ITE_DESOPE').AsFloat, cdsItens.FieldByName('ITE_DESOPE_NOV').AsFloat);
  fltImpFed := IfThen(cdsItens.FieldByName('ITE_IMPFED_NOV').IsNull, cdsItens.FieldByName('ITE_IMPFED').AsFloat, cdsItens.FieldByName('ITE_IMPFED_NOV').AsFloat);

  fltPreComLiq := fCalculaPrecoCompraLiq(IfThen(cdsItens.FieldByName('ITE_PRECOM_NOV').IsNull, cdsItens.FieldByName('ITE_PRECOM').AsFloat, cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat),
                                         IfThen(cdsItens.FieldByName('ITE_DESF01_NOV').IsNull, cdsItens.FieldByName('ITE_DESF01').AsFloat, cdsItens.FieldByName('ITE_DESF01_NOV').AsFloat),
                                         IfThen(cdsItens.FieldByName('ITE_DESF02_NOV').IsNull, cdsItens.FieldByName('ITE_DESF02').AsFloat, cdsItens.FieldByName('ITE_DESF02_NOV').AsFloat),
                                         IfThen(cdsItens.FieldByName('ITE_DESF03_NOV').IsNull, cdsItens.FieldByName('ITE_DESF03').AsFloat, cdsItens.FieldByName('ITE_DESF03_NOV').AsFloat),
                                         IfThen(cdsItens.FieldByName('ITE_DESF04_NOV').IsNull, cdsItens.FieldByName('ITE_DESF04').AsFloat, cdsItens.FieldByName('ITE_DESF04_NOV').AsFloat),
                                         IfThen(cdsItens.FieldByName('ITE_DESF05_NOV').IsNull, cdsItens.FieldByName('ITE_DESF05').AsFloat, cdsItens.FieldByName('ITE_DESF05_NOV').AsFloat),
                                         IfThen(cdsItens.FieldByName('ITE_DESF06_NOV').IsNull, cdsItens.FieldByName('ITE_DESF06').AsFloat, cdsItens.FieldByName('ITE_DESF06_NOV').AsFloat),
                                         intDecUni,
                                         (cdsItens.FieldByName('ITE_PREDOL').AsString = 'S'));

  fltIcmsST := fGetIcmsSTParteVenda(cdsItens.FieldByName('CODABF').AsString,
                                    '_SAI_CCO',
                                    strCodSit,
                                    strEstEmp,
                                    fltPreComLiq,
                                    IfThen(cdsItens.FieldByName('ITE_IPIENT_NOV').IsNull, cdsItens.FieldByName('ITE_IPIENT').AsFloat, cdsItens.FieldByName('ITE_IPIENT_NOV').AsFloat),
                                    fltIcmSai,
                                    strEstEmp,
                                    blnCalcSt);

  For i := 1 To 7 do
   recPrecos[i].fltComiss := cdsIte.FieldByName('ITE_COMTB' +  IntToStr(i)).AsFloat;

  If rdbPreVen.Checked Then
  Begin
    For intTabela := 1 To 7 Do
    Begin
      recPrecos[intTabela].fltComiss := cdsItens.FieldByName('ITE_COMTB' + IntToStr(intTabela)).AsFloat;
      recPrecos[intTabela].fltMarBru := cdsItens.fieldbyname('ITE_MARBR' + IntToStr(intTabela)).AsFloat;

      If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabela))))) Or (intTabela = 1) Then
      Begin
        recPrecos[intTabela].fltPreVen := fCalculaPrecoVenda(1,
                                                             fltPreCus + fltOutVal,
                                                             0,
                                                             recPrecos[intTabela].fltMarBru,
                                                             fltIcmSai,
                                                             fltImpFed,
                                                             fltDesOpe,
                                                             recPrecos[intTabela].fltComiss,
                                                             strMarMkp,
                                                             strPcmPro,
                                                             intDecUni,
                                                             fltIcmsST,
                                                             blnCalcSt);

        recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fltOutVal,
                                                             recPrecos[intTabela].fltPreVen,
                                                             0,
                                                             fltIcmSai,
                                                             fltImpFed,
                                                             fltDesOpe,
                                                             recPrecos[intTabela].fltComiss,
                                                             strMarMkp,
                                                             strPcmPro,
                                                             intDecUni,
                                                             fltIcmsST,
                                                             blnCalcSt);

        If chkArrMai.Checked Then
        Begin
          recPrecos[intTabela].fltPreVen := RoundTo(recPrecos[intTabela].fltPreVen, StrToIntDef(edtDecUni.Text,0) * -1 );
          recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                               fltPreCus + fltOutVal,
                                                               recPrecos[intTabela].fltPreVen,
                                                               0,
                                                               fltIcmSai,
                                                               fltImpFed,
                                                               fltDesOpe,
                                                               recPrecos[intTabela].fltComiss,
                                                               strMarMkp,
                                                               strPcmPro,
                                                               intDecUni,
                                                               fltIcmsST,
                                                               blnCalcSt);
        End;
      End
      Else
      Begin
        recPrecos[intTabela].fltPreVen := objFatPre.fCalculaPrecoVendaFator(cdsItens.fieldbyname('ITE_PREVE1').AsFloat, intTabela);
        recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fltOutVal,
                                                             recPrecos[intTabela].fltPreVen,
                                                             0,
                                                             fltIcmSai,
                                                             fltImpFed,
                                                             fltDesOpe,
                                                             recPrecos[intTabela].fltComiss,
                                                             strMarMkp,
                                                             strPcmPro,
                                                             intDecUni,
                                                             fltIcmsST,
                                                             blnCalcSt);

        If chkArrMai.Checked Then
        Begin
          recPrecos[intTabela].fltPreVen := RoundTo(recPrecos[intTabela].fltPreVen, StrToIntDef(edtDecUni.Text,0) * -1 );
          recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                               fltPreCus + fltOutVal,
                                                               recPrecos[intTabela].fltPreVen,
                                                               0,
                                                               fltIcmSai,
                                                               fltImpFed,
                                                               fltDesOpe,
                                                               recPrecos[intTabela].fltComiss,
                                                               strMarMkp,
                                                               strPcmPro,
                                                               intDecUni,
                                                               fltIcmsST,
                                                               blnCalcSt);
        End;
      End;
    End;
  End
  Else
  Begin
    For intTabela := 1 To 7 Do
    Begin
      recPrecos[intTabela].fltPreVen := cdsItens.fieldbyname('ITE_PREVE' + IntToStr(intTabela)).AsFloat;
      recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                           fltPreCus + fltOutVal,
                                                           recPrecos[intTabela].fltPreVen,
                                                           0,
                                                           fltIcmSai,
                                                           fltImpFed,
                                                           fltDesOpe,
                                                           recPrecos[intTabela].fltComiss,
                                                           strMarMkp,
                                                           strPcmPro,
                                                           intDecUni,
                                                           fltIcmsST,
                                                           blnCalcSt);
    End;
  End;
end;

function TfrmImportTabPrecosIteger.fCampoAltera(strColuna: String): Boolean;
begin
  Result := True;

  If cdsItens.FieldByName('IMPORT').AsInteger = 0 Then
    Exit;

  cdsCampos.First;
  If cdsCampos.Locate('COLUNA', strColuna, []) Then
    Result := cdsCamposMARDES.AsString = 'S';
end;

function TfrmImportTabPrecosIteger.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

function TfrmImportTabPrecosIteger.fCriarCdsLocalizaItens: TZClient;
  var
    strSql: string;
begin
  strSql := strSql + ' SELECT ' + fSqlBase(True);
  strSql := strSql + '   FROM ';
  strSql := strSql + ' ITEGER G ';
  strSql := strSql + '   LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  strSql := strSql + '   LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE  ';
  strSql := strSql + ' WHERE FALSE';
  Result := TZClient.Create(Self, strSql);
  Result.fAbreClient(True, 'TfrmImportTabPrecosIteger.fCriarCdsLocalizaItens');

end;

function TfrmImportTabPrecosIteger.fGetCampoCSV(tcCampo: TTipoCampo; intLinha: Integer): Variant;
  Var
    strLinha  : String;

    procedure pSetaValoresArr;
      Var
        intIndex,
        intPos,
        intPosEx: Integer;
        strLinTmp: String;
    Begin
      For intIndex := 0 To 34 Do
      Begin
        strLinTmp := '';
        intPos    := Pos(';', strLinha)-1;

        If intIndex = 0 Then
        Begin
          arrValores[intIndex] := Copy(strLinha, 1, intPos);
        End
        Else
        Begin
          intPosEx  := PosEx(';', strLinha, intPos+2);
          strLinTmp := Copy(strLinha, intPos+2, intPosEx-intPos-2);
          strLinha  := Copy(strLinha, intPos+2, Length(strLinha));

          arrValores[intIndex] := strLinTmp;
        End;
      End;
    End;
begin
  If (tcCampo = tcCodIte) Or
     (tcCampo = tcCodBar) Or
     (tcCampo = tcCodFab) Or
     (tcCampo = tcCodFor) Then
    Result := ''
  Else
    Result := Null;

  If intLinha > stlArqCsv.Count Then
    Exit;

  strLinha := stlArqCsv[intLinha-1];


  pSetaValoresArr;

  If (tcCampo = tcCodIte) Then
    Result := arrValores[0]
  Else If (tcCampo = tcCodBar) Then
    Result := arrValores[1]
  Else If (tcCampo = tcCodFab) Then
    Result := arrValores[2]
  Else If (tcCampo = tcCodFor) Then
    Result := arrValores[3]
  Else If (tcCampo = tcPreCom) And (Not fEmptyStr(arrValores[4])) Then
    Result := arrValores[4]
  Else If (tcCampo = tcDesF01) And (Not fEmptyStr(arrValores[5])) Then
    Result := arrValores[5]
  Else If (tcCampo = tcDesF02) And (Not fEmptyStr(arrValores[6])) Then
    Result := arrValores[6]
  Else If (tcCampo = tcDesF03) And (Not fEmptyStr(arrValores[7])) Then
    Result := arrValores[7]
  Else If (tcCampo = tcDesF04) And (Not fEmptyStr(arrValores[8])) Then
    Result := arrValores[8]
  Else If (tcCampo = tcDesF05) And (Not fEmptyStr(arrValores[9])) Then
    Result := arrValores[9]
  Else If (tcCampo = tcDesF06) And (Not fEmptyStr(arrValores[10])) Then
    Result := arrValores[10]
  Else If (tcCampo = tcIcmEnt) And (Not fEmptyStr(arrValores[11])) Then
    Result := arrValores[11]
  Else If (tcCampo = tcSubFed) And (Not fEmptyStr(arrValores[12])) Then
    Result := arrValores[12]
  Else If (tcCampo = tcIpiEnt) And (Not fEmptyStr(arrValores[13])) Then
    Result := arrValores[13]
  Else If (tcCampo = tcFreEnt) And (Not fEmptyStr(arrValores[14])) Then
    Result := arrValores[14]
  Else If (tcCampo = tcValFre) And (Not fEmptyStr(arrValores[15])) Then
    Result := arrValores[15]
  Else If (tcCampo = tcAcrFin) And (Not fEmptyStr(arrValores[16])) Then
    Result := arrValores[16]
  Else If (tcCampo = tcSubSti) And (Not fEmptyStr(arrValores[17])) Then
    Result := arrValores[17]
  Else If (tcCampo = tcDesAbd) And (Not fEmptyStr(arrValores[18])) Then
    Result := arrValores[18]
  Else If (tcCampo = tcOutVal) And (Not fEmptyStr(arrValores[19])) Then
    Result := arrValores[19]
  Else If (tcCampo = tcIcmSai) And (Not fEmptyStr(arrValores[20])) Then
    Result := arrValores[20]
  Else If (tcCampo = tcImpFed) And (Not fEmptyStr(arrValores[21])) Then
    Result := arrValores[21]
  Else If (tcCampo = tcDesOpe) And (Not fEmptyStr(arrValores[22])) Then
    Result := arrValores[22]
  Else If (tcCampo = tcTCIFCu) And (Not fEmptyStr(arrValores[23])) Then
    Result := arrValores[23]
  Else If (tcCampo = tcTSCust) And (Not fEmptyStr(arrValores[24])) Then
    Result := arrValores[24]
  Else If (tcCampo = tcDePiCo) And (Not fEmptyStr(arrValores[25])) Then
    Result := arrValores[25]
  Else If (tcCampo = tcDeICMS) And (Not fEmptyStr(arrValores[26])) Then
    Result := arrValores[26]
  Else If (tcCampo = tcFatReg) And (Not fEmptyStr(arrValores[27])) Then
    Result := arrValores[27]
  Else If (tcCampo = tcMarId1) And (Not fEmptyStr(arrValores[28])) Then
    Result := arrValores[28]
  Else If (tcCampo = tcMarId2) And (Not fEmptyStr(arrValores[29])) Then
    Result := arrValores[29]
  Else If (tcCampo = tcMarId3) And (Not fEmptyStr(arrValores[30])) Then
    Result := arrValores[30]
  Else If (tcCampo = tcMarId4) And (Not fEmptyStr(arrValores[31])) Then
    Result := arrValores[31]
  Else If (tcCampo = tcMarId5) And (Not fEmptyStr(arrValores[32])) Then
    Result := arrValores[32]
  Else If (tcCampo = tcMarId6) And (Not fEmptyStr(arrValores[33])) Then
    Result := arrValores[33]
  Else If (tcCampo = tcMarId7) And (Not fEmptyStr(arrValores[34])) Then
    Result := arrValores[34];
end;

Procedure TfrmImportTabPrecosIteger.pGetCodigos(Var strCodIte, strCodBar, strCodFor, strCodFab: String; intLinha: Integer);
Begin
  If Not blnArqCsv Then
  Begin
    If Not fEmptyStr(Trim(fRetSomenteNumeros(Excel.Range[cCodIte + IntToStr(intLinha)].Value))) Then
      strCodIte := Format('%0.'+IntToStr(fTamCodIte)+'d', [StrToInt(Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value))])
    Else
      strCodIte := '';

    If Not fEmptyStr(Trim(fRetSomenteNumeros(Excel.Range[cCodFor + IntToStr(intLinha)].Value))) Then
      strCodFor := Format('%0.8d', [StrToInt(Trim(Excel.Range[cCodFor + IntToStr(intLinha)].Value))])
    Else
      strCodFor := '';

    strCodBar := Trim(Excel.Range[cCodBar + IntToStr(intLinha)].Value);
    strCodFab := Trim(Excel.Range[cCodFab + IntToStr(intLinha)].Value);
  End
  Else
  Begin
    strCodIte := objValidaExcel.fGetValueCSV(intLinha, cCODITE);
    If strCodIte <> '' Then
      strCodIte := fStrZero(strCodIte, fTamCodIte);

    strCodFor := objValidaExcel.fGetValueCSV(intLinha, cCODFOR);
    If strCodFor <> '' Then
      strCodFor := fStrZero(strCodFor, 8);

    strCodBar := objValidaExcel.fGetValueCSV(intLinha, cCODBAR);
    strCodFab := objValidaExcel.fGetValueCSV(intLinha, cCODFAB);
  End;
End;

procedure TfrmImportTabPrecosIteger.FormCreate(Sender: TObject);
begin
  inherited;
  chkCalcST.Visible := fCfgSis('IITCST', varBoolean);
  chkCalcST.Checked := False;

  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  intDecUni := fCfgSis('DECUNI', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');
  strEstEmp := fCadEmp('ESTADO');

  cdsItens := Nil;

  SetLength(arrValores, 35);

  LayoutPadrao.Descricao := 'Importação Tabela de Preços - Padrão';
  LayoutPadrao.pAddCampo( 'Código do Item'                             , 'A' ,  iCodIte, True);
  LayoutPadrao.pAddCampo( 'Código de Barras'                           , 'B' ,  iCodBar, True);
  LayoutPadrao.pAddCampo( 'Código de Fábrica'                          , 'C' ,  iCodFab, True);
  LayoutPadrao.pAddCampo( 'Código do Fornecedor'                       , 'D' ,  iCodFor, True);
  LayoutPadrao.pAddCampo( 'Preço de Compra'                            , 'E' ,  iPreCom);
  LayoutPadrao.pAddCampo( 'Desconto do Fornecedor 01'                  , 'F' ,  iDesF01);
  LayoutPadrao.pAddCampo( 'Desconto do Fornecedor 02'                  , 'G' ,  iDesF02);
  LayoutPadrao.pAddCampo( 'Desconto do Fornecedor 03'                  , 'H' ,  iDesF03);
  LayoutPadrao.pAddCampo( 'Desconto do Fornecedor 04'                  , 'I' ,  iDesF04);
  LayoutPadrao.pAddCampo( 'Desconto do Fornecedor 05'                  , 'J' ,  iDesF05);
  LayoutPadrao.pAddCampo( 'Desconto do Fornecedor 06'                  , 'K' ,  iDesF06);
  LayoutPadrao.pAddCampo( 'Icms de Entrda'                             , 'L' ,  iIcmEnt);
  LayoutPadrao.pAddCampo( '% Impostos Federais (-)'                    , 'M' ,  iSubFed);
  LayoutPadrao.pAddCampo( '% IPI Entrada (+)'                          , 'N' ,  iIpiEnt);
  LayoutPadrao.pAddCampo( '% Frete (+)'                                , 'O' ,  iFreEnt);
  LayoutPadrao.pAddCampo( 'Valor de Frete (+)'                         , 'P' ,  iValFre);
  LayoutPadrao.pAddCampo( '% Acrecimo Financeiro (+)'                  , 'Q' ,  iAcrFin);
  LayoutPadrao.pAddCampo( '% Sub.Tributaria (+)'                       , 'R' ,  iSubSti);
  LayoutPadrao.pAddCampo( fCfgSis('DESADI')+' ('+fCfgSis('OPEADI')+')' , 'S' ,  iDesAdc);
  LayoutPadrao.pAddCampo( fCfgSis('DOVCPP')+' (+)'                     , 'T' ,  iOutVal);
  LayoutPadrao.pAddCampo( '% ICMS Saída (+)'                           , 'U' ,  iIcmSai);
  LayoutPadrao.pAddCampo( '% Impostos Federais (+)'                    , 'V' ,  iImpFed);
  LayoutPadrao.pAddCampo( '% Despesas Operacionais (+)'                , 'W' ,  iDesOpe);
  LayoutPadrao.pAddCampo( 'TCIF (+)'                                   , 'X' ,  iTCIFCu);
  LayoutPadrao.pAddCampo( 'TS (+)'                                     , 'Y' ,  iTSCust);
  LayoutPadrao.pAddCampo( 'Desconto de PIS/COFINS (-)'                 , 'Z' ,  iDePiCo);
  LayoutPadrao.pAddCampo( 'Desconto ICMS (-)'                          , 'AA',  iDeICMS);
  LayoutPadrao.pAddCampo( 'Fator Regional (+)'                         , 'AB',  iFatReg);
  LayoutPadrao.pAddCampo( 'Margem Ideal 1'                             , 'AC',  iMarId1);
  LayoutPadrao.pAddCampo( 'Margem Ideal 2'                             , 'AD',  iMarId2);
  LayoutPadrao.pAddCampo( 'Margem Ideal 3'                             , 'AE',  iMarId3);
  LayoutPadrao.pAddCampo( 'Margem Ideal 4'                             , 'AF',  iMarId4);
  LayoutPadrao.pAddCampo( 'Margem Ideal 5'                             , 'AG',  iMarId5);
  LayoutPadrao.pAddCampo( 'Margem Ideal 6'                             , 'AH',  iMarId6);
  LayoutPadrao.pAddCampo( 'Margem Ideal 7'                             , 'AI',  iMarId7);


  LayoutDinamico := TLayoutDinamico.Create('TfrmImportTabPrecosIteger', LayoutPadrao);

  lblLayoutSelecionado.Caption := LayoutDinamico.strLayoutSelecionado;
  pSetaColunasVariaveis;
  pPopulaCDS;
end;

procedure TfrmImportTabPrecosIteger.FormDestroy(Sender: TObject);
begin
  SetLength(arrValores, 0);

  inherited;
end;

function TfrmImportTabPrecosIteger.fRetPrecoCusto(fltPreCom, fltDesF01, fltDesF02, fltDesF03, fltDesF04, fltDesF05, fltDesF06, fltICMEnt, fltSubFed, fltIpiEnt, fltFreEnt, fltAcrFin, fltSubsti, fltDesAdb, fltVrFret: Double; blnPreDol: Boolean; fltTCIFCu, fltTSCust, fltDePiCo, fltDeICMS, fltFatReg: Double): Double;
begin
  Try
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fltDesF01;
      curDesF02 := fltDesF02;
      curDesF03 := fltDesF03;
      curDesF04 := fltDesF04;
      curDesF05 := fltDesF05;
      curDesF06 := fltDesF06;
      curICMSEnt:= fltICMEnt;
      curIPIEnt := fltIpiEnt;
      curFrete  := fltFreEnt;
      curAcrFin := fltAcrFin;
      curSubsti := fltSubsti;
      curDesAdb := fltDesAdb;
      curSubFed := fltSubFed;
      curValFre := fltVrFret;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fltTCIFCu;
        curTSCust := fltTSCust;
        curDePiCo := fltDePiCo;
        curDeICMS := fltDeICMS;
        curFatReg := fltFatReg;
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

    Result := cpcParams.fCalculaPrecoCusto(blnPreDol)
  Finally
  End;
end;

function TfrmImportTabPrecosIteger.fSqlBase(blnCamposVariacao: Boolean): string;
begin
  Result := '';
  Result := Result + (' G.ITE_CODITE AS CODITE ,');
  { Para exitir o campo na função fIncluirPreIte }
  Result := Result + (' G.ITE_PRECUS AS ITE_PRECUS ,');
  Result := Result + (' G.ITE_PRECUS AS ITE_PRECUS_NOV ,');
  Result := Result + (' G.ITE_CODITE AS ITE_CODITE ,');
  Result := Result + (' I.ITE_MLTCOM AS ITE_MLTCOM_NOV ,');
  Result := Result + (' G.ITE_DESMAX AS DESMAX, ');
  Result := Result + (' G.ITE_DESMGE AS DESMGE, ');
  Result := Result + (' G.ITE_DESMGE AS ITE_DESMGE_NOV, ');
  Result := Result + (' G.ITE_DESMSU AS DESMSU, ');
  Result := Result + (' G.ITE_DESMSU AS ITE_DESMSU_NOV, ');
  Result := Result + (' G.ITE_DESMAX AS ITE_DESMAX_NOV,');

  Result := Result + ('  ITE_DESMVM, ');
  Result := Result + ('  ITE_DESMGM, ');
  Result := Result + ('  ITE_DESMSM, ');

  Result := Result + ('  ITE_DESMVM AS ITE_DESMVM_NOV, ');
  Result := Result + ('  ITE_DESMGM AS ITE_DESMGM_NOV, ');
  Result := Result + ('  ITE_DESMSM AS ITE_DESMSM_NOV, ');

  Result := Result + (' G.ITE_MARMIN AS ITE_MARMIN_NOV,');
  Result := Result + (' G.ITE_MARMIN AS MARMIN,');
  {}

  Result := Result + (' B.BAR_CODBAR AS CODBAR ,');
  Result := Result + (' I.ITE_CODFOR AS CODFOR ,');
  Result := Result + (' I.ITE_CODFAB AS CODFAB ,');
  Result := Result + (' I.ITE_DESITE AS DESITE ,');
  Result := Result + (' I.ITE_ITEATI AS ITEATI ,');

  If fCfgSis('TIPABF') = '1' Then
    Result := Result + (' I.ITE_CODABF AS CODABF, ')
  Else
    Result := Result + (' G.ITE_CODABF AS CODABF, ');

  Result := Result + (' G.ITE_DESF01 AS ITE_DESF01 ,');
  Result := Result + (' G.ITE_DESF02 AS ITE_DESF02 ,');
  Result := Result + (' G.ITE_DESF03 AS ITE_DESF03 ,');
  Result := Result + (' G.ITE_DESF04 AS ITE_DESF04 ,');
  Result := Result + (' G.ITE_DESF05 AS ITE_DESF05 ,');
  Result := Result + (' G.ITE_DESF06 AS ITE_DESF06 ,');
  Result := Result + (' G.ITE_ICMENT AS ITE_ICMENT ,');
  Result := Result + (' G.ITE_SUBFED AS ITE_SUBFED ,');
  Result := Result + (' G.ITE_IPIENT AS ITE_IPIENT ,');
  Result := Result + (' G.ITE_FREENT AS ITE_FREENT ,');
  Result := Result + (' G.ITE_VALFRE AS ITE_VALFRE ,');
  Result := Result + (' G.ITE_ACRFIN AS ITE_ACRFIN ,');
  Result := Result + (' G.ITE_SUBSTI AS ITE_SUBSTI ,');
  Result := Result + (' G.ITE_DESADB AS ITE_DESADB ,');
  Result := Result + (' G.ITE_PREDOL AS ITE_PREDOL ,');
  Result := Result + (' G.ITE_ICMSAI AS ITE_ICMSAI ,');
  Result := Result + (' G.ITE_IMPFED AS ITE_IMPFED ,');
  Result := Result + (' G.ITE_OUTVAL AS ITE_OUTVAL ,');
  Result := Result + (' G.ITE_DESOPE AS ITE_DESOPE ,');
  Result := Result + (' G.ITE_COMTB1 AS ITE_COMTB1 ,');
  Result := Result + (' G.ITE_COMTB2 AS ITE_COMTB2 ,');
  Result := Result + (' G.ITE_COMTB3 AS ITE_COMTB3 ,');
  Result := Result + (' G.ITE_COMTB4 AS ITE_COMTB4 ,');
  Result := Result + (' G.ITE_COMTB5 AS ITE_COMTB5 ,');
  Result := Result + (' G.ITE_COMTB6 AS ITE_COMTB6 ,');
  Result := Result + (' G.ITE_COMTB7 AS ITE_COMTB7 ,');

  Result := Result + (' G.ITE_PREVE1 AS ITE_PREVE1 ,');
  Result := Result + (' G.ITE_PREVE2 AS ITE_PREVE2 ,');
  Result := Result + (' G.ITE_PREVE3 AS ITE_PREVE3 ,');
  Result := Result + (' G.ITE_PREVE4 AS ITE_PREVE4 ,');
  Result := Result + (' G.ITE_PREVE5 AS ITE_PREVE5 ,');
  Result := Result + (' G.ITE_PREVE6 AS ITE_PREVE6 ,');
  Result := Result + (' G.ITE_PREVE7 AS ITE_PREVE7 ,');

  Result := Result + (' G.ITE_MARBR1 AS ITE_MARBR1 ,');
  Result := Result + (' G.ITE_MARBR2 AS ITE_MARBR2 ,');
  Result := Result + (' G.ITE_MARBR3 AS ITE_MARBR3 ,');
  Result := Result + (' G.ITE_MARBR4 AS ITE_MARBR4 ,');
  Result := Result + (' G.ITE_MARBR5 AS ITE_MARBR5 ,');
  Result := Result + (' G.ITE_MARBR6 AS ITE_MARBR6 ,');
  Result := Result + (' G.ITE_MARBR7 AS ITE_MARBR7 ,');
  Result := Result + (' G.ITE_PRECOM AS ITE_PRECOM, ');
  Result := Result + (' G.ITE_TCIFCU AS ITE_TCIFCU, ');
  Result := Result + (' G.ITE_TSCUST AS ITE_TSCUST, ');
  Result := Result + (' G.ITE_DEPICO AS ITE_DEPICO, ');
  Result := Result + (' G.ITE_DEICMS AS ITE_DEICMS, ');
  Result := Result + (' G.ITE_FATREG AS ITE_FATREG, ');

  Result := Result + (' G.ITE_MARID1 AS ITE_MARID1, ');
  Result := Result + (' G.ITE_MARID2 AS ITE_MARID2, ');
  Result := Result + (' G.ITE_MARID3 AS ITE_MARID3, ');
  Result := Result + (' G.ITE_MARID4 AS ITE_MARID4, ');
  Result := Result + (' G.ITE_MARID5 AS ITE_MARID5, ');
  Result := Result + (' G.ITE_MARID6 AS ITE_MARID6, ');
  Result := Result + (' G.ITE_MARID7 AS ITE_MARID7, ');


  Result := Result + (' G.ITE_DESF01 AS ITE_DESF01_NOV,');
  Result := Result + (' G.ITE_DESF02 AS ITE_DESF02_NOV,');
  Result := Result + (' G.ITE_DESF03 AS ITE_DESF03_NOV,');
  Result := Result + (' G.ITE_DESF04 AS ITE_DESF04_NOV,');
  Result := Result + (' G.ITE_DESF05 AS ITE_DESF05_NOV,');
  Result := Result + (' G.ITE_DESF06 AS ITE_DESF06_NOV,');
  Result := Result + (' G.ITE_ICMENT AS ITE_ICMENT_NOV,');
  Result := Result + (' G.ITE_SUBFED AS ITE_SUBFED_NOV,');
  Result := Result + (' G.ITE_IPIENT AS ITE_IPIENT_NOV,');
  Result := Result + (' G.ITE_FREENT AS ITE_FREENT_NOV,');
  Result := Result + (' G.ITE_VALFRE AS ITE_VALFRE_NOV,');
  Result := Result + (' G.ITE_ACRFIN AS ITE_ACRFIN_NOV,');
  Result := Result + (' G.ITE_SUBSTI AS ITE_SUBSTI_NOV,');
  Result := Result + (' G.ITE_DESADB AS ITE_DESADB_NOV,');
  Result := Result + (' G.ITE_ICMSAI AS ITE_ICMSAI_NOV,');
  Result := Result + (' G.ITE_IMPFED AS ITE_IMPFED_NOV,');
  Result := Result + (' G.ITE_OUTVAL AS ITE_OUTVAL_NOV,');
  Result := Result + (' G.ITE_DESOPE AS ITE_DESOPE_NOV,');
  Result := Result + (' G.ITE_PRECOM AS ITE_PRECOM_NOV,');

  Result := Result + (' G.ITE_COMTB1 AS ITE_COMTB1_NOV,');
  Result := Result + (' G.ITE_COMTB2 AS ITE_COMTB2_NOV,');
  Result := Result + (' G.ITE_COMTB3 AS ITE_COMTB3_NOV,');
  Result := Result + (' G.ITE_COMTB4 AS ITE_COMTB4_NOV,');
  Result := Result + (' G.ITE_COMTB5 AS ITE_COMTB5_NOV,');
  Result := Result + (' G.ITE_COMTB6 AS ITE_COMTB6_NOV,');
  Result := Result + (' G.ITE_COMTB7 AS ITE_COMTB7_NOV,');

  Result := Result + (' G.ITE_PREVE1 AS ITE_PREVE1_NOV,');
  Result := Result + (' G.ITE_PREVE2 AS ITE_PREVE2_NOV,');
  Result := Result + (' G.ITE_PREVE3 AS ITE_PREVE3_NOV,');
  Result := Result + (' G.ITE_PREVE4 AS ITE_PREVE4_NOV,');
  Result := Result + (' G.ITE_PREVE5 AS ITE_PREVE5_NOV,');
  Result := Result + (' G.ITE_PREVE6 AS ITE_PREVE6_NOV,');
  Result := Result + (' G.ITE_PREVE7 AS ITE_PREVE7_NOV,');

  If blnCamposVariacao then
  Begin
    Result := Result + (' 0 VARIACAO_1,');
    Result := Result + (' 0 VARIACAO_2,');
    Result := Result + (' 0 VARIACAO_3,');
    Result := Result + (' 0 VARIACAO_4,');
    Result := Result + (' 0 VARIACAO_5,');
    Result := Result + (' 0 VARIACAO_6,');
    Result := Result + (' 0 VARIACAO_7,');
    Result := Result + (' 1 AS MARCADO, ');
  End;

  Result := Result + (' G.ITE_MARBR1 AS ITE_MARBR1_NOV,');
  Result := Result + (' G.ITE_MARBR2 AS ITE_MARBR2_NOV,');
  Result := Result + (' G.ITE_MARBR3 AS ITE_MARBR3_NOV,');
  Result := Result + (' G.ITE_MARBR4 AS ITE_MARBR4_NOV,');
  Result := Result + (' G.ITE_MARBR5 AS ITE_MARBR5_NOV,');
  Result := Result + (' G.ITE_MARBR6 AS ITE_MARBR6_NOV,');
  Result := Result + (' G.ITE_MARBR7 AS ITE_MARBR7_NOV,');

  Result := Result + (' G.ITE_TCIFCU AS ITE_TCIFCU_NOV,');
  Result := Result + (' G.ITE_TSCUST AS ITE_TSCUST_NOV,');
  Result := Result + (' G.ITE_DEPICO AS ITE_DEPICO_NOV,');
  Result := Result + (' G.ITE_DEICMS AS ITE_DEICMS_NOV,');
  Result := Result + (' G.ITE_FATREG AS ITE_FATREG_NOV,');

  Result := Result + (' G.ITE_MARID1 AS ITE_MARID1_NOV,');
  Result := Result + (' G.ITE_MARID2 AS ITE_MARID2_NOV,');
  Result := Result + (' G.ITE_MARID3 AS ITE_MARID3_NOV,');
  Result := Result + (' G.ITE_MARID4 AS ITE_MARID4_NOV,');
  Result := Result + (' G.ITE_MARID5 AS ITE_MARID5_NOV,');
  Result := Result + (' G.ITE_MARID6 AS ITE_MARID6_NOV,');
  Result := Result + (' G.ITE_MARID7 AS ITE_MARID7_NOV ');


end;

function TfrmImportTabPrecosIteger.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtDecUni) Then
  Begin
    if chkArrMai.Checked then
    Begin
      if ( StrToIntDef(edtDecUni.Text,0) < 0 ) Or
         ( StrToIntDef(edtDecUni.Text,0) > fCfgSis('DECUNI', varInteger) ) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Valor indicado para arredondamento das casas decimais deve ser entre 0 e ' + fCfgSis('DECUNI', varString) + ' !', ['&OK']);
      End;

    End;

  End;
  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmImportTabPrecosIteger.fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
begin
  Result := cdsIte.FieldByName('ITE_IMPFED_NOV').AsFloat +
            cdsIte.FieldByName('ITE_DESOPE_NOV').AsFloat +
            cdsIte.FieldByName('ITE_ICMSAI_NOV').AsFloat +
            IIF(fCfgSis('PCMPRO') = '2', cdsIte.FieldByName('ITE_COMTB' + intToStr(intTabPreco)).AsFloat, 0) +
            IIF(Pos(fCfgSis('MARMKP'), '1_5_') > 0, objPrecos[intTabPreco].fltMarBru, 0) <= 100;
end;

function TfrmImportTabPrecosIteger.fVerificaIteAti(
  qryLocaliza: TUniQuery): boolean;
begin
  Case rdgIteAti.ItemIndex of
    0: exit(qryLocaliza.FieldByName('ITEATI').AsString = 'S');
    1: exit(qryLocaliza.FieldByName('ITEATI').AsString = 'N');
    else
      Exit(True);
  End;
end;

procedure TfrmImportTabPrecosIteger.lblLayoutSelecionadoClick(Sender: TObject);
begin
  inherited;
  If LayoutDinamico.fSelecionaModelo Then
  Begin
    lblLayoutSelecionado.Caption := LayoutDinamico.strLayoutSelecionado;
    pSetaColunasVariaveis;
    pPopulaCDS
  End;


end;

function TfrmImportTabPrecosIteger.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If Not blnArqCsv Then
  Begin
    If Trim(Excel.Range[cCodIte + IntToStr(1)].Value) <> '' Then
      Result := not TryStrToInt(Trim(Excel.Range[cCodIte + IntToStr(1)].Value), intValDef)
    Else
      Result := False;
  End
  Else
  Begin
    If objValidaExcel.fGetValueCSV(0, cCODITE) <> '' Then
      Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCODITE)), intValDef)
    Else
      Result := False;
  End
end;

procedure TfrmImportTabPrecosIteger.pCriarCds;
  var
    strSql: string;
    i: integer;
begin
  strSql := strSql + ('SELECT ');
  strSql := strSql + fSqlBase(True);
  strSql := strSql + (', CAST("" AS CHAR(500)) AS DESEXC,');
  strSql := strSql + (' 0 AS IMPORT');
  strSql := strSql + (' FROM ITEGER G');
  strSql := strSql + (' LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE ');
  strSql := strSql + ('  LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
  strSql := strSql + ('  WHERE FALSE');

  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);

  cdsItens := TZClient.Create(Self, strSql);

  cdsItens.fAbreClient(True,'[TfrmImportTabPrecosIteger.pCriarCds]');
  {Formata os campos usando format #,##0.00}
  pFormatarCampo('DESF01', True);
  pFormatarCampo('DESF02', True);
  pFormatarCampo('DESF03', True);
  pFormatarCampo('DESF04', True);
  pFormatarCampo('DESF05', True);
  pFormatarCampo('DESF06', True);
  pFormatarCampo('ICMENT', True);
  pFormatarCampo('SUBFED', True);
  pFormatarCampo('IPIENT', True);
  pFormatarCampo('FREENT', True);
  pFormatarCampo('VALFRE', True);
  pFormatarCampo('ACRFIN', True);
  pFormatarCampo('SUBSTI', True);
  pFormatarCampo('DESADB', True);
  pFormatarCampo('ICMSAI', True);
  pFormatarCampo('IMPFED', True);
  pFormatarCampo('OUTVAL', True);
  pFormatarCampo('DESOPE', True);
  pFormatarCampo('PRECOM', True);
  pFormatarCampo('TCIFCU', True);
  pFormatarCampo('TSCUST', True);
  pFormatarCampo('DEPICO', True);
  pFormatarCampo('DEICMS', True);
  pFormatarCampo('FATREG', True);
  for i := 1 To 7 do
  Begin
    pFormatarCampo('COMTB' + IntToStr(i), True);
    pFormatarCampo('PREVE' + IntToStr(i), True);
    pFormatarCampo('MARBR' + IntToStr(i), True);
    pFormatarCampo('MARID' + IntToStr(i), True);
  End;
end;

procedure TfrmImportTabPrecosIteger.pFormatarCampo(strCampo: string; blnTem_ITE: boolean = False);
begin
  if not blnTem_ITE then
  Begin
    (cdsItens.FieldByName(strCampo) as TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('ITE_' + strCampo + '_NOV') as TFloatField).DisplayFormat := '#,##0.00';
  end
  Else
  Begin
    (cdsItens.FieldByName('ITE_' + strCampo) as TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('ITE_' + strCampo + '_NOV') as TFloatField).DisplayFormat := '#,##0.00';
  End

end;

procedure TfrmImportTabPrecosIteger.pInsereItensCDS(intLinha: integer);
  var
    i: integer;
    strCodIte,
    strCodBar,
    strCodFor,
    strCodFab: String;
    fltVariacao_Percentual: Double;
begin
  pGetCodigos(strCodIte, strCodBar, strCodFor, strCodFab, intLinha);
  Try
    cdsItens.Insert;

    cdsItens.FieldByName('DESEXC').AsString := '';

    If ((fLocalizaItemIteger(qryItensEncontrados, intLinha)) And (fVerificaIteAti(qryItensEncontrados)))Then
    Begin

      For i := 0 to qryItensEncontrados.Fields.Count -1 do
        cdsItens.FieldByName(qryItensEncontrados.Fields[i].FieldName).Value := qryItensEncontrados.Fields[i].Value;

      { Para exitir o campo na função fIncluirPreIte }
      cdsItens.FieldByName('ITE_PRECUS_NOV').Value := qryItensEncontrados.FieldByName('ITE_PRECUS_NOV').Value;
      cdsItens.FieldByName('ITE_CODITE').Value     := qryItensEncontrados.FieldByName('ITE_CODITE').Value;
      cdsItens.FieldByName('ITE_MLTCOM_NOV').Value := qryItensEncontrados.FieldByName('ITE_MLTCOM_NOV').Value;

      cdsItens.FieldByName('ITE_DESMAX_NOV').Value := qryItensEncontrados.FieldByName('DESMAX').Value;
      cdsItens.FieldByName('ITE_DESMGE_NOV').Value := qryItensEncontrados.FieldByName('DESMGE').Value;
      cdsItens.FieldByName('ITE_DESMSU_NOV').Value := qryItensEncontrados.FieldByName('DESMSU').Value;
      cdsItens.FieldByName('ITE_MARMIN_NOV').Value := qryItensEncontrados.FieldByName('MARMIN').Value;



      cdsItens.FieldByName('IMPORT').AsInteger := 1;
    End
    Else
    Begin
      If (strCodIte + strCodBar + strCodFor +  strCodFab) <> '' then
      Begin
        cdsItens.FieldByName('IMPORT').AsInteger := 0;
        If Not fVerificaIteAti(qryItensEncontrados) Then
          cdsItens.FieldByName('DESEXC').AsString := 'Produto excluído pelo filtro de item ativo.'
        Else
          cdsItens.FieldByName('DESEXC').AsString := 'Produto não encontrado na Base de Dados.';
      end
      else
      begin
        cdsItens.Cancel;
        exit;
      end;

    End;

    If Not blnArqCsv Then
    Begin
      If Not fEmptyStr(strList.Cells[iPreCom, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iPreCom, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_PRECOM_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesF01, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESF01_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesF01, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF01_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesF02, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESF02_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesF02, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF02_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesF03, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESF03_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesF03, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF03_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesF04, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESF04_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesF04, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF04_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesF05, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESF05_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesF05, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF05_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesF06, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESF06_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesF06, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF06_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iIcmEnt, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_ICMENT_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iIcmEnt, intLinha -1 ]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_ICMENT_NOV').Value := Null;

      If Not fEmptyStr(strList.Cells[iIpiEnt, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_IPIENT_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iIpiEnt, intLinha - 1]), intDecUni)

      Else
        cdsItens.FieldByName('ITE_IPIENT_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iFreEnt, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_FREENT_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iFreEnt, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_FREENT_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iValFre, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_VALFRE_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iValFre, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_VALFRE_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iAcrFin, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_ACRFIN_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iAcrFin, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_ACRFIN_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iSubSti, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_SUBSTI_NOV').AsFloat :=  fFormataFloat(fStrToFloat(strList.Cells[iSubSti, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_SUBSTI_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesAdc, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESADB_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesAdc, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESADB_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iOutVal, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_OUTVAL_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iOutVal, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_OUTVAL_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iIcmSai, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_ICMSAI_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iIcmSai, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_ICMSAI_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iSubFed, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_SUBFED_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iSubFed, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_SUBFED_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iImpFed, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_IMPFED_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iImpFed, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_IMPFED_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDesOpe, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DESOPE_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDesOpe, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESOPE_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iTCIFCu, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_TCIFCU_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iTCIFCu, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_TCIFCU_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iTSCust, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_TSCUST_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iTSCust, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_TSCUST_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDePiCo, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DEPICO_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDePiCo, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DEPICO_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iDeICMS, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_DEICMS_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iDeICMS, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DEICMS_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iFatReg, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_FATREG_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iFatReg, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_FATREG_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId1, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID1_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId1, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID1_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId2, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID2_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId2, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID2_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId3, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID3_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId3, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID3_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId4, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID4_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId4, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID4_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId5, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID5_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId5, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID5_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId6, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID6_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId6, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID6_NOV').Value   := Null;

      If Not fEmptyStr(strList.Cells[iMarId7, intLinha - 1]) Then
        cdsItens.FieldByName('ITE_MARID7_NOV').AsFloat := fFormataFloat(fStrToFloat(strList.Cells[iMarId7, intLinha - 1]), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID7_NOV').Value   := Null;

    End
    Else
    Begin
      If IIf(fCampoAltera(cPrComp), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPrComp)), Null) <> Null Then
        cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cPrComp)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_PRECOM_NOV').Value := Null;

      If IIf(fCampoAltera(cDesFo1), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesFo1)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESF01_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesFo1)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF01_NOV').Value := Null;

      If IIf(fCampoAltera(cDesFo2), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesFo2)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESF02_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesFo2)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF02_NOV').Value := Null;

      If IIf(fCampoAltera(cDesFo3), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesFo3)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESF03_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesFo3)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF03_NOV').Value := Null;

      If IIf(fCampoAltera(cDesFo4), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesFo4)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESF04_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesFo4)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF04_NOV').Value := Null;

      If IIf(fCampoAltera(cDesFo5), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesFo5)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESF05_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesFo5)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF05_NOV').Value := Null;

      If IIf(fCampoAltera(cDesFo6), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesFo6)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESF06_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesFo6)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESF06_NOV').Value := Null;

      If IIf(fCampoAltera(cIcmEnt), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIcmEnt)), Null) <> Null Then
        cdsItens.FieldByName('ITE_ICMENT_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cIcmEnt)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_ICMENT_NOV').Value := Null;

      If IIf(fCampoAltera(cIpiEnt), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIpiEnt)), Null) <> Null Then
        cdsItens.FieldByName('ITE_IPIENT_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cIpiEnt)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_IPIENT_NOV').Value := Null;

      If IIf(fCampoAltera(cFrete_), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cFrete_)), Null) <> Null Then
        cdsItens.FieldByName('ITE_FREENT_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cFrete_)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_FREENT_NOV').Value := Null;

      If IIf(fCampoAltera(cVrFret), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVrFret)), Null) <> Null Then
        cdsItens.FieldByName('ITE_VALFRE_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cVrFret)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_VALFRE_NOV').Value := Null;

      If IIf(fCampoAltera(cAcrFin), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cAcrFin)), Null) <> Null Then
        cdsItens.FieldByName('ITE_ACRFIN_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cAcrFin)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_ACRFIN_NOV').Value := Null;

      If IIf(fCampoAltera(cSubSti), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cSubSti)), Null) <> Null Then
        cdsItens.FieldByName('ITE_SUBSTI_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cSubSti)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_SUBSTI_NOV').Value := Null;

      If IIf(fCampoAltera(cDesAdc), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesAdc)), Null)  <> Null Then
        cdsItens.FieldByName('ITE_DESADB_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesAdc)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESADB_NOV').Value := Null;

      If IIf(fCampoAltera(cOutros), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cOutros)), Null) <> Null Then
        cdsItens.FieldByName('ITE_OUTVAL_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cOutros)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_OUTVAL_NOV').Value := Null;

      If IIf(fCampoAltera(cIcmSai), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIcmSai)), Null) <> Null Then
        cdsItens.FieldByName('ITE_ICMSAI_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cIcmSai)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_ICMSAI_NOV').Value := Null;

      If IIf(fCampoAltera(cSubFed), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cSubFed)), Null) <> Null Then
        cdsItens.FieldByName('ITE_SUBFED_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cSubFed)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_SUBFED_NOV').Value := Null;

      If IIf(fCampoAltera(cImpFed), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cImpFed)), Null) <> Null Then
        cdsItens.FieldByName('ITE_IMPFED_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cImpFed)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_IMPFED_NOV').Value := Null;

      If IIf(fCampoAltera(cDesOpe), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDesOpe)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DESOPE_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDesOpe)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DESOPE_NOV').Value := Null;

      If IIf(fCampoAltera(cTCIFCu), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTCIFCu)), Null) <> Null Then
        cdsItens.FieldByName('ITE_TCIFCU_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cTCIFCu)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_TCIFCU_NOV').Value := Null;

      If IIf(fCampoAltera(cTSCust), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTSCust)), Null) <> Null Then
        cdsItens.FieldByName('ITE_TSCUST_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cTSCust)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_TSCUST_NOV').Value := Null;

      If IIf(fCampoAltera(cDePico), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDePico)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DEPICO_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDePico)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DEPICO_NOV').Value := Null;

      If IIf(fCampoAltera(cDeICMS), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDeICMS)), Null) <> Null Then
        cdsItens.FieldByName('ITE_DEICMS_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cDeICMS)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_DEICMS_NOV').Value := Null;

      If IIf(fCampoAltera(cFatReg), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cFatReg)), Null) <> Null Then
        cdsItens.FieldByName('ITE_FATREG_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cFatReg)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_FATREG_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId1), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId1)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID1_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId1)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID1_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId2), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId2)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID2_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId2)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID2_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId3), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId3)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID3_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId3)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID3_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId4), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId4)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID4_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId4)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID4_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId5), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId5)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID5_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId5)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID5_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId6), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId6)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID6_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId6)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID6_NOV').Value := Null;

      If IIf(fCampoAltera(cMarId7), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMarId7)), Null) <> Null Then
        cdsItens.FieldByName('ITE_MARID7_NOV').Value := fFormataFloat(fStrToFloat(objValidaExcel.fGetValueCSV(intLinha, cMarId7)), intDecUni)
      Else
        cdsItens.FieldByName('ITE_MARID7_NOV').Value := Null;
    End;

    pCalcularPrecos(cdsItens, recPrecos);

    //Novos Valores Para Margem e Preco Venda
    For i := 1 to 7 Do
    Begin
      cdsItens.FieldByName('ITE_MARBR' + IntToStr(i) + '_NOV').AsFloat := recPrecos[i].fltMarBru;
      cdsItens.FieldByName('ITE_PREVE' + IntToStr(i) + '_NOV').AsFloat := recPrecos[i].fltPreVen;

      fltVariacao_Percentual := (cdsItens.FieldByname('ITE_PREVE' + IntToStr(i) + '_NOV').AsFloat/cdsItens.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat - 1) * 100;
      cdsItens.FieldByName('VARIACAO_' + IntToStr(i)).AsFloat := fltVariacao_Percentual;

      If not fValidaMargem(i, cdsItens, recPrecos) Then
      Begin
        if cdsItens.FieldByName('DESEXC').AsString <> '' then
           cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
        cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + 'TABELA DE PREÇOS ' +
                                                   IntToStr(i) + ': A SOMA DO "ICMS SAÍDA" + "IMPOSTOS FEDERAIS" + "DESPESAS OPERACIONAIS" ' +
                                                   IIF(Pos(fCfgSis('MARMKP'), '1_5_') > 0, ' + "MARGEM BRUTA" ', '') +
                                                   IIF(fCfgSis('PCMPRO') = '2', '+ "COMISSÃO" ', '') + ' NÃO PODEM SER SUPERIOR A 100%.  PORCENTAGEM "MARGEM BRUTA": ' +
                                                   FormatFloat('#,###0.00', recPrecos[i].fltMarBru) + IIF(fCfgSis('PCMPRO') = '2', '  PORCENTAGEM "COMISSÃO": ' + FormatFloat('#,###0.00', recPrecos[i].fltComiss), '');
        cdsItens.FieldByName('IMPORT').AsInteger := 2;
      End;
    End;

    If cdsItens.FieldByName('IMPORT').AsInteger = 0 Then
    Begin
      cdsItens.FieldByName('CODITE').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodIte));
      cdsItens.FieldByName('CODFOR').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodFor));
      cdsItens.FieldByName('CODBAR').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodBar));
      cdsItens.FieldByName('CODFAB').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodFab));
    End;
    If cdsItens.FieldByName('IMPORT').AsInteger = 1 Then
      cdsItens.FieldByName('MARCADO').AsInteger := 1;

    cdsItens.Post;

  Except
    on E: Exception do
       pMensagensErro(E.Message, '[TfrmImportTabPrecosIteger.pInsereItensCDS]');
  End;
end;

procedure TfrmImportTabPrecosIteger.pLimparCDS;
begin
  cdsItens.EmptyDataSet;
end;

procedure TfrmImportTabPrecosIteger.pPopulaCDS;
  procedure pAddCampo(cdsCampo: TUniClientDataSet; StrDescricao: String; strColuna: String; intColuna: Integer; StrField: String);
  begin
    cdsCampo.Append;
    cdsCampo.FieldByName('DESCRI').AsString := StrDescricao;
    cdsCampo.FieldByName('COLUNA').AsString := StrCOLUNA;
    cdsCampo.FieldByName('MARDES').AsString := 'S';
    cdsCampo.FieldByName('INDEX').AsInteger :=  intColuna;
    cdsCampo.FieldByName('FIELD').AsString := StrField;
    cdsCampo.Post;
  end;
Begin
  If Not cdsCampos.IsEmpty then
  Begin
    While not cdsCampos.Eof do
      cdsCampos.Delete;
  End;

  pAddCampo(cdsCampos, cDesPrComp, cPrComp, iPreCom, 'ITE_PRECOM');
  pAddCampo(cdsCampos, cDesDesFo1, cDesFo1, iDesF01, 'ITE_DESF01');
  pAddCampo(cdsCampos, cDesDesFo2, cDesFo2, iDesF02, 'ITE_DESF02');
  pAddCampo(cdsCampos, cDesDesFo3, cDesFo3, iDesF03, 'ITE_DESF03');
  pAddCampo(cdsCampos, cDesDesFo4, cDesFo4, iDesF04, 'ITE_DESF04');
  pAddCampo(cdsCampos, cDesDesFo5, cDesFo5, iDesF05, 'ITE_DESF05');
  pAddCampo(cdsCampos, cDesDesFo6, cDesFo6, iDesF06, 'ITE_DESF06');
  pAddCampo(cdsCampos, cDesIcmEnt, cIcmEnt, iIcmEnt, 'ITE_ICMENT');
  pAddCampo(cdsCampos, cDesSubFed, cSubFed, iSubFed, 'ITE_SUBFED');
  pAddCampo(cdsCampos, cDesIpiEnt, cIpiEnt, iIpiEnt, 'ITE_IPIENT');
  pAddCampo(cdsCampos, cDesFrete_, cFrete_, iFreEnt, 'ITE_FREENT');
  pAddCampo(cdsCampos, cDesVrFret, cVrFret, iValFre, 'ITE_VALFRE');
  pAddCampo(cdsCampos, cDesAcrFin, cAcrFin, iAcrFin, 'ITE_ACRFIN');
  pAddCampo(cdsCampos, cDesSubSti, cSubSti, iSubSti, 'ITE_SUBSTI');
  pAddCampo(cdsCampos, fCfgSis('DESADI')+' ('+fCfgSis('OPEADI')+')', cDesAdc, iDesAdc, 'ITE_DESADC');
  pAddCampo(cdsCampos,  fCfgSis('DOVCPP')+' (+)', cOutros, iOutVal, 'ITE_OUTVAL');
  pAddCampo(cdsCampos, cDesIcmSai, cIcmSai,iIcmSai, 'ITE_ICMSAI');
  pAddCampo(cdsCampos, cDesImpFed, cImpFed,iImpFed, 'ITE_IMPFED');
  pAddCampo(cdsCampos, cDesDesOpe, cDesOpe,iDesOpe, 'ITE_DESOPE');
  pAddCampo(cdsCampos, cDesTCIFCu, cTCIFCu,iTCIFCu, 'ITE_TCIFCU');
  pAddCampo(cdsCampos, cDesTSCust, cTSCust,iTSCust, 'ITE_TSCUST');
  pAddCampo(cdsCampos, cDesDePico, cDePico,iDePiCo, 'ITE_DEPICO');
  pAddCampo(cdsCampos, cDesDeICMS, cDeICMS,iDeICMS, 'ITE_DEICMS');
  pAddCampo(cdsCampos, cDesFatReg, cFatReg,iFatReg, 'ITE_FATREG');

  pAddCampo(cdsCampos, cDesMarId1, cMarId1, iMarId1,'ITE_MARID1');
  pAddCampo(cdsCampos, cDesMarId2, cMarId2, iMarId2,'ITE_MARID2');
  pAddCampo(cdsCampos, cDesMarId3, cMarId3, iMarId3,'ITE_MARID3');
  pAddCampo(cdsCampos, cDesMarId4, cMarId4, iMarId4,'ITE_MARID4');
  pAddCampo(cdsCampos, cDesMarId5, cMarId5, iMarId5,'ITE_MARID5');
  pAddCampo(cdsCampos, cDesMarId6, cMarId6, iMarId6,'ITE_MARID6');
  pAddCampo(cdsCampos, cDesMarId7, cMarId7, iMarId7,'ITE_MARID7');

end;

procedure TfrmImportTabPrecosIteger.pSetaColunasVariaveis;
begin
  cCodIte := LayoutDinamico.ArrCamposLayoutSelecionado[iCodIte -1].strPosicao;
  cCodBar := LayoutDinamico.ArrCamposLayoutSelecionado[iCodBar -1].strPosicao;
  cCodFab := LayoutDinamico.ArrCamposLayoutSelecionado[iCodFab -1].strPosicao;
  cCodFor := LayoutDinamico.ArrCamposLayoutSelecionado[iCodFor -1].strPosicao;
  cPrComp := LayoutDinamico.ArrCamposLayoutSelecionado[iPreCom -1].strPosicao;
  cDesFo1 := LayoutDinamico.ArrCamposLayoutSelecionado[iDesF01 -1].strPosicao;
  cDesFo2 := LayoutDinamico.ArrCamposLayoutSelecionado[iDesF02 -1].strPosicao;
  cDesFo3 := LayoutDinamico.ArrCamposLayoutSelecionado[iDesF03 -1].strPosicao;
  cDesFo4 := LayoutDinamico.ArrCamposLayoutSelecionado[iDesF04 -1].strPosicao;
  cDesFo5 := LayoutDinamico.ArrCamposLayoutSelecionado[iDesF05 -1].strPosicao;
  cDesFo6 := LayoutDinamico.ArrCamposLayoutSelecionado[iDesF06 -1].strPosicao;
  cIcmEnt := LayoutDinamico.ArrCamposLayoutSelecionado[iIcmEnt -1].strPosicao;
  cSubFed := LayoutDinamico.ArrCamposLayoutSelecionado[iSubFed -1].strPosicao;
  cIpiEnt := LayoutDinamico.ArrCamposLayoutSelecionado[iIpiEnt -1].strPosicao;
  cFrete_ := LayoutDinamico.ArrCamposLayoutSelecionado[iFreEnt -1].strPosicao;
  cVrFret := LayoutDinamico.ArrCamposLayoutSelecionado[iValFre -1].strPosicao;
  cAcrFin := LayoutDinamico.ArrCamposLayoutSelecionado[iAcrFin -1].strPosicao;
  cSubSti := LayoutDinamico.ArrCamposLayoutSelecionado[iSubSti -1].strPosicao;
  cDesAdc := LayoutDinamico.ArrCamposLayoutSelecionado[iDesAdc -1].strPosicao;
  cOutros := LayoutDinamico.ArrCamposLayoutSelecionado[iOutVal -1].strPosicao;
  cIcmSai := LayoutDinamico.ArrCamposLayoutSelecionado[iIcmSai -1].strPosicao;
  cImpFed := LayoutDinamico.ArrCamposLayoutSelecionado[iImpFed -1].strPosicao;
  cDesOpe := LayoutDinamico.ArrCamposLayoutSelecionado[iDesOpe -1].strPosicao;
  cTCIFCu := LayoutDinamico.ArrCamposLayoutSelecionado[iTCIFCu -1].strPosicao;
  cTSCust := LayoutDinamico.ArrCamposLayoutSelecionado[iTSCust -1].strPosicao;
  cDePico := LayoutDinamico.ArrCamposLayoutSelecionado[iDePiCo -1].strPosicao;
  cDeICMS := LayoutDinamico.ArrCamposLayoutSelecionado[iDeICMS -1].strPosicao;
  cFatReg := LayoutDinamico.ArrCamposLayoutSelecionado[iFatReg -1].strPosicao;

  cMarId1 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId1 -1].strPosicao;
  cMarId2 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId2 -1].strPosicao;
  cMarId3 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId3 -1].strPosicao;
  cMarId4 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId4 -1].strPosicao;
  cMarId5 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId5 -1].strPosicao;
  cMarId6 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId6 -1].strPosicao;
  cMarId7 := LayoutDinamico.ArrCamposLayoutSelecionado[iMarId7 -1].strPosicao;
end;

function TfrmImportTabPrecosIteger.XlsToStringGrid(AGrid: TStringGrid;
  AXLSFile: String): boolean;
const
	xlCellTypeLastCell = $0000000B;
var
	XLApp, Sheet: OLEVariant;
	RangeMatrix: Variant;
	x, y, k, r: Integer;
begin
  Result:=False;
  //Cria Excel- OLE Object
  XLApp:=CreateOleObject('Excel.Application');
try
	//Esconde Excel
	XLApp.Visible:=False;

	//Abre o Workbook
	XLApp.Workbooks.Open(AXLSFile);
	Sheet := XLApp.Workbooks[ExtractFileName(AXLSFile)].WorkSheets[1];
	Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;

	//Pegar o número da última linha
	x:=XLApp.ActiveCell.Row;

	//Pegar o número da última coluna
	y:=XLApp.ActiveCell.Column;
	//Seta Stringgrid linha e coluna

	AGrid.RowCount:=x;
	AGrid.ColCount:=y;

	//Associa a variant WorkSheet com a variant do Delphi
	RangeMatrix:=XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;

	//Cria o loop para listar os registros no TStringGrid
	k:=1;

	repeat
		for r:=1 to y do
			AGrid.Cells[(r - 1),(k - 1)]:=RangeMatrix[K, R];
		Inc(k,1);
	until k > x;

	RangeMatrix := Unassigned;

  finally
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
      Result := True;
    end;
	end;
end;

function TfrmImportTabPrecosIteger.fSQLIteger(pesTipPes: TTipoPesquisa): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ' + fSqlBase(False);
  strSQL := strSQL + ' FROM';
  strSQL := strSQL + '   ITEGER G ';
  strSQL := strSQL + '   LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE  ';
  If pesTipPes = pesCodBar Then
    strSQL := strSQL + '   LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE '
  Else
    strSQL := strSQL + '   LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE AND B.BAR_CODBAR = I.ITE_CODBAR ';
  strSQL := strSQL + '   WHERE G.ITE_CODEMP = :CODEMP ';

  Case pesTipPes Of
    pesCodIte: strSQL := strSQL + ' AND G.ITE_CODITE = :CODITE ';
    pesCodBar: strSQL := strSQL + ' AND B.BAR_CODBAR = :CODBAR ';
    pesCodFab: strSQL := strSQL + ' AND (I.ITE_CODFAB = :CODFAB AND I.ITE_CODFOR = :CODFOR) ';
  End;

  Result := strSQL;
End;

function TfrmImportTabPrecosIteger.fLocalizaItemIteger(qryLocaliza: TUniQuery; intLinha: Integer): boolean;
  Var
    strCodIte,
    strCodBar,
    strCodFor,
    strCodFab: String;
begin
  Result := False;
  pGetCodigos(strCodIte, strCodBar, strCodFor, strCodFab, intLinha);
  Try
    qryLocaliza.Close;

    If (Not Result) And (Not fEmptyStr(strCodFab)) And (Not fEmptyStr(strCodFor)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesCodFab);
      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODFAB').AsString := strCodFab;
      qryLocaliza.ParamByName('CODFOR').AsString := strCodFor;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
    End;

    If (Not Result) And (Not fEmptyStr(strCodIte)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesCodIte);

      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODITE').AsString := strCodIte;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
    End;

    If (Not Result) And (Not fEmptyStr(strCodBar)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesCodBar);

      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODBAR').AsString := strCodBar;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmImportTabPrecosIteger.fLocalizaItemIteger]');
  End;

end;


end.
