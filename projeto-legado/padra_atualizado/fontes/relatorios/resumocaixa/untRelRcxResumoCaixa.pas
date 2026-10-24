unit untRelRcxResumoCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, Uni,
  StrUtils, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, AppEvnts, DB, cxProgressBar,
  UniClientDataSet, BitBtnLockedIncrem, Printers, frxDMPClass, ComCtrls,
  frxExportCSVTestabilidade, untRelEstItemsAbaixoMin, TypesRel,
  Datasnap.DBClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, untRcxTResumoDeCaixa;

type
  TfrmRelRcxResumoCaixa = class(TfrmPaiRelatorio)
    frxResumo: TfrxDBDataset;
    frxCheques: TfrxDBDataset;
    frxDuplicatas: TfrxDBDataset;
    frxResumoVendas: TfrxDBDataset;
    frxCredito: TfrxDBDataset;
    Label12: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    mskEspecie: TMaskEditFocus;
    Label2: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOperador: TEditFocus;
    Label4: TLabel;
    edtGruGpo: TEditFocus;
    edtDesGpo: TEditFocus;
    Label3: TLabel;
    edtSeqFec: TEditFocus;
    chkCredito: TCheckBox;
    gpbTipo: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipo: TEditFocus;
    gpbExiDta: TGroupBox;
    ColorLabel4: TColorLabel;
    edtExiDta: TEditFocus;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtVisualizacao: TEditFocus;
    rdgEmpresa: TRadioGroup;
    chkCancelados: TCheckBox;
    chkRelAbast: TCheckBox;
    chkDesFpg: TCheckBox;
    cdsVenPra: TUniClientDataSet;
    cdsVenPraDESFPG: TStringField;
    cdsVenPraVALFPG: TFloatField;
    cdsVenVis: TUniClientDataSet;
    cdsVenVisDESFPG: TStringField;
    cdsVenVisVALFPG: TFloatField;
    frxVenVis: TfrxDBDataset;
    frxVenPra: TfrxDBDataset;
    frxResumoEspecies: TfrxDBDataset;
    prbProgesso: TcxProgressBar;
    frxResumofPG: TfrxDBDataset;
    frxListVenPraz: TfrxDBDataset;
    chkListVenPraz: TCheckBox;
    frxPagamento: TfrxDBDataset;
    frxResFat: TfrxDBDataset;
    frxDupJus: TfrxDBDataset;
    chkTipRec: TCheckBox;
    chkSeparaDtaCad: TCheckBox;
    chkLDPGInicio: TCheckBox;
    frxDetOutrosFpg: TfrxDBDataset;
    chkNaoExibeCheque: TCheckBox;
    lblCaixa: TLabel;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    frxFechamentos: TfrxDBDataset;
    frxLacresMalotes: TfrxDBDataset;
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtVisualizacaoExit(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure edtTipoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtGruGpoKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruGpoExit(Sender: TObject);
    procedure edtCodOpeChange(Sender: TObject);
    procedure edtGruGpoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkRelAbastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkTipRecClick(Sender: TObject);
    procedure edtVisualizacaoChange(Sender: TObject);
    procedure edtCodigoCaixaKeyPress(Sender: TObject; var Key: Char);
  private
    blnNaoBai: Boolean;

    fltVenPra: Double;
    fltVenVis: Double;
    fltVenDev: Double;
    intQtdCan: Integer;
    fltValCan: Double;
    intSqFcRx: Integer;
    fltSalIni: Double;
    fltSalInF: Double;

    fltDinIni: Double;
    fltCarIni: Double;
    fltChaIni: Double;
    fltChpIni: Double;
    fltOrdIni: Double;
    fltPixIni: Double;
    fltFinIni: Double;

    fltQtdDia: Integer;
    fltQtdDoc: Integer;
    fltTotAcu: Double;
    fltTotDia: Double;
    fltAviDia: Double;
    fltAviAcu: Double;
    fltPrzDia: Double;
    fltPrzAcu: Double;

    {***************************************}
    { QRY GENERICA P\ CADRCXX UTILIZADO NA  }
    { UNTQCKRCXRESUMOCAIXA                  }
    {************************************JB*}
    qryCadRcxx : TUniQuery;
    qryCadRec  : TUniQuery;
    qryCheques : TUniQuery;
    qryCredito : TUniQuery;
    qryResFpg  : TUniQuery;
    qryListPrz : TUniQuery;
    qryCadPag  : TUniQuery;
    qryDupJus  : TUniQuery;
    qryDetORpg : TUniQuery;

    qryMovGer  : TUniQuery;
    qryFatGor  : TUniQuery;
    cdsResFat  : TUniClientDataSet;

    qryRelat : TUniQuery;
    cdsRelat : TUniClientDataSet;

    strTipoFechamento: String;

    FEntraBrindeFaturamento: Boolean;

    function fLisCliFil: string;
    procedure pCriaCdsDados(Var cdsDados: TUniClientDataSet);
    procedure pCarregaDados(cdsDados: TUniClientDataSet);
    procedure pCalculaSaldoParcial;
    procedure pMostraDtaMov(strTipImp,strExiDta: String; frxRel: TfrxReport);
    procedure pMontaResumoVendas(cdsDados: TUniClientDataSet);
    Procedure pSetaParamMovDet(qryMovDet: TUniQuery; dtaDtaIni, dtaDtaFim: TDate);

    function fRetornaSaldoInicial(dtaDtaIni: TDateTime; Var fltDinIni, fltCarIni, fltChpIni, fltChaIni, fltOrdIni, fltFinIni, fltPixIni: Double): Double;
    function fAdicionaCheques(strDocum, strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Boolean;
    function fTotalSeq(strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Double;
    Function fSqlFiltros(blnPGs: Boolean = False): String;
    Function fSomaPG: Double;
    function fSQLFiltroEmpresa: String;
    Function fSQLFromMovDet: String;

    function frxRelRcxResumoCaixaMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    function frxRelRcxResumoCaixaJUserFunction(const MethodName: String;
      var Params: Variant): Variant;

    procedure pProcessaDocumentos;
    function fProcessaDocumentos(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pMontaResumoFpg;
    procedure pMontaDetOutrosFpg;
    function fRetornaSaldoInicialFec(dtaDtaIni, dtaDtaFin: TDateTime): Double;
    procedure pMontaListaVendaPrazo;
    procedure pDetalhaPagamentos;
    function fFiltroPagamentos: String;
    procedure pPreparaDadosFaturamento;
    procedure pMontaVendas(cdsDados: TUniClientDataSet; blnPrazo: Boolean);
    procedure pGravaModalidade(cdsDados: TUniClientDataSet; strModali: String; fltValMod: Double);
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untPai, untTypesSistema,
     untRelRcxResumoCaixaMod, untFuncoesRel, untFatGor,
     untConstantes, untMsgValidacaoGeracaoOrcPed, untGravando;

{$R *.dfm}

procedure TfrmRelRcxResumoCaixa.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodOpe, edtDesOperador, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRcxResumoCaixa.edtCodOpeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodOpe.Text) Then
    edtDesOperador.Text := 'TODOS'
  Else
    edtDesOperador.Text := fRetNomeOperador(edtCodOpe.Text);

  If fEmptyStr(edtDesOperador.Text) And (Not fEmptyStr(edtCodOpe.Text))  Then
  Begin
    fMensagem('AVISO','Código do operador não encontrado.', ['&O K']);
    edtCodOpe.Clear;
    pSetFocus(edtCodOpe);
  End;

end;

function TfrmRelRcxResumoCaixa.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodigoCaixa) And (edtCodigoCaixa.Visible) Then
    Begin

      If (fEmptyStr(edtCodigoCaixa.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Caixa deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDescricaoCaixa.Text := fCampoTabela('CAX_DESCRI', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [edtCodigoCaixa.Text, VS_strCodEmp]);

        If (fEmptyStr(edtDescricaoCaixa.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Caixa não está cadastrado ou não faz parte da empresa atual!', ['&OK']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtTipo) Then
    Begin

      If (Not fEmptyStr(edtTipo.Text)) And (Pos(edtTipo.Text,'AS') <= 0) Then
      Begin
        Result := False;
      End;

    End

    Else If (Sender = edtExiDta) Then
    Begin

      If (Not fEmptyStr(edtExiDta.Text)) And (Pos(edtExiDta.Text,'S_N_') <= 0) Then
      Begin
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelRcxResumoCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  {************************}
  { INSTÂNCIA QRY GENERICA }
  {*********************JB*}
  qryCadRcxx := fCriaQuery(Self);
  qryCadRec  := fCriaQuery(Self);
  qryCheques := fCriaQuery(Self);
  qryCredito := fCriaQuery(Self);
  qryMovGer  := fCriaQuery(Self);
  qryFatGor  := fCriaQuery(Self);
  qryDupJus  := fCriaQuery(Self);
  cdsResFat  := TUniClientDataSet.Create(Self);

  frxCheques.DataSet := qryCheques;
  frxCredito.DataSet := qryCredito;

  If (fCfgSis('RELABA') = 'S') Then
    chkRelAbast.Visible := True
  Else
    chkListVenPraz.Top  := chkRelAbast.Top;

  FEntraBrindeFaturamento := fCfgSis('ENTBRF', varBoolean);
end;

procedure TfrmRelRcxResumoCaixa.FormDestroy(Sender: TObject);
begin
  If Assigned(qryDupJus) Then
    FreeAndNil(qryDupJus);

  inherited;

end;

Function TfrmRelRcxResumoCaixa.fSqlFiltros(blnPGs: Boolean = False): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + '  RCX_DTACAD BETWEEN "'+FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text))+'" AND "'+ FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text))+'" AND ';
  strSQL := strSQL + '  RCX_CODEMP = "'+VS_strCodEmp+'" AND ';
  strSQL := strSQL + '  RCX_ESPDOC <> "FC" AND ';
  strSQL := strSQL + '  ( RCX_VENPRZ <= 0 OR ( RCX_VENPRZ > 0 AND RCX_DINREC+RCX_CHQAVI+RCX_CHQPRE+RCX_CARREC+RCX_ORDREC+RCX_VALFIN+RCX_VALCRE <> 0 ))';

  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    strSQL := strSQL + '  AND RCX_CODCAX = "'+edtCodigoCaixa.Text+'" ';

  If Not fEmptyStr(edtCodOpe.Text) Then
    strSQL := strSQL + '  AND RCX_CODOPE = "'+edtCodOpe.Text+'" ';

  If Not fEmptyStr(edtSeqFec.Text) Then
    strSQL := strSQL + '  AND RCX_SQFCRX = '+IntToStr(StrToIntDef(edtSeqFec.Text, -1))+' ';

  If Not blnPGs Then
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQL := strSQL + '  AND LOCATE(RCX_ESPDOC, "' + mskEspecie.Text + '") > 0 ';
  End;

  Result := strSQL;
End;

Function TfrmRelRcxResumoCaixa.fSomaPG: Double;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   SUM(RCX_VALDOC) AS TOTPGS ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADRCXX ';

  If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   (RCX_ESPDOC = "PG" OR (RCX_ESPDOC = "LC" AND RCX_DESCRI LIKE "REF.ESTORNO PG %") ) AND ';

  strSQL := strSQL + fSqlFiltros(True);

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Text := strSQL;

    Open;
    Result := FieldByName('TOTPGS').AsFloat;
    Close;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmRelRcxResumoCaixa.btnImprimirClick(Sender: TObject);
  Var
    fltTotVis: Double;
    fltTotPra: Double;
    fltTotJvs: Double;
    fltTotDvs: Double;
    fltTotJpr: Double;
    fltTotDpr: Double;
    fltTotGer: Double;
    strSQL   : String;
    frxRel   : TfrxReport;
    qryEmp   : TUniQuery;
    qryEsp   : TUniQuery;
    cdsResVen: TUniClientDataSet;
    cdsResEsp: TUniClientDataSet;
    intQtdCol: Integer;
    intCor   : Integer;
    regVarEst: TRegistroVarEstoque;
    intCon   : Integer;
    fltTotPag: Double;
    dicIndice: TDicionario;
    LRelRcxResumoCaixaMod : TfrmRelRcxResumoCaixaMod;

  function fGetTotal(strCampo: String): String;
  Begin
    Result := 'IF(X.RCX_ESPDOC <> "CC", ROUND(';                                                                                                                         //AND (NOT (Z.RCX_ESPDOC = "CC" AND Z.RCX_VALDOC < 0))
    Result := Result + '(SELECT SUM(' + strCampo + ') FROM CADRCXX Z WHERE Z.RCX_SEQCON = X.RCX_SEQCON AND Z.RCX_CODEMP = X.RCX_CODEMP AND Z.RCX_DTACAD = X.RCX_DTACAD AND Z.RCX_ESPDOC <> "CC" AND Z.RCX_VALDOC > 0 ) * ';
    Result := Result + '(X.RCX_VALDOC / (SELECT SUM(Z.RCX_VALDOC) FROM CADRCXX Z WHERE Z.RCX_SEQCON = X.RCX_SEQCON AND Z.RCX_CODEMP = X.RCX_CODEMP AND Z.RCX_DTACAD = X.RCX_DTACAD AND Z.RCX_ESPDOC <> "CC" AND Z.RCX_VALDOC > 0)), 2), 0)';
  End;
begin

  Try
    fltDinIni := 0;
    fltCarIni := 0;
    fltChpIni := 0;
    fltChaIni := 0;
    fltOrdIni := 0;
    fltFinIni := 0;
    fltPixIni := 0;
    fltTotGer := 0;
    intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);

    qryRelat  := fCriaQuery;
    qryResFpg := fCriaQuery;
    qryListPrz:= fCriaQuery;
    qryCadPag := fCriaQuery;
    qryDetORpg:= fCriaQuery;

    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    Screen.Cursor   := crHourGlass;
    intSqFcRx := StrToIntDef(edtSeqFec.Text, -1);

    inherited;
    If blnImprime Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If edtVisualizacao.Text = 'E' Then
      Begin
{        strSQL := strSQL + '  IF(RCX_ESPDOC IN ("PG", "LD"), IF(EXISTS(                         ';
        strSQL := strSQL + '  SELECT 1 FROM CADPAG WHERE CTP_RCXCON=RCX_SEQCON AND              ';
        strSQL := strSQL + '  CTP_EMPBAI=RCX_CODEMP), (SELECT IF(COUNT(CTP_NUMDUP) > 1,         ';
        strSQL := strSQL + '  "DIVERSOS", CONCAT(CTP_NUMDUP, CTP_PARCEL)) FROM CADPAG           ';
        strSQL := strSQL + '  WHERE CTP_RCXCON=RCX_SEQCON AND CTP_EMPBAI=RCX_CODEMP             ';
        strSQL := strSQL + '  GROUP BY CTP_RCXCON, CTP_EMPBAI), CONCAT(RCX_NUMDOC,RCX_PARCEL)), ';
        strSQL := strSQL + '  CONCAT(RCX_NUMDOC,RCX_PARCEL)) AS NUMDOC,                         ';
}
        {**Req. 97805**23/04/2018**WS**}
        strSQL := strSQL + '  IF(RCX_ESPDOC IN ("PG","LD"), CONCAT(IFNULL(RCX_NUMDUP, ""), IFNULL(RCX_PARCEL, "")), ';
        strSQL := strSQL + '  CONCAT(IFNULL(RCX_NUMDOC, ""), IFNULL(RCX_PARCEL, ""))) AS NUMDOC, ';
      End
      Else
      Begin
{        strSQL := strSQL + '  IF(RCX_ESPDOC IN ("PG", "LD"), IF(EXISTS(                              ';
        strSQL := strSQL + '  SELECT 1 FROM CADPAG WHERE CTP_RCXCON=RCX_SEQCON AND                   ';
        strSQL := strSQL + '  CTP_EMPBAI=RCX_CODEMP), (SELECT IF(COUNT(CTP_NUMDUP) > 1, "DIVERSOS",  ';
        strSQL := strSQL + '  CONCAT(CTP_NUMDUP, CTP_PARCEL,"-",RCX_ESPDOC)) FROM CADPAG             ';
        strSQL := strSQL + '  WHERE CTP_RCXCON=RCX_SEQCON AND CTP_EMPBAI=RCX_CODEMP GROUP BY         ';
        strSQL := strSQL + '  CTP_RCXCON, CTP_EMPBAI), CONCAT(RCX_NUMDOC,RCX_PARCEL,"-",RCX_ESPDOC)),';
        strSQL := strSQL + '  CONCAT(RCX_NUMDOC,RCX_PARCEL,"-",RCX_ESPDOC)) AS NUMDOC,               ';
}
        {**Req. 97805**23/04/2018**WS**}
        strSQL := strSQL + '  IF(RCX_ESPDOC IN ("PG","LD"), CONCAT(IFNULL(RCX_NUMDUP, ""), IFNULL(RCX_PARCEL, ""), ';
        strSQL := strSQL + '  IF(RCX_ESPDOC IS NULL, "", "-"), IFNULL(RCX_ESPDOC, "")), ';
        strSQL := strSQL + '  CONCAT(IFNULL(RCX_NUMDOC, ""), IFNULL(RCX_PARCEL, ""), ';
        strSQL := strSQL + '  IF(RCX_ESPDOC IS NULL, "", "-"), IFNULL(RCX_ESPDOC, ""))) AS NUMDOC, ';
      End;

      strSQL := strSQL +  'if(X.RCX_MOTEST = 0 or X.RCX_MOTEST IS NULL, "", CONCAT("MOTIVO DO ESTORNO: ", O.OCO_DESOCO)) AS MOTEST,  ';

      strSQL := strSQL + '  RCX_DESCRI AS DESCRI, ';

      if chkLDPGInicio.Checked then
        strSQL := strSQL + '  IF(RCX_ESPDOC = "LD", 0, IF(RCX_ESPDOC = "PG", 2, 3)) AS ORDREL, ';

      If edtTipo.Text = 'A' Then
      Begin

        If edtVisualizacao.Text = 'E' Then
        Begin
          strSQL := strSQL + '  RCX_CODOPE AS CODOPE, ';
          strSQL := strSQL + '  RCX_VALDOC AS VALDOC, ';
          strSQL := strSQL + '  IFNULL(RCX_VALDOC, 0) AS SOMSLD, ';
        End
        Else
        Begin
          strSQL := strSQL + '  RCX_CODOPE AS CODOPE, ';
          strSQL := strSQL + '  RCX_VALDOC AS VALDOC, ';

          If fCfgSis('MODRCX', VarString) = '1' Then
            strSQL := strSQL + '  IFNULL(RCX_DINREC + RCX_CARREC + RCX_CHQAVI + RCX_CHQPRE + RCX_ORDREC, 0) AS SOMSLD, '
          Else
            strSQL := strSQL + '  IFNULL(RCX_VALDOC, 0) AS SOMSLD, ';
        End;

      End
      Else
      Begin
        strSQL := strSQL + '  SUM(RCX_VALDOC) AS VALDOC, ';
        strSQL := strSQL + '  0 AS SOMSLD, ';
      End;

      {*******************************************}
      {* ESTOU INCLUINDO ESSE CAMPO PARA PODER   *}
      {* UTILIZA-LO COMO QUEBRA, SE O USUÁRIO    *}
      {* ESCOLHER A OPÇÃO SEQ BAIXA              *}
      {****************************************AC*}
      strSQL := strSQL + '  RCX_SEQCON AS SEQCON, ';
      strSQL := strSQL + '  RCX_JURDES AS JURDES, ';

      strSQL := strSQL + '  RCX_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '  IF(RCX_ESPDOC = "LD", IF(LOCATE("BAIXA CT. PAG",RCX_DESCRI) > 0,"LD-BAIXA CT. PAG",RCX_ESPDOC), RCX_ESPDOC) AS QUEBRA, ';
      strSQL := strSQL + '  RCX_DTACAD AS DTACAD, RCX_HORCAD AS HORCAD, ';
      If edtTipo.Text = 'A' Then
      Begin                                                                                                                                                                    //AND (NOT (RCX_ESPDOC = "CC" AND RCX_VALDOC < 0))
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','RCX_DINREC', 'IF(((RCX_CODFPG = "001") OR (RCX_CODFPG = "009") OR (' + fGetTotal('RCX_DINREC') + ' <> 0)) AND (RCX_VALDOC > 0), ' + fGetTotal('RCX_DINREC') + ', IF((RCX_ESPDOC = "CC" AND RCX_DINREC > 0) OR (RCX_DINREC < 0), RCX_DINREC, 0))') + ' AS DINHEI, ';
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','RCX_CHQAVI', 'IF(((RCX_CODFPG = "006") OR (RCX_CODFPG = "009") OR (' + fGetTotal('RCX_CHQAVI') + ' <> 0)) AND (RCX_VALDOC > 0), ' + fGetTotal('RCX_CHQAVI') + ', IF((RCX_ESPDOC = "CC" AND RCX_CHQAVI > 0) OR (RCX_CHQAVI < 0), RCX_CHQAVI, 0))') + ' AS CHQAVI, ';
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','RCX_CHQPRE', 'IF(((RCX_CODFPG = "002") OR (RCX_CODFPG = "009") OR (' + fGetTotal('RCX_CHQPRE') + ' <> 0)) AND (RCX_VALDOC > 0), ' + fGetTotal('RCX_CHQPRE') + ', IF((RCX_ESPDOC = "CC" AND RCX_CHQPRE > 0) OR (RCX_CHQPRE < 0), RCX_CHQPRE, 0))') + ' AS CHQPRE, ';
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','RCX_CARREC', 'IF(((RCX_CODFPG = "007") OR (RCX_CODFPG = "009") OR (' + fGetTotal('RCX_CARREC') + ' <> 0)) AND (RCX_VALDOC > 0), ' + fGetTotal('RCX_CARREC') + ', IF((RCX_ESPDOC = "CC" AND RCX_CARREC > 0) OR (RCX_CARREC < 0), RCX_CARREC, 0))') + ' AS CARREC, ';
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','IF(RCX_RECPIX<>"S", RCX_ORDREC, 0)', 'IF(((' + fGetTotal('IF(RCX_RECPIX<>"S", RCX_ORDREC, 0)') + ' <> 0)) AND (RCX_VALDOC > 0), ' + fGetTotal('IF(RCX_RECPIX<>"S", RCX_ORDREC, 0)') + ', IF((RCX_ESPDOC = "CC" AND RCX_ORDREC > 0) OR (RCX_ORDREC < 0), IF(RCX_RECPIX<>"S", RCX_ORDREC, 0), 0))') + ' AS ORDREC, ';
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','IF(RCX_RECPIX="S", RCX_ORDREC, 0)', 'IF(((' + fGetTotal('IF(RCX_RECPIX="S", RCX_ORDREC, 0)') + ' <> 0)) AND (RCX_VALDOC > 0), ' + fGetTotal('IF(RCX_RECPIX="S", RCX_ORDREC, 0)') + ', IF((RCX_ESPDOC = "CC" AND RCX_ORDREC > 0) OR (RCX_ORDREC < 0), IF(RCX_RECPIX="S", RCX_ORDREC, 0), 0))') + ' AS PIXREC, ';
        strSQL := strSQL + IfThen(fCfgSis('MODRCX', VarString) = '1','RCX_VALCRE', 'IF(((RCX_ESPDOC = "CC") OR (RCX_VALDOC < 0)) AND NOT(RCX_ESPDOC IN ("TF","LD","PG")), RCX_VALDOC, 0)') + '  AS VALCRE, '; {'IF((COALESCE(RCX_CODFPG, "") = "" AND RCX_DESCRI = "REF. A CRED. DE CLIENTE") OR (RCX_CODFPG = "009") OR (' + fGetTotal('RCX_VALCRE') + ' <> 0), ' + fGetTotal('RCX_VALCRE') + ', 0)') + ' AS VALCRE, ';}
        strSQL := strSQL + '  RCX_DINREC AS DINHEI_TMP, ';
        strSQL := strSQL + '  RCX_CHQAVI AS CHQAVI_TMP, ';
        strSQL := strSQL + '  RCX_CHQPRE AS CHQPRE_TMP, ';
        strSQL := strSQL + '  RCX_CARREC AS CARREC_TMP, ';
        strSQL := strSQL + '  IF(RCX_RECPIX<>"S", RCX_ORDREC, 0) AS ORDREC_TMP, ';
        strSQL := strSQL + '  IF(RCX_RECPIX="S", RCX_ORDREC, 0) AS PIXREC_TMP, ';
        strSQL := strSQL + '  RCX_VALCRE AS VALCRE_TMP, ';
      End
      Else
      Begin
        strSQL := strSQL + '  SUM(RCX_DINREC) AS DINHEI, ';
        strSQL := strSQL + '  SUM(RCX_CHQAVI) AS CHQAVI, ';
        strSQL := strSQL + '  SUM(RCX_CHQPRE) AS CHQPRE, ';
        strSQL := strSQL + '  SUM(RCX_CARREC) AS CARREC, ';
        strSQL := strSQL + '  SUM(IF(RCX_RECPIX<>"S", RCX_ORDREC, 0)) AS ORDREC, ';
        strSQL := strSQL + '  SUM(IF(RCX_RECPIX="S", RCX_ORDREC, 0)) AS PIXREC, ';
        strSQL := strSQL + '  SUM(RCX_VALCRE) AS VALCRE, ';
      End;

      strSQL := strSQL + '  RCX_VALFIN AS VALFIN, ';
      strSQL := strSQL + '  TRIM(IFNULL(RCX_MOTDES, "")) AS MOTDES, ';
      strSQL := strSQL + '  RCX_CODEMP, ';
      strSQL := strSQL + '  CONCAT(RCX_NUMDOC,RCX_PARCEL,RCX_ESPDOC,RCX_CODEMP) AS RCX_DOCUME, ';

      If Not chkTipRec.Checked Then
        strSQL := strSQL + ' "" AS TIPREC, '
      Else
        strSQL := strSQL + ' IF(CTR.CTR_DTAREC IS NULL, "3 - OUTROS", IF(CTR.CTR_DTACAD = CTR.CTR_DTAREC, "1 - A VISTA", "2 - A PRAZO")) AS TIPREC, ';

      If fCfgSis('TROPGT', varBoolean) Then
      Begin
        strSQL := strSQL + '  IFNULL(TRO_SEQGER,"") AS TROSEQ, ';
        strSQL := strSQL + '  TRO_DINREC AS TRODIN, ';
        strSQL := strSQL + '  TRO_CHQAVI AS TROCHQ, ';
        strSQL := strSQL + '  TRO_CHQPRE AS TROPRE, ';
        strSQL := strSQL + '  TRO_CARREC AS TROCAR, ';
        strSQL := strSQL + '  TRO_VALFIN AS TROFIN, ';
        strSQL := strSQL + '  IF(TRO_RECPIX<>"S", TRO_ORDREC, 0) AS TROORD, ';
        strSQL := strSQL + '  IF(TRO_RECPIX="S", TRO_ORDREC, 0) AS TROPIX, ';
      End
      Else
      Begin
        strSQL := strSQL + '  ""         AS TROSEQ, ';
        strSQL := strSQL + '  0          AS TRODIN, ';
        strSQL := strSQL + '  0          AS TROCHQ, ';
        strSQL := strSQL + '  0          AS TROPRE, ';
        strSQL := strSQL + '  0          AS TROCAR, ';
        strSQL := strSQL + '  0          AS TROFIN, ';
        strSQL := strSQL + '  0          AS TROORD, ';
        strSQL := strSQL + '  0          AS TROPIX, ';
      End;

      If chkSeparaDtaCad.Checked Then
        strSQL := strSQL + '  IF(DATEDIFF(' + fCurrentDate + ', RCX_DTACAD), "MOVIMENTAÇÕES DE DIAS ANTERIORES", "MOVIMENTAÇÕES DE HOJE") AS MOVDIA '
      Else
        strSQL := strSQL + '  "" AS MOVDIA ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADRCXX X ';

      strSQL := strSQL + '  LEFT JOIN CADOCO O ON X.RCX_MOTEST = O.OCO_CODOCO ';
      
      If fCfgSis('TROPGT', varBoolean) Then
        strSQL := strSQL + '  LEFT JOIN TRORCX ON X.AUTOINCREM = TRO_SEQGER ';

      If Not fEmptyStr(edtGruGpo.Text) Then
        strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

      If chkTipRec.Checked Then
      Begin
        strSQL := strSQL + '  LEFT JOIN CADREC CTR                ';
        strSQL := strSQL + '    ON CTR.CTR_NUMDUP = RCX_NUMDOC    ';
        strSQL := strSQL + '      AND CTR.CTR_ESPDOC = RCX_ESPDOC ';
        strSQL := strSQL + '      AND CTR.CTR_CODCLI = RCX_CODCLI ';
        strSQL := strSQL + '      AND CTR.CTR_PARCEL = RCX_PARCEL ';
        strSQL := strSQL + '      AND CTR.CTR_CODEMP = RCX_CODEMP ';
        strSQL := strSQL + '      AND CTR.CTR_SEQBAI = RCX_SEQBAI ';
      End;

      strSQL := strSQL + 'WHERE ';

      strSQL := strSQL + fSqlFiltros;

      If edtTipo.Text <> 'A' Then
      Begin
        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  ESPDOC ';
      End;

      If edtVisualizacao.Text = 'E' Then
      Begin
        strSQL := strSQL + 'ORDER BY ';

        If chkSeparaDtaCad.Checked Then
          strSQL := strSQL + '  MOVDIA, ';

        If chkTipRec.Checked Then
          strSQL := strSQL + '  TIPREC, ';

        strSQL := strSQL + ' ESPDOC, LPAD(NUMDOC, 12, "0"), LENGTH(NUMDOC), DTACAD, HORCAD ';
      End
      Else
      Begin

        If (edtVisualizacao.Text = 'S') And (edtTipo.Text = 'A') Then
        Begin
          strSQL := strSQL + 'ORDER BY ';

          if chkLDPGInicio.Checked then
            strSQL := strSQL + '  ORDREL, ';

          If chkSeparaDtaCad.Checked Then
            strSQL := strSQL + '  MOVDIA, ';

          If chkTipRec.Checked Then
            strSQL := strSQL + '  TIPREC, ';

          strSQL := strSQL + '  SEQCON, DTACAD, HORCAD, ABS(DINHEI), ABS(CHQAVI), ABS(CHQPRE), ABS(CARREC), ABS(ORDREC), ABS(PIXREC), ABS(VALCRE) ';
        End
        Else
        Begin
          strSQL := strSQL + 'ORDER BY ';

          If chkSeparaDtaCad.Checked Then
            strSQL := strSQL + '  MOVDIA, ';

          If chkTipRec.Checked Then
            strSQL := strSQL + '  TIPREC, ';

          strSQL := strSQL + '  ESPDOC, LPAD(NUMDOC, 12, "0"), LENGTH(NUMDOC), DTACAD, HORCAD ';
        End;

      End;

      fltSalIni := fRetornaSaldoInicial(StrToDate(mskDtaIni.Text),fltDinIni,fltCarIni,fltChpIni,fltChaIni,fltOrdIni,fltFinIni,fltPixIni);
      fltSalInf := fRetornaSaldoInicialFec(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
      pCalculaSaldoParcial;

      With qryRelat Do
      Begin
        ParamCheck := False;
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
      End;

      {***************************************}
      {* CRIANDO OS CAMPOS NO CLIENTDATASET  *}
      {************************************JU*}
      cdsResEsp := TUniClientDataSet.Create(nil);
      If fVerificaAcessoSistema('RELRCXESP', strLoginUsuarioLogado)  Then
      Begin

        dicIndice := TDicionario.Create;

        qryEmp := fCriaQuery;

        With qryEmp Do
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT SQL_NO_CACHE EMP_CODEMP FROM CADEMP ';
          strSQL := strSQL + ' ORDER BY EMP_CODEMP LIMIT 10';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          Open;
        End;

        qryEsp := fCriaQuery;

        With qryEsp Do
        Begin
          Close;
          SQL.Clear;
          strSQL := '';
          strSQL := strSQL + ' SELECT SQL_NO_CACHE                                                                            ';
          strSQL := strSQL + '   R.RCX_CODEMP,                                                                                  ';
          strSQL := strSQL + '   R.RCX_ESPDOC,                                                                                  ';

          If Not fEmptyStr(edtGruGpo.Text) Then
            strSQL := strSQL + ' G.GPO_CODGPO,                                                                                ';

          strSQL := strSQL + '   SUM(IF(IFNULL(IFNULL(M.GER_CONPAG,N.GER_CONPAG),"01000") = "01000" AND IFNULL(R.RCX_JURDES,"") NOT IN ("J","D"), R.RCX_VALDOC, 0)) AVISTA,  ';
          strSQL := strSQL + '   SUM(IF(IFNULL(IFNULL(M.GER_CONPAG,N.GER_CONPAG),"01000") <> "01000" AND IFNULL(R.RCX_JURDES,"") NOT IN ("J","D"), R.RCX_VALDOC, 0)) APRAZO, ';
          strSQL := strSQL + '   SUM(IF(R.RCX_JURDES = "J" AND IFNULL(IFNULL(M.GER_CONPAG,N.GER_CONPAG), "01000") = "01000", R.RCX_VALDOC, 0)) JUROSVISTA, ';
          strSQL := strSQL + '   SUM(IF(R.RCX_JURDES = "J" AND IFNULL(IFNULL(M.GER_CONPAG,N.GER_CONPAG), "01000") <> "01000", R.RCX_VALDOC, 0)) JUROSPRAZO, ';
          strSQL := strSQL + '   SUM(IF(R.RCX_JURDES = "D" AND IFNULL(IFNULL(M.GER_CONPAG,N.GER_CONPAG), "01000") = "01000", R.RCX_VALDOC, 0)) DESCONTOVISTA, ';
          strSQL := strSQL + '   SUM(IF(R.RCX_JURDES = "D" AND IFNULL(IFNULL(M.GER_CONPAG,N.GER_CONPAG), "01000") <> "01000", R.RCX_VALDOC, 0)) DESCONTOPRAZO ';
          strSQL := strSQL + ' FROM                                                                                           ';
          strSQL := strSQL + '   CADRCXX R                                                                                      ';
          strSQL := strSQL + '   LEFT JOIN MOVGER M ON M.GER_NUMDOC = R.RCX_NUMDOC AND                                          ';
          strSQL := strSQL + '                         M.GER_ESPDOC = R.RCX_ESPDOC AND                                                                ';
          strSQL := strSQL + '                         M.GER_CODEMP = R.RCX_CODEMP AND                                                                ';
          strSQL := strSQL + '                         M.GER_CODCLI = R.RCX_CODCLI AND                                                                ';
          strSQL := strSQL + '                         M.GER_TIP_FC = "C"                                                                             ';
          strSQL := strSQL + '   LEFT JOIN NOTGER N ON N.GER_NUMDOC = R.RCX_NUMDOC AND                                          ';
          strSQL := strSQL + '                         N.GER_ESPDOC = R.RCX_ESPDOC AND                                                                ';
          strSQL := strSQL + '                         N.GER_CODEMP = R.RCX_CODEMP AND                                                                ';
          strSQL := strSQL + '                         N.GER_CODCLI = R.RCX_CODCLI AND                                                                ';
          strSQL := strSQL + '                         N.GER_TIP_FC = "C"                                                                             ';

          If Not fEmptyStr(edtGruGpo.Text) Then
            strSQL := strSQL + '  JOIN OPEGPO G ON R.RCX_CODOPE = G.OPE_CODOPE AND G.GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

          strSQL := strSQL + ' WHERE R.RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN                                                 ';
          strSQL := strSQL + '   AND R.RCX_ESPDOC <> "FC"                                                                     ';
          strSQL := strSQL + '   AND R.RCX_ESPDOC IS NOT NULL                                                                 ';
          strSQL := strSQL + '   AND R.RCX_ESPDOC <> ""                                                                       ';

          If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
            strSQL := strSQL + '  AND LOCATE(R.RCX_ESPDOC, :ESPDOC) > 0 ';

          If Not fEmptyStr(edtCodOpe.Text) Then
            strSQL := strSQL + ' AND R.RCX_CODOPE = :CODOPE                                                                   ';

          If Not fEmptyStr(edtSeqFec.Text) Then
            strSQL := strSQL + '  AND R.RCX_SQFCRX = :SQFCRX                                                                  ';

          If Not fEmptyStr(edtCodigoCaixa.Text) Then
            strSQL := strSQL + ' AND R.RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

          If Not qryEmp.IsEmpty Then
            strSQL := strSQL + ' AND ( ';

          qryEmp.First;
          While Not qryEmp.Eof Do
          Begin
            strSQL := strSQL + ' R.RCX_CODEMP = ' + QuotedStr(qryEmp.FieldByName('EMP_CODEMP').AsString);
            qryEmp.Next;

            If Not qryEmp.Eof Then
              strSQL := strSQL + ' OR ';
          End;

          If Not qryEmp.IsEmpty Then
            strSQL := strSQL + ' ) ';

          strSQL := strSQL + ' GROUP BY R.RCX_ESPDOC, R.RCX_CODEMP                                                            ';
          strSQL := strSQL + ' ORDER BY R.RCX_ESPDOC, R.RCX_CODEMP                                                            ';
          SQL.Add(strSQL);

          ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

          If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
            ParamByName('ESPDOC').AsString := mskEspecie.Text;

          If Not fEmptyStr(edtCodOpe.Text) Then
            ParamByName('CODOPE').AsString := edtCodOpe.Text;

          If Not fEmptyStr(edtSeqFec.Text) Then
            ParamByName('SQFCRX').AsString := edtSeqFec.Text;

          Open;
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'RCX_ESPDOC';
          DataType := ftString;
          Size := 03;
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'RCX_CODEMP';
          DataType  := ftString;
          Size := 03;
        End;

        qryEmp.First;
        intCon := 1;
        While Not qryEmp.Eof Do
        Begin

          dicIndice.Adicionar(qryEmp.FieldByName('EMP_CODEMP').AsString, fStrZero(intCon,3));

          With cdsResEsp.FieldDefs.AddFieldDef Do
          Begin
            Name := 'VIS' + fStrZero(intCon,3);
            DataType := ftFloat;
            Precision := fCfgSis('DECUNI', varInteger);
          End;

          With cdsResEsp.FieldDefs.AddFieldDef Do
          Begin
            Name := 'PRA' + fStrZero(intCon,3);
            DataType := ftFloat;
            Precision := fCfgSis('DECUNI', varInteger);
          End;

          With cdsResEsp.FieldDefs.AddFieldDef Do
          Begin
            Name := 'JVS' + fStrZero(intCon,3);
            DataType := ftFloat;
            Precision := fCfgSis('DECUNI', varInteger);
          End;

          With cdsResEsp.FieldDefs.AddFieldDef Do
          Begin
            Name := 'DVS' + fStrZero(intCon,3);
            DataType := ftFloat;
            Precision := fCfgSis('DECUNI', varInteger);
          End;

          With cdsResEsp.FieldDefs.AddFieldDef Do
          Begin
            Name := 'JPR' + fStrZero(intCon,3);
            DataType := ftFloat;
            Precision := fCfgSis('DECUNI', varInteger);
          End;

          With cdsResEsp.FieldDefs.AddFieldDef Do
          Begin
            Name := 'DPR' + fStrZero(intCon,3);
            DataType := ftFloat;
            Precision := fCfgSis('DECUNI', varInteger);
          End;

          Inc(intCon);
          qryEmp.Next;
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTVIS';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTPRA';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTJVS';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTDVS';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTJPR';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTDPR';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        With cdsResEsp.FieldDefs.AddFieldDef Do
        Begin
          Name := 'TOTAL';
          DataType := ftFloat;
          Precision := fCfgSis('DECUNI', varInteger);
        End;

        cdsResEsp.CreateDataSet;

        {****************************************************}
        {* INCLUI NO CLIENTDATASET OS DADOS DO SELECT ACIMA *}
        {*************************************************JU*}
        qryEsp.First;

        fltTotGer := 0;
        While Not qryEsp.Eof Do
        Begin
          cdsResEsp.Insert;
          cdsResEsp.FieldByName('RCX_ESPDOC').AsString := qryEsp.fieldbyname('RCX_ESPDOC').AsString;

          fltTotVis := 0;
          fltTotPra := 0;
          fltTotJvs := 0;
          fltTotDvs := 0;
          fltTotJpr := 0;
          fltTotDpr := 0;

          While (Not qryEsp.Eof) And
                (cdsResEsp.FieldByName('RCX_ESPDOC').AsString = qryEsp.FieldByName('RCX_ESPDOC').AsString) Do
          Begin
            cdsResEsp.FieldByName('RCX_CODEMP').AsString := qryEsp.fieldbyname('RCX_CODEMP').AsString;
            cdsResEsp.FieldByName('VIS' + dicIndice.Retorna(qryEsp.fieldbyname('RCX_CODEMP').AsString)).AsFloat := qryEsp.fieldbyname('AVISTA').AsFloat;
            cdsResEsp.FieldByName('PRA' + dicIndice.Retorna(qryEsp.fieldbyname('RCX_CODEMP').AsString)).AsFloat := qryEsp.fieldbyname('APRAZO').AsFloat;
            cdsResEsp.FieldByName('JVS' + dicIndice.Retorna(qryEsp.fieldbyname('RCX_CODEMP').AsString)).AsFloat := qryEsp.fieldbyname('JUROSVISTA').AsFloat;
            cdsResEsp.FieldByName('DVS' + dicIndice.Retorna(qryEsp.fieldbyname('RCX_CODEMP').AsString)).AsFloat := qryEsp.fieldbyname('DESCONTOVISTA').AsFloat;
            cdsResEsp.FieldByName('JPR' + dicIndice.Retorna(qryEsp.fieldbyname('RCX_CODEMP').AsString)).AsFloat := qryEsp.fieldbyname('JUROSPRAZO').AsFloat;
            cdsResEsp.FieldByName('DPR' + dicIndice.Retorna(qryEsp.fieldbyname('RCX_CODEMP').AsString)).AsFloat := qryEsp.fieldbyname('DESCONTOPRAZO').AsFloat;

            fltTotVis := fltTotVis + qryEsp.fieldbyname('AVISTA').AsFloat;
            fltTotPra := fltTotPra + qryEsp.fieldbyname('APRAZO').AsFloat;
            fltTotJvs := fltTotJvs + qryEsp.fieldbyname('JUROSVISTA').AsFloat;
            fltTotDvs := fltTotDvs + qryEsp.fieldbyname('DESCONTOVISTA').AsFloat;
            fltTotJpr := fltTotJpr + qryEsp.fieldbyname('JUROSPRAZO').AsFloat;
            fltTotDpr := fltTotDpr + qryEsp.fieldbyname('DESCONTOPRAZO').AsFloat;

            qryEsp.Next;
          End;

          cdsResEsp.FieldByName('TOTVIS').AsFloat := fltTotVis;
          cdsResEsp.FieldByName('TOTPRA').AsFloat := fltTotPra;
          cdsResEsp.FieldByName('TOTJVS').AsFloat := fltTotJvs;
          cdsResEsp.FieldByName('TOTDVS').AsFloat := fltTotDvs;
          cdsResEsp.FieldByName('TOTJPR').AsFloat := fltTotJpr;
          cdsResEsp.FieldByName('TOTDPR').AsFloat := fltTotDpr;

          cdsResEsp.Post;
          {***************************}
          {* CALCULADO O TOTAL GERAL *}
          {************************JU*}
          fltTotGer := fltTotGer + fltTotVis + fltTotPra + fltTotJvs + fltTotDvs + fltTotJpr + fltTotDpr;
        End;

        FreeAndNil(dicIndice);
      End;

      frxResumoEspecies.DataSet := cdsResEsp;

      If Not qryRelat.IsEmpty Then
      Begin
        pPreparaDadosFaturamento;

        LRelRcxResumoCaixaMod := TfrmRelRcxResumoCaixaMod.Create(Self);
        LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.OnUserFunction := frxRelRcxResumoCaixaMUserFunction;
        LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaJ.OnUserFunction := frxRelRcxResumoCaixaJUserFunction;

        If fVerificaAcessoSistema('RELRCXESP', strLoginUsuarioLogado) Then
        Begin

          If qryEmp.RecordCount > 10 Then
            intQtdCol := 10
          Else
            intQtdCol := qryEmp.RecordCount;

          If (strTipImp = 'M') and (edtDestino.Text = 'I') Then
          Begin
            If intQtdCol <= 7 Then
            Begin
              {******************************}
              {* CONFIGURAÇÃO PARA RETRATO  *}
              {***************************LU*}
              LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.PreviewOptions.Zoom := 0.78;

              Try
                if not VS_SpoolImpressaoCitel then
                  TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.Pages[11]).SetDefaults;
              Except
               // SetDefaults estava dando Access violation nos TSPlus
              End;

              TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.Pages[11]).Orientation := Printers.poPortrait;
              TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.Pages[11]).PaperWidth := 332;
              TfrxDMPCommand(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.FindObject('rllComando')).Command := '#27#64#18#27#80#15#27#80'; // 10cpi - condensado
            End
            Else
            Begin
              {******************************}
              {* CONFIGURAÇÃO PARA PAISAGEM *}
              {***************************LU*}
              LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.PreviewOptions.Zoom := 0.64;

              Try
                if not VS_SpoolImpressaoCitel then
                  TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.Pages[11]).SetDefaults;
              Except
               // SetDefaults estava dando Access violation nos TSPlus
              End;

              TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.Pages[11]).Orientation := Printers.poLandscape;
              TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.Pages[11]).PaperWidth := 407;
              TfrxDMPCommand(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaM.FindObject('rllComando')).Command := '#27#64#18#27#80#18#27#77'; // 12cpi - normal
            End;
          End
          Else
          If (strTipImp = 'J') Then
          Begin
            {******************************}
            {* CONFIGURAÇÃO PARA PAISAGEM *}
            {***************************LU*}
            LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaJ.PreviewOptions.Zoom := 0.64;

            Try
              if not VS_SpoolImpressaoCitel then
                TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaJ.Pages[11]).SetDefaults;
            Except
              //SetDefaults estava dando Access violation nos TSPlus
            End;

            TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaJ.Pages[11]).Orientation := Printers.poLandscape;
            TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaJ.Pages[11]).PaperSize   := DMPAPER_A4;
            TfrxReportPage(LRelRcxResumoCaixaMod.frxRelRcxResumoCaixaJ.Pages[11]).PaperWidth  := 420;
          End;
        End;
      End;

      With LRelRcxResumoCaixaMod Do
      If Not qryRelat.IsEmpty Then
      Begin

        If SameText(strTipImp,'M') Then
          frxRel := frxRelRcxResumoCaixaM
        Else
        Begin
          frxRel := frxRelRcxResumoCaixaJ;
          frxRel.DotMatrixReport           := False;
          frxRel.PrintOptions.PrintMode    := pmScale;
          frxRel.PrintOptions.PrintOnSheet := 9; //A4
        End;

        Try
          pCriaCdsDados(cdsResVen);
          pCarregaDados(cdsResVen);
          pMontaResumoVendas(cdsResVen);
          pMontaResumoFpg;
          pMontaDetOutrosFpg;

          frxFechamentos.DataSet := fCriaQuery;
          frxLacresMalotes.DataSet := fCriaQuery;
          If Not fEmptyStr(edtCodigoCaixa.Text) Then
          Begin
            frxFechamentos.DataSet := TResumoDeCaixa.Create('C').fRetornaFechamentosDoCaixa(edtCodigoCaixa.Text,
                                                                                            mskDtaIni.Date,
                                                                                            mskDtaFin.Date);
            TfrxBand(frxRel.FindObject('rlbFechamentosA')).Visible := True;
            TfrxBand(frxRel.FindObject('rlbFechamentosS')).Visible := True;

            If fCfgSis('RCXLAC', varBoolean) Then
            Begin
              frxLacresMalotes.DataSet := TResumoDeCaixa.Create('C').RetornaTransferenciasLacresMalotesDoCaixa(edtCodigoCaixa.Text,
                                                                                                               mskDtaIni.Date,
                                                                                                               mskDtaFin.Date,
                                                                                                               frxFechamentos.DataSet);

              TfrxBand(frxRel.FindObject('rlbLacresMalotesA')).Visible := True;
              TfrxBand(frxRel.FindObject('rlbLacresMalotesS')).Visible := True;
            End;
          End;

          If chkListVenPraz.Checked Then
            pMontaListaVendaPrazo;

          cdsVenVis.CreateDataSet;
          cdsVenVis.IndexFieldNames := 'DESFPG';
          pMontaVendas(cdsVenVis, False);

          cdsVenPra.CreateDataSet;
          cdsVenPra.IndexFieldNames := 'DESFPG';
          pMontaVendas(cdsVenPra, True);

          frxRel.FindObject('ChildCancelados').Visible := chkCancelados.Checked;
          frxRel.FindObject('ChildCanceladosS').Visible := chkCancelados.Checked;

          If fVerificaAcessoSistema('RELRCXESP', strLoginUsuarioLogado) Then
          Begin
            qryEmp.First;
            intCon := 1;
            While Not qryEmp.Eof Do
            Begin
              frxRel.FindObject('rllVis' + fStrZero(intCon,3)).Visible := True;
              frxRel.FindObject('rllPra' + fStrZero(intCon,3)).Visible := True;
              frxRel.FindObject('rllJvs' + fStrZero(intCon,3)).Visible := True;
              frxRel.FindObject('rllDvs' + fStrZero(intCon,3)).Visible := True;
              frxRel.FindObject('rllJpr' + fStrZero(intCon,3)).Visible := True;
              frxRel.FindObject('rllDpr' + fStrZero(intCon,3)).Visible := True;
              TfrxMemoView(frxRel.FindObject('rllLoja' + fStrZero(intCon,1))).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllLoja' + fStrZero(intCon,1))).Memo.Add('LOJA-' + qryEmp.FieldByName('EMP_CODEMP').AsString);
              TfrxMemoView(frxRel.FindObject('rllLoja' + fStrZero(intCon,1))).Visible := True;

              TfrxMemoView(frxRel.FindObject('rllTotLoj' + fStrZero(intCon,3))).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllTotLoj' + fStrZero(intCon,3))).Memo.Add('[SUM(<frxResumoEspecies."VIS' + fStrZero(intCon,3)+ '">,rlbDetalhes) + ' +
                                                                                         ' SUM(<frxResumoEspecies."PRA' + fStrZero(intCon,3)+ '">,rlbDetalhes) + ' +
                                                                                         ' SUM(<frxResumoEspecies."JVS' + fStrZero(intCon,3)+ '">,rlbDetalhes) + ' +
                                                                                         ' SUM(<frxResumoEspecies."DVS' + fStrZero(intCon,3)+ '">,rlbDetalhes) + ' +
                                                                                         ' SUM(<frxResumoEspecies."JPR' + fStrZero(intCon,3)+ '">,rlbDetalhes) + ' +
                                                                                         ' SUM(<frxResumoEspecies."DPR' + fStrZero(intCon,3)+ '">,rlbDetalhes)]');
              TfrxMemoView(frxRel.FindObject('rllTotLoj' + fStrZero(intCon,3))).Visible := True;

              Inc(intCon);
              qryEmp.Next;
            End;

            TfrxMemoView(frxRel.FindObject('rllTotalGeral')).Memo.Clear;
            TfrxMemoView(frxRel.FindObject('rllTotalGeral')).Memo.Add(FormatFloat('###,#0.00',fltTotGer));
            TfrxMemoView(frxRel.FindObject('rllTotalGeral')).Visible := True;

          End;

          frxRel.Variables['fltQtdDia'] := fltQtdDia;
          frxRel.Variables['fltQtdDoc'] := fltQtdDoc;
          frxRel.Variables['fltTotDia'] := fltTotDia;
          frxRel.Variables['fltTotAcu'] := fltTotAcu;
          frxRel.Variables['fltAviDia'] := fltAviDia;
          frxRel.Variables['fltAviAcu'] := fltAviAcu;
          frxRel.Variables['fltPrzDia'] := fltPrzDia;
          frxRel.Variables['fltPrzAcu'] := fltPrzAcu;

          If (fCfgSis('MODRCX', VarString) = '2') And (edtTipo.Text = 'A') Then
          Begin
            pProcessaDocumentos;
            LRelRcxResumoCaixaMod.frxRelatorio_RelRcx.DataSet  := cdsRelat;
          End
          Else
            LRelRcxResumoCaixaMod.frxRelatorio_RelRcx.DataSet  := qryRelat;

          frxResumoVendas.DataSet := cdsResVen;
          frxResumo.DataSet       := qryCadRcxx;
          frxResumofPG.DataSet    := qryResFpg;
          frxListVenPraz.DataSet  := qryListPrz;
          frxDupJus.DataSet       := qryDupJus;
          frxDetOutrosFpg.DataSet := qryDetORpg;

          {*******************************************}
          {* EXIBE OU NÃO A COLUNA DATA DO MOVIMENTO *}
          {****************************************JC*}
          pMostraDtaMov(strTipImp, edtExiDta.Text, frxRel);

          frxRel.Script.Variables['PERIODO'] := 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text));
          If fEmptyStr(edtCodigoCaixa.Text) Then
            frxRel.Script.Variables['SQFCRX']  := 'SEQUENCIAL DE FECHAMENTO PARCIAL: ' + IIF(intSqFcRx <= 0, 'TODOS', IntToStr(intSqFcRx))
          Else
            frxRel.Script.Variables['SQFCRX']  := 'CAIXA: ' + edtCodigoCaixa.Text + '-' + edtDescricaoCaixa.Text;

          If fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
            frxRel.Script.Variables['ESPECIE'] := 'ESPECIE DO DOCUMENTO : TODOS'
          Else
            frxRel.Script.Variables['ESPECIE'] := 'ESPECIE : ' + mskEspecie.Text;

          If SameText(edtTipo.Text,'A') Then
          Begin
            If SameText(edtVisualizacao.Text,'E') Then
              frxRel.Script.Variables['VISUALI'] := 'VISUALIZACAO : ESPECIE DO DOCUMENTO'
            Else
              frxRel.Script.Variables['VISUALI'] := 'VISUALIZACAO : SEQUENCIA DE BAIXA';
          End
          Else
            frxRel.Script.Variables['VISUALI'] := '';

          If Not fEmptyStr(edtCodOpe.Text) Then
            frxRel.Script.Variables['OPERADOR'] := 'OPERADOR: ' + edtCodOpe.Text + ' - ' + edtDesOperador.Text
          Else
            frxRel.Script.Variables['OPERADOR'] := 'OPERADOR: TODOS';

          If Not fEmptyStr(edtGruGpo.Text) Then
            frxRel.Script.Variables['OPERADOR'] := frxRel.Script.Variables['OPERADOR'] + '    GRUPO DE OPERADOR: ' + edtGruGpo.Text + ' - ' + edtDesGpo.Text
          Else
            frxRel.Script.Variables['OPERADOR'] := frxRel.Script.Variables['OPERADOR'] + '    GRUPO DE OPERADOR: TODOS';

          If SameText(edtTipo.Text,'A') Then
            frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE RESUMO DE CAIXA - ANALITICO'
          Else
            frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE RESUMO DE CAIXA - SINTETICO';

          frxRel.Script.Variables['VENPRA'] := FormatFloat('###,#0.00',fltVenPra);
          frxRel.Script.Variables['VENVIS'] := FormatFloat('###,#0.00',fltVenVis);
          frxRel.Script.Variables['TRODEV'] := FormatFloat('###,#0.00',fltVenDev);
          frxRel.Script.Variables['VENPER'] := FormatFloat('###,#0.00',fltVenVis + fltVenPra + fltVenDev);
          frxRel.Script.Variables['QTDCAN'] := IntToStr(intQtdCan);
          frxRel.Script.Variables['VALCAN'] := FormatFloat('###,#0.00',fltValCan);
          frxRel.Script.Variables['SALINI'] := FormatFloat('###,#0.00',fltSalIni);
          frxRel.Script.Variables['DININI'] := FormatFloat('###,#0.00',fltDinIni);
          frxRel.Script.Variables['CARINI'] := FormatFloat('###,#0.00',fltCarIni);
          frxRel.Script.Variables['CHPINI'] := FormatFloat('###,#0.00',fltChpIni);
          frxRel.Script.Variables['CHAINI'] := FormatFloat('###,#0.00',fltChaIni);
          frxRel.Script.Variables['ORDINI'] := FormatFloat('###,#0.00',fltOrdIni);
          frxRel.Script.Variables['FININI'] := FormatFloat('###,#0.00',fltFinIni);
          frxRel.Script.Variables['PIXINI'] := FormatFloat('###,#0.00',fltPixIni);

          {*********************************************************}
          {* VERIFICA SE EXIBE OU NÃO OS DADOS NO INFORMATIVO      *}
          {******************************************************AC*}
          TfrxMemoView(frxRel.FindObject('rllVenPra' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rlbVenPra' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rllVenVis' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rlbVenVis' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rllTroDev' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rlbTroDev' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rllVenDia' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rlbVenDia' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rllQdeCan' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rlbQdeCan' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rllVlrCan' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          TfrxMemoView(frxRel.FindObject('rlbVlrCan' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);

          If fCfgSis('MODRCX', VarString) = '2' Then
          Begin
            TfrxGroupHeader(frxRel.FindObject('gphTipRec')).Visible := chkTipRec.Checked;
            TfrxGroupFooter(frxRel.FindObject('gpfTipRec')).Visible := chkTipRec.Checked;
          End
          Else
          Begin
            TfrxGroupHeader(frxRel.FindObject('gphTipRec')).Visible := False;
            TfrxGroupFooter(frxRel.FindObject('gpfTipRec')).Visible := False;
          End;
          TfrxGroupHeader(frxRel.FindObject('gphMovDia')).Visible := chkSeparaDtaCad.Checked;

          If not SameText(strTipImp,'M') Then
          Begin
            TfrxMemoView(frxRel.FindObject('linhaVenVis' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
            TfrxMemoView(frxRel.FindObject('linhaTroDev' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
            TfrxMemoView(frxRel.FindObject('linhaQdeCan' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);
          End;

          TfrxGroupHeader(frxRel.FindObject('childTotVenVis' + edtTipo.Text)).Visible := fCfgSis('EXVLFA', varBoolean);

          If Not TfrxMemoView(frxRel.FindObject('rlbQdeCan' + edtTipo.Text)).Visible And
             Not TfrxMemoView(frxRel.FindObject('rlbVlrCan' + edtTipo.Text)).Visible Then
          Begin
            if edtTipo.Text = 'S' then
              frxRel.FindObject('ChildCanceladosS').Visible := False
            Else
              frxRel.FindObject('ChildCancelados').Visible := False;
          End;

          If Not TfrxMemoView(frxRel.FindObject('rlbTroDev' + edtTipo.Text)).Visible And
             Not TfrxMemoView(frxRel.FindObject('rlbVenDia' + edtTipo.Text)).Visible Then
            frxRel.FindObject('childRodInform' + edtTipo.Text).Visible := False;

          fltTotPag := fSomaPG;

          frxRel.Script.Variables['TOTPAG'] := fltTotPag;

          If fltTotPag <> 0 Then
            pDetalhaPagamentos;

          If edtTipo.Text = 'A' Then
            TfrxPage(frxRel.FindObject('subPagamento')).Visible := Not qryCadPag.IsEmpty
          Else If edtTipo.Text = 'S' Then
            TfrxPage(frxRel.FindObject('subPagamentoS')).Visible := Not qryCadPag.IsEmpty;

          frxPagamento.DataSet := qryCadPag;

          {*********************************************************}
          {* SE O USURIO ESCOLHER NA TELE DE FILTRO :              *}
          {* VISUALIZAO = S ENTO TROCO RLBGRUPO DATAFIELDS PARA    *}
          {* SEQCON, SEMO FICA COMO EST : ESPDOC                   *}
          {******************************************************AC*}
          frxRel.Script.Variables['SEQBAI'] := edtVisualizacao.Text;
          frxRel.Script.Variables['MODRCX'] := fCfgSis('MODRCX', VarString);
          If edtVisualizacao.Text = 'S' Then
          Begin
            TfrxGroupHeader(frxRel.FindObject('rlbGrupo')).Visible       := False;
            TfrxGroupFooter(frxRel.FindObject('rlbResumoGrupo')).Visible := False;
            TfrxGroupHeader(frxRel.FindObject('rlbGrupo')).Condition     := 'frxRelatorio_RelRcx."SEQCON"';
            TfrxMemoView(frxRel.FindObject('rllTitEspecie')).Text        := 'SEQ BAIXA:';
            TfrxMemoView(frxRel.FindObject('rdbEspecie')).DataField      := 'SEQCON';

            If fCfgSis('MODRCX', VarString) = '1' Then
            Begin
              TfrxMemoView(frxRel.FindObject('rdbValor')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rdbValor')).Memo.Add('[<frxRelatorio_RelRcx."DINHEI"> + <frxRelatorio_RelRcx."CARREC"> + <frxRelatorio_RelRcx."CHQAVI"> + <frxRelatorio_RelRcx."CHQPRE"> + <frxRelatorio_RelRcx."ORDREC"> + <frxRelatorio_RelRcx."PIXREC">]');
            End;

            If Not SameText(strTipImp,'M') Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := intCor;
              TfrxMemoView(frxRel.FindObject('rllZebra2')).Highlight.Color := intCor;
              TfrxMemoView(frxRel.FindObject('rllZebra3')).Highlight.Color := intCor;
              TfrxMemoView(frxRel.FindObject('rllZebDupJus')).Highlight.Color  := intCor;
              TfrxMemoView(frxRel.FindObject('rllbEstorno')).Highlight.Color   := intCor;
            End;

          End
          Else
          Begin

            If Not SameText(strTipImp,'M') Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := intCor;
              TfrxMemoView(frxRel.FindObject('rllZebra2')).Highlight.Color := intCor;
              TfrxMemoView(frxRel.FindObject('rllZebra3')).Highlight.Color := intCor;
              TfrxMemoView(frxRel.FindObject('rllZebDupJus')).Highlight.Color  := intCor;
              TfrxMemoView(frxRel.FindObject('rllbEstorno')).Highlight.Color   := intCor;
            End;

            TfrxMemoView(frxRel.FindObject('rdbValor')).Memo.Clear;
            TfrxMemoView(frxRel.FindObject('rdbValor')).Memo.Add('[frxRelatorio_RelRcx."VALDOC"]');

            TfrxGroupHeader(frxRel.FindObject('rlbGrupo')).Visible       := True;
            TfrxGroupFooter(frxRel.FindObject('rlbResumoGrupo')).Visible := True;
            TfrxGroupHeader(frxRel.FindObject('rlbGrupo')).Condition     := 'frxRelatorio_RelRcx."QUEBRA"';
            TfrxMemoView(frxRel.FindObject('rllTitEspecie')).Text        := 'ESPECIE:';
            TfrxMemoView(frxRel.FindObject('rdbEspecie')).DataField      := 'QUEBRA';
          End;

          If edtTipo.Text = 'A' Then
          Begin
            frxRel.Pages[1].Visible := True;
            frxRel.Pages[2].Visible := False;
          End
          Else
          Begin
            frxRel.Pages[1].Visible := False;
            frxRel.Pages[2].Visible := True;
          End;

          frxDuplicatas.DataSet := qryCadRec;
          If blnNaoBai Then
            frxRel.Pages[5].Visible := True
          Else
            frxRel.Pages[5].Visible := False;

          frxRel.Pages[6].Visible := chkCredito.Checked And (Not qryCredito.IsEmpty);

          If fVerificaAcessoSistema('RELRCXESP', strLoginUsuarioLogado) Then
            frxRel.Pages[11].Visible := True
          Else
            frxRel.Pages[11].Visible := False;

          If Not fVerificaAcessoSistema('IMPRFP') Then
            frxRel.Pages[12].Visible := False;

          If Not fVerificaAcessoSistema('IMPRVE') Then
            frxRel.Pages[4].Visible := False;

          If Not chkListVenPraz.Checked Then
            frxRel.Pages[13].Visible := False;

          TfrxGroupHeader(frxRel.FindObject('childFpgVenPraA')).Visible := chkDesFpg.Checked And fCfgSis('EXVLFA', varBoolean);
          TfrxGroupHeader(frxRel.FindObject('childFpgVenPraS')).Visible := chkDesFpg.Checked And fCfgSis('EXVLFA', varBoolean);
          TfrxGroupHeader(frxRel.FindObject('childFpgVenVisA')).Visible := chkDesFpg.Checked And fCfgSis('EXVLFA', varBoolean);
          TfrxGroupHeader(frxRel.FindObject('childFpgVenVisS')).Visible := chkDesFpg.Checked And fCfgSis('EXVLFA', varBoolean);

          If (fCfgSis('MDERCX', varBoolean)) Then
            TfrxReportPage(frxRel.FindObject('qckDupJus')).Visible  := fCfgSis('RMTDES', varBoolean)
          Else
            TfrxReportPage(frxRel.FindObject('qckDupJus')).Visible  := False;

          TfrxMemoView(frxRel.FindObject('rllNomeEmpresa')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNomeFantasia')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          TfrxMemoView(frxRel.FindObject('rllNmEmPs')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNmFnPs')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          TfrxMemoView(frxRel.FindObject('rllNmEmRv')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNmFnRv')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          TfrxMemoView(frxRel.FindObject('rllNmEmRe')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNmFnRe')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          TfrxMemoView(frxRel.FindObject('rllNmEmRf')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNmFnRf')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          TfrxMemoView(frxRel.FindObject('rllNmEmLv')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNmFnLv')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          TfrxMemoView(frxRel.FindObject('rllNmEmDj')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMEMP">]');
          TfrxMemoView(frxRel.FindObject('rllNmFnDj')).Memo.Add(VS_strCodEmp + ' - ' + '[<frxGen_RelRcx."EMP_NOMFAN">]');

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frxRel)
          Else If frxRel.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);

          FreeAndNil(LRelRcxResumoCaixaMod);

          {*******************************************************}
          {* SE O CHECKBOX "IMPRIMIR RELATÓRIO DE ABASTECIMENTO" *}
          {* ESTIVER CHECKADO, IMPRIME O RELATÓRIO.              *}
          {****************************************************RV*}
          If chkRelAbast.Checked Then
          Begin
            pnlInfo.Caption := 'Aguarde, gerando pedido...';
            prbProgesso.Visible    := True;
            prbProgesso.Position   := 0;
            Screen.Cursor   := crHourGlass;

            Application.ProcessMessages;

            FillChar(regVarEst,Sizeof(regVarEst), #0);
            regVarEst.prgProgresso := prbProgesso;
            regVarEst.blnOriRcx    := True;
            Try
              pCriarFormularios(TfrmRelEstItemsAbaixoMin, frmRelEstItemsAbaixoMin);
              frmRelEstItemsAbaixoMin.prgProgresso := regVarEst.prgProgresso;
              frmRelEstItemsAbaixoMin.fGravaFatGor := untFatGor.fGravaFatGor;
              frmRelEstItemsAbaixoMin.fGravaFatDor := untFatGor.fGravaFatDor;
              frmRelEstItemsAbaixoMin.blnOriRcx    := regVarEst.blnOriRcx;
              frmRelEstItemsAbaixoMin.ShowModal;
            Except
              On E: Exception Do
              Begin
                pMensagensErro(E.Message, '[pRelEstItemsAbaixoMin]');
              End;
            End;

            pFreeAndNil(frmRelEstItemsAbaixoMin);
            prbProgesso.Visible    := False;
          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;
      End
      Else
      Begin
        pTabelaVazia;
      End;
    End;

  Finally
    FreeAndNil(qryRelat);
    If Assigned(cdsRelat) Then
      FreeAndNil(cdsRelat);

    If Assigned(cdsResVen) Then
      FreeAndNil(cdsResVen);

    If Assigned(cdsVenVis) Then
      cdsVenVis.Close;

    If Assigned(cdsVenPra) Then
      cdsVenPra.Close;

    If Assigned(cdsResEsp) Then
      FreeAndNil(cdsResEsp);

    If Assigned(qryEmp) Then
      FreeAndNil(qryEmp);

    If Assigned(qryEsp) Then
      FreeAndNil(qryEsp);

    If Assigned(qryResFpg) Then
      FreeAndNil(qryResFpg);

    If Assigned(qryListPrz) Then
      FreeAndNil(qryListPrz);

    If Assigned(qryCadPag) Then
      FreeAndNil(qryCadPag);

    If Assigned(qryDetORpg) Then
      FreeAndNil(qryDetORpg);

    btnImprimir.Enabled := True;
    Screen.Cursor       := crDefault;
    pnlInfo.Caption     := '';
  End;

end;

function TfrmRelRcxResumoCaixa.fSQLFiltroEmpresa: String;
begin
  If (rdgEmpresa.ItemIndex = 0) Then
    Result := ' DET_CODEMP '
  Else
    Result := ' MOVTRI.DET_EMPORI ';
end;

Function TfrmRelRcxResumoCaixa.fSQLFromMovDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + 'WHERE    ';

  strSQL := strSQL + fSQLFiltroEmpresa + ' = :CODEMP             AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S"                        AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C"                         AND ';
  strSQL := strSQL + '  DET_CODCLI NOT IN (' + fLisCliFil + ') AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND ';

  strSQL := strSQL + cnsFiltroFFDVTR;
  
  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

  If FEntraBrindeFaturamento Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
    strSQL := strSQL + '  AND LOCATE(DET_ESPDOC, :ESPDOC) > 0 ';

  Result := strSQL;
End;

function TfrmRelRcxResumoCaixa.fTotalSeq(strCodEmp: String; intSeqCon: Integer;
  dtaDtaCad: TDate): Double;
Var qrySel:   TUniQuery;
    strSQL:   String;
begin
  If Not fEmptyStr(DateToStr(dtaDtaCad)) Then
  Begin
    qrySel := fCriaQuery(Nil);
    strSQL := 'SELECT SUM(COALESCE(RCX_DINREC, 0) + COALESCE(RCX_CARREC, 0) + ';
    strSQL := strSQL + ' COALESCE(RCX_CHQAVI, 0) + COALESCE(RCX_CHQPRE, 0) + COALESCE(RCX_ORDREC, 0)) AS TOTAL ';
    strSQL := strSQL + ' FROM CADRCXX ';
    strSQL := strSQL + ' WHERE RCX_CODEMP = :CODEMP AND RCX_SEQCON = :SEQCON AND RCX_DTACAD = :DTACAD ';

    With qrySel do begin
      Close;
      SQL.Text := strSQL;

      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('DTACAD').AsDate    := dtaDtaCad;
      Open;

      Result := FieldByName('TOTAL').Value;
      Close;
    End;
    FreeAndNil(qrySel);
  End
  Else
    Result := 0;
end;

Procedure TfrmRelRcxResumoCaixa.pSetaParamMovDet(qryMovDet: TUniQuery;
                          dtaDtaIni, dtaDtaFim: TDate);
Begin
  With qryMovDet Do
  Begin
    ParamByName('DTAINI').AsDate   := dtaDtaIni;
    ParamByName('DTAFIN').AsDate   := dtaDtaFim;
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
       (Params.FindParam('ESPDOC') <> Nil) Then
      ParamByName('ESPDOC').AsString := mskEspecie.Text;
  End;
End;

{************************************}
{* CARREGA DADOS DO RESUMO          *}
{*********************************AF*}
procedure TfrmRelRcxResumoCaixa.pCarregaDados(cdsDados: TUniClientDataSet);
  Var
    strSQL       : String;
    strSQLUnion  : String;
    strSQLMovGer : String;
    strSQLNotGer : String;
    strSQLFatGor : String;
    qryFat     : TUniQuery;
Begin

  Try

    qryFat     := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  SUM(IF(DET_CONPAG = "01000" AND DET_ESPDOC NOT IN ("TR","DV") AND LEFT(DET_CLAFIS,1) >= 5, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)),0.00)) AS VENVIS, ';
    strSQL := strSQL + '  SUM(IF(DET_CONPAG<> "01000" AND DET_ESPDOC NOT IN ("TR","DV") AND LEFT(DET_CLAFIS,1) >= 5, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)),0.00)) AS VENPRA, ';
    strSQL := strSQL + '  SUM(IF(DET_ESPDOC IN ("TR","DV") OR LEFT(DET_CLAFIS,1) < 5, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE-DET_DESESP-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF),0.00)) AS VENDEV, ';
    strSQL := strSQL + '  SUM(IF(DET_CONPAG = "01000", (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS AVIDIA, ';
    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS VENDIA ';

    strSQL := strSQL + fSQLFromMovDet;

    strSQL := strSQL + ' GROUP BY     ';
    strSQL := strSQL + '   DET_ESPDOC ';

    strSQLUnion := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ESPDOC, ';
    strSQL := strSQL + '  SUM(VENVIS) AS VENVIS, ';
    strSQL := strSQL + '  SUM(VENPRA) AS VENPRA, ';
    strSQL := strSQL + '  SUM(VENDEV) AS VENDEV, ';
    strSQL := strSQL + '  SUM(AVIDIA) AS AVIDIA, ';
    strSQL := strSQL + '  SUM(VENDIA) AS VENDIA  ';
    strSQL := strSQL + 'FROM   ';
    strSQL := strSQL + '(';

    strSQL := strSQL +  strSQLUnion;

    strSQL := strSQL + ') AS TMP_TABELA ';

    strSQL := strSQL + ' GROUP BY    ';
    strSQL := strSQL + '   ESPDOC    ';

    With qryFat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      pSetaParamMovDet(qryFat, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));

      Open;

      fltVenVis := 0;
      fltVenPra := 0;
      fltVenDev := 0;
      fltAviDia := 0;
      fltTotDia := 0;

      First;

      While Not Eof Do
      Begin
        fltVenVis := fltVenVis + FieldbyName('VENVIS').AsFloat;
        fltVenPra := fltVenPra + FieldbyName('VENPRA').AsFloat;
        fltVenDev := fltVenDev + FieldbyName('VENDEV').AsFloat;
        fltAviDia := fltAviDia + FieldByName('AVIDIA').AsFloat;

        fltTotDia := fltTotDia + FieldByName('VENDIA').AsFloat;

        cdsDados.Append;
        cdsDados.FieldByName('ESPDOC').AsString := FieldByName('ESPDOC').AsString;
        cdsDados.FieldByName('VENDIA').AsFloat  := FieldByName('VENDIA').AsFloat;
        cdsDados.Post;

        Next;
      End;

      fltPrzDia := fltTotDia - fltAviDia;

      Close;
    End;

    {**************************************}
    {* PEGA VALORES DO RESUMO             *}
    {***********************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    strSQL := strSQL + '  SUM(IF(RCX_DINREC < 0,0,RCX_DINREC)) AS DINENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_DINREC < 0,RCX_DINREC,0)) AS DINSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_CHQAVI < 0,0,RCX_CHQAVI)) AS CHQENT_AVI, ';
    strSQL := strSQL + '  SUM(IF(RCX_CHQAVI < 0,RCX_CHQAVI,0)) AS CHQSAI_AVI, ';

    strSQL := strSQL + '  SUM(IF(RCX_CHQPRE < 0,0,RCX_CHQPRE)) AS CHQENT_PRE, ';
    strSQL := strSQL + '  SUM(IF(RCX_CHQPRE < 0,RCX_CHQPRE,0)) AS CHQSAI_PRE, ';

    strSQL := strSQL + '  SUM(IF(RCX_CARREC < 0,0,RCX_CARREC)) AS CARENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_CARREC < 0,RCX_CARREC,0)) AS CARSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_VENPRZ < 0,0,RCX_VENPRZ)) AS VENENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_VENPRZ < 0,RCX_VENPRZ,0)) AS VENSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_OUTROS < 0,0,RCX_OUTROS)) AS OUTENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_OUTROS < 0,RCX_OUTROS,0)) AS OUTSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_RECPIX="S",0, IF(RCX_ORDREC < 0, 0, RCX_ORDREC))) AS ORDENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_ORDREC < 0 AND RCX_RECPIX<>"S",RCX_ORDREC,0)) AS ORDSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_RECPIX<>"S",0,IF(RCX_ORDREC < 0, 0, RCX_ORDREC))) AS PIXENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_ORDREC < 0 AND RCX_RECPIX="S",RCX_ORDREC,0)) AS PIXSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_VALFIN < 0,0,RCX_VALFIN)) AS FINENT, ';
    strSQL := strSQL + '  SUM(IF(RCX_VALFIN < 0,RCX_VALFIN,0)) AS FINSAI, ';

    strSQL := strSQL + '  SUM(IF(RCX_JURDES = "D", RCX_VALDOC, 0)) AS VALDES, ';
    strSQL := strSQL + '  SUM(IF(RCX_JURDES = "J", RCX_VALDOC, 0)) AS VALJUR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';

    If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  RCX_ESPDOC <> "FC" ';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + '  AND RCX_CODOPE = :CODOPE ';

    If Not fEmptyStr(edtSeqFec.Text) Then
      strSQL := strSQL + '  AND RCX_SQFCRX = :SQFCRX ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + '  AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQL := strSQL + '  AND LOCATE(RCX_ESPDOC, :ESPDOC) > 0 ';

    With qryCadRcxx Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
         (Params.FindParam('ESPDOC') <> Nil) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;

      If Not fEmptyStr(edtCodOpe.Text) Then
        ParamByName('CODOPE').AsString := edtCodOpe.Text;

      If Not fEmptyStr(edtSeqFec.Text) Then
        ParamByName('SQFCRX').AsInteger := StrToIntDef(edtSeqFec.Text, -1);

      Open;

    End;

    {*******************************************}
    {* ACRESCENTEI A SEGUINTE INSTRUÇÃO :      *}
    {* SE CONSUMIDOR, ELE FAZ JOIN COM MOVGER  *}
    {* PARA PEGAR O NOME DO CONSUMIDOR         *}
    {****************************************AC*}

    strSQL := '';
    strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '    CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC) AS NUMDUP, ';

    strSQL := strSQL + IIF( rdgEmpresa.ItemIndex = 0, ' CTR_CODEMP AS CODEMP, ',
                       ' IF(CTR_EMP_PD <> "", CTR_EMP_PD, CTR_CODEMP) AS CODEMP, ');

    strSQL := strSQL + '    CTR_CODVEN AS CODVEN, ';

    {*************************************************}
    {* ACRESCENTEI A SEGUINTE INSTRUÇÃO :            *}
    {* SE CONSUMIDOR, ELE FAZ JOIN COM MOVGER\NOTGER *}
    {* PARA PEGAR O NOME DO CONSUMIDOR               *}
    {**********************************************JB*}
    strSQL := strSQL + '    ( ';
    strSQL := strSQL + '       IF ';
    strSQL := strSQL + '         ( ';
    strSQL := strSQL + '            CLI_NOMCLI LIKE "%CONSUMIDOR%", ';
    strSQL := strSQL + '            ( ';
    strSQL := strSQL + '               IF ';
    strSQL := strSQL + '                 ( ';
    strSQL := strSQL + '                   ( ( M.GER_CODCLI IS NULL) OR (TRIM(M.GER_CODCLI) = "") ), ';
    strSQL := strSQL + '                   CONCAT(N.GER_CODCLI, "-", N.GER_NOMCON), ';
    strSQL := strSQL + '                   CONCAT(M.GER_CODCLI, "-", M.GER_NOMCON) ';
    strSQL := strSQL + '                 ) ';
    strSQL := strSQL + '            ), ';
    strSQL := strSQL + '            CONCAT(CTR_CODCLI,"-",CLI_NOMCLI) ';
    strSQL := strSQL + '         ) ';
    strSQL := strSQL + '    ) AS CODCLI, ';

    strSQL := strSQL + '    CTR_HIST01 AS HISTOR, ';
    strSQL := strSQL + '    CTR_VALDUP AS VALDUP  ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC ';
    strSQL := strSQL + '    LEFT JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';

    strSQL := strSQL + '    LEFT JOIN MOVGER AS M ON M.GER_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                         AND M.GER_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                         AND M.GER_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                         AND M.GER_CODEMP = CTR_CODEMP ';

    strSQL := strSQL + '    LEFT JOIN NOTGER AS N ON N.GER_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                         AND N.GER_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                         AND N.GER_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                         AND N.GER_CODEMP = CTR_CODEMP ';

    If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON CTR_CODVEN = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  CTR_DTACAD = CTR_DTAVEN AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';

    strSQL := strSQL + IIF( rdgEmpresa.ItemIndex = 0, ' CTR_CODEMP = :CODEMP AND ',
                       ' IF(CTR_EMP_PD <> "", CTR_EMP_PD, CTR_CODEMP) = :CODEMP AND ');

    strSQL := strSQL + '  CTR_ESPDOC <> "CC" ';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + '  AND CTR_CODVEN = :CODOPE ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQL := strSQL + '  AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';

    With qryCadRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
         (Params.FindParam('ESPDOC') <> Nil) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;

      If Not fEmptyStr(edtCodOpe.Text) Then
        ParamByName('CODOPE').AsString := edtCodOpe.Text;

      Open;

      If Not IsEmpty Then
        blnNaoBai := True
      Else
        blnNaoBai := False;

    End;

    {******************************************************}
    {* BUSCA OS DOCUMENTOS CANCELADOS - QTD E VALOR TOTAL *}
    {***************************************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  SUM(QTDDOC) AS QTDDOC, ';
    strSQL := strSQL + '  SUM(VLRCON) AS VLRCON  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' ( ';

    strSQLMovGer := '';
    strSQLMovGer := strSQLMovGer + 'SELECT SQL_NO_CACHE ';
    strSQLMovGer := strSQLMovGer + '  COUNT(*) AS QTDDOC, ';
    strSQLMovGer := strSQLMovGer + '  SUM(GER_VLRCON) AS VLRCON ';
    strSQLMovGer := strSQLMovGer + 'FROM ';
    strSQLMovGer := strSQLMovGer + '  DEL_MOVGER ';
    strSQLMovGer := strSQLMovGer + '  LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
    strSQLMovGer := strSQLMovGer + '  LEFT JOIN CADFOR ON GER_CODFOR = FOR_CODFOR ';
    strSQLMovGer := strSQLMovGer + 'WHERE ';
    strSQLMovGer := strSQLMovGer + '  DTADEL BETWEEN :DTAINI AND :DTAFIN  AND ';
    strSQLMovGer := strSQLMovGer + '  GER_CODEMP = :CODEMP ';

    strSQLMovGer := strSQLMovGer + '  AND NOT ( GER_TIP_FC = "F"                        AND ';
    strSQLMovGer := strSQLMovGer + '            LEFT(GER_CLAFIS,1) < 5                  AND ';
    strSQLMovGer := strSQLMovGer + '            IFNULL(GER_ORIDOC,"") NOT IN ("V", "D") )   ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQLMovGer := strSQLMovGer + '  AND LOCATE(GER_ESPDOC, :ESPDOC) > 0 ';

    strSQLNotGer := AnsiReplaceStr(strSQLMovGer,'DEL_MOVGER','DEL_NOTGER');

    strSQLFatGor := '';
    strSQLFatGor := strSQLFatGor + 'SELECT SQL_NO_CACHE ';
    strSQLFatGor := strSQLFatGor + '  COUNT(*) AS QTDDOC, ';
    strSQLFatGor := strSQLFatGor + '  SUM(FGO_VLRCON) AS VLRCON ';
    strSQLFatGor := strSQLFatGor + 'FROM ';
    strSQLFatGor := strSQLFatGor + '  DEL_FATGOR ';
    strSQLFatGor := strSQLFatGor + '  LEFT JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
    strSQLFatGor := strSQLFatGor + 'WHERE ';
    strSQLFatGor := strSQLFatGor + '  DTADEL BETWEEN :DTAINI AND :DTAFIN  AND ';
    strSQLFatGor := strSQLFatGor + '  FGO_CODEMP = :CODEMP ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQLFatGor := strSQLFatGor + '  AND LOCATE(FGO_ESPDOC, :ESPDOC) > 0 ';

    strSQL := strSQL + strSQLMovGer + ' UNION ALL ' + strSQLNotGer;
    strSQL := strSQL + ') AS TAB ';

    With qryFat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
         (Params.FindParam('ESPDOC') <> Nil) Then 
        ParamByName('ESPDOC').AsString := mskEspecie.Text;

      Open;

      If Not IsEmpty Then
      Begin
        intQtdCan := 0;
        fltValCan := 0.0;

        intQtdCan := FieldbyName('QTDDOC').AsInteger;
        fltValCan := FieldbyName('VLRCON').AsFloat;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryFat);
  End;

  {*****************************************}
  {* GERA RESUMO DE CREDITOS               *}
  {**************************************AF*}
  If chkCredito.Checked Then
  Begin
    strSQL :=  '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  RCX_DTACAD AS DTAENT, ';
    strSQL := strSQL + '  RCX_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CONCAT(RCX_NUMDOC,RCX_PARCEL,"-",RCX_ESPDOC) AS NUMDUP, ';
    strSQL := strSQL + '  CONCAT(CLI_CODCLI,"-",CLI_NOMCLI) AS NOMCLI, ';
    strSQL := strSQL + '  RCX_DESCRI AS DESCRI, ';
    strSQL := strSQL + '  RCX_VALDOC AS VALDUP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = RCX_CODCLI ';

    If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  RCX_VALDOC < 0 AND ';
    strSQL := strSQL + '  RCX_ESPDOC <> "FC" AND ';
    strSQL := strSQL + '  LOCATE(RCX_ESPDOC,"LD_PG_TF_") <= 0 AND ';
    strSQL := strSQL + '  ( RCX_VENPRZ <= 0 OR ( RCX_VENPRZ > 0 AND RCX_DINREC+RCX_CHQAVI+RCX_CHQPRE+RCX_CARREC+RCX_ORDREC+RCX_VALFIN <> 0 ))';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + '  AND RCX_CODOPE = "'+edtCodOpe.Text+'" ';

    If Not fEmptyStr(edtSeqFec.Text) Then
      strSQL := strSQL + '  AND RCX_SQFCRX = '+IntToStr(StrToIntDef(edtSeqFec.Text, -1))+' ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + '  AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQLFatGor := strSQLFatGor + '  AND LOCATE(FGO_ESPDOC, :ESPDOC) > 0 ';

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  NUMDUP ';

    With qryCredito Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;
  End;

  {*****************************************}
  {* CARREGA DUPLICATAS COM JUSTIFICATIVAS *}
  {* DE DESCONTO                           *}
  {**************************************JU*}
  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  CTR_DINHEI, ';
  strSQL := strSQL + '  CTR_CHQAVI, ';
  strSQL := strSQL + '  CTR_CHQPRE, ';
  strSQL := strSQL + '  CTR_CARTAO, ';
  strSQL := strSQL + '  CTR_ORDPAG, ';
  strSQL := strSQL + '  "" AS CODFPG, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP,"-",CTR_ESPDOC) AS NUMDUP, ';
  strSQL := strSQL + '  CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  CTR_DTAREC AS DTAREC, ';
  strSQL := strSQL + '  CONCAT(CTR_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
  strSQL := strSQL + '  CTR_VALORI AS VALORI, ';
  strSQL := strSQL + '  ((CTR_VALDES / CTR_VALORI) * 100) AS VALDES, ';
  strSQL := strSQL + '  CTR_VALREC AS VALREC, ';
  strSQL := strSQL + '  IF(IFNULL(CTR_JUSDES, "") = "", RCX_MOTDES, CTR_JUSDES)  AS JUSDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADRCXX ON CTR_NUMDUP = RCX_NUMDUP AND ';
  strSQL := strSQL + '                       CTR_PARCEL = RCX_PARCEL AND ';
  strSQL := strSQL + '                       CTR_ESPDOC = RCX_ESPDOC AND ';
  strSQL := strSQL + '                       CTR_CODCLI = RCX_CODCLI AND ';
  strSQL := strSQL + '                       CTR_EMPBAI = RCX_CODEMP AND ';
  strSQL := strSQL + '                       RCX_VALDOC > 0          AND ';
  strSQL := strSQL + '                       RCX_JURDES <> "J"       AND ';
  strSQL := strSQL + '                       RCX_JURDES <> "D"           ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  IFNULL(CTR_JUSDES, RCX_MOTDES) <> "" AND ';
  strSQL := strSQL + '  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  IFNULL(CTR_VALDES, 0) > 0 AND ';
  strSQL := strSQL + '  CTR_EMPBAI=:EMPBAI ';

  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    strSQL := strSQL + '  AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

  With qryDupJus Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('EMPBAI').AsString := VS_strCodEmp;
    Open;
  End;

End;

procedure TfrmRelRcxResumoCaixa.edtVisualizacaoChange(Sender: TObject);
begin
  inherited;
  If edtVisualizacao.Text = 'S' then
  begin
    chkLDPGInicio.Enabled := True
  end
  else
  begin
    chkLDPGInicio.Checked := False;
    chkLDPGInicio.Enabled := False;
  end;
end;

procedure TfrmRelRcxResumoCaixa.edtVisualizacaoExit(Sender: TObject);
begin
  inherited;
  If (((edtVisualizacao.Text <> 'E') And (edtVisualizacao.Text <> 'S')) Or (edtVisualizacao.Text = '')) Then
    pSetFocus(edtVisualizacao);

  edtVisualizacaoChange(nil);

end;

procedure TfrmRelRcxResumoCaixa.edtTipoChange(Sender: TObject);
begin
  inherited;

  If edtTipo.Text = 'S' Then
  Begin
    chkTipRec.Enabled := False;
    chkTipRec.Checked := False;
    chkSeparaDtaCad.Enabled := False;
    chkSeparaDtaCad.Checked := False;
    edtVisualizacao.Text    := 'E';
    edtVisualizacao.Enabled := False;
  End
  Else
  Begin
    chkTipRec.Enabled := True;
    chkSeparaDtaCad.Enabled := True;
    edtVisualizacao.Enabled := True;
  End;
end;

function TfrmRelRcxResumoCaixa.fProcessaDocumentos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    intSeqCon: Integer;
    fltTotDin, fltTotChq, fltTotPre, fltTotCar, fltTotOrd, fltTotPix: Double;
    fltSomDin, fltSomChq, fltSomPre, fltSomCar, fltSomOrd, fltSomPix: Double;
    strIndAnt: String;

  procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
  Begin
    If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
    Begin
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
      Application.ProcessMessages;
    End;
  End;

  procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
  Begin

    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
      pgbStatus.Position := intProgresso;
      pgbStatus.properties.Max := intMaximo;
      Application.ProcessMessages;
    End;
  End;
Begin
  Result   := True;
  cdsRelat := CriarClientDataSet(qryRelat);

  fltTotDin := 0;
  fltTotChq := 0;
  fltTotPre := 0;
  fltTotCar := 0;
  fltTotOrd := 0;
  fltTotPix := 0;
  fltSomDin := 0;
  fltSomChq := 0;
  fltSomPre := 0;
  fltSomCar := 0;
  fltSomOrd := 0;
  fltSomPix := 0;

  With cdsRelat Do
  Begin
    If Not IsEmpty Then
    Begin
      strIndAnt := IndexFieldNames;
      IndexFieldNames := 'SEQCON;VALDOC';
      First;
      intSeqCon := FieldByName('SEQCON').AsInteger;
      pInformacao('Aguarde, Verificando documentos...', pgbStatus);
      pProgresso(0, RecordCount, pgbStatus);

      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbStatus);
        //If FieldByName('VALDOC').ASFloat >= 0 Then
        //Begin
          fltTotDin := fltTotDin + FieldByName('DINHEI_TMP').AsFloat;
          fltTotChq := fltTotChq + FieldByName('CHQAVI_TMP').AsFloat;
          fltTotPre := fltTotPre + FieldByName('CHQPRE_TMP').AsFloat;
          fltTotCar := fltTotCar + FieldByName('CARREC_TMP').AsFloat;
          fltTotOrd := fltTotOrd + FieldByName('ORDREC_TMP').AsFloat;
          fltTotPix := fltTotPix + FieldByName('PIXREC_TMP').AsFloat;
          fltSomDin := fltSomDin + FieldByName('DINHEI').AsFloat;
          fltSomChq := fltSomChq + FieldByName('CHQAVI').AsFloat;
          fltSomPre := fltSomPre + FieldByName('CHQPRE').AsFloat;
          fltSomCar := fltSomCar + FieldByName('CARREC').AsFloat;
          fltSomOrd := fltSomOrd + FieldByName('ORDREC').AsFloat;
          fltSomPix := fltSomPix + FieldByName('PIXREC').AsFloat;

          Next;

          If (FieldByName('SEQCON').AsString <> '') And (intSeqCon <> FieldByName('SEQCON').AsInteger) Then
          Begin
            Prior;
            Edit;
            If fltSomDin <> fltTotDin Then
              FieldByName('DINHEI').AsFloat := FieldByName('DINHEI').AsFloat + (fltTotDin - fltSomDin);
            If fltSomChq <> fltTotChq Then
              FieldByName('CHQAVI').AsFloat := FieldByName('CHQAVI').AsFloat + (fltTotChq - fltSomChq);
            If fltSomPre <> fltTotPre Then
              FieldByName('CHQPRE').AsFloat := FieldByName('CHQPRE').AsFloat + (fltTotPre - fltSomPre);
            If fltSomCar <> fltTotCar Then
              FieldByName('CARREC').AsFloat := FieldByName('CARREC').AsFloat + (fltTotCar - fltSomCar);
            If fltSomOrd <> fltTotOrd Then
              FieldByName('ORDREC').AsFloat := FieldByName('ORDREC').AsFloat + (fltTotOrd - fltSomOrd);
            If fltSomPix <> fltTotPix Then
              FieldByName('PIXREC').AsFloat := FieldByName('PIXREC').AsFloat + (fltTotPix - fltSomPix);
            Post;

            Next;
            intSeqCon := FieldByName('SEQCON').AsInteger;
            fltTotDin := 0;
            fltTotChq := 0;
            fltTotPre := 0;
            fltTotCar := 0;
            fltTotOrd := 0;
            fltTotPix := 0;
            fltSomDin := 0;
            fltSomChq := 0;
            fltSomPre := 0;
            fltSomCar := 0;
            fltSomOrd := 0;
            fltSomPix := 0;
          End;
        //End
        //Else
        //  Next;
      End;
      IndexFieldNames := strIndAnt;
    End;
  End;
end;

function TfrmRelRcxResumoCaixa.fRetornaSaldoInicial(dtaDtaIni: TDateTime; Var fltDinIni, fltCarIni, fltChpIni, fltChaIni, fltOrdIni, fltFinIni, fltPixIni: Double): Double;
  Var
    strSQL   : String;
    qryGenRcx: TUniQuery;

begin

  Try

    Result := 0;

    qryGenRcx := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  RCX_ESPDOC, ';
    strSQL := strSQL + '  RCX_DINREC, ';
    strSQL := strSQL + '  RCX_CHQAVI, ';
    strSQL := strSQL + '  RCX_CHQPRE, ';
    strSQL := strSQL + '  RCX_CARREC, ';
    strSQL := strSQL + '  IF(RCX_RECPIX<>"S", RCX_ORDREC, 0) AS RCX_ORDREC, ';
    strSQL := strSQL + '  IF(RCX_RECPIX="S", RCX_ORDREC, 0) AS PIXREC, ';
    strSQL := strSQL + '  RCX_VALFIN, ';
    strSQL := strSQL + '  RCX_VALDOC  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_DTACAD < :DTACAD AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + ' AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

    strSQL := strSQL + 'ORDER BY ';

    If fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + '  RCX_IDEFEC DESC, RCX_DTACAD DESC '
    Else
      strSQL := strSQL + '  RCX_IDEFEC DESC, RCX_DTAGRV DESC, RCX_DTACAD DESC ';

    strSQL := strSQL + 'LIMIT 1 ';

    With qryGenRcx Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTACAD').AsDate := dtaDtaIni;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If (Not IsEmpty) Then
      Begin

        If (FieldByName('RCX_ESPDOC').AsString = 'FC') Then
        Begin
          Result := FieldByName('RCX_DINREC').AsFloat + //FieldByName('RCX_VALDOC').AsFloat;
                    FieldByName('RCX_CHQAVI').AsFloat +
                    FieldByName('RCX_CHQPRE').AsFloat +
                    FieldByName('RCX_CARREC').AsFloat +
                    FieldByName('RCX_ORDREC').AsFloat +
                    FieldByName('RCX_VALFIN').AsFloat +
                    FieldByName('PIXREC').AsFloat;

          fltDinIni := FieldByName('RCX_DINREC').AsFloat;
          fltChaIni := FieldByName('RCX_CHQAVI').AsFloat;
          fltChpIni := FieldByName('RCX_CHQPRE').AsFloat;
          fltCarIni := FieldByName('RCX_CARREC').AsFloat;
          fltOrdIni := FieldByName('RCX_ORDREC').AsFloat;
          fltFinIni := FieldByName('RCX_VALFIN').AsFloat;
          fltPixIni := FieldByName('PIXREC').AsFloat;
        End;

      End;

      Close;

    End;

  Finally
    FreeAndNil(qryGenRcx);
  End;

end;

function TfrmRelRcxResumoCaixa.fRetornaSaldoInicialFec(dtaDtaIni, dtaDtaFin: TDateTime): Double;
  Var
    strSQL   : String;
    qryGenRcx: TUniQuery;
begin

  Try

    Result := 0;

    qryGenRcx := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  SUM(RCX_DINREC) AS RCX_DINREC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_ESPDOC = "LC" AND ';
    strSQL := strSQL + '  RCX_IDEFEC = "S" AND ';
    strSQL := strSQL + '  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + '  AND RCX_CODOPE = :CODOPE ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + ' AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

    With qryGenRcx Do
    Begin     
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := dtaDtaIni;
      ParamByName('DTAFIN').AsDate := dtaDtaFin;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(edtCodOpe.Text) Then
        ParamByName('CODOPE').AsString := edtCodOpe.Text;

      Open;

      If (Not IsEmpty) Then
        Result := FieldByName('RCX_DINREC').AsFloat;

      Close;
    End;

  Finally
    FreeAndNil(qryGenRcx);
  End;

end;

procedure TfrmRelRcxResumoCaixa.pCalculaSaldoParcial;
  Var
    qryAux: TUniQuery;
begin

  If intSqFcRx <= 0 Then
    Exit;

  Try

    qryAux := fCriaQuery;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT SQL_NO_CACHE ');
    qryAux.SQL.Add('  SUM(RCX_DINREC) AS DINREC, ');
    qryAux.SQL.Add('  SUM(RCX_CHQAVI) AS CHQAVI, ');
    qryAux.SQL.Add('  SUM(RCX_CHQPRE) AS CHQPRE, ');
    qryAux.SQL.Add('  SUM(RCX_CARREC) AS CARREC, ');
    qryAux.SQL.Add('  SUM(IF(RCX_RECPIX<>"S", RCX_ORDREC, 0)) AS ORDREC, ');
    qryAux.SQL.Add('  SUM(IF(RCX_RECPIX="S", RCX_ORDREC, 0)) AS PIXREC, ');
    qryAux.SQL.Add('  SUM(RCX_VALFIN) AS VALFIN, ');
    qryAux.SQL.Add('  SUM(RCX_VALDOC) AS VALPAR ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADRCXX ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  RCX_DTACAD = :DTACAD AND ');
    qryAux.SQL.Add('  RCX_SQFCRX < :SQFCRX AND ');
    qryAux.SQL.Add('  RCX_CODEMP = :CODEMP ');

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      qryAux.SQL.Add('  AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ');

    qryAux.ParamByName('DTACAD').AsDateTime := StrToDate(mskDtaIni.Text);
    qryAux.ParamByName('SQFCRX').AsInteger  := intSqFcRx;
    qryAux.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryAux.Open;

    fltSalIni := fltSalIni + qryAux.FieldByName('VALPAR').AsFloat;
    fltDinIni := fltDinIni + qryAux.FieldByName('DINREC').AsFloat;
    fltChaIni := fltChaIni + qryAux.FieldByName('CHQAVI').AsFloat;
    fltChpIni := fltChpIni + qryAux.FieldByName('CHQPRE').AsFloat;
    fltCarIni := fltCarIni + qryAux.FieldByName('CARREC').AsFloat;
    fltOrdIni := fltOrdIni + qryAux.FieldByName('ORDREC').AsFloat;
    fltFinIni := fltFinIni + qryAux.FieldByName('VALFIN').AsFloat;
    fltPixIni := fltPixIni + qryAux.FieldByName('PIXREC').AsFloat;
  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmRelRcxResumoCaixa.fAdicionaCheques(strDocum, strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Boolean;
Begin
  Result := True;
  qryCheques.Close;

  if chkNaoExibeCheque.Checked then
    Result := False
  else
    If Not fExisteCheque(strDocum, strCodEmp, intSeqCon, qryCheques, dtaDtaCad) Then
      Result := False;

End;

function TfrmRelRcxResumoCaixa.fFiltroPagamentos: String;
  Var
    qryAuxPag: TUniQuery;
    strSQL   : String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '   RCX_SEQCON,           ';
  strSQL := strSQL + '   RCX_CODEMP            ';
  strSQL := strSQL + ' FROM                    ';
  strSQL := strSQL + '   CADRCXX               ';

  If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

  strSQL := strSQL + ' WHERE                   ';
  strSQL := strSQL + fSqlFiltros(True)          ;
  strSQL := strSQL + '   AND RCX_ESPDOC = "PG" ';

  qryAuxPag := fCriaQuery(Nil);

  With qryAuxPag Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    First;
  End;

  Result := '';

  If Not qryAuxPag.IsEmpty Then
  Begin
    While Not qryAuxPag.Eof Do
    Begin
      Result := Result + '   (CTP_RCXCON = ' + QuotedStr(qryAuxPag.FieldByName('RCX_SEQCON').AsString) + ' AND ';
      Result := Result + '    CTP_CODEMP = ' + QuotedStr(qryAuxPag.FieldByName('RCX_CODEMP').AsString) + ' AND ';
      Result := Result + '    CTP_EMPBAI = ' + QuotedStr(qryAuxPag.FieldByName('RCX_CODEMP').AsString) + ' AND ';
      Result := Result + '    CTP_RESCAI = "1") OR';

      qryAuxPag.Next;
    End;

    Result := Copy(Result, 01, Length(Result) - 3);
  End;

  FreeAndNil(qryAuxPag);

end;

function TfrmRelRcxResumoCaixa.frxRelRcxResumoCaixaMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;
  If MethodName = 'FADICIONACHEQUES' Then
    Result:= fAdicionaCheques(Params[0], Params[1], Params[2], Params[3])
  Else If MethodName = 'FTOTALSEQ' Then
    Result:= fTotalSeq(Params[0], Params[1], Params[2]);

end;

function TfrmRelRcxResumoCaixa.frxRelRcxResumoCaixaJUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;
  If MethodName = 'FADICIONACHEQUES' Then
    Result:= fAdicionaCheques(Params[0], Params[1], Params[2], Params[3])
  Else If MethodName = 'FTOTALSEQ' Then
    Result:= fTotalSeq(Params[0], Params[1], Params[2]);

end;

procedure TfrmRelRcxResumoCaixa.edtTipoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtTipo.Text) Then
  Begin
    fMensagem('ATENÇÃO','O Tipo do Relatório dever ser informado!',['&O K']);
    pSetFocus(edtTipo);
  End
  Else If (Pos(edtTipo.Text,'AS')<=0) Then
  Begin
    pSetFocus(edtTipo);
  End;

end;

procedure TfrmRelRcxResumoCaixa.pMostraDtaMov(strTipImp,strExiDta: String; frxRel: TfrxReport);
begin
  If (SameText(strExiDta, 'S')) Then
  Begin
    If edtVisualizacao.Text = 'S' Then
    Begin
      TfrxMemoView(frxRel.FindObject('rllTitDta')).Visible    := True;
      TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible    := True;
      TfrxMemoView(frxRel.FindObject('rllTitSeqBai')).Visible := True;
      TfrxMemoView(frxRel.FindObject('rllSeqBai')).Visible    := True;
    End Else
    Begin

      TfrxMemoView(frxRel.FindObject('rllTitDta')).Visible    := True;
      TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible    := True;

      TfrxMemoView(frxRel.FindObject('rllTitSeqBai')).Visible := False;
      TfrxMemoView(frxRel.FindObject('rllSeqBai')).Visible    := False;

      TfrxMemoView(frxRel.FindObject('rllTitDta')).Left    :=
        TfrxMemoView(frxRel.FindObject('rllTitDta')).Left -
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('rllDtaCad')).Left    :=
         TfrxMemoView(frxRel.FindObject('rllDtaCad')).Left -
         TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('rllDesDoc')).Left    :=
        TfrxMemoView(frxRel.FindObject('rllDesDoc')).Left -
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('rllTitDoc')).Left    :=
        TfrxMemoView(frxRel.FindObject('rllTitDoc')).Left -
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;


      TfrxMemoView(frxRel.FindObject('rllTitHis')).Left    :=
        TfrxMemoView(frxRel.FindObject('rllTitHis')).Left -
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('rdbDescri')).Left    :=
        TfrxMemoView(frxRel.FindObject('rdbDescri')).Left -
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('rllTitHis')).Width   :=
        TfrxMemoView(frxRel.FindObject('rllTitHis')).Width +
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('rdbDescri')).Width   :=
        TfrxMemoView(frxRel.FindObject('rdbDescri')).Width +
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width;

      TfrxMemoView(frxRel.FindObject('Memo405')).Left    := TfrxMemoView(frxRel.FindObject('rdbDescri')).Left;

    End;
  End
  Else
  Begin
    If edtVisualizacao.Text = 'S' Then
    Begin
      if (edtTipo.Text = 'A') then
      begin
        TfrxMemoView(frxRel.FindObject('rllTitDta')).Visible    := True;
        TfrxMemoView(frxRel.FindObject('rllTitDta')).Text       := 'HORA';
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible    := True;
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).DisplayFormat.FormatStr := '';
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).DisplayFormat.Kind      := fkText;
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Memo.Clear;
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Memo.Add('[frxRelatorio_RelRcx."HORCAD"]');
      end else
      begin
        TfrxMemoView(frxRel.FindObject('rllTitDta')).Visible    := False;
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible    := False;

        TfrxMemoView(frxRel.FindObject('rllDesDoc')).Left    :=
          TfrxMemoView(frxRel.FindObject('rllDesDoc')).Left -
          TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width ;

        TfrxMemoView(frxRel.FindObject('rllTitDoc')).Left    :=
          TfrxMemoView(frxRel.FindObject('rllTitDoc')).Left -
          TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width ;

        TfrxMemoView(frxRel.FindObject('rllTitHis')).Left    :=
          TfrxMemoView(frxRel.FindObject('rllTitHis')).Left -
          TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width;

        TfrxMemoView(frxRel.FindObject('rdbDescri')).Left    :=
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Left -
          TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width;

        TfrxMemoView(frxRel.FindObject('rllTitHis')).Width   :=
          TfrxMemoView(frxRel.FindObject('rllTitHis')).Width +
          TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width;

        TfrxMemoView(frxRel.FindObject('rdbDescri')).Width   :=
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Width +
          TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width;

        TfrxMemoView(frxRel.FindObject('Memo405')).Left    := TfrxMemoView(frxRel.FindObject('rdbDescri')).Left;

      end;

      TfrxMemoView(frxRel.FindObject('rllTitSeqBai')).Visible := True;
      TfrxMemoView(frxRel.FindObject('rllSeqBai')).Visible    := True;

    End Else
    Begin
      TfrxMemoView(frxRel.FindObject('rllTitDta')).Visible    := False;
      TfrxMemoView(frxRel.FindObject('rllDtaCad')).Visible    := False;
      TfrxMemoView(frxRel.FindObject('rllTitSeqBai')).Visible := False;
      TfrxMemoView(frxRel.FindObject('rllSeqBai')).Visible    := False;

      TfrxMemoView(frxRel.FindObject('rllDesDoc')).Left    := TfrxMemoView(frxRel.FindObject('rllDesCodOpe')).Width + 1;
      TfrxMemoView(frxRel.FindObject('rllTitDoc')).Left    := TfrxMemoView(frxRel.FindObject('rllTitCodOpe')).Width + 1;

      TfrxMemoView(frxRel.FindObject('rllTitHis')).Left    :=
        TfrxMemoView(frxRel.FindObject('rllTitHis')).Left -
        (TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width +
         TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width);

      TfrxMemoView(frxRel.FindObject('rdbDescri')).Left    :=
        TfrxMemoView(frxRel.FindObject('rdbDescri')).Left -
        (TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width +
         TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width);

      TfrxMemoView(frxRel.FindObject('rllTitHis')).Width   :=
        TfrxMemoView(frxRel.FindObject('rllTitHis')).Width +
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width +
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width;

      TfrxMemoView(frxRel.FindObject('rdbDescri')).Width   :=
        TfrxMemoView(frxRel.FindObject('rdbDescri')).Width +
        TfrxMemoView(frxRel.FindObject('rllSeqBai')).Width +
        TfrxMemoView(frxRel.FindObject('rllDtaCad')).Width;

      TfrxMemoView(frxRel.FindObject('Memo405')).Left    := TfrxMemoView(frxRel.FindObject('rdbDescri')).Left;
    End;
  End;
end;

procedure TfrmRelRcxResumoCaixa.pPreparaDadosFaturamento;
  Var
    strSQL   : String;
    strSQLTmp: String;
    strClaVen,
    strClaDev: String;

    {******************************************************************}
    {* FUNÇÃO QUE RETORNA O SQL PARA SOMATÓRIA DOS VALORES NO MOVMOD  *}
    {* FOI REMOVIDO O INNER JOIN DOS SELECTS POIS ESTAVA GERANDO      *}
    {* CARTESIANO QUANDO EXISTIA MAIS DE UMA MODALIDADE POR DOCUMENTO *}
    {***************************************************************PZ*}
    function fRetSQLMovMod(strInstrucao: String; strSigTab: String = 'DET'): String;
    Begin
      Result := '';
      Result := Result + ' (SELECT ' + strInstrucao  + ' FROM MOVMOD WHERE MOD_NUMDOC = ' + strSigTab + '_NUMDOC AND MOD_ESPDOC = ' + strSigTab + '_ESPDOC AND MOD_CODEMP = ' + strSigTab + '_CODEMP AND MOD_CODCLI = ' + strSigTab + '_CODCLI AND IFNULL(MOD_SERIE_,"") = IFNULL(' + strSigTab + '_SERIE_,"")) ';
    End;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP = :CODEMP AND (LEFT(FDO_CONPAG,5) = "01000") AND (LOCATE(FDO_CODFPG, "001_002_006_011_013_012_010_") > 0) AND (FGO_ENT_CD = "S"), IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP),(FDO_TOTITE - FDO_DESESP)),0)) AS PD_ATU_AVI, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP = :CODEMP AND (LEFT(FDO_CONPAG,5) =   "01000") AND (FDO_CODFPG="015") AND (FGO_ENT_CD = "S"), IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_ATU_AVI015, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP = :CODEMP AND (LEFT(FDO_CONPAG,5) <>  "01000") AND (LOCATE(FDO_CODFPG, "007"             ) < 0) AND (FGO_ENT_CD = "S"), IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_ATU_PRZ, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP = :CODEMP AND                                      (LOCATE(FDO_CODFPG, "002_006_"        ) > 0) AND (FGO_ENT_CD = "S"), IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_ATU_CHE, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP = :CODEMP AND                                      (FDO_CODFPG = "007")                         AND (FGO_ENT_CD = "S"), IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_ATU_CAR, ';

  strSQL := strSQL + '  SUM(IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LEFT(FDO_CONPAG,5) =  "01000" AND LOCATE(FDO_CODFPG, "001_011_") > 0, IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_CD_AVI, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LEFT(FDO_CONPAG,5) =  "01000" AND (FDO_CODFPG = "015"), IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_CD_AVI015, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LEFT(FDO_CONPAG,5) <> "01000",      IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_CD_PRZ, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LOCATE(FDO_CODFPG, "002_006_") > 0, IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_CD_CHE, ';
  strSQL := strSQL + '  SUM(IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND FDO_CODFPG = "007",                 IF( LEFT(FDO_CLAFIS,1) < 5, -(FDO_TOTITE - FDO_DESESP), (FDO_TOTITE - FDO_DESESP)), 0) ) AS PD_CD_CAR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  FDO_CODFPG <> "009" AND ';
  strSQL := strSQL + '  FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  FDO_ESPDOC = "PD"                      AND ';
  strSQL := strSQL + '  FDO_SEQIND <> -1                           ';

  strSQL := strSQL + '  UNION ALL ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IF(FDO_CODEMP = :CODEMP AND (LEFT(FDO_CONPAG,5) =   "01000") AND (FGO_ENT_CD = "S"), ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_002_006_011_013_012_010_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_ATU_AVI, ';
  strSQL := strSQL + '  IF(FDO_CODEMP = :CODEMP AND (LEFT(FDO_CONPAG,5) =   "01000") AND (FGO_ENT_CD = "S"), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_ATU_AVI015, ';
  strSQL := strSQL + '  IF(FDO_CODEMP = :CODEMP AND (LEFT(FDO_CONPAG,5) <>  "01000") AND (FGO_ENT_CD = "S"), ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "007") < 0, IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_ATU_PRZ, ';
  strSQL := strSQL + '  IF(FDO_CODEMP = :CODEMP AND (FGO_ENT_CD = "S"), ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "002_006_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_ATU_CHE, ';
  strSQL := strSQL + '  IF(FDO_CODEMP = :CODEMP AND (FGO_ENT_CD = "S"), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_ATU_CAR, ';

  strSQL := strSQL + '  IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LEFT(FDO_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_011_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_CD_AVI, ';
  strSQL := strSQL + '  IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LEFT(FDO_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_CD_AVI015, ';
  strSQL := strSQL + '  IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S" AND LEFT(FDO_CONPAG,5) <> "01000", ' + fRetSQLMovMod(' SUM(IFNULL(MOD_VALMOD, 0)) ', 'FDO') + ', 0) AS PD_CD_PRZ, ';
  strSQL := strSQL + '  IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "002_006_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_CD_CHE, ';
  strSQL := strSQL + '  IF(FDO_CODEMP <> :CODEMP AND FGO_EMPFAT = :CODEMP AND FGO_ENT_CD = "S", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IFNULL(MOD_VALMOD, 0), 0)) ', 'FDO') + ', 0) AS PD_CD_CAR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + '  LEFT  JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  FDO_CODFPG = "009" AND ';
  strSQL := strSQL + '  FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  FDO_ESPDOC = "PD"                      AND ';
  strSQL := strSQL + '  FDO_SEQIND <> -1                           ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP, FDO_CODCLI ';

  With qryFatGor, SQL Do
  Begin
    Close;
    Clear;
    Add (' SELECT                                ');
    Add ('   SUM( PD_ATU_AVI ) AS PD_ATU_AVI,    ');
    Add ('   SUM( PD_ATU_AVI ) AS PD_ATU_AVI015, ');
    Add ('   SUM( PD_ATU_PRZ ) AS PD_ATU_PRZ,    ');
    Add ('   SUM( PD_ATU_CHE ) AS PD_ATU_CHE,    ');
    Add ('   SUM( PD_ATU_CAR ) AS PD_ATU_CAR,    ');

    Add ('   SUM( PD_CD_AVI ) AS PD_CD_AVI,    ');
    Add ('   SUM( PD_CD_AVI ) AS PD_CD_AVI015, ');
    Add ('   SUM( PD_CD_PRZ ) AS PD_CD_PRZ,    ');
    Add ('   SUM( PD_CD_CHE ) AS PD_CD_CHE,    ');
    Add ('   SUM( PD_CD_CAR ) AS PD_CD_CAR     ');

    Add (' FROM ( ' + strSQL + ' ) AS T ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    Open;
  End;

  strSQLTmp := '';
  strSQLTmp := strSQLTmp + 'SELECT ';
  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO DA PRÓPRIA EMPRESA.                *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND LOCATE(IFNULL(DET_CODFPG, "001"), "001_002_006_011_013_012_010_") > 0, '+
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) )   AS VENAVI, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND LOCATE(DET_CODFPG, "001_002_006_011_013_012_010_") > 0, '+
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENAVIFRE, ';

  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND DET_CODFPG = "015", '+
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) )   AS VENAVI015, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND DET_CODFPG = "015", '+
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENAVIFRE015, ';

  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(IFNULL(DET_CODFPG, "008"), "001_008_013_014_015_010_") > 0  AND DET_CONPAG <> "01000", ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENPRA, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(IFNULL(DET_CODFPG, "008"), "001_008_013_014_015_010_") > 0  AND DET_CONPAG <> "01000", ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENPRAFRE, ';

  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND DET_CODFPG = "007", ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENCAR, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND DET_CODFPG = "007", ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENCARFRE, ';

  {*********************************************}
  {* PEGA OS VALORES DE DESPESAS ACESSÓRIAS.   *}
  {******************************************DO*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_DESACE), (DET_DESACE)), 0) ) AS VENDESACE, ';

  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO REFERENTE ENTREGA PELO CD.         *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND LOCATE(IFNULL(DET_CODFPG, "001"), "001_002_006_011_013_012_010_") > 0, ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) )   AS VENAVI_CD, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND DET_CODFPG = "015", ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) )   AS VENAVI_CD015, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(IFNULL(DET_CODFPG, "008"), "001_008_013_014_015_010_") > 0  AND DET_CONPAG <> "01000", DET_TOTITE - DET_DESESP - DET_DESCFF, 0) ) AS VENPRA_CD, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND DET_CODFPG = "007",  ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENCAR_CD, ';

  {********************************************************}
  {* PEGA OS VALORES DAS NOTAS FISCAIS A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO DA PROPRIA EMPRESA.                  *}
  {*****************************************************PZ*}
  {*******************************************************}
  {* NÃO RETIRAR ESSES CALCULOS. NÃO ESTÃO SENDO USADOS, *}
  {* MAS CASO O CLIENTE PEÇA NOVAMENTE JÁ ESTÁ PRONTO.   *}
  {* INICIO                                              *}
  {****************************************************PZ*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND LOCATE(DET_CODFPG, "001_011_013_") > 0, ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_ATU_AVI, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND DET_CODFPG = "015", ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) <> "01000", ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_ATU_PRZ, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LOCATE(DET_CODFPG, "002_006_") > 0, ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_ATU_CHE, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND DET_CODFPG = "007",  ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_ATU_CAR, ';

  {********************************************************}
  {* PEGA OS VALORES DAS NOTAS FISCAIS A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO REFERENTE A ENTREGA CD.              *}
  {*****************************************************PZ*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND LOCATE(DET_CODFPG, "001_011_013_") > 0, ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_CD_AVI,   ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000" AND DET_CODFPG = "015", ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_CD_AVI015, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) <> "01000", ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_CD_PRZ,   ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LOCATE(DET_CODFPG, "002_006_") > 0, ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_CD_CHE,   ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND DET_CODFPG = "007",   ' +
                           '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS NF_CD_CAR,   ';
  {***********************************}
  {* FIM                             *}
  {********************************PZ*}

  strClaVen := fRetStrToSQLIn(VS_strClaVen);
  If strClaVen.IsEmpty Then
    strClaVen := '""';

  strClaDev := fRetStrToSQLIn(VS_strClaDev);
  If strClaDev.IsEmpty Then
    strClaDev := '""';

  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_CAR,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_AVI,     ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_AVI015,  ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_PRZ,     ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_CHE,     ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_CAR      ';
  strSQLTmp := strSQLTmp + 'FROM     ';
  strSQLTmp := strSQLTmp + '  MOVDET ';
  strSQLTmp := strSQLTmp + 'WHERE    ';
  strSQLTmp := strSQLTmp + '  (DET_CODFPG IS NULL OR DET_CODFPG <> "009") AND ';
  strSQLTmp := strSQLTmp + '  DET_ESPDOC IN ("NF", "EL", "IF", "NA", "IA", "NS") AND   ';
  strSQLTmp := strSQLTmp + '  DET_PROEMB <> "S" AND                  ';
  strSQLTmp := strSQLTmp + '  DET_CODEMP = :CODEMP AND               ';

  strSQLTmp := strSQLTmp + '  DET_TIP_FC = "C"  AND ';
  strSQLTmp := strSQLTmp + '  DET_CODCLI NOT IN (' + fLisCliFil + ') AND ';

  strSQLTmp := strSQLTmp + '  ((DET_CLAFIS IN (' + strClaVen + ') ) OR ';
  strSQLTmp := strSQLTmp + '   (DET_CLAFIS IN (' + strClaDev + ') )';

  If FEntraBrindeFaturamento Then
    strSQLTmp := strSQLTmp + '  OR (DET_ESPDOC = "BR")) AND '
  Else
    strSQLTmp := strSQLTmp + '  ) AND ';

  strSQLTmp := strSQLTmp + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQLTmp + ' UNION ALL ';

  strSQLTmp := ' SELECT ';

  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO DA PRÓPRIA EMPRESA.                *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(IFNULL(DET_CODFPG, "001"), "001_002_006_011_013_012_010_") > 0 AND LEFT(DET_CONPAG,5) = "01000", ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENAVI, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_CODFPG, "001_002_006_011_013_012_010_") > 0 AND LEFT(DET_CONPAG,5) = "01000", ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENAVIFRE, ';

  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CODFPG = "015" AND LEFT(DET_CONPAG,5) = "01000", ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENAVI015, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CODFPG = "015" AND LEFT(DET_CONPAG,5) = "01000", ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENAVIFRE015, ';

  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_CODFPG, "001_008_013_014_015_010_") > 0 AND DET_CONPAG <> "01000", ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENPRA, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_CODFPG, "001_008_013_014_015_010_") > 0 AND DET_CONPAG <> "01000", ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENPRAFRE, ';

  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CODFPG = "007", IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENCAR, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CODFPG = "007", IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTFRE), (DET_TOTFRE)), 0) ) AS VENCARFRE, ';

  {*********************************************}
  {* PEGA OS VALORES DE DESPESAS ACESSÓRIAS.   *}
  {******************************************DO*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), ' +
                           '       IF(LEFT(DET_CLAFIS,1) < 5, -(DET_DESACE), (DET_DESACE)), 0) ) AS VENDESACE, ';

  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO REFERENTE ENTREGA PELO CD.         *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(IFNULL(DET_CODFPG, "001"), "001_002_006_011_013_012_010_") > 0 AND LEFT(DET_CONPAG,5) = "01000", ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENAVI_CD, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND DET_CODFPG = "015" AND LEFT(DET_CONPAG,5) = "01000", ';
  strSQLTmp := strSQLTmp + '       IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENAVI_CD015, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_CODFPG, "001_008_013_014_015_010_") > 0 AND DET_CONPAG <> "01000", DET_TOTITE - DET_DESESP - DET_DESCFF, 0) ) AS VENPRA_CD, ';
  strSQLTmp := strSQLTmp + '  SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND DET_CODFPG = "007", IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VENCAR_CD, ';

  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_CAR,    ';

  strSQLTmp := strSQLTmp + ' 0.00 AS NF_CD_AVI,    ';
  strSQLTmp := strSQLTmp + ' 0.00 AS NF_CD_AVI015, ';
  strSQLTmp := strSQLTmp + ' 0.00 AS NF_CD_PRZ,    ';
  strSQLTmp := strSQLTmp + ' 0.00 AS NF_CD_CHE,    ';
  strSQLTmp := strSQLTmp + ' 0.00 AS NF_CD_CAR,    ';

  {*******************************************************}
  {* NÃO RETIRAR ESSES CALCULOS. NÃO ESTÃO SENDO USADOS, *}
  {* MAS CASO O CLIENTE PEÇA NOVAMENTE JÁ ESTÁ PRONTO.   *}
  {* INICIO                                              *}
  {****************************************************PZ*}
  {*************************************************************}
  {* PEGA OS VALORES DE DOCUMENTOS DE VENDA A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO DA PROPRIA EMPRESA.                       *}
  {**********************************************************PZ*}
  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) =  "01000" AND LOCATE(DET_CODFPG, "001_011_013_") > 0, ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_ATU_AVI, ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) =  "01000" AND DET_CODFPG = "015", ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_ATU_AVI015, ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) <> "01000",   ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_ATU_PRZ, ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_CODFPG, "002_006_") > 0, ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_ATU_CHE, ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CODFPG = "007", ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_ATU_CAR, ';

  {*************************************************************}
  {* PEGA OS VALORES DE DOCUMENTOS DE VENDA A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO REFERENTE ENTREGA CD.                     *}
  {**********************************************************PZ*}

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LEFT(DET_CONPAG,5) =  "01000") AND (LOCATE(DET_CODFPG, "001_011_013_") > 0) AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP),   ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_CD_AVI,  ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LEFT(DET_CONPAG,5) =  "01000") AND (DET_CODFPG = "015") AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP),   ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_CD_AVI015,  ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LEFT(DET_CONPAG,5) <> "01000") AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP),    ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_CD_PRZ,  ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LOCATE(DET_CODFPG, "002_006_") > 0) AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_CD_CHE,   ';

  strSQLTmp := strSQLTmp + ' SUM( IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (DET_CODFPG = "007") AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ';
  strSQLTmp := strSQLTmp + '      IF( LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) ) AS VE_CD_CAR    ';
  {***********************************}
  {* FIM                             *}
  {********************************PZ*}
  strSQLTmp := strSQLTmp + 'FROM    ';
  strSQLTmp := strSQLTmp + ' MOVDET ';
  strSQLTmp := strSQLTmp + ' INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  strSQLTmp := strSQLTmp + 'WHERE    ';
  strSQLTmp := strSQLTmp + ' DET_CODFPG <> "009" AND ';
  strSQLTmp := strSQLTmp + ' DET_ESPDOC IN ("FF", "MI", "TR") AND ';
  strSQLTmp := strSQLTmp + ' DET_CODEMP = :CODEMP AND                ';
  strSQLTmp := strSQLTmp + ' DET_PROEMB <> "S" AND                   ';

  strSQLTmp := strSQLTmp + ' DET_TIP_FC = "C"  AND ';
  strSQLTmp := strSQLTmp + ' DET_CODCLI NOT IN (' + fLisCliFil + ') AND ';

  strSQLTmp := strSQLTmp + cnsFiltroFFDVTR;

  strSQLTmp := strSQLTmp + ' ((DET_CLAFIS IN (' + strClaVen + ') ) OR ';
  strSQLTmp := strSQLTmp + '  (DET_CLAFIS IN (' + strClaDev + ') )';

  If FEntraBrindeFaturamento Then
    strSQLTmp := strSQLTmp + ' OR (DET_ESPDOC = "BR")) AND '
  Else
  strSQLTmp := strSQLTmp + ' ) AND ';

  strSQLTmp := strSQLTmp + ' DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

  strSQLTmp := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLTmp,[],[],['FF','TR']);

  {********************}
  {* UNION COM MOVMOD *}
  {*****************AF*}
  strSQL := strSQL + strSQLTmp + ' UNION ALL ';

  strSQLTmp := ' SELECT ';
  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO DA PRÓPRIA EMPRESA.                *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(IFNULL(MOD_CODMOD, "001"), "001_002_006_011_013_012_010_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(LOCATE(IFNULL(MOD_CODMOD, "001"), "001_002_006_011_013_012_010_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENAVIFRE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENAVIFRE015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CONPAG <> "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_008_013_014_015_010_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENPRA, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CONPAG <> "01000", SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_008_013_014_015_010_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENPRAFRE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0, ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IF(IFNULL(MOD_VALMOD, 0)=0,DET_TOTITE- DET_DESESP - DET_DESCFF,MOD_VALMOD), 0)) ') + ', 0) AS VENCAR, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0, SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IF(IFNULL(MOD_VALMOD, 0)=0,DET_TOTITE- DET_DESESP - DET_DESCFF,MOD_VALMOD), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENCARFRE, ';

  {*********************************************}
  {* PEGA OS VALORES DE DESPESAS ACESSÓRIAS.   *}
  {******************************************DO*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_DESACE), (DET_DESACE))), 0) AS VENDESACE, ';

  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO REFERENTE ENTREGA PELO CD.         *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(IFNULL(MOD_CODMOD, "001"), "001_002_006_011_013_012_010_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI_CD, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI_CD015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND DET_CONPAG <> "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_008_013_014_015_010_") > 0  , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENPRA_CD, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0, ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IF(IFNULL(MOD_VALMOD, 0)=0,DET_TOTITE- DET_DESESP - DET_DESCFF,MOD_VALMOD), 0)) ') + ', 0) AS VENCAR_CD, ';

  {********************************************************}
  {* PEGA OS VALORES DAS NOTAS FISCAIS A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO DA PROPRIA EMPRESA.                  *}
  {*****************************************************PZ*}
  {*******************************************************}
  {* NÃO RETIRAR ESSES CALCULOS. NÃO ESTÃO SENDO USADOS, *}
  {* MAS CASO O CLIENTE PEÇA NOVAMENTE JÁ ESTÁ PRONTO.   *}
  {* INICIO                                              *}
  {****************************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_011_013)") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_ATU_AVI, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) <> "01000", ' + fRetSQLMovMod(' SUM(IFNULL(MOD_VALMOD, 0)) ') + ', 0) AS NF_ATU_PRZ, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0, ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "002_006_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_ATU_CHE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0, ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_ATU_CAR, ';

  {********************************************************}
  {* PEGA OS VALORES DAS NOTAS FISCAIS A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO REFERENTE A ENTREGA CD.              *}
  {*****************************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_011_013_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_CD_AVI, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_CD_AVI015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0 AND LEFT(DET_CONPAG,5) <> "01000", ' + fRetSQLMovMod(' SUM(IFNULL(MOD_VALMOD, 0)) ') + ', 0) AS NF_CD_PRZ,   ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0, ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "002_006_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_CD_CHE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND LOCATE(DET_ESPDOC, "NF_EL_NS") > 0, ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS NF_CD_CAR, ';

  {***********************************}
  {* FIM                             *}
  {********************************PZ*}
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_CAR,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_AVI,     ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_AVI015,  ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_PRZ,     ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_CHE,     ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_CAR      ';
  strSQLTmp := strSQLTmp + 'FROM     ';
  strSQLTmp := strSQLTmp + '  MOVDET ';
  strSQLTmp := strSQLTmp + 'WHERE    ';
  strSQLTmp := strSQLTmp + '  DET_CODFPG = "009" AND                  ';
  strSQLTmp := strSQLTmp + '  LOCATE(DET_ESPDOC, "NF_EL_IF_NA_IA_NS") > 0 AND   ';
  strSQLTmp := strSQLTmp + '  DET_PROEMB <> "S" AND                  ';
  strSQLTmp := strSQLTmp + '  DET_CODEMP = :CODEMP AND               ';

  strSQLTmp := strSQLTmp + '  DET_TIP_FC = "C"  AND ';
  strSQLTmp := strSQLTmp + '  DET_CODCLI NOT IN (' + fLisCliFil + ') AND ';

  strSQLTmp := strSQLTmp + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

  If FEntraBrindeFaturamento Then
    strSQLTmp := strSQLTmp + '  OR (DET_ESPDOC = "BR")) AND '
  Else
    strSQLTmp := strSQLTmp + '  ) AND ';

  strSQLTmp := strSQLTmp + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQLTmp := strSQLTmp + 'GROUP BY ';
  strSQLTmp := strSQLTmp + '  DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, DET_SERIE_ ';

  strSQL := strSQL + strSQLTmp + ' UNION ALL ';

  strSQLTmp := ' SELECT ';

  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO DA PRÓPRIA EMPRESA.                *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) = "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(IFNULL(MOD_CODMOD, "001"), "001_002_006_011_013_012_010_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) = "01000", SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(LOCATE(IFNULL(MOD_CODMOD, "001"), "001_002_006_011_013_012_010_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENAVIFRE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) = "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) = "01000", SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENAVIFRE015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CONPAG <> "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_008_013_014_015_010_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ')  + ', 0) AS VENPRA, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND DET_CONPAG <> "01000", SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_008_013_014_015_010_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ')  + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENPRAFRE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IF(IFNULL(MOD_VALMOD, 0)=0,DET_TOTITE- DET_DESESP - DET_DESCFF,MOD_VALMOD), 0)) ') + ', 0) AS VENCAR, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), SUM(DET_TOTFRE) / 100 * (' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IF(IFNULL(MOD_VALMOD, 0)=0,DET_TOTITE- DET_DESESP - DET_DESCFF,MOD_VALMOD), 0)) ') + ' / SUM(DET_VLRCON) * 100), 0.00) AS VENCARFRE, ';

  {*********************************************}
  {* PEGA OS VALORES DE DESPESAS ACESSÓRIAS.   *}
  {******************************************DO*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_DESACE), (DET_DESACE))), 0) AS VENDESACE, ';

  {*********************************************}
  {* PEGA OS VALORES DE VENDA A VISTA, PRAZO E *}
  {* CARTÃO REFERENTE ENTREGA PELO CD.         *}
  {******************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LEFT(DET_CONPAG,5) = "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(IFNULL(MOD_CODMOD, "001"), "001_002_006_011_013_012_010_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI_CD, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND LEFT(DET_CONPAG,5) = "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENAVI_CD015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP) AND DET_CONPAG <> "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_008_013_014_015_010_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VENPRA_CD, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IF(IFNULL(MOD_VALMOD, 0)=0,DET_TOTITE- DET_DESESP - DET_DESCFF,MOD_VALMOD), 0)) ') + ', 0) AS VENCAR_CD, ';

  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_CAR,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_CAR,    ';

  {*******************************************************}
  {* NÃO RETIRAR ESSES CALCULOS. NÃO ESTÃO SENDO USADOS, *}
  {* MAS CASO O CLIENTE PEÇA NOVAMENTE JÁ ESTÁ PRONTO.   *}
  {* INICIO                                              *}
  {****************************************************PZ*}
  {*************************************************************}
  {* PEGA OS VALORES DE DOCUMENTOS DE VENDA A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO DA PROPRIA EMPRESA.                       *}
  {**********************************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_011_013_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_ATU_AVI, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) =  "01000", ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)) AND LEFT(DET_CONPAG,5) <> "01000", ' + fRetSQLMovMod(' SUM(IFNULL(MOD_VALMOD, 0)) ') +  ', 0) AS VE_ATU_PRZ, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "002_006_") > 0, IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_ATU_CHE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") =  ""  OR  (DET_EMP_PD =  DET_CODEMP)), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_ATU_CAR, ';

  {*************************************************************}
  {* PEGA OS VALORES DE DOCUMENTOS DE VENDA A VISTA, FATURADO, *}
  {* CHEQUE E CARTÃO REFERENTE ENTREGA CD.                     *}
  {**********************************************************PZ*}
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LEFT(DET_CONPAG,5) =  "01000") AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "001_011_013_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_CD_AVI, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LEFT(DET_CONPAG,5) =  "01000") AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "015", IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_CD_AVI015, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (LEFT(DET_CONPAG,5) <> "01000") AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ' + fRetSQLMovMod(' SUM(IFNULL(MOD_VALMOD, 0)) ') + ', 0) AS VE_CD_PRZ, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ' + fRetSQLMovMod(' SUM(IF(LOCATE(MOD_CODMOD, "002_006_") > 0 , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_CD_CHE, ';
  strSQLTmp := strSQLTmp + '  IF((IFNULL(DET_NUM_PD, "") <> "") AND (DET_EMP_PD <> DET_CODEMP)  AND (IFNULL(GER_EMPORI,GER_CODEMP) <> GER_CODEMP), ' + fRetSQLMovMod(' SUM(IF(MOD_CODMOD = "007" , IFNULL(MOD_VALMOD, 0), 0)) ') + ', 0) AS VE_CD_CAR  ';
  {***********************************}
  {* FIM                             *}
  {********************************PZ*}
  strSQLTmp := strSQLTmp + 'FROM     ';
  strSQLTmp := strSQLTmp + '  MOVDET ';
  strSQLTmp := strSQLTmp + '  INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  strSQLTmp := strSQLTmp + 'WHERE    ';
  strSQLTmp := strSQLTmp + '  DET_CODFPG = "009" AND                  ';
  strSQLTmp := strSQLTmp + '  DET_ESPDOC IN ("FF", "MI", "TR") AND ';
  strSQLTmp := strSQLTmp + '  DET_CODEMP = :CODEMP AND                ';
  strSQLTmp := strSQLTmp + '  DET_PROEMB <> "S" AND                   ';

  strSQLTmp := strSQLTmp + '  DET_TIP_FC = "C"  AND ';
  strSQLTmp := strSQLTmp + '  DET_CODCLI NOT IN (' + fLisCliFil + ') AND ';

  strSQLTmp := strSQLTmp + cnsFiltroFFDVTR;

  strSQLTmp := strSQLTmp + '  ((DET_CLAFIS IN (' + strClaVen + ') ) OR ';
  strSQLTmp := strSQLTmp + '   (DET_CLAFIS IN (' + strClaDev + ') )';

  If FEntraBrindeFaturamento Then
    strSQLTmp := strSQLTmp + '  OR (DET_ESPDOC = "BR")) AND '
  Else
  strSQLTmp := strSQLTmp + '  ) AND ';

  strSQLTmp := strSQLTmp + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

  strSQLTmp := strSQLTmp + 'GROUP BY ';
  strSQLTmp := strSQLTmp + '  DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, DET_SERIE_ ';

  {****************************************************************************************************************************}
  {* SELECT PARA O CENÁRIO ****************************************************************************************************}
  {* > DUPLICATA FATURADA COM MODALIDADE FATURADA 009 (DET_CODFPG = 009), UMA DAS PARCELAS ESTÁ NA MOVMOD *********************}
  {*   COMO FORMA DE PAGAMENTO 007 REFERENTE A CARTÃO E QUE ESSA MESMA MODALIDADE ESTÁ ESTORNADA. *****************************}
  {* O SINAL DE NEGATIVO (-) NO MOD_VALMOD E O LEFT JOIN COM A CADRCXX É PQ ESSA MODALIDADE DE CARTÃO FOI ESTORNADA, OU SEJA, *}
  {* RCX_ESPDOC = 'LD' E O VALOR DA MODALIDE DEVE SER SUBTRAIDO. **************************************************************}
  {**REQ*109945*************************************************************************************************************MO*}
  strSQLTmp := strSQLTmp + ' UNION ALL ';
  strSQLTmp := strSQLTmp + '  SELECT ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENAVI    , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENAVIFRE , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENAVI015 , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENAVIFRE015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENPRA    , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENPRAFRE , ';
  strSQLTmp := strSQLTmp + '   IF((IFNULL(DET_NUM_PD, "") = "" OR (DET_EMP_PD = DET_CODEMP)) AND LOCATE(DET_ESPDOC, "NF_EL_IF_NS") > 0, ';
  strSQLTmp := strSQLTmp + '            (SELECT SUM(IF(MOD_CODMOD = "007", IFNULL(-MOD_VALMOD, 0), 0)) ';
  strSQLTmp := strSQLTmp + '             FROM MOVMOD ';
  strSQLTmp := strSQLTmp + '             WHERE MOD_NUMDOC = DET_NUMDOC AND ';
  strSQLTmp := strSQLTmp + '                   MOD_ESPDOC = DET_ESPDOC AND ';
  strSQLTmp := strSQLTmp + '                   MOD_CODEMP = DET_CODEMP AND ';
  strSQLTmp := strSQLTmp + '                   MOD_CODCLI = DET_CODCLI AND ';
  strSQLTmp := strSQLTmp + '                   IFNULL(MOD_SERIE_, "") = IFNULL(DET_SERIE_, "")), 0) AS VENCAR, ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENCARFRE , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENDESACE,  ';

  strSQLTmp := strSQLTmp + '  0.00 AS VENAVI_CD ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENAVI_CD015 , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENPRA_CD ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VENCAR_CD ,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_ATU_CAR,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_AVI ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_AVI015 , ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_PRZ ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_CHE ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS NF_CD_CAR ,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_AVI,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_AVI015, ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_PRZ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_CHE,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_ATU_CAR,    ';

  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_AVI ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_AVI015 , ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_PRZ ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_CHE ,    ';
  strSQLTmp := strSQLTmp + '  0.00 AS VE_CD_CAR      ';
  strSQLTmp := strSQLTmp + '  FROM MOVDET ';
  strSQLTmp := strSQLTmp + '  JOIN CADRCXX ON RCX_NUMDOC = DET_NUMDOC AND      ';
  strSQLTmp := strSQLTmp + '                  RCX_CODCLI = DET_CODCLI AND      ';
  strSQLTmp := strSQLTmp + '        RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQLTmp := strSQLTmp + '                       RCX_ESPDOC = "LD"           ';
  strSQLTmp := strSQLTmp + '  WHERE DET_CODFPG = "009" AND ';
  strSQLTmp := strSQLTmp + '        DET_ESPDOC IN ("NF", "EL", "IF", "NA", "IA", "NS") AND ';
  strSQLTmp := strSQLTmp + '        DET_PROEMB <> "S" AND ';
  strSQLTmp := strSQLTmp + '        DET_CODEMP = :CODEMP AND ';
  strSQLTmp := strSQLTmp + '        DET_TIP_FC = "C" AND ';
  strSQLTmp := strSQLTmp + '        DET_CODCLI NOT IN (' + fLisCliFil + ') AND ';
  strSQLTmp := strSQLTmp + '        ((DET_CLAFIS IN (' + strClaVen + ') ) OR ';
  strSQLTmp := strSQLTmp + '         (DET_CLAFIS IN (' + strClaDev + ') ) ';

  If FEntraBrindeFaturamento Then
    strSQLTmp := strSQLTmp + '  OR (DET_ESPDOC = "BR")) AND '
  Else
    strSQLTmp := strSQLTmp + '  ) AND ';

  strSQLTmp := strSQLTmp + '        DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    strSQLTmp := strSQLTmp + '  AND RCX_CODCAX = "'+edtCodigoCaixa.Text+'" ';

  strSQLTmp := strSQLTmp + '  GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, DET_SERIE_ ';

  strSQLTmp := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLTmp,[],[],['FF','TR']);

  strSQL := strSQL + strSQLTmp;

  With qryMovGer, SQL Do
  Begin
    Clear;
    Add (' SELECT                                    ');
    Add ('       SUM(VENAVI    ) AS VENAVI    ,      ');
    Add ('       SUM(VENAVIFRE ) AS VENAVIFRE ,      ');

    Add ('       SUM(VENAVI015 ) AS VENAVI015 ,      ');
    Add ('       SUM(VENAVIFRE015 ) AS VENAVIFRE015, ');

    Add ('       SUM(VENPRA    ) AS VENPRA    ,      ');
    Add ('       SUM(VENPRAFRE ) AS VENPRAFRE ,      ');

    Add ('       SUM(VENCAR    ) AS VENCAR    ,      ');
    Add ('       SUM(VENCARFRE ) AS VENCARFRE ,      ');
    Add ('       SUM(VENDESACE ) AS VENDESACE ,      ');

    Add ('       SUM(VENAVI_CD ) AS VENAVI_CD ,      ');
    Add ('       SUM(VENAVI_CD015 ) AS VENAVI_CD015, ');
    Add ('       SUM(VENPRA_CD ) AS VENPRA_CD ,      ');
    Add ('       SUM(VENCAR_CD ) AS VENCAR_CD ,      ');

    Add ('       SUM(NF_ATU_AVI) AS NF_ATU_AVI,      ');
    Add ('       SUM(NF_ATU_AVI015) AS NF_ATU_AVI015,');
    Add ('       SUM(NF_ATU_PRZ) AS NF_ATU_PRZ,      ');
    Add ('       SUM(NF_ATU_CHE) AS NF_ATU_CHE,      ');
    Add ('       SUM(NF_ATU_CAR) AS NF_ATU_CAR,      ');

    Add ('       SUM(NF_CD_AVI ) AS NF_CD_AVI ,      ');
    Add ('       SUM(NF_CD_AVI015 ) AS NF_CD_AVI015, ');
    Add ('       SUM(NF_CD_PRZ ) AS NF_CD_PRZ ,      ');
    Add ('       SUM(NF_CD_CHE ) AS NF_CD_CHE ,      ');
    Add ('       SUM(NF_CD_CAR ) AS NF_CD_CAR ,      ');

    Add ('       SUM(VE_ATU_AVI) AS VE_ATU_AVI,      ');
    Add ('       SUM(VE_ATU_AVI015) AS VE_ATU_AVI015,');
    Add ('       SUM(VE_ATU_PRZ) AS VE_ATU_PRZ,      ');
    Add ('       SUM(VE_ATU_CHE) AS VE_ATU_CHE,      ');
    Add ('       SUM(VE_ATU_CAR) AS VE_ATU_CAR,      ');

    Add ('       SUM(VE_CD_AVI ) AS VE_CD_AVI ,      ');
    Add ('       SUM(VE_CD_AVI015 ) AS VE_CD_AVI015, ');
    Add ('       SUM(VE_CD_PRZ ) AS VE_CD_PRZ ,      ');
    Add ('       SUM(VE_CD_CHE ) AS VE_CD_CHE ,      ');
    Add ('       SUM(VE_CD_CAR ) AS VE_CD_CAR        ');
    Add (' FROM ( ' + strSQL + ' ) AS VENDAS         ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    Open;

  End;

  cdsResFat.Close;
  cdsResFat.FieldDefs.Clear;

  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_VIS';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_VISFRE';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_VIS015';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_VISFRE015';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_FAT';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_FATFRE';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_CAR';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_CARFRE';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VD_DESACE';
    DataType := ftFloat;
  End;

  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PD_VIS';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PD_VIS015';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PD_FAT';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PD_CAR';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CD_VIS';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CD_VIS015';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CD_FAT';
    DataType := ftFloat;
  End;
  With cdsResFat.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CD_CAR';
    DataType := ftFloat;
  End;

  With cdsResFat Do
  Begin
    CreateDataSet;
    Append;
    FieldByName('VD_VIS').AsFloat       := qryMovGer.FieldByName('VENAVI').AsFloat;
    FieldByName('VD_VISFRE').AsFloat    := qryMovGer.FieldByName('VENAVIFRE').AsFloat;
    FieldByName('VD_VIS015').AsFloat    := qryMovGer.FieldByName('VENAVI015').AsFloat;
    FieldByName('VD_VISFRE015').AsFloat := qryMovGer.FieldByName('VENAVIFRE015').AsFloat;
    FieldByName('VD_FAT').AsFloat       := qryMovGer.FieldByName('VENPRA').AsFloat;
    FieldByName('VD_FATFRE').AsFloat    := qryMovGer.FieldByName('VENPRAFRE').AsFloat;
    FieldByName('VD_CAR').AsFloat       := qryMovGer.FieldByName('VENCAR').AsFloat;
    FieldByName('VD_CARFRE').AsFloat    := qryMovGer.FieldByName('VENCARFRE').AsFloat;
    FieldByName('VD_DESACE').AsFloat    := qryMovGer.FieldByName('VENDESACE').AsFloat;

    FieldByName('PD_VIS').AsFloat       := qryFatGor.FieldByName('PD_ATU_AVI').AsFloat;
    FieldByName('PD_VIS015').AsFloat    := qryFatGor.FieldByName('PD_ATU_AVI015').AsFloat;
    FieldByName('PD_FAT').AsFloat       := qryFatGor.FieldByName('PD_ATU_PRZ').AsFloat;
    FieldByName('PD_CAR').AsFloat       := qryFatGor.FieldByName('PD_ATU_CAR').AsFloat;

    FieldByName('CD_VIS').AsFloat       := qryMovGer.FieldByName('VENAVI_CD').AsFloat;
    FieldByName('CD_VIS015').AsFloat    := qryMovGer.FieldByName('VENAVI_CD015').AsFloat;
    FieldByName('CD_FAT').AsFloat       := qryMovGer.FieldByName('VENPRA_CD').AsFloat;
    FieldByName('CD_CAR').AsFloat       := qryMovGer.FieldByName('VENCAR_CD').AsFloat;

    Post;

  End;

  frxResFat.DataSet := cdsResFat;
end;

procedure TfrmRelRcxResumoCaixa.pProcessaDocumentos;
  Var
    frmAguarde: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fProcessaDocumentos;
    frmAguarde.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmAguarde);
end;

procedure TfrmRelRcxResumoCaixa.pCriaCdsDados(Var cdsDados: TUniClientDataSet);
Begin
  cdsDados := TUniClientDataSet.Create(Self);

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ESPDOC';
    DataType := ftString;
    Size     := 2;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDDOC';
    DataType := ftInteger;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VENDIA';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VENACU';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VENMED';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TICMED';
    DataType := ftFloat;
  End;
  cdsDados.CreateDataSet;

  cdsDados.IndexFieldNames := 'ESPDOC';
End;

procedure TfrmRelRcxResumoCaixa.pDetalhaPagamentos;
  Var
    strSQL   : String;
    strFiltro: String;
begin
  strFiltro := fFiltroPagamentos;

  If Not fEmptyStr(strFiltro) Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
    strSQL := strSQL + '   CTP_NUMDUP,                 ';
    strSQL := strSQL + '   CTP_PARCEL,                 ';
    strSQL := strSQL + '   CTP_CODEMP,                 ';
    strSQL := strSQL + '   CTP_SERIE_,                 ';
    strSQL := strSQL + '   CTP_HISBAI,                 ';
    strSQL := strSQL + '   CTP_CODFOR,                 ';
    strSQL := strSQL + '   CTP_VALORI,                 ';
    strSQL := strSQL + '   FOR_NOMFOR,                 ';
    strSQL := strSQL + '   CTP_HIST01                  ';
    strSQL := strSQL + ' FROM                          ';
    strSQL := strSQL + '   CADPAG,                     ';
    strSQL := strSQL + '   CADFOR                      ';
    strSQL := strSQL + ' WHERE                         ';
    strSQL := strSQL + '   (                           ';
    strSQL := strSQL + strFiltro                        ;
    strSQL := strSQL + '   )                           ';
    strSQL := strSQL + '   AND FOR_CODFOR = CTP_CODFOR ';

    With qryCadPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;
  End
  Else
    Exit;

end;

procedure TfrmRelRcxResumoCaixa.pMontaResumoVendas(cdsDados: TUniClientDataSet);
  Var
    strSQL   : String;
    strSQLDet: String;
    qryGenDet: TUniQuery;

    procedure pSetaParametros;
      Var
        dtaDtaIni: TDate;
    begin
      If StrToDate('01' + Copy(mskDtaFin.Text, 3, 8)) < StrToDate(mskDtaIni.Text) Then
        dtaDtaIni := StrToDate('01' + Copy(mskDtaFin.Text, 3, 8))
      Else
        dtaDtaIni := StrToDate(mskDtaIni.Text);

      pSetaParamMovDet(qryGenDet, dtaDtaIni, StrToDate(mskDtaFin.Text));
    end;

begin
  qryGenDet := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '   DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   SUM(IF(DET_CONPAG = "01000", IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF), 0)) AS AVIACU,  ';
  strSQL := strSQL + '   SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS TOTVEN, ';
  strSQL := strSQL + '   COUNT(DISTINCT MOVDET.DET_SEQGER) AS QTDDOC ';

  strSQL := strSQL + fSQLFromMovDet;

  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   DET_ESPDOC  ';

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  strSQLDet := strSQL;

  {*******************************************}
  {* PEGA O TOTAL A VISTA RESUMO (ACUMULADO) *}
  {****************************************JC*}
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE      ';
  strSQL := strSQL + '   ESPDOC,                ';
  strSQL := strSQL + '   SUM(AVIACU) AS AVIACU, ';
  strSQL := strSQL + '   SUM(TOTVEN) AS VENACU, ';
  strSQL := strSQL + '   SUM(QTDDOC) AS QTDDOC  ';
  strSQL := strSQL + ' FROM                     ';
  strSQL := strSQL + '   (' + strSQLDet + ') AS TMP_RESUMO  ';
  strSQL := strSQL + ' GROUP BY  ';
  strSQL := strSQL + '   ESPDOC  ';

  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    pSetaParametros;
    Open;

    fltAviAcu := 0;
    fltTotAcu := 0;
    fltQtdDoc := 0;

    First;
    While Not Eof Do
    Begin
      fltAviAcu := fltAviAcu + FieldByName('AVIACU').AsFloat;
      fltTotAcu := fltTotAcu + FieldByName('VENACU').AsFloat;
      fltQtdDoc := fltQtdDoc + FieldByName('QTDDOC').AsInteger;

      If cdsDados.Locate('ESPDOC', FieldByName('ESPDOC').AsString, []) Then
      Begin
        cdsDados.Edit;
      End Else
      Begin
        cdsDados.Insert;
        cdsDados.FieldByName('VENDIA').AsFloat  := 0;
      End;

      cdsDados.FieldByName('ESPDOC').AsString  := FieldByName('ESPDOC').AsString;
      cdsDados.FieldByName('VENACU').AsFloat   := FieldByName('VENACU').AsFloat;
      cdsDados.FieldByName('QTDDOC').AsInteger := FieldByName('QTDDOC').AsInteger;
      cdsDados.Post;

      Next;
    End;
  End;

  fltPrzAcu := fltTotAcu - fltAviAcu;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE              ';
  strSQL := strSQL + '   DISTINCT DET_DTAENT AS DTAENT  ';
  strSQL := strSQL + fSQLFromMovDet;

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  strSQLDet := strSQL;

  {*********************************************}
  {* PEGA A QUANTIDADE DE DIAS DE VENDA RESUMO *}
  {******************************************JC*}
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                ';
  strSQL := strSQL + '   COUNT(DISTINCT DTAENT) AS QTDDIA ';
  strSQL := strSQL + ' FROM (                             ';
  strSQL := strSQL + strSQLDet;
  strSQL := strSQL + ') AS TMP_RESUMO ';

  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    pSetaParametros;
    Open;

    fltQtdDia := FieldByName('QTDDIA').AsInteger;
  End;

  {***********************************************}
  {* CALCULA A VENDA MEDIA E O TICKET DA ESPECIE *}
  {********************************************JC*}
  cdsDados.First;

  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;

    If fltQtdDia > 0 Then
      cdsDados.FieldByName('VENMED').AsFloat := ( cdsDados.FieldByName('VENACU').AsFloat / fltQtdDia )
    Else
      cdsDados.FieldByName('VENMED').AsFloat := 0.0;

    If cdsDados.FieldByName('QTDDOC').AsInteger > 0 Then
      cdsDados.FieldByName('TICMED').AsFloat := ( cdsDados.FieldByName('VENACU').AsFloat / cdsDados.FieldByName('QTDDOC').AsInteger)
    Else
      cdsDados.FieldByName('TICMED').AsFloat := 0.0;

    cdsDados.Post;
    cdsDados.Next;
  End;

  FreeAndNil(qryGenDet);
end;

procedure TfrmRelRcxResumoCaixa.pMontaDetOutrosFpg;
  Var
    strSQL: String;
    intIndice: Integer;
  Const
    arrModalidades: Array[0..5] Of Array[0..1] Of String = (('DINHEIRO','RCX_DINREC'),('CHEQUE A VISTA','RCX_CHQAVI'),
                                                            ('CHEQUE PRE','RCX_CHQPRE'), ('ORDEM DE PAGAMENTO','RCX_ORDREC'),
                                                            ('CARTAO DE CREDITO','RCX_CARREC'), ('OUTROS','RCX_OUTROS'));
begin
  strSQL := '';

  For intIndice := 0 To 5 Do
  Begin
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  "' + arrModalidades[intIndice][0] + '" AS FORMA, ';
    strSQL := strSQL + '  RCX_DTACAD AS DATA,                              ';
    strSQL := strSQL + '  RCX_HORCAD AS HORA,                              ';
    strSQL := strSQL + '  RCX_ESPDOC AS ESPECIE,                           ';
    strSQL := strSQL + '  RCX_DESCRI AS DESCRICAO,                         ';
    strSQL := strSQL + '  RCX_ESPDOC AS ESPECIE,                           ';
    strSQL := strSQL + ' ' + arrModalidades[intIndice][1] + ' AS VALOR     ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADRCXX ';

    If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '   RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   RCX_ESPDOC NOT IN ("FC", "PG", "TF") AND ';
    strSQL := strSQL + '   IFNULL(RCX_IDEFEC,"") <> "S" AND ';
    strSQL := strSQL + '   ' + arrModalidades[intIndice][1] + ' < 0 ';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + '  AND RCX_CODOPE = :CODOPE ';

    If Not fEmptyStr(edtSeqFec.Text) Then
      strSQL := strSQL + '  AND RCX_SQFCRX = :SQFCRX ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + '  AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQL := strSQL + '  AND LOCATE(RCX_ESPDOC, :ESPDOC) > 0 ';

    strSQL := strSQL + ' UNION ALL ';
  End;

  strSQL := LeftStr(strSQL,Length(strSQL)-11);

  With qryDetORpg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      ParamByName('ESPDOC').AsString := mskEspecie.Text;

    If Not fEmptyStr(edtCodOpe.Text) Then
      ParamByName('CODOPE').AsString := edtCodOpe.Text;

    If Not fEmptyStr(edtSeqFec.Text) Then
      ParamByName('SQFCRX').AsInteger := StrToIntDef(edtSeqFec.Text, -1);

    Open;
  End;
end;

procedure TfrmRelRcxResumoCaixa.pMontaListaVendaPrazo;
  Var
    strSQL   : String;
    strTabela: String;

begin
  strTabela := 'MOVGER';

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                               ';
  strSQL := strSQL + '   GER_DTADOC,                                                     ';
  strSQL := strSQL + '   GER_NUMDOC,                                                     ';
  strSQL := strSQL + '   GER_ESPDOC,                                                     ';
  strSQL := strSQL + '   GER_CODEMP,                                                     ';
  strSQL := strSQL + '   CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '   GER_CODCLI,                                                     ';
  strSQL := strSQL + '   GER_CODVEN,                                                     ';
  strSQL := strSQL + '   GER_CONPAG,                                                     ';
  strSQL := strSQL + '   GER_VLRCON,                                                     ';
  strSQL := strSQL + '   ( ';
  strSQL := strSQL + '     IF ';
  strSQL := strSQL + '       ( ';
  strSQL := strSQL + '         CLI_NOMCLI LIKE "%CONSUMIDOR%", ';
  strSQL := strSQL + '         GER_NOMCON, ';
  strSQL := strSQL + '         CLI_NOMCLI ';
  strSQL := strSQL + '       ) ';
  strSQL := strSQL + '   ) AS CLI_NOMCLI ';
  strSQL := strSQL + ' FROM                                                              ';
  strSQL := strSQL + '   ' + strTabela                                                    ;
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI                     ';
  strSQL := strSQL + ' WHERE                                                             ';
  strSQL := strSQL + '   GER_CODEMP =  :CODEMP                    AND                    ';
  strSQL := strSQL + '   GER_CONPAG <> "01000"                    AND                    ';
  strSQL := strSQL + '   GER_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND                    ';
  strSQL := strSQL + '   LOCATE(GER_CLAFIS, :CLAFIS) > 0                                 ';
  strSQL := strSQL + ' ORDER BY GER_DTADOC, GER_CODEMP, GER_ESPDOC, GER_NUMDOC           ';

  With qryListPrz Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString  := VS_strCodEmp;
    ParamByName('DTAINI').AsDate  := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate  := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString:= VS_strClaVen;
    Open;
  End;

end;

procedure TfrmRelRcxResumoCaixa.pMontaResumoFpg;
  Var
    strSQL: String;
    intIndice: Integer;

    function fRetValor(strChave: String): String;
    Begin
           If strChave = 'RCX_DINREC' Then Result := FloatToStr(fltDinIni)
      Else If strChave = 'RCX_CHQAVI' Then Result := FloatToStr(fltChaIni)
      Else If strChave = 'RCX_CHQPRE' Then Result := FloatToStr(fltChpIni)
      Else If strChave = 'RCX_ORDREC' Then Result := FloatToStr(fltOrdIni)
      Else If strChave = 'RCX_CARREC' Then Result := FloatToStr(fltCarIni)
      Else If strChave = 'RCX_OUTROS' Then Result := '0.00';
    End;
  Const
    arrModalidades: Array[0..5] Of Array[0..1] Of String = (('DINHEIRO','RCX_DINREC'),('CHEQUE A VISTA','RCX_CHQAVI'),
                                                            ('CHEQUE PRE','RCX_CHQPRE'), ('ORDEM DE PAGAMENTO','RCX_ORDREC'),
                                                            ('CARTAO DE CREDITO','RCX_CARREC'), ('OUTROS','RCX_OUTROS'));
begin
  strSQL := '';

  For intIndice := 0 To 5 Do
  Begin
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  "' + arrModalidades[intIndice][0] + '" AS FORMA, ';
    strSQL := strSQL + '  (' + AnsiReplaceStr(fRetValor(arrModalidades[intIndice][1]) + ' + ' + IIF(intIndice = 0, FloatToStr(fltSalInF), '0.00'),',','.') + ') AS VALINI, ';

    strSQL := strSQL + '  SUM( ';
    strSQL := strSQL + '  IF(IFNULL(REC.CTR_DTACAD = REC.CTR_DTAVEN, FALSE) AND ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ' <> 0 AND RCX_ESPDOC <> "PG" AND RCX_ESPDOC <> "TF", ';
    strSQL := strSQL + '  IF(' + arrModalidades[intIndice][1] + ' < 0, 0, ' + arrModalidades[intIndice][1] + ' )' + ', 0) ) AS VENAVI, ';

    strSQL := strSQL + '  SUM( ';
    strSQL := strSQL + '  IF(IFNULL(REC.CTR_DTACAD <> REC.CTR_DTAVEN, FALSE) AND ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ' <> 0 AND RCX_ESPDOC <> "PG" AND RCX_ESPDOC <> "TF", ';
    strSQL := strSQL + '  IF(' + arrModalidades[intIndice][1] + ' < 0, 0, ' + arrModalidades[intIndice][1] + ' )' + ', 0) ) AS VENPRA, ';

    strSQL := strSQL + '  SUM( ';
    strSQL := strSQL + '  IF(REC.CTR_DTACAD IS NULL AND ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ' <> 0 AND ' + arrModalidades[intIndice][1] + ' > 0  AND RCX_ESPDOC <> "PG" AND RCX_ESPDOC <> "TF", ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ', 0) ) AS OUTREC, ';

    strSQL := strSQL + '  SUM( ';
    strSQL := strSQL + '  IF(RCX_ESPDOC = "PG" AND ' + arrModalidades[intIndice][1] + ' <> 0, ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ', 0) ) AS PAGAME, ';

    strSQL := strSQL + '  SUM( ';
    strSQL := strSQL + '  IF(RCX_ESPDOC = "TF" AND ' + arrModalidades[intIndice][1] + ' <> 0, ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ', 0) ) AS TRANSF, ';

    strSQL := strSQL + '  SUM( ';
    strSQL := strSQL + '  IF(' + arrModalidades[intIndice][1] + ' < 0 AND RCX_ESPDOC <> "PG" AND RCX_ESPDOC <> "TF", ';
    strSQL := strSQL +    arrModalidades[intIndice][1] + ', 0) ) AS OUTROS, ';

    If intIndice = 0 Then
      strSQL := strSQL + '  SUM(RCX_VALCRE) AS VALCRE '
    Else
      strSQL := strSQL + '  0 AS VALCRE ';

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADRCXX ';
    strSQL := strSQL + '   LEFT JOIN CADREC REC ON REC.CTR_NUMDUP = RCX_NUMDOC AND ';
    strSQL := strSQL + '                           REC.CTR_ESPDOC = RCX_ESPDOC AND ';
    strSQL := strSQL + '                           REC.CTR_CODEMP = RCX_EMPDUP AND ';
    strSQL := strSQL + '                           REC.CTR_PARCEL = RCX_PARCEL AND ';
    strSQL := strSQL + '                           REC.CTR_CODCLI = RCX_CODCLI AND ';
    strSQL := strSQL + '                           REC.CTR_SEQBAI = RCX_SEQBAI AND ';
    strSQL := strSQL + '                           REC.CTR_SEQCON = RCX_SEQCON     ';

    If Not fEmptyStr(edtGruGpo.Text) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(edtGruGpo.Text);

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '   RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   RCX_ESPDOC <> "FC" AND ';
    strSQL := strSQL + '   (RCX_IDEFEC IS NULL OR RCX_IDEFEC <> "S") ';

    If Not fEmptyStr(edtCodOpe.Text) Then
      strSQL := strSQL + '  AND RCX_CODOPE = :CODOPE ';

    If Not fEmptyStr(edtSeqFec.Text) Then
      strSQL := strSQL + '  AND RCX_SQFCRX = :SQFCRX ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
      strSQL := strSQL + '  AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      strSQL := strSQL + '  AND LOCATE(RCX_ESPDOC, :ESPDOC) > 0 ';

    strSQL := strSQL + ' UNION ALL ';
  End;

  strSQL := LeftStr(strSQL,Length(strSQL)-11);

  With qryResFpg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      ParamByName('ESPDOC').AsString := mskEspecie.Text;

    If Not fEmptyStr(edtCodOpe.Text) Then
      ParamByName('CODOPE').AsString := edtCodOpe.Text;

    If Not fEmptyStr(edtSeqFec.Text) Then
      ParamByName('SQFCRX').AsInteger := StrToIntDef(edtSeqFec.Text, -1);

    Open;
  End;
end;

procedure TfrmRelRcxResumoCaixa.pMontaVendas(cdsDados: TUniClientDataSet; blnPrazo: Boolean);

  function fWhere: String;
  begin
    Result := '';
    Result := Result + ' WHERE ';
    Result := Result + cnsFiltroFFDVTR;
    Result := Result + '  ' + fSQLFiltroEmpresa + ' = :CODEMP ';
    If (blnPrazo) Then
      Result := Result + '  AND DET_CONPAG <> "01000" '
    Else
      Result := Result + '  AND DET_CONPAG = "01000" ';
    Result := Result + '    AND DET_ESPDOC NOT IN ("TR", "DV") ';
    Result := Result + '    AND (LEFT(DET_CLAFIS,1) >= 5) ';
    Result := Result + '    AND DET_PROEMB <> "S" ';
    Result := Result + '    AND DET_TIP_FC = "C" ';
    Result := Result + '    AND DET_CODCLI NOT IN (' + fLisCliFil + ') ';
    Result := Result + '    AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    Result := Result + '    AND DET_ESPDOC NOT IN ("FF") ';

    Result := Result + '    AND (((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

    If FEntraBrindeFaturamento Then
      Result := Result + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      Result := Result + ') ';
  end;

  Var
    strSQL    : String;
    strHeader : String;
    strFooter : String;
    qryMovDet : TUniQuery;
    qryMovMod : TUniQuery;
    fltSomVal : Double;
    fltDifere : Double;
begin
  qryMovDet := fCriaQuery(Self);
  qryMovMod := fCriaQuery(Self);

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '        DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, ';
    strSQL := strSQL + '   SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) >= 5, ';
    strSQL := strSQL + '           DET_TOTITE - DET_DESESP - DET_DESCFF,  ';
    strSQL := strSQL + '         -(DET_TOTITE - DET_DESESP - DET_DESCFF)))) AS DET_VALMOD, ';
    strSQL := strSQL + '   (SELECT CONCAT(MOD_CODMOD, "-", FPG_DESCRI) AS DESCRI FROM MOVMOD ';
    strSQL := strSQL + '      LEFT JOIN CADFPG ON MOD_CODMOD = FPG_CODIGO ';
    strSQL := strSQL + '    WHERE MOD_NUMDOC = DET_NUMDOC ';
    strSQL := strSQL + '      AND MOD_ESPDOC = DET_ESPDOC ';
    strSQL := strSQL + '      AND MOD_CODEMP = DET_CODEMP ';
    strSQL := strSQL + '      AND MOD_CODCLI = DET_CODCLI LIMIT 1 ) AS MOD_DESCRI, ';
    strSQL := strSQL + '   (SELECT IFNULL(SUM(MOD_VALMOD),0) AS MOD_VALMOD FROM MOVMOD ';
    strSQL := strSQL + '    WHERE MOD_NUMDOC = DET_NUMDOC ';
    strSQL := strSQL + '      AND MOD_ESPDOC = DET_ESPDOC ';
    strSQL := strSQL + '      AND MOD_CODEMP = DET_CODEMP ';
    strSQL := strSQL + '      AND MOD_CODCLI = DET_CODCLI ) AS MOD_VALMOD, ';
    strSQL := strSQL + '   (SELECT COUNT(*) FROM MOVMOD ';
    strSQL := strSQL + '    WHERE MOD_NUMDOC = DET_NUMDOC ';
    strSQL := strSQL + '      AND MOD_ESPDOC = DET_ESPDOC ';
    strSQL := strSQL + '      AND MOD_CODEMP = DET_CODEMP ';
    strSQL := strSQL + '      AND MOD_CODCLI = DET_CODCLI ) AS MOD_QTDMOD ';
    strSQL := strSQL + '   FROM MOVDET ';
    strSQL := strSQL + ' LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + fWhere;
    strSQL := strSQL + '  GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI ';

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL,[],[],['FF']);

    strHeader := ' SELECT IFNULL(MOD_DESCRI,"(SEM MODALIDADE)") AS MOD_DESCRI, SUM(DET_VALMOD) AS DET_VALMOD FROM (';
    strFooter := ') AS TAB WHERE MOD_QTDMOD <= 1 GROUP BY MOD_DESCRI ';

    With qryMovDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strHeader + strSQL + strFooter);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
         (Params.FindParam('ESPDOC') <> Nil) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;
      Open;
    End;

    qryMovDet.First;
    While Not qryMovDet.Eof Do
    Begin
      pGravaModalidade(cdsDados,
                       qryMovDet.FieldByName('MOD_DESCRI').AsString,
                       qryMovDet.FieldByName('DET_VALMOD').AsFloat);
      qryMovDet.Next;
    End;

    qryMovDet.Close;
    strHeader := ' SELECT * FROM (';
    strFooter := ') AS TAB WHERE MOD_QTDMOD > 1 ';

    With qryMovDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strHeader + strSQL + strFooter);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
         (Params.FindParam('ESPDOC') <> Nil) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;
      Open;
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   DISTINCT MOVMOD.AUTOINCREM, ';
    strSQL := strSQL + '   MOD_CODMOD, MOD_NUMDOC, MOD_ESPDOC, MOD_CODEMP, MOD_CODCLI, ';
    strSQL := strSQL + '   CONCAT(MOD_CODMOD, "-", FPG_DESCRI) AS DESCRI, ';
    strSQL := strSQL + '   MOD_VALMOD AS VALMOD ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '  MOVDET  ';
    strSQL := strSQL + ' LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + '  INNER JOIN MOVMOD ON MOD_NUMDOC = DET_NUMDOC ';
    strSQL := strSQL + '                   AND MOD_ESPDOC = DET_ESPDOC ';
    strSQL := strSQL + '                   AND MOD_CODEMP = DET_CODEMP ';
    strSQL := strSQL + '                   AND MOD_CODCLI = DET_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADFPG ON MOD_CODMOD = FPG_CODIGO ';
    strSQL := strSQL + fWhere;

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL,[],[],['FF']);

    With qryMovMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
         (Params.FindParam('ESPDOC') <> Nil) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;
      Open;
    End;

    pInformacao('Aguarde, Efetuando cálculos...', prbProgesso);
    pProgresso(0, qryMovDet.RecordCount, prbProgesso);
    qryMovDet.First;
    While Not qryMovDet.Eof Do
    Begin
      pInformacao('Aguarde, Efetuando cálculos...', prbProgesso);
      pProgresso(qryMovDet.RecNo, qryMovDet.RecordCount, prbProgesso);

      qryMovMod.Filtered := False;
      qryMovMod.Filter := 'MOD_NUMDOC = ' + QuotedStr(qryMovDet.FieldByName('DET_NUMDOC').AsString) +
                     ' AND MOD_ESPDOC = ' + QuotedStr(qryMovDet.FieldByName('DET_ESPDOC').AsString) +
                     ' AND MOD_CODEMP = ' + QuotedStr(qryMovDet.FieldByName('DET_CODEMP').AsString) +
                     ' AND MOD_CODCLI = ' + QuotedStr(qryMovDet.FieldByName('DET_CODCLI').AsString);

      qryMovMod.Filtered := True;

      If (Not qryMovMod.IsEmpty) Then
      Begin
        fltSomVal := 0;

        qryMovMod.First;
        While Not qryMovMod.Eof Do
        Begin
          fltSomVal := fltSomVal + qryMovMod.FieldByName('VALMOD').AsFloat;
          qryMovMod.Next;
        End;

        fltDifere := fFormataFloat(qryMovDet.FieldByName('DET_VALMOD').AsFloat, 2) - fFormataFloat(fltSomVal, 2);

        qryMovMod.First;
        While Not qryMovMod.Eof Do
        Begin
          If fFormataFloat(fltDifere, 2) >= 0.00 Then
          Begin
            pGravaModalidade(cdsDados,
                             qryMovMod.FieldByName('DESCRI').AsString,
                             qryMovMod.FieldByName('VALMOD').AsFloat + fltDifere);
            fltDifere := 0;
          End
          Else
          Begin
            If Abs(fFormataFloat(fltDifere, 2)) <= fFormataFloat(qryMovMod.FieldByName('VALMOD').AsFloat,2) Then
            Begin
              pGravaModalidade(cdsDados,
                               qryMovMod.FieldByName('DESCRI').AsString,
                               qryMovMod.FieldByName('VALMOD').AsFloat + fltDifere);
              fltDifere := 0;
            End
            Else
              pGravaModalidade(cdsDados,
                               qryMovMod.FieldByName('DESCRI').AsString,
                               qryMovMod.FieldByName('VALMOD').AsFloat);
          End;

          qryMovMod.Next;
        End;
      End
      Else
      Begin
        pGravaModalidade(cdsDados,
                         '(SEM MODALIDADE)',
                         qryMovDet.FieldByName('DET_VALMOD').AsFloat);
      End;

      qryMovDet.Next;
    End;
    pProgresso(0, qryMovDet.RecordCount, prbProgesso);
    prbProgesso.Visible := False;
  Finally
    FreeAndNil(qryMovDet);
    FreeAndNil(qryMovMod);
  End;
end;

procedure TfrmRelRcxResumoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ((ActiveControl) = Nil) Or (SameText(ActiveControl.ClassName, 'TGroupButton')) Then
    SelectNext(ActiveControl, True, True);
  inherited;
end;

procedure TfrmRelRcxResumoCaixa.FormShow(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr('RRCXOF') Then
    rdgEmpresa.ItemIndex := fCfgSis('RRCXOF', varInteger)-1;

  chkTipRec.Visible := fCfgSis('MODRCX', VarString) = '2';

  chkCancelados.Visible := fCfgSis('EXVLFA', varBoolean);

  strTipoFechamento := fCfgSis('TPFCCX');

  Label3.Visible    := strTipoFechamento <> 'C';
  edtSeqFec.Visible := strTipoFechamento <> 'C';

  lblCaixa.Visible          := strTipoFechamento = 'C';
  edtCodigoCaixa.Visible    := strTipoFechamento = 'C';
  edtDescricaoCaixa.Visible := strTipoFechamento = 'C';

  If strTipoFechamento = 'C' Then
    fValidaCampos(edtCodigoCaixa, True);
end;

procedure TfrmRelRcxResumoCaixa.edtGruGpoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupo: TConsultasArray;
begin
  inherited;
  If fPesqGrupoOperador(Self, edtGruGpo, edtDesGpo, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(edtGruGpo, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRcxResumoCaixa.edtGruGpoExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtGruGpo.Text) Then
    edtDesGpo.Text := 'TODOS'
  Else
    edtDesGpo.Text := fRetNomCadGpo(edtGruGpo.Text);

  If fEmptyStr(edtDesGpo.Text) And (Not fEmptyStr(edtGruGpo.Text))  Then
  Begin
    fMensagem('','Código do grupo não encontrado.', ['&O K']);
    edtGruGpo.Clear;
    pSetFocus(edtGruGpo);
  End;

end;

procedure TfrmRelRcxResumoCaixa.chkRelAbastClick(Sender: TObject);
begin
  if chkRelAbast.Checked then
     chkRelAbast.Checked := TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed(veNaoValida, '', False);
end;

procedure TfrmRelRcxResumoCaixa.chkTipRecClick(Sender: TObject);
begin
  inherited;
  edtVisualizacao.Enabled := Not chkTipRec.Checked;
  If Not edtVisualizacao.Enabled Then
    edtVisualizacao.Text := 'E';

end;

procedure TfrmRelRcxResumoCaixa.edtCodigoCaixaKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrCaixa: TConsultasArray;
begin
  inherited;
  if fPesqCaixas(Self, edtCodigoCaixa, edtDescricaoCaixa, nil, Key, arrCaixa, True, VS_strCodEmp) then
  Begin
    If fValidaCampos(edtCodigoCaixa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRcxResumoCaixa.edtCodOpeChange(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodOpe.Text) Then
  Begin
    edtDesGpo.Text := 'TODOS';
    edtGruGpo.Clear;
    edtGruGpo.Enabled := False;
  End
  Else
    edtGruGpo.Enabled := True;

end;

procedure TfrmRelRcxResumoCaixa.edtGruGpoChange(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtGruGpo.Text) Then
  Begin
    edtDesOperador.Text := 'TODOS';
    edtCodOpe.Clear;
    edtCodOpe.Enabled := False;
  End
  Else
    edtCodOpe.Enabled := True;

end;

procedure TfrmRelRcxResumoCaixa.pGravaModalidade(cdsDados: TUniClientDataSet;
  strModali: String; fltValMod: Double);
begin
  If Not cdsDados.FindKey([strModali]) Then
  Begin
    cdsDados.Insert;
    cdsDados.FieldByName('DESFPG').AsString := strModali;
    cdsDados.FieldByName('VALFPG').AsFloat  := 0;
  End
  Else
    cdsDados.Edit;

  cdsDados.FieldByName('VALFPG').AsFloat  := cdsDados.FieldByName('VALFPG').AsFloat + fltValMod;
  cdsDados.Post;
end;

function TfrmRelRcxResumoCaixa.fLisCliFil: string;
begin
  Result := IfEmptyStr(VS_strCliFil, '""');
end;

end.

