unit untImpReducaoZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask, StrUtils,
  MaskEditFocus, Uni, untFiscal, FilenameEditFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

Type
  TDadosCadRdz = Record

    strCodEmp: String;
    dtaDtaMov: TDate;
    strCodMod: String;
    strCodEcf: String;
    strCpoIni: String;
    strCpoFim: String;
    strCpoUlt: String;
    strQtdRdz: String;
    dtaDtaEmi: TDate;
    strHorEmi: String;
    strNroCoo: String;
    strNroCro: String;
    fltGrtAnt: Double;
    fltGrtAtu: Double;
    fltValDia: Double;
    fltTotCnl: Double;
    fltTotDsc: Double;
    fltTotIss: Double;
    fltTotAcr: Double;
    fltTotCtb: Double;
    fltTotSbt: Double;
    fltTotIse: Double;
    fltTotNin: Double;
    fltAlqIc1: Double;
    fltValIc1: Double;
    fltAlqIc2: Double;
    fltValIc2: Double;
    fltAlqIc3: Double;
    fltValIc3: Double;
    fltAlqIc4: Double;
    fltValIc4: Double;
    fltAlqIc5: Double;
    fltValIc5: Double;
    fltAlqIc6: Double;
    fltValIc6: Double;
    fltAlqIc7: Double;
    fltValIc7: Double;
    fltAlqIc8: Double;
    fltValIc8: Double;

  End;

Type
  TLogImpRdZ = class
    private
      FDtaImp: TDate;
      FHorImp: TTime;
      FOpeImp: String;
      FNumSer: String;
      FDtaIni: TDate;
      FDtaFin: TDate;
    public
      Constructor Create; reintroduce;
                         
      procedure pGravarLogRdZ(strImportado: String = ''; strNomArq: String = '');
      
      procedure pMarcarReducaoImportada;
      procedure pGravarArquivoMFD(strNomArq: String);

      property dtaDtaImp: TDate  Read FDtaImp Write FDtaImp;
      property horHorImp: TTime  Read FHorImp Write FHorImp;
      property strOpeImp: String Read FOpeImp Write FOpeImp;
      property strNumSer: String Read FNumSer Write FNumSer;
      property dtaDtaIni: TDate  Read FDtaIni Write FDtaIni;
      property dtaDtaFin: TDate  Read FDtaFin Write FDtaFin;
  end;

Type
   TDadosRdzTot = Record

    strCODEcf: String;
    strNumCrz: String;
    strCodTot: String;
    strDesTot: String;
    dtaDtaMov: TDate;
    fltBasImp: Double;
    fltAlqImp: Double;
    fltValImp: Double;
    fltvlrAcu: Double;
    strNumTot: String;
    strDesSit: String;

  End;

type
  TfrmImpReducaoZ = class(TfrmPaiConfirma)
    pnlDatas: TPanel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    pnlMensag: TPanel;
    lblMensag: TLabel;
    pnlMsgRdZ: TPanel;
    Memo1: TMemo;
    pnlArqRdZ: TPanel;
    lbl1: TLabel;
    edtArqRdZ: TFilenameEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtArqRdZPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    strArqSai: String;
    stlEspMFD: TStringList;
    objFiscal: TFiscalBrd;
    objLogRdZ: TLogImpRdZ;    

    arrCadRdz: Array Of TDadosCadRdz;
    arrRdzTot: Array Of TDadosRdzTot;

  {********************************************}
  {* USADAS NAS FUNÇÕES ExtraiDadosEspelhoMFD *}
  {*****************************************CI*}

    intContGer: Integer;
    intContDad: Integer;
    intContTot: Integer;
    intPosicao: Integer;
    intContImp: Integer;
    intNumTot : Integer;
    intPosIni : Integer;
    intQtdCpy : Integer;
    str_Linha : String;
    strLinCoo : String;
    strLinTot : String;
    strTipImp : String;
    strBasIcm : String;
    strAlqIcm : String;
    strTipImpTmp: String;
    blnTipImp   : Boolean;
    blnNaoTri   : Boolean;
    blnContinua : Boolean;
    blnConfirmou : Boolean;

    intImpRdz : Integer;
    blnObjFiscalCriado: Boolean;

    procedure pCalculaValores;
    procedure pAtualizaCodEcfTotais(strCodEcf: String);

    function  fGravarReducaoZ: Boolean;
    function  fCarregaEspelhoMFD: Boolean;
    function  fExtraiDadosEspelhoMFD: Boolean;
    function  fExtraiDadosEspelhoMFD_SWEDA_ST120: Boolean;
    function  fExtraiDadosEspelhoMFD_2000: Boolean;
    function  fExtraiDadosEspelhoMFD_4200: Boolean;
    function  fExtraiDadosEspelhoMFD_Daruma: Boolean;
    function  fExtraiDadosEspelhoMFD_Elgin: Boolean;
    function  fExtraiDadosEspelhoMFD_Epson: Boolean;
    function  fGeraEspelhoMFD  : Boolean;
    function  fEspelhoGeradoMFD: Boolean;
    function  fGravaDadosTabela: Boolean;
    function  fCalcularValorLiquido(strCODEcf, strNumCrz: String): Double;
    function  fCalculaRDZAnterior(Data: TDate; strCodEcf: String): String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnImportaAutomatico: Boolean;
  end;

Const

  DARUMA600   = 'FS600';
  DARUMAMACH  = 'MACH 1';
  DARUMAMACH_2  = 'MACH 2';

var
  frmImpReducaoZ: TfrmImpReducaoZ;

implementation

uses untFuncoes, untFuncoesSimples, untConstantes, untTypesSistema;

{$R *.dfm}

procedure TfrmImpReducaoZ.btnConfirmaClick(Sender: TObject);
  Var
    blnGravou: Boolean;
begin
  If Not fVerificaCampos Then
  Begin
    blnConfirmou := False;
    Exit;
  End;

  inherited;
  blnGravou := false;
  Try
    blnGravou := False;
    blnConfirmou := True;

    If Assigned(objLogRdZ) Then
    Begin
      objLogRdZ.dtaDtaImp := VS_Date;
      objLogRdZ.horHorImp := fTime();
      objLogRdZ.strOpeImp := strLoginUsuarioLogado;
      objLogRdZ.dtaDtaIni := StrToDateTimeDef(mskDtaIni.Text, 0);
      objLogRdZ.dtaDtaFin := StrToDateTimeDef(mskDtaFin.Text, 0);

      If Assigned(objFiscal) Then
      Begin
        objLogRdZ.strNumSer := objFiscal.fNumeroSerie;
        objLogRdZ.pGravarLogRdZ;
      End;
    End;

    blnGravou := fGravarReducaoZ;

    If blnImportaAutomatico Then
      Close;

  Finally

    If Assigned(objLogRdZ) Then
    Begin
      If blnGravou Then
        objLogRdZ.pMarcarReducaoImportada
      Else
        objLogRdZ.pGravarArquivoMFD(strArqSai);      
    End;

    If blnGravou Then
      fMensagem('','Dados importados com sucesso!',['&O k']);
    
  End;
            
end;

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;

Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUÇÃO Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Reduções Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'Total de ISSQN:';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = 'ICMS';
  FIMIMP = 'ISSQN';

begin
  Result := True;

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := stlEspMFD[intContGer];

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z E QUE TEVE MOVIMENTAÇÃO. *}
      {*********************************************PZ*}
      If (Trim(stlEspMFD[intContGer])  = REDUCZ) And
         (Trim(stlEspMFD[intContGer + 1]) <> SEMMOV) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;

        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(strLinCoo, 10);
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Copy(strLinCoo, 12, 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := fStrZero(str_Linha, 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}
        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;
            blnNaoTri  := False;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************PZ*}
//            While (Trim(stlEspMFD[intContGer]) <> FIMIMP) Do
            While (Pos('TOTALIZADORES N', stlEspMFD[intContGer]) <= 0) Do
            Begin
              strCodTot  := '';
              intContImp := 1;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              {*************************************************}
              {* AJUSTA PARA PEGAR OS DADOS DOS NÃO TRIBUTADOS *}
              {**********************************************PZ*}
              If (Pos('-----', str_Linha) > 0) Then
              Begin
                intContGer := intContGer + 3;
                blnNaoTri := True;
                Continue;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 0 To Length(str_Linha) - 1 Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************PZ*}
                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))                   And
                        (((intContImp <= 5) And (Not blnNaoTri)) Or
                         ((intContImp <= 1) And (blnNaoTri)))        And
                        (Not fEmptyStr(str_Linha[intContLin]))       Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp)) Or
                   ((blnNaoTri) And (Pos('=', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              If AnsiEndsText('00', strCodTot) Then
              Begin
                strCodTot := LeftStr(strCodTot, 3);
              End
              Else
              Begin
                strCodTot := AnsiReplaceStr(strCodTot, ',', '');
              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              If (Not blnNaoTri) Then
              Begin
                {*************************************************}
                {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
                {**********************************************PZ*}
                While(intContLin < Length(strLinTot)) Do
                Begin
                  If (Not fEmptyStr(strLinTot[intContLin])) Then
                    strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                  Else If intContLin > 0 Then
                    intContLin := Length(strLinTot);

                  Inc(intContLin);
                End;

                {******************************}
                {* ARMAZENA A BASE DO IMPOSTO *}
                {****************************PZ*}
                arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

                {**********************************}
                {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
                {*******************************PZ*}
                arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

                intPosIni := (Length(Trim(strBasIcm)) + 1);
                intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

                {***************************}
                {* PEGA O VALOR DO IMPOSTO *}
                {************************PZ*}
                strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              End;

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

          End

          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := AnsiReplaceStr(str_Linha, CODECF, '');
            str_Linha  := Trim(Copy(str_Linha, 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If Assigned(objLogRdZ) Then
            Begin
              objLogRdZ.strNumSer := str_Linha;
              objLogRdZ.pGravarLogRdZ;            
            End;

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);

            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;

end;

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD_2000: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;

Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUÇÃO Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Reduções Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'Total de ISSQN:';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = 'ICMS';

  NAOTRI = 'Não Tributados';
  FIMIMP = 'TOTALIZADORES NÃO FISCAIS';
  VALSQN = 'ISSQN';
  SUBICM = 'Substituição Tributária ICMS:';
  ISEICM = 'Isento ICMS:';
  NINICM = 'Não Incidência ICMS:';
begin

  {***********************************************}
  {* TRATAMENTO PARA IMPRESSORA BEMATECH MP-2000 *}
  {********************************************CI*}

  Result := True;

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := stlEspMFD[intContGer];

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z E QUE TEVE MOVIMENTAÇÃO. *}
      {***********************************PZ*}
      If (Trim(fTiraCaracEspeciais(stlEspMFD[intContGer])) = REDUCZ) And
         (Trim(stlEspMFD[intContGer + 1]) <> SEMMOV) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;


        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(strLinCoo, 10);
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Copy(strLinCoo, 12, 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := fStrZero(str_Linha, 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}
        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************PZ*}
            While (Pos(VALSQN, stlEspMFD[intContGer]) = 0) Do
            Begin
              strCodTot  := '';
              intContImp := 1;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              {********************************}
              {* AJUSTA PARA PULAR TOTAL ICMS *}
              {*****************************CI*}
              If (Pos('-----', str_Linha) > 0) Then
              Begin
                intContGer := intContGer + 2;
                Continue;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {***************************************************}

              For intContLin := 0 To Length(str_Linha) - 1 Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************CI*}
                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))             And
                        (intContImp <= 2)                      And
                        (Not fEmptyStr(str_Linha[intContLin])) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp))Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              {*************************************************}
              {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
              {**********************************************PZ*}
              While(intContLin < Length(strLinTot)) Do
              Begin
                If (Not fEmptyStr(strLinTot[intContLin])) Then
                  strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                Else If intContLin > 0 Then
                  intContLin := Length(strLinTot);

                Inc(intContLin);
              End;

              {******************************}
              {* ARMAZENA A BASE DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

              {**********************************}
              {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
              {*******************************PZ*}
              arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

              intPosIni := (Length(Trim(strBasIcm)) + 1);
              intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

              {***************************}
              {* PEGA O VALOR DO IMPOSTO *}
              {************************PZ*}
              strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

            {****************************************}
            {* BUSCA INFORMAÇÕES DOS NÃO TRIBUTADOS *}
            {*************************************CI*}

            intContGer := intContGer + 1;
            While (Pos(NAOTRI, stlEspMFD[intContGer]) = 0) Do
            Begin
              intContGer := intContGer + 1;
            End;

            {****************************************}
            {* PULA A LINHA DO TITULO "Totalizador" *}
            {*************************************CI*}
            intContGer := intContGer + 2;
            intNumTot  := 1;

            {*************************************************}
            {* AJUSTA PARA PEGAR OS DADOS DOS NÃO TRIBUTADOS *}
            {**********************************************CI*}

            While ((Trim(stlEspMFD[intContGer]) <> FIMIMP)  AND
                  (Pos(VALICM, stlEspMFD[intContGer]) <> 0)) Do
            Begin
              strCodTot  := '';
              intContImp := 1;
              str_Linha  := Trim(stlEspMFD[intContGer]);

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 0 To Length(str_Linha) - 1 Do
              Begin
                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp) Or
                    (Pos(':', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;
              End;

              If (Pos(SUBICM, strTipImpTmp) > 0 ) Then
                strTipImp := 'F'
              Else If (Pos(ISEICM, strTipImpTmp) > 0 ) Then
                strTipImp := 'I'
              Else
                strTipImp := 'N';

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strTipImp + '1';

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;
          End
          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := AnsiReplaceStr(str_Linha, CODECF, '');
            str_Linha  := Trim(Copy(str_Linha, 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If Assigned(objLogRdZ) Then
            Begin
              objLogRdZ.strNumSer := str_Linha;
              objLogRdZ.pGravarLogRdZ;            
            End;            

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);

            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;

end;

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD_4200: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;

Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUÇÃO Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Reduções Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'TOTAL DE ISSQN:';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = '----------------------ICMS----------------------';
  FIMIMP = '----------------------ISSQN---------------------';
  TOTICM = 'Total ICMS:';

begin
  Result := True;

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := stlEspMFD[intContGer];

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z E QUE TEVE MOVIMENTAÇÃO. *}
      {*********************************************PZ*}
      If (Trim(stlEspMFD[intContGer])  = REDUCZ) And
         (Trim(stlEspMFD[intContGer + 1]) <> SEMMOV) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;

        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(strLinCoo, 10);
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Copy(strLinCoo, 12, 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := RightStr(fStrZero(str_Linha, 9), 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}
        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;
            blnNaoTri  := False;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************PZ*}
            While (Trim(stlEspMFD[intContGer]) <> FIMIMP) Do
            Begin
              strCodTot  := '';
              intContImp := 1;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              {*************************************************}
              {* AJUSTA PARA PEGAR OS DADOS DOS NÃO TRIBUTADOS *}
              {**********************************************PZ*}
              If (Pos(TOTICM, str_Linha) > 0) Then
              Begin
                intContGer := intContGer + 2;
                blnNaoTri := True;
                Continue;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 1 To Length(str_Linha) Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************PZ*}
                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))                   And
                        (((intContImp <= 5) And (Not blnNaoTri)) Or
                         ((intContImp <= 1) And (blnNaoTri)))        And
                        (Not fEmptyStr(str_Linha[intContLin]))       Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp)) Or
                   ((blnNaoTri) And (Pos('=', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              If AnsiEndsText('00', strCodTot) Then
              Begin
                strCodTot := LeftStr(strCodTot, 3);
              End
              Else
              Begin
                strCodTot := AnsiReplaceStr(strCodTot, ',', '');
              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              If (Not blnNaoTri) Then
              Begin
                {*************************************************}
                {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
                {**********************************************PZ*}
                While(intContLin < Length(strLinTot)) Do
                Begin
                  If (Not fEmptyStr(strLinTot[intContLin])) Then
                    strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                  Else If intContLin > 0 Then
                    intContLin := Length(strLinTot);

                  Inc(intContLin);
                End;

                {******************************}
                {* ARMAZENA A BASE DO IMPOSTO *}
                {****************************PZ*}
                arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

                {**********************************}
                {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
                {*******************************PZ*}
                arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

                intPosIni := (Length(Trim(strBasIcm)) + 1);
                intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

                {***************************}
                {* PEGA O VALOR DO IMPOSTO *}
                {************************PZ*}
                strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              End;

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

          End

          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := Trim(AnsiReplaceStr(str_Linha, CODECF, ''));
            str_Linha  := Trim(Copy(str_Linha, 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);

            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;
end;

function TfrmImpReducaoZ.fGeraEspelhoMFD: Boolean;
begin
  Result := False;

  If (objFiscal = Nil) Then
    Exit;

  lblMensag.Caption := 'Recuperando informações da ECF...';
  btnConfirma.Enabled := False;

  Application.ProcessMessages;

  strArqSai := fRetNomeArquivoPAF('EspelhoMFD_' + objFiscal.fNumeroSerie);

  If (objFiscal.fEspelhoMFD('D', FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaIni.Text)), FormatDateTime('DD/MM/YYYY', strToDate(mskDtaFin.Text)), strArqSai)) Then
  Begin
    lblMensag.Caption := 'Assinando arquivo digitalmente...';
    Application.ProcessMessages;
    pAssinarDigitalmente(AnsiString(strArqSai));
    Result := True;
  End;

  lblMensag.Caption := '';
  btnConfirma.Enabled := True;

end;

function TfrmImpReducaoZ.fEspelhoGeradoMFD;
begin

  Result := False;
  btnConfirma.Enabled := False;

  Application.ProcessMessages;

  If Not fEmptyStr(edtArqRdZ.Text) Then
  Begin
    strArqSai := edtArqRdZ.Text;
    Result    := True;
  End;

  lblMensag.Caption := '';
  btnConfirma.Enabled := True;

end;

function TfrmImpReducaoZ.fGravaDadosTabela: Boolean;
Var
  qryCadRdZ  : TUniQuery;
  qryRdzTot  : TUniQuery;
  intContador: Integer;
begin

  Try

    lblMensag.Caption := 'Gravando as informações...';
    Application.ProcessMessages;       

    fStartTransaction;
    qryCadRdZ := fCriaQuery(Self);
    qryRdzTot := fCriaQuery(Self);

    With qryCadRdZ Do
    Begin

      For intContador := 0 To (Length(arrCadRDZ) - 1) Do
      Begin

        If (fExisteLancReducaoZ(arrCadRDZ[intContador].strCodEcf,
                                arrCadRDZ[intContador].strQtdRdz)) Then
        Begin
          qryRdzTot.Close;
          qryRdzTot.SQL.Clear;
          qryRdzTot.SQL.Add('DELETE FROM RDZTOT WHERE TOT_CODECF = :CODECF AND TOT_NUMCRZ = :NUMCRZ');
          qryRdzTot.ParamByName('CODECF').AsString := arrCadRDZ[intContador].strCodEcf;
          qryRdzTot.ParamByName('NUMCRZ').AsString := arrCadRDZ[intContador].strQtdRdz;
          qryRdzTot.ExecSQL;

          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CADRDZ WHERE RDZ_CODECF = :CODECF AND RDZ_QTDRDZ = :QTDRDZ');
          ParamByName('CODECF').AsString := arrCadRDZ[intContador].strCodEcf;
          ParamByName('QTDRDZ').AsString := arrCadRDZ[intContador].strQtdRdz;
          Open;
          Edit;
        End
        Else
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM CADRDZ WHERE FALSE');
          Open;
          Append;
          FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADRDZ', VS_strCodEmp);
          FieldByName('RDZ_CODECF').AsString   := arrCadRDZ[intContador].strCodEcf;
          FieldByName('RDZ_QTDRDZ').AsString   := arrCadRDZ[intContador].strQtdRdz;
        End;

        FieldByName('RDZ_CODEMP').AsString   := arrCadRDZ[intContador].strCodEmp;
        FieldByName('RDZ_DTAMOV').AsDateTime := arrCadRDZ[intContador].dtaDtaMov;
        FieldByName('RDZ_CODMOD').AsString   := arrCadRDZ[intContador].strCodMod;
        FieldByName('RDZ_CPOINI').AsString   := arrCadRDZ[intContador].strCpoIni;
        FieldByName('RDZ_CPOFIM').AsString   := arrCadRDZ[intContador].strCpoFim;
        FieldByName('RDZ_CPOULT').AsString   := arrCadRDZ[intContador].strCpoUlt;
        FieldByName('RDZ_DTAEMI').AsDateTime := arrCadRDZ[intContador].dtaDtaEmi;
        FieldByName('RDZ_HOREMI').AsString   := arrCadRDZ[intContador].strHorEmi;
        FieldByName('RDZ_NROCOO').AsString   := arrCadRDZ[intContador].strNroCoo;
        FieldByName('RDZ_NROCRO').AsString   := arrCadRDZ[intContador].strNroCro;
        FieldByName('RDZ_GRTANT').AsFloat    := arrCadRDZ[intContador].fltGrtAnt;
        FieldByName('RDZ_GRTATU').AsFloat    := arrCadRDZ[intContador].fltGrtAtu;
        FieldByName('RDZ_VALDIA').AsFloat    := arrCadRDZ[intContador].fltValDia;
        FieldByName('RDZ_TOTCNL').AsFloat    := arrCadRDZ[intContador].fltTotCnl;
        FieldByName('RDZ_TOTDSC').AsFloat    := arrCadRDZ[intContador].fltTotDsc;
        FieldByName('RDZ_TOTISS').AsFloat    := arrCadRDZ[intContador].fltTotIss;
        FieldByName('RDZ_TOTACR').AsFloat    := arrCadRDZ[intContador].fltTotAcr;
        FieldByName('RDZ_TOTCTB').AsFloat    := arrCadRDZ[intContador].fltTotCtb;
        FieldByName('RDZ_TOTSBT').AsFloat    := arrCadRDZ[intContador].fltTotSbt;
        FieldByName('RDZ_TOTISE').AsFloat    := arrCadRDZ[intContador].fltTotIse;
        FieldByName('RDZ_TOTNIN').AsFloat    := arrCadRDZ[intContador].fltTotNin;
        FieldByName('RDZ_ALQIC1').AsFloat    := arrCadRDZ[intContador].fltAlqIc1;
        FieldByName('RDZ_VALIC1').AsFloat    := arrCadRDZ[intContador].fltValIc1;
        FieldByName('RDZ_ALQIC2').AsFloat    := arrCadRDZ[intContador].fltAlqIc2;
        FieldByName('RDZ_VALIC2').AsFloat    := arrCadRDZ[intContador].fltValIc2;
        FieldByName('RDZ_ALQIC3').AsFloat    := arrCadRDZ[intContador].fltAlqIc3;
        FieldByName('RDZ_VALIC3').AsFloat    := arrCadRDZ[intContador].fltValIc3;
        FieldByName('RDZ_ALQIC4').AsFloat    := arrCadRDZ[intContador].fltAlqIc4;
        FieldByName('RDZ_VALIC4').AsFloat    := arrCadRDZ[intContador].fltValIc4;
        FieldByName('RDZ_ALQIC5').AsFloat    := arrCadRDZ[intContador].fltAlqIc5;
        FieldByName('RDZ_VALIC5').AsFloat    := arrCadRDZ[intContador].fltValIc5;
        FieldByName('RDZ_ALQIC6').AsFloat    := arrCadRDZ[intContador].fltAlqIc6;
        FieldByName('RDZ_VALIC6').AsFloat    := arrCadRDZ[intContador].fltValIc6;
        FieldByName('RDZ_ALQIC7').AsFloat    := arrCadRDZ[intContador].fltAlqIc7;
        FieldByName('RDZ_VALIC7').AsFloat    := arrCadRDZ[intContador].fltValIc7;
        FieldByName('RDZ_ALQIC8').AsFloat    := arrCadRDZ[intContador].fltAlqIc8;
        FieldByName('RDZ_VALIC8').AsFloat    := arrCadRDZ[intContador].fltValIc8;

        Post;
      End;

    End;

    With qryRdzTot Do
    Begin
      For intContador := 0 To Length(arrRdzTot) - 1 Do
      Begin
        If (arrRdzTot[intContador].fltValImp > 0) Then
        Begin

          If (arrRdzTot[intContador].fltAlqImp <= 0) And
             (arrRdzTot[intContador].fltBasImp <= 0) Then
          Begin
            arrRdzTot[intContador].fltBasImp := arrRdzTot[intContador].fltValImp;
            arrRdzTot[intContador].fltValImp := 0;
          End;

          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM RDZTOT WHERE FALSE');
          Open;
          Append;

          FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('RDZTOT', VS_strCodEmp);
          FieldByName('TOT_CODECF').AsString   := arrRdzTot[intContador].strCODEcf;
          FieldByName('TOT_NUMCRZ').AsString   := arrRdzTot[intContador].strNumCrz;
          FieldByName('TOT_CODTOT').AsString   := arrRdzTot[intContador].strCodTot;
          FieldByName('TOT_DESTOT').AsString   := arrRdzTot[intContador].strDesTot;
          FieldByName('TOT_DTAMOV').AsDateTime := arrRdzTot[intContador].dtaDtaMov;
          FieldByName('TOT_BASIMP').AsFloat    := arrRdzTot[intContador].fltBasImp;
          FieldByName('TOT_ALQIMP').AsFloat    := arrRdzTot[intContador].fltAlqImp;
          FieldByName('TOT_VALIMP').AsFloat    := arrRdzTot[intContador].fltValImp;
          FieldByName('TOT_VLRACU').AsFloat    := arrRdzTot[intContador].fltvlrAcu;
          FieldByName('TOT_NUMTOT').AsString   := arrRdzTot[intContador].strNumTot;
          FieldByName('TOT_DESSIT').AsString   := arrRdzTot[intContador].strDesSit;

          Post;
        End;
      End;
    End;

    If Length(arrCadRDZ) = 0 Then
    Begin
      fRollBack;
      Result := False;
    End
    Else
    Begin
      fCommit;
      Result := True;
    End;

    If Result = False Then
      fMensagem('Atenção', 'O ECF não retornou os dados da redução corretamente. Por favor, realize o processo de importação novamente.', ['&O K']);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fGravaDadosTabela]');
      Result := False;
    End;
  End;

end;

procedure TfrmImpReducaoZ.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmImpReducaoZ.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(stlEspMFD);

  If (Assigned(objFiscal)) And (Not blnObjFiscalCriado) Then
    FreeAndNil(objFiscal);

  If Assigned(objLogRdZ) Then
    FreeAndNil(objLogRdZ);

  inherited;
end;

procedure TfrmImpReducaoZ.FormCreate(Sender: TObject);
begin
  inherited;
  blnImportaAutomatico := False;
  blnConfirmou := False;

  If fEmptyStr(edtArqRdZ.Text) Then
    edtArqRdZ.Dialog.Dialog.InitialDir := fCfgSis('PATIRZ');
end;

procedure TfrmImpReducaoZ.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnImportaAutomatico) and Not(blnConfirmou) Then
    btnConfirma.Click;
end;

procedure TfrmImpReducaoZ.FormShow(Sender: TObject);
  Var
    strCodEcf: String;
    strModEcf: String;
    strPorta : String;
begin
  inherited;

  blnObjFiscalCriado := False;

  If (Not pnlMsgRdZ.Visible) Then
    Self.Height := Self.Height - pnlMsgRdZ.Height;

  Try
    intImpRdz := fCfgSis('IMPRDZ', varInteger);

    If intImpRdz <> 2 Then
    Begin
      pnlArqRdZ.Visible := False;
      Self.Height := Self.Height - pnlArqRdZ.Height;
    End;

    stlEspMFD := TStringList.Create;

    If Not blnImportaAutomatico Then
    Begin
      mskDtaIni.Text := FormatDateTime('DD/MM/YYYY', VS_DATE);
      mskDtaFin.Text := FormatDateTime('DD/MM/YYYY', VS_DATE);
    End;

    strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
    strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

    strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

    If (Not fEmptyStr(strModEcf)) And (intImpRdz = 1) Then
    Begin
      If Assigned(VS_objFiscal) Then
      Begin
        blnObjFiscalCriado := True;
        objFiscal := VS_objFiscal;
      End
      Else
      Begin
        objFiscal := TFiscalBrd.Create(frmImpReducaoZ, strModEcf);
      End;
    End;

    objLogRdZ := TLogImpRdZ.Create;
  Except
    On E: ExceptionAutCom Do
    Begin
			fMensagem('', E.Message,['&Ok']);
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmImpReducaoZ.FormShow]');
    End;
  End;
end;

function TfrmImpReducaoZ.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If (fEmptyDate(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End

    End
    Else If (Sender = mskDtaFin) Then
    Begin

      If (fEmptyDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (fEmptyDate(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
        pSetFocus(mskDtaIni);
        Exit;
      End
      Else If StrToDateTimeDef(mskDtaIni.Text,-1) = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial está incorreta!', ['&O k']);
        Result := False;
        pSetFocus(mskDtaIni);
        Exit;
      End
      Else If StrToDateTimeDef(mskDtaFin.Text,-1) = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final está incorreta!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final precisa ser maior ou igual a data inicial!', ['&O k']);
        Result := False;
      End
      Else
        Result := fCompDatas(mskDtaIni.Text, mskDtaFin.Text);

    End
    Else If (Sender = edtArqRdZ) And (edtArqRdZ.Enabled) And (pnlArqRdZ.Visible) Then
    Begin

      If fEmptyStr(edtArqRdZ.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O arquivo de memória fiscal não foi encontrado!', ['&O k']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmImpReducaoZ.pAtualizaCodEcfTotais(strCodEcf: String);
Var
  intContador: Integer;
begin

  For intContador := 0 To Length(arrRdzTot) - 1 Do
  Begin
    If (fEmptyStr(arrRdzTot[intContador].strCODEcf)) Then
      arrRdzTot[intContador].strCODEcf := strCodEcf;
  End;

end;

procedure TfrmImpReducaoZ.pCalculaValores;
Var
  intContador: Integer;
  strCpoAux  : String;
begin
  For intContador := 0 To Length(arrCadRdz) - 1 Do
  Begin
    If (intContador = 0) And (Not fEmptyStr(arrCadRdz[intContador].strCodEcf)) Then
    Begin
      arrCadRdz[intContador].strCpoIni := fCalculaRDZAnterior(arrCadRdz[intContador].dtaDtaMov,
                                                              arrCadRdz[intContador].strCodEcf);
      arrCadRdz[intContador].strCpoFim := arrCadRdz[intContador].strNroCoo;
      strCpoAux := arrCadRdz[intContador].strCpoIni;
    End;

    {********************}
    {* PEGA VENDA BRUTA *}
    {*****************PZ*}
    arrCadRdz[intContador].fltValDia := fCalcularValorLiquido(arrCadRdz[intContador].strCodEcf, arrCadRdz[intContador].strQtdRdz) +
                                        arrCadRdz[intContador].fltTotDsc +
                                        arrCadRdz[intContador].fltTotCnl;

    {**********************}
    {* PEGA VENDA LÍQUIDA *}
    {*******************PZ*}
    arrCadRdz[intContador].fltTotCtb := fCalcularValorLiquido(arrCadRdz[intContador].strCodEcf, arrCadRdz[intContador].strQtdRdz);

    {************************************}
    {* ATUALIZA O GRANDE TOTAL ANTERIOR *}
    {*********************************PZ*}
    arrCadRdz[intContador].fltGrtAnt  := arrCadRdz[intContador].fltGrtAtu - arrCadRdz[intContador].fltValDia;

    {*******************************************}
    {* ATUALIZA O COO DO PRIMEIRO CUPOM DO DIA *}
    {****************************************IV*}
    arrCadRdz[intContador].strCpoIni := fStrZero(StrToIntDef(strCpoAux, 0) + 1, 06);
    arrCadRdz[intContador].strCpoFim := arrCadRdz[intContador].strNroCoo;
    strCpoAux := arrCadRdz[intContador].strNroCoo;
  End;

end;

procedure TfrmImpReducaoZ.edtArqRdZPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  edtArqRdZ.Dialog.Execute;
end;

function TfrmImpReducaoZ.fCalculaRDZAnterior(Data: TDate; strCodEcf: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT SQL_NO_CACHE ');
    qryAux.SQL.Add('  RDZ_CPOFIM AS REDUCAOINI ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADRDZ ');
    qryAux.SQL.Add('WHERE RDZ_DTAMOV < :DATA ');
    qryAux.SQL.Add('  AND RDZ_CODECF = :CODECF ');
    qryAux.SQL.Add('ORDER BY RDZ_DTAMOV DESC ');
    qryAux.SQL.Add('LIMIT 1 ');

    qryAux.ParamByName('DATA').AsDateTime := Data;
    qryAux.ParamByName('CODECF').AsString := strCodEcf;
    qryAux.Open;

    Result := qryAux.FieldByName('REDUCAOINI').AsString;
  Finally
    qryAux.Free;
  End;
end;

function TfrmImpReducaoZ.fCalcularValorLiquido(strCODEcf, strNumCrz: String): Double;
  Var
    intContador: Integer;
    ValorLiquido: Double;
begin
  ValorLiquido := 0;
  For intContador := Low(arrRdzTot) to High(arrRdzTot) Do
  Begin
    If (arrRdzTot[intContador].strCODEcf = strCODEcf) And
       (arrRdzTot[intContador].strNumCrz = strNumCrz) Then
    Begin
      If arrRdzTot[intContador].fltBasImp <> 0 Then
        ValorLiquido := ValorLiquido + arrRdzTot[intContador].fltBasImp
      Else
        ValorLiquido := ValorLiquido + arrRdzTot[intContador].fltValImp;
    End;
  End;

  Result := ValorLiquido;
end;

function TfrmImpReducaoZ.fCarregaEspelhoMFD: Boolean;
  Var
    txfArq : TextFile;
    strLinha : String;
begin
  Result := False;
  stlEspMFD.Clear;

  If (FileExists(strArqSai)) Then
  Begin
    AssignFile(txfArq, strArqSai);
    Reset(txfArq);

    stlEspMFD.Clear;

    While Not Eof(txfArq) Do
    Begin
      ReadLn(txfArq, strLinha);
      stlEspMFD.Add(strLinha);
    End;

    CloseFile(txfArq);

    //stlEspMFD.LoadFromFile(strArqSai);

    If (stlEspMFD.Count = 0) Then
    Begin
      fMensagem('ATENÇÃO!','Não existem dados para gravação!',['&O k']);
      Result := False;
    End
    Else
      Result := True;
  End
  Else
    fMensagem('ATENÇÃO!','Arquivo não encontrado!',['&O k']);

end;

function TfrmImpReducaoZ.fGravarReducaoZ: Boolean;
Var
   intPosFim: Integer;
   strModImp: string;

Const
  BEMATECH2000 = 'MP-2000';
  BEMATECH2100 = 'MP-2100';
  BEMATECH3000 = 'MP-3000';
  BEMATECH4000 = 'MP-4000';
  BEMATECH4200 = 'MP-4200';
  BEMATECHFIM  = 'ECF-IF';

  DARUMA700    = 'FS700';
  DARUMAFIM    = 'ECF-IF';

  SWEDAST120   = 'ST120';
  SWEDAST200   = 'ST200';

  EPSON        = 'EPSON';

  ELGIN        = 'ELGIN';
begin

  If intImpRdz = 2 Then
  Begin

    //ATRAVÉS DE UM PATH
    Result := fEspelhoGeradoMFD;

  End
  Else
  Begin

    Result := fGeraEspelhoMFD;

  End;

  If (Result) Then
    Result := fCarregaEspelhoMFD;

  If (Result) Then
  Begin
    If (Pos('BEMATECH', stlEspMFD.Text) > 0) Then
    Begin

      {**********************************************}
      {* ECF BEMATECH, BUSCA O MODELO DA IMPRESSORA *}
      {*******************************************CI*}

      intPosIni := Pos('BEMATECH', stlEspMFD.Text);
      intPosFim := Pos(BEMATECHFIM, stlEspMFD.Text);
      strModImp := Trim(Copy(stlEspMFD.Text, intPosIni, (intPosFim-intPosIni)));
      If (Pos(BEMATECH2000, strModImp) > 0) Then
        Result := fExtraiDadosEspelhoMFD_2000
      Else If (Pos(BEMATECH4200, strModImp) > 0) Then
        Result := fExtraiDadosEspelhoMFD_4200
      Else If ((Pos(BEMATECH4000, strModImp) > 0) Or
               (Pos(BEMATECH3000, strModImp) > 0) Or
               (Pos(BEMATECH2100, strModImp) > 0)) Then
        Result := fExtraiDadosEspelhoMFD
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Modelo Bematech não cadastrado no sistema!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Pos(SWEDAST120, stlEspMFD.Text) > 0) Or (Pos(SWEDAST200, stlEspMFD.Text) > 0) Then
      Result := fExtraiDadosEspelhoMFD_SWEDA_ST120

    Else If (Pos(DARUMA700, stlEspMFD.Text) > 0) Or (Pos(DARUMA600, stlEspMFD.Text) > 0) Or (Pos(DARUMAMACH, stlEspMFD.Text) > 0) Or (Pos(DARUMAMACH_2, stlEspMFD.Text) > 0) Then
    Begin
      {********************************************}
      {* ECF DARUMA, BUSCA O MODELO DA IMPRESSORA *}
      {*****************************************CI*}
      intPosIni := Pos('DARUMA', stlEspMFD.Text);

      If (Pos(DARUMA600, stlEspMFD.Text) > 0) Then
        intPosFim := Pos(DARUMA600, stlEspMFD.Text) + 10
      Else If (Pos(DARUMAMACH, stlEspMFD.Text) > 0) Then
         intPosFim := Pos(DARUMAMACH, stlEspMFD.Text) + 10
      Else If (Pos(DARUMAMACH_2, stlEspMFD.Text) > 0) Then
         intPosFim := Pos(DARUMAMACH_2, stlEspMFD.Text) + 10
      Else intPosFim := Pos(DARUMAFIM, stlEspMFD.Text);

      strModImp := Trim(Copy(stlEspMFD.Text, intPosIni, (intPosFim-intPosIni)));
      If (Pos(DARUMA700, strModImp) > 0) Or (Pos(DARUMA600, strModImp) > 0) Or (Pos(DARUMAMACH, strModImp) > 0) Or (Pos(DARUMAMACH_2, strModImp) > 0) Then
        Result := fExtraiDadosEspelhoMFD_Daruma
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Modelo Daruma não cadastrado no sistema!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Pos(EPSON, stlEspMFD.Text) > 0) Then 
    Begin
      Result := fExtraiDadosEspelhoMFD_Epson;
    End
    Else If (Pos(ELGIN, stlEspMFD.Text) > 0) Then
    Begin
      Result := fExtraiDadosEspelhoMFD_Elgin;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Impressora ECF não cadastrada no sistema!', ['&O k']);
      Result := False;
    End;

  End;

  If (Result) Then
    Result := fGravaDadosTabela;

  lblMensag.Caption := '';

end;

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD_Daruma: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;
  blnDFs700 : Boolean;
Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUCAO Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Reduções Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'Total de ISSQN:';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = 'ICMS';

  FIMIMP = 'ISSQN';
begin
  Result := True;

  blnDFs700 := True;

  {**************************************}
  {* TRATAMENTO DARUMA FS600/FS700/MACH *}
  {***********************************CI*}

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      If (Pos(DARUMA600, stlEspMFD[intContGer]) > 0) Or (Pos(DARUMAMACH, stlEspMFD[intContGer]) > 0) Or (Pos(DARUMAMACH_2, stlEspMFD[intContGer]) > 0) Then
        blnDFs700 := False;

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := AnsiReplaceStr(TrimLeft(stlEspMFD[intContGer]), #22, '');

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z                          *}
      {***********************************PZ*}
      If (fTiraCaracEspeciais(Trim(stlEspMFD[intContGer])) = REDUCZ) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;

        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Trim(LeftStr(strLinCoo, 10));
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(Trim(Copy(strLinCoo, Pos(' ', strLinCoo), 10)), 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := fStrZero(str_Linha, 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}

        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;
            blnNaoTri  := False;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************CI*}
            While (Pos(FIMIMP, stlEspMFD[intContGer]) = 0) Do
            Begin
              strCodTot  := '';
              intContImp := 1;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              If blnDFs700 Then
              Begin
                If (Pos('-----', str_Linha) > 0) Then
                Begin
                  intContGer := intContGer + 4;
                  blnNaoTri := True;
                  Continue;
                End;
              End
              Else
              Begin
                If (Pos('Total ICMS:', str_Linha) > 0) Then
                Begin
                  intContGer := intContGer + 3;
                  blnNaoTri := True;
                  Continue;
                End;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 0 To Length(str_Linha) - 1 Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************PZ*}
                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))               And
                        (((intContImp <= 2) And (Not blnNaoTri)) Or
                         ((intContImp <= 1) And (blnNaoTri)))    And
                        (Not fEmptyStr(str_Linha[intContLin]))   Then
                Begin
                  strCodTot := strCodTot + IIf((Pos('=', str_Linha[intContLin]) > 0), '', str_Linha[intContLin]);
                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp)) Or
                   ((blnNaoTri) And (Pos('=', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              If (Not blnNaoTri) Then
              Begin
                {*************************************************}
                {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
                {**********************************************PZ*}
                While(intContLin < Length(strLinTot)) Do
                Begin
                  If (Not fEmptyStr(strLinTot[intContLin])) Then
                    strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                  Else If intContLin > 0 Then
                    intContLin := Length(strLinTot);

                  Inc(intContLin);
                End;

                {******************************}
                {* ARMAZENA A BASE DO IMPOSTO *}
                {****************************PZ*}
                arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

                {**********************************}
                {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
                {*******************************PZ*}
                arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

                intPosIni := (Length(Trim(strBasIcm)) + 1);
                intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

                {***************************}
                {* PEGA O VALOR DO IMPOSTO *}
                {************************PZ*}
                strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              End;

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

          End

          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := AnsiReplaceStr(str_Linha, CODECF, '');
            str_Linha  := Trim(Copy(str_Linha, 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If Assigned(objLogRdZ) Then
            Begin
              objLogRdZ.strNumSer := str_Linha;
              objLogRdZ.pGravarLogRdZ;            
            End;

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);
            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;

end;

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD_Elgin: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;

Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUÇÃO  Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Reduções Z:';
  CONRDZ_ESP = 'Contador de Redu‡äes Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  CONROP_ESP = 'Contador de Rein¡cio de Opera‡ão:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'TOTAL DE ISSQN';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = '--------------------- ICMS ---------------------';
  FIMIMP = '-------------------  ISSQN  --------------------';

begin
  Result := True;

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := stlEspMFD[intContGer];

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z E QUE TEVE MOVIMENTAÇÃO. *}
      {*********************************************PZ*}
      If (Trim(stlEspMFD[intContGer])  = REDUCZ) And
         (Trim(stlEspMFD[intContGer + 1]) <> SEMMOV) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;

        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(strLinCoo, 10);
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Copy(strLinCoo, 12, 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := fStrZero(str_Linha, 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}
        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {****************************}
          {* PEGA CONTADOR CRO QUANDO *}
          {* VEM COM CARACTER ESPECIAL*}
          {*************************NC*}
          Else If (Pos(CONROP_ESP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP_ESP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {**********************************}
          {* PEGA CONTADOR REDUÇÃO Z QUANDO *}
          {* VEM COM CARACTER ESPECIAL      *}
          {*******************************NC*}
          Else If (Pos(CONRDZ_ESP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ_ESP, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;
            blnNaoTri  := False;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************PZ*}
            While (Trim(stlEspMFD[intContGer]) <> FIMIMP) Do
            Begin
              strCodTot  := '';
              intContImp := 1;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              {*************************************************}
              {* AJUSTA PARA PEGAR OS DADOS DOS NÃO TRIBUTADOS *}
              {**********************************************PZ*}
              If (Pos('-----', str_Linha) > 0) Then
              Begin
                intContGer := intContGer + 3;
                blnNaoTri := True;
                Continue;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {******************************************************}
              {* REMOVE OS CONTADORES(01,02...) QUE NÃO SERÃO USADOS*}
              {***************************************************NC*}
              If UpperCase(str_Linha[1]) = 'T' Then
                str_Linha := 'T' + Copy(str_Linha, 5, Length(str_Linha));

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 1 To Length(str_Linha) Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************PZ*}
                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))                   And
                        (((intContImp <= 5) And (Not blnNaoTri)) Or
                         ((intContImp <= 1) And (blnNaoTri)))        And
                        (Not fEmptyStr(str_Linha[intContLin]))       Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp)) Or
                   ((blnNaoTri) And (Pos('=', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              If AnsiEndsText('00', strCodTot) Then
              Begin
                strCodTot := LeftStr(strCodTot, 3);
              End
              Else
              Begin
                strCodTot := AnsiReplaceStr(strCodTot, ',', '');
              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              If (Not blnNaoTri) Then
              Begin
                {*************************************************}
                {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
                {**********************************************PZ*}
                While(intContLin < Length(strLinTot)) Do
                Begin
                  If (Not fEmptyStr(strLinTot[intContLin])) Then
                    strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                  Else If intContLin > 0 Then
                    intContLin := Length(strLinTot);

                  Inc(intContLin);
                End;

                {******************************}
                {* ARMAZENA A BASE DO IMPOSTO *}
                {****************************PZ*}
                arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

                {**********************************}
                {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
                {*******************************PZ*}
                arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

                intPosIni := (Length(Trim(strBasIcm)) + 1);
                intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

                {***************************}
                {* PEGA O VALOR DO IMPOSTO *}
                {************************PZ*}
                strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              End;

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

          End

          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := AnsiReplaceStr(str_Linha, CODECF, '');
            str_Linha  := Trim(Copy(str_Linha, 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If Assigned(objLogRdZ) Then
            Begin
              objLogRdZ.strNumSer := str_Linha;
              objLogRdZ.pGravarLogRdZ;
            End;

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);

            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;
end;

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD_Epson: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;
  blnCodTot : Boolean;

Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUÇÃO Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Redução Z:';
  CONRDZ2 = 'Contador de Reduções Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'Total de ISSQN:';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = 'ICMS';
  FIMIMP = 'TOTALIZADORES NÃO FISCAIS';

begin
  Result := True;

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := stlEspMFD[intContGer];

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z E QUE TEVE MOVIMENTAÇÃO. *}
      {*********************************************PZ*}
      If (Trim(stlEspMFD[intContGer])  = REDUCZ) And
         (Trim(stlEspMFD[intContGer + 1]) <> SEMMOV) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;

        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(strLinCoo, 10);
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Copy(strLinCoo, 12, 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := fStrZero(str_Linha, 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}
        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Or
                  (Pos(CONRDZ2, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];

            If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
              str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''))
            Else
              str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ2, ''));

            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;
            blnNaoTri  := False;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************PZ*}
            While Not (Pos(FIMIMP, Trim(stlEspMFD[intContGer])) > 0) Do
            Begin
              strCodTot  := '';
              intContImp := 1;
              blnCodTot := True;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              {*************************************************}
              {* AJUSTA PARA PEGAR OS DADOS DOS NÃO TRIBUTADOS *}
              {**********************************************PZ*}
              If (Pos('-----', str_Linha) > 0) Then
              Begin
                intContGer := intContGer + 3;
                blnNaoTri := True;
                Continue;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 1 To Length(str_Linha) Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************PZ*}
                if str_Linha[intContLin] = '=' then
                begin
                  blnCodTot := False;
                end;

                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  if blnCodTot then
                  begin
                    strCodTot := strCodTot + str_Linha[intContLin];
                  end;

                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))                   And
                        (((intContImp <= 5) And (Not blnNaoTri)) Or
                         ((intContImp <= 1) And (blnNaoTri)))        And
                        (Not fEmptyStr(str_Linha[intContLin]))       Then
                Begin
                  if blnCodTot then
                  begin
                    strCodTot := strCodTot + str_Linha[intContLin];
                  end;

                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp)) Or
                   ((blnNaoTri) And (Pos('=', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              If AnsiEndsText('00', strCodTot) Then
              Begin
                strCodTot := LeftStr(strCodTot, 3);
              End
              Else
              Begin
                strCodTot := AnsiReplaceStr(strCodTot, ',', '');
              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              If (Not blnNaoTri) Then
              Begin
                {*************************************************}
                {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
                {**********************************************PZ*}
                While(intContLin < Length(strLinTot)) Do
                Begin
                  If (Not fEmptyStr(strLinTot[intContLin])) Then
                    strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                  Else If intContLin > 0 Then
                    intContLin := Length(strLinTot);

                  Inc(intContLin);
                End;

                {******************************}
                {* ARMAZENA A BASE DO IMPOSTO *}
                {****************************PZ*}
                arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

                {**********************************}
                {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
                {*******************************PZ*}
                arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

                intPosIni := (Length(Trim(strBasIcm)) + 1);
                intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

                {***************************}
                {* PEGA O VALOR DO IMPOSTO *}
                {************************PZ*}
                strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              End;

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

          End

          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := AnsiReplaceStr(str_Linha, CODECF, '');
            str_Linha  := Trim(Copy(str_Linha, 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);

            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;
end;

{**************************}
{* IMPRESSORA SWEDA ST120 *}
{***********************CI*}

function TfrmImpReducaoZ.fExtraiDadosEspelhoMFD_SWEDA_ST120: Boolean;
Var
  intContLin: Integer;
  strCodTot : String;
  strCodEcf : String;

Const
  SEMMOV = 'SEM MOVIMENTO FISCAL';
  REDUCZ = 'REDUÇÃO Z';
  MOVDIA = 'MOVIMENTO DO DIA:';
  CONCFI = 'Contador de Cupom Fiscal:';
  CONRDZ = 'Contador de Reduções Z:';
  CONCOO = 'COO:';
  CONROP = 'Contador de Reinício de Operação:';
  TOTGER = 'TOTALIZADOR GERAL:';
  TOTISS = 'Total de ISSQN:';
  TOTCAN = 'CANCELAMENTO ICMS:';
  TOTDES = 'DESCONTO ICMS:';
  TOTACR = 'ACRÉSCIMO ICMS:';
  CODECF = 'FAB:';
  VALICM = 'ICMS';
  FIMIMP = 'ISSQN';
  MEIPAG = 'MEIOS DE PAGAMENTO';
  TOTNFI = 'TOTALIZADORES NÃO FISCAIS';
begin
  Result := True;

  Try
    lblMensag.Caption := 'Carregando informações do arquivo...';
    Application.ProcessMessages;

    intContDad := 0;
    intContGer := 0;
    intContTot := 0;
    SetLength(arrCadRdz, 0);
    SetLength(arrRdzTot, 0);

    {*************************************}
    {* PERCORRE O ARQUIVO DO ESPELHO MFD *}
    {**********************************PZ*}
    While (intContGer < (stlEspMFD.Count)) Do
    Begin

      {**************************************}
      {* PEGA A LINHA DO NÚMERO DO COO PARA *}
      {* UTILIZAR QUANDO FOR REDUÇÃO Z.     *}
      {***********************************PZ*}
      If (Pos(CONCOO, stlEspMFD[intContGer]) > 0) Then
        strLinCoo := stlEspMFD[intContGer];

      {**************************************}
      {* VERIFICA SE O REGISTRO SE REFERE A *}
      {* REDUÇÃO Z E QUE TEVE MOVIMENTAÇÃO. *}
      {*********************************************PZ*}
      If (Trim(stlEspMFD[intContGer])  = REDUCZ) And
         (Trim(stlEspMFD[intContGer + 1]) <> SEMMOV) Then
      Begin
        SetLength(arrCadRdz, Length(arrCadRdz) + 1);
        blnContinua := True;

        {************************}
        {* PEGA DATA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := LeftStr(strLinCoo, 10);
        arrCadRdz[intContDad].dtaDtaEmi := StrToDate(str_Linha);

        {************************}
        {* PEGA HORA DA EMISSÃO *}
        {*********************PZ*}
        str_Linha := Copy(strLinCoo, 12, 8);
        str_Linha := AnsiReplaceStr(str_Linha, ':', '');
        arrCadRdz[intContDad].strHorEmi := str_Linha;

        {*********************}
        {* PEGA CONTADOR COO *}
        {******************PZ*}
        intPosicao := Pos(CONCOO, strLinCoo);
        str_Linha := Copy(strLinCoo, intPosicao, Length(strLinCoo));
        str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCOO, ''));
        arrCadRdz[intContDad].strNROCoo := fStrZero(str_Linha, 6);

        {*********************}
        {* CÓDIGO DA EMPRESA *}
        {******************PZ*}
        arrCadRdz[intContDad].strCodEmp := VS_strCodEmp;

        {*********************************}
        {* CÓDIGO DO MODELO DE DOCUMENTO *}
        {******************************PZ*}
        arrCadRdz[intContDad].strCodMod := '2D';

        {********************************************}
        {* PERCORRE AS LINHAS REFERENTE A REDUÇÃO Z *}
        {*****************************************PZ*}
        While (blnContinua) Do
        Begin

          {****************************}
          {* PEGA A DATA DO MOVIMENTO *}
          {*************************PZ*}
          If (Pos(MOVDIA, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, MOVDIA,''));
            arrCadRdz[intContDad].dtaDtaMov := StrToDate(str_Linha);
          End

          {*********************}
          {* PEGA CONTADOR CRO *}
          {******************PZ*}
          Else If (Pos(CONROP, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONROP, ''));
            arrCadRdz[intContDad].strNROCro := fStrZero(str_Linha, 3);
          End

          {***************************}
          {* PEGA CONTADOR REDUÇÃO Z *}
          {************************PZ*}
          Else If (Pos(CONRDZ, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONRDZ, ''));
            arrCadRdz[intContDad].strQTDRdz := fStrZero(str_Linha, 6);
          End

          {*******************}
          {* PEGA O 1º CUPOM *}
          {****************PZ*}
          Else If (Pos(CONCFI, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, CONCFI, ''));
            arrCadRdz[intContDad].strCpoIni := fStrZero(str_Linha, 6);
          End

          {***************************}
          {* PEGA GRANDE TOTAL ATUAL *}
          {*************************PZ*}
          Else If (Pos(TOTGER, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTGER, ''));
            arrCadRdz[intContDad].fltGrtAtu := fStrToFloat(str_Linha);
          End

          {*******************************}
          {* PEGA TOTAL DE CANCELAMENTOS *}
          {****************************PZ*}
          Else If (Pos(TOTCAN, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTCAN, ''));
            arrCadRdz[intContDad].fltTotCnl := fStrToFloat(str_Linha);
          End

          {***************************}
          {* PEGA TOTAL DE DESCONTOS *}
          {************************PZ*}
          Else If (Pos(TOTDES, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTDES, ''));
            arrCadRdz[intContDad].fltTotDsc := fStrToFloat(str_Linha);
          End

          {*********************}
          {* PEGA VALOR DE ISS *}
          {******************PZ*}
          Else If (Pos(TOTISS, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTISS, ''));
            arrCadRdz[intContDad].fltTotIss := fStrToFloat(str_Linha);
          End

          {****************************}
          {* PEGA TOTAL DE ACRÉSCIMOS *}
          {*************************PZ*}
          Else If (Pos(TOTACR, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha := stlEspMFD[intContGer];
            str_Linha := Trim(AnsiReplaceStr(str_Linha, TOTACR, ''));
            arrCadRdz[intContDad].fltTotAcr := fStrToFloat(str_Linha);
          End

          {*****************************************}
          {* PEGA A BASE, ALIQUOTA E VALOR DE ICMS *}
          {**************************************PZ*}
          Else If (Pos(VALICM, stlEspMFD[intContGer]) > 0) Then
          Begin
            {*****************************************************}
            {* PULA A LINHA DO TITULO "Totalizador Base Cálculo" *}
            {**************************************************PZ*}
            intContGer := intContGer + 2;
            intNumTot  := 1;
            blnNaoTri  := False;

            {******************************}
            {* PERCORRE OS TOTAIS DE ICMS *}
            {***************************PZ*}
            While (Trim(stlEspMFD[intContGer]) <> MEIPAG) And
                  (Trim(stlEspMFD[intContGer]) <> TOTNFI) Do
            Begin
              strCodTot  := '';
              intContImp := 1;

              str_Linha  := Trim(stlEspMFD[intContGer]);

              {*************************************************}
              {* AJUSTA PARA PEGAR OS DADOS DOS NÃO TRIBUTADOS *}
              {**********************************************PZ*}
              If (Pos('-----', str_Linha) > 0) Or (Pos('—————', str_Linha) > 0) Then
              Begin
                intContGer := intContGer + 4;
                blnNaoTri  := True;
                Continue;
              End;

              SetLength(arrRdzTot, Length(arrRdzTot) + 1);

              strTipImpTmp := '';
              strAlqIcm    := '';
              blnTipImp    := True;

              {***************************************************}
              {* PERCORRE A LINHA PARA ACHAR O CÓDIGO DO IMPOSTO *}
              {************************************************PZ*}
              For intContLin := 0 To Length(str_Linha) - 1 Do
              Begin
                {**********************************************}
                {* PROCURA A(S) LETRA(S) DO CÓDIGO DO IMPOSTO *}
                {*******************************************PZ*}
                If (fEhLetra(UpperCase(str_Linha[intContLin]))) Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strTipImp := strCodTot;
                End
                Else If (Not fEmptyStr(strCodTot))                   And
                        (((intContImp <= 2) And (Not blnNaoTri)) Or
                         ((intContImp <= 1) And (blnNaoTri)))        And
                        (Not fEmptyStr(str_Linha[intContLin]))       Then
                Begin
                  strCodTot := strCodTot + str_Linha[intContLin];
                  strAlqIcm := strAlqIcm + str_Linha[intContLin];
                  Inc(intContImp);
                End;

                If ((Not fEmptyStr(Trim(str_Linha[intContLin]))) And (blnTipImp)) Or
                   ((blnNaoTri) And (Pos('=', strTipImpTmp) <= 0)) Then
                  strTipImpTmp := strTipImpTmp + str_Linha[intContLin]
                Else If (fEmptyStr(Trim(str_Linha[intContLin]))) And (Length(strTipImpTmp) > 0) Then
                  blnTipImp := False;

              End;

              {***********************************}
              {* ARMAZENA O CONTADOR DE REDUÇÃO Z*}
              {********************************PZ*}
              arrRdzTot[intContTot].strNumCrz := arrCadRdz[intContDad].strQTDRdz;

              {*******************************}
              {* ARMAZENA A DATA DO MOVIMENTO*}
              {****************************PZ*}
              arrRdzTot[intContTot].dtaDtaMov := arrCadRdz[intContDad].dtaDtaMov;

              {*********************}
              {* CÓDIGO DO IMPOSTO *}
              {******************PZ*}
              arrRdzTot[intContTot].strCodTot := strCodTot;

              {*******************}
              {* TIPO DO IMPOSTO *}
              {****************PZ*}
              arrRdzTot[intContTot].strDesTot := fRetTipoImposto(strTipImp);

              intPosIni := Length(Trim(strTipImpTmp)) + 1;
              intQtdCpy := (Length(str_Linha) - intPosIni) + 1;

              {**************************}
              {* PEGA A BASE DE CÁLCULO *}
              {***********************PZ*}
              strLinTot := Trim(Copy(Trim(str_Linha), intPosIni, intQtdCpy));
              strBasIcm := '';

              intContLin := 0;

              If (Not blnNaoTri) Then
              Begin
                {*************************************************}
                {* PERCORRE A LINHA PARA PEGAR A BASE DO IMPOSTO *}
                {**********************************************PZ*}
                While(intContLin < Length(strLinTot)) Do
                Begin
                  If (Not fEmptyStr(strLinTot[intContLin])) Then
                    strBasIcm := strBasIcm + Trim(strLinTot[intContLin])
                  Else If intContLin > 0 Then
                    intContLin := Length(strLinTot);

                  Inc(intContLin);
                End;

                {******************************}
                {* ARMAZENA A BASE DO IMPOSTO *}
                {****************************PZ*}
                arrRdzTot[intContTot].fltBasImp := fStrToFloat(strBasIcm);

                {**********************************}
                {* ARMAZENA A ALÍQUOTA DO IMPOSTO *}
                {*******************************PZ*}
                arrRdzTot[intContTot].fltAlqImp := fStrToFloat(strAlqIcm);

                intPosIni := (Length(Trim(strBasIcm)) + 1);
                intQtdCpy := (Length(strLinTot) - intPosIni) + 1;

                {***************************}
                {* PEGA O VALOR DO IMPOSTO *}
                {************************PZ*}
                strLinTot := Trim(Copy(strLinTot, intPosIni, intQtdCpy));

              End;

              {*******************************}
              {* ARMAZENA O VALOR DO IMPOSTO *}
              {****************************PZ*}
              arrRdzTot[intContTot].fltValImp := fStrToFloat(strLinTot);

              If (arrRdzTot[intContTot].fltValImp > 0) Then
              Begin
                {*****************************************}
                {* SEQUENCIAL DE LANÇAMENTO DOS IMPOSTOS *}
                {**************************************PZ*}
                arrRdzTot[intContTot].strNumTot := intToStr(intNumTot);
                Inc(intNumTot);
              End;

              Inc(intContTot);
              Inc(intContGer);
            End;

          End

          {*********************}
          {* PEGA O CÓDIGO ECF *}
          {******************PZ*}
          Else If (Pos(CODECF, stlEspMFD[intContGer]) > 0) Then
          Begin
            str_Linha  := stlEspMFD[intContGer];
            str_Linha  := AnsiReplaceStr(str_Linha, CODECF, '');
            str_Linha  := Trim(Copy(Trim(str_Linha), 1, 20));
            strCodEcf  := fRetCodECF(str_Linha);

            If Assigned(objLogRdZ) Then
            Begin
              objLogRdZ.strNumSer := str_Linha;
              objLogRdZ.pGravarLogRdZ;            
            End;            

            If (fEmptyStr(strCodEcf)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foi encontrado o cadastro da ECF com o número de série: ' + #10#13 +
                        str_Linha + '.' + #10#13 +
                        'A importação será cancelada!', ['&O k']);
              Result := False;
              Exit;
            End
            Else
              arrCadRdz[intContDad].strCodEcf := fStrZero(strCodEcf, 5);

            pAtualizaCodEcfTotais(arrCadRdz[intContDad].strCodEcf);
            blnContinua := False;
          End;

          Inc(intContGer);

        End;

        Inc(intContDad);

      End;

      Inc(intContGer);

    End;

    pCalculaValores;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmGravarReducaoZ.fExtraiDadosEspelhoMFD]');
      Result := False;
    End;
  End;

end;

{ TLogImpRdZ }

constructor TLogImpRdZ.Create;
begin
  //
end;

procedure TLogImpRdZ.pGravarArquivoMFD(strNomArq: String);
begin
  pGravarLogRdZ('', strNomArq);
end;

procedure TLogImpRdZ.pGravarLogRdZ(strImportado: String = ''; strNomArq: String = '');
  Var
    qryLogRdZ: TUniQuery;
begin
  fStartTransaction;
  Try
    qryLogRdZ := fCriaQuery;

    With qryLogRdZ, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT');
      Add('  *   ');
      Add('FROM  ');
      Add('  LOGRDZ');
      Add('WHERE   ');
      Add('  RDZ_NUMSER = :NUMSER AND');
      Add('  RDZ_DTAIMP = :DTAIMP AND');
      Add('  RDZ_HORIMP = :HORIMP AND');
      Add('  RDZ_OPEIMP = :OPEIMP    ');

      ParamByName('NUMSER').AsString := FNumSer;
      ParamByName('OPEIMP').AsString := FOpeImp;
      ParamByName('DTAIMP').AsDate   := FDtaImp;
      ParamByName('HORIMP').AsTime   := FHorImp;

      Open;

      If IsEmpty Then
        qryLogRdZ.Append
      Else
        qryLogRdZ.Edit;

      FieldByName('RDZ_NUMSER').AsString   := FNumSer;
      FieldByName('RDZ_OPEIMP').AsString   := FOpeImp;
      FieldByName('RDZ_DTAIMP').AsDateTime := FDtaImp;
      FieldByName('RDZ_HORIMP').AsDateTime := FHorImp;
      FieldByName('RDZ_DTAINI').AsDateTime := FDtaIni;
      FieldByName('RDZ_DTAFIN').AsDateTime := FDtaFin;

      If Not fEmptyStr(strImportado) Then
        FieldByName('RDZ_IMPORT').AsString := strImportado;

      If Not fEmptyStr(strNomArq) And FileExists(strNomArq) Then
        TBlobField(FieldByName('RDZ_ARQMFD')).LoadFromFile(strNomArq);

      Post;
    End;

    FreeAndNil(qryLogRdZ);

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

procedure TLogImpRdZ.pMarcarReducaoImportada;
begin
  pGravarLogRdZ('S');
end;

end.
