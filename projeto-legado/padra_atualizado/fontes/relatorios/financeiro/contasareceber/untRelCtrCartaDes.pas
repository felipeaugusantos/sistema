unit untRelCtrCartaDes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, RLFilters, RLDraftFilter,
  AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel, ExtCtrls, BitBtnLockedIncrem,
  Buttons, DBCtrls, DBLookupComboBoxFocus, CurrencyEditFocus, Mask, MaskEditFocus,
  UniDataSetProvider, Uni, DB, UniClientDataSet, StrUtils,
  untIFuncoes, untFuncoesGenerica, MemDS, DBAccess, frxExportCSVTestabilidade,
  untICamposUso, TypesRel, untIFuncMacro, Math, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmRelCtrCartaDes = class(TfrmPaiRelatorio)
    lbl3: TLabel;
    lblDesDtaIni: TLabel;
    lbl4: TLabel;
    lblDesDtaFin: TLabel;
    lbl5: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lbl9: TLabel;
    cbbModelo: TDBLookupComboBoxFocus;
    gpbgrp1: TGroupBox;
    lbl2: TLabel;
    chkImpEti: TCheckBox;
    edtQtdEti: TEditFocus;
    pnlEndere: TPanel;
    rdbEndCob: TRadioButton;
    rdbEndFat: TRadioButton;
    pnlTipImp: TPanel;
    rdbImpLas: TRadioButton;
    rdbImpMat: TRadioButton;
    shpLiberado: TShape;
    qryModelos: TUniQuery;
    qryEmpresa: TUniQuery;
    dtsModelos: TDataSource;
    cdsModelosCAR_CODCAR: TStringField;
    cdsModelosCAR_NOMCAR: TStringField;
    cdsModelosCAR_PATCAR: TStringField;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure cbbModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure chkImpEtiClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    cdsRelato: TUniClientDataSet;
    dspRelato: TUniDataSetProvider;

    cpuCampos   : ICamposUso;
    objFuncMacro: IFuncMacro;
    strArqTxt   : String;

    strNomImp, strNomPro, strDesPro: String;
    intColAtu: Integer;
    arrLinEti: Array Of String;
    FPais    : TPais;

    qryRelatorio: TUniQuery;

    function fGeraCartaDespesas(): Boolean;
    function fRetornaPathModelo(strCodMod: String): String;
    function fChamaTelaSelecaoImp: Boolean;
    function fClienteSelecionado(strCodCli: String): Boolean;
    function fVirgulaPontoFloatStr(strValor: String): String;

    procedure pAgrupaPorCliente;
    procedure pImpEtiquetas;
    procedure pImpEtiquetasMatricial;
    function  fImprimeEtiquetaClienteLaser: Boolean;
    function  fRetAutoIncremCliente: String;

    procedure pAtualizaCamposUso;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;

    procedure pImpRegistro;
    procedure pImpArrLinhasEti;
    procedure pHabilitaCamposEtiquetas;

    procedure pCriaQryRelatorio;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses  untPai, untWord, untTypesSistema, untModulo, untClassPanelCx,untFuncoesSimples,
      untFuncoes, untCfgRel, untFuncoesRelatorios, untFuncoesConsulta, untConsultas,
      untPesqAux, untValorPorExtenso, untFuncoesEtiquetas, untFuncMacro;
{
uses untSelCtrExportaCobranca, untClassPanelCx, untIFuncoes, untFuncoesSimples,
     untConsultas, untFuncoes, untCfgRel, untPesqAux, untFuncoesConsulta; 
}  
{$R *.dfm}

procedure TfrmRelCtrCartaDes.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    fltJuros : Double;
    strImagem: String;
    strDirImg: String;
    intDiaAtr: Integer;
    blnConfir: Boolean;
begin
  fltJuros  := 0;
  strNomImp := '';
  strImagem := '';
  strDirImg := '';
  intDiaAtr := 0;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Screen.Cursor   := crHourGlass;
  Application.ProcessMessages;
  inherited;
  btnImprimir.Enabled := False;
  If blnImprime Then
  Begin

    Try

      cdsRelato := TUniClientDataSet.Create(Self);
      dspRelato := TUniDataSetProvider.Create(Self);
      cdsRelato.SetProvider(dspRelato);
      dspRelato.DataSet := qryRelatorio;

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '        CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC,"-",CTR_CODEMP) AS CTR_NUMDUP, ';
      strSQL := strSQL + '        1   AS QTDTIT, ';
      strSQL := strSQL + '        "S" AS MOSTRA, ';
      strSQL := strSQL + '        "M" AS MARDES, ';
      strSQL := strSQL + '        CTR_HIST02,    ';
      strSQL := strSQL + '        CTR_PARCEL,    ';
      strSQL := strSQL + '        CTR_ESPDOC,    ';
      strSQL := strSQL + '        CTR_DTAVEN,    ';
      strSQL := strSQL + '        CTR_VALORI,    ';
      strSQL := strSQL + '        (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)  - IFNULL(CTR_DESSUJ, 0)) AS CTR_VALDUP, ';

      {*******************************************}
      {* CALCULA JUROS SE HOUVER                 *}
      {****************************************AC*}
      If (Not (fltJuros = 0)) And (Not (intDiaAtr = 0)) Then
      Begin
        strSQL := strSQL + '        ROUND((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) + ((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) * (((' + fVirgulaPontoFloatStr(FloatToStr(fltJuros)) + ' * ' + IntToStr(intDiaAtr) + ') /30) /100)), 2) AS CTR_CORRIGIDO, ';
        strSQL := strSQL + '        ROUND(((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) * (((' + fVirgulaPontoFloatStr(FloatToStr(fltJuros)) + ' * ' + IntToStr(intDiaAtr) + ') /30) /100)), 2) AS CTR_JUROS, ';
      End
      Else If (Not (fltJuros = 0)) Then
      Begin
        strSQL := strSQL + '        ROUND((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) + ((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) * (((' + fVirgulaPontoFloatStr(FloatToStr(fltJuros)) + ' * IF(DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0)) /30) /100)), 2) AS CTR_CORRIGIDO, ';
        strSQL := strSQL + '        ROUND(((CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) * (((' + fVirgulaPontoFloatStr(FloatToStr(fltJuros)) + ' * IF(DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0)) /30) /100)), 2) AS CTR_JUROS, ';
      End
      Else
      Begin
        strSQL := strSQL + '        (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) AS CTR_CORRIGIDO, ';
        strSQL := strSQL + '        0.00 AS CTR_JUROS, ';
      End;

      If rdbEndCob.Checked Then
      Begin
        {*******************************************}
        {* DADOS PARA COBRANÇA                     *}
        {****************************************jb*}
        strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_ENDERE, CLI_ENDCOB) AS CLI_ENDERE, ';
        strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
        strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_C_E_P_, ';
        strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID) AS CID_NOMCID, ';
        strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS CID_ESTADO, ';
        strSQL := strSQL + '  CLI_ENDNUM, ';
        strSQL := strSQL + '  CLI_ENDCOM, ';
      End
      Else
      Begin
        strSQL := strSQL + '  CLI_ENDERE, ';
        strSQL := strSQL + '  CLI_BAIRRO, ';
        strSQL := strSQL + '  CLI_C_E_P_, ';
        strSQL := strSQL + '  CLI_ENDNUM, ';
        strSQL := strSQL + '  CLI_ENDCOM, ';
        strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID, ';
        strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO, ';
      End;

      strSQL := strSQL + '        CONCAT(CLI_CODREP, "-", OPE_NOMOPE) AS CLI_NOMREP, ';
      strSQL := strSQL + '        CONCAT(CTR_CODPOR, "-", POR_NOMPOR) AS POR_NOMPOR, ';
      strSQL := strSQL + '        CTR_CODCLI, ';
      strSQL := strSQL + '        CADCLI.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '        CLI_CODCLI, ';
      strSQL := strSQL + '        CLI_NOMCLI, ';
      strSQL := strSQL + '        CLI_C_G_C_, ';
      strSQL := strSQL + '        IF (DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0) AS DIAS_ATRASO, ';

      strSQL := strSQL + '        RIGHT(CTR_HIST02, 21) AS DUPORI, ';
      strSQL := strSQL + '        "2012-01-01"          AS VCTORI, ';
      strSQL := strSQL + '        "2012-01-01"          AS PGTORI, ';
      strSQL := strSQL + '        0.00                  AS VALORI, ';
      strSQL := strSQL + '        0.00                  AS JURORI, ';
      strSQL := strSQL + '        "CADREC"              AS TABELA  ';

      strSQL := strSQL + '   FROM CADREC      ';
      strSQL := strSQL + '     INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
      strSQL := strSQL + '     LEFT  JOIN CADCID D1 ON CLI_CODCID = D1.CID_CODCID ';
      strSQL := strSQL + '     LEFT  JOIN CADCID D2 ON CLI_CIDCOB = D2.CID_CODCID ';
      strSQL := strSQL + '     LEFT  JOIN CADPOR P  ON CTR_CODPOR = P.POR_CODPOR  ';
      strSQL := strSQL + '     LEFT  JOIN CADOPE R  ON CLI_CODREP = R.OPE_CODOPE  ';
      strSQL := strSQL + '  WHERE CTR_DTAREC IS NULL AND CTR_VALORI > 0 ';
      strSQL := strSQL + '    AND CTR_ESPDOC = ''DC'' ';
      //strSQL := strSQL + '    AND IF (DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) > 0, DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN), 0) > 0 ';
      strSQL := strSQL + '    AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM ';

      If (Not (intDiaAtr = 0)) Then
        strSQL := strSQL + '    AND DATEDIFF(' + fCurrentDate + ',CTR_DTAVEN) = :DIAS_ATRASO ';

      If (Not fEmptyStr(edtCodCli.Text)) Then
        strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        strSQL := strSQL + '    AND CTR_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '    AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := strSQL + ' ORDER BY CLI_CODCLI, CTR_DTAVEN, CTR_ESPDOC, CTR_NUMDUP ';

      With qryRelatorio Do
      Begin
      
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
      
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

        If (Not fEmptyStr(edtCodCli.Text)) Then
          ParamByName('CODCLI').AsString := edtCodCli.Text;

        If (Not fEmptyStr(edtCodEmp.Text)) Then
          ParamByName('CODEMP').AsString := edtCodEmp.Text;

        Open;

        pSetaClient(qryRelatorio);
        cdsRelato.Open;
        pSetaClient(cdsRelato);

        blnConfir := False;

        If IsEmpty Then
          fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok'])
        Else
        Begin
          blnConfir := fChamaTelaSelecaoImp;

          If blnConfir And cdsRelato.IsEmpty Then
          Begin
            fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
            blnConfir := False;
          End;

        End;

      End;

      If blnConfir Then
      Begin
        If edtDestino.Text = 'I' Then
        Begin
          {***************************************************}
          { CARREGA A FILA DE IMPRESSAO DE CARTA DE COBRANCA *}
          { "frmRelCtrCartaCob_CP"                           *}
          {************************************************AC*}
          pCarregaConfImpr(qryCfgRel, Self.Name);
          strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
          strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
          strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;
        End;

        blnConfir := fGeraCartaDespesas;

        If Not blnConfir Then
          fMensagem('ATENÇÃO!', 'Problemas ao gerar a(s) Carta(s) de Cobrança!', ['&O k']);

        If blnConfir And chkImpEti.Checked Then
          pImpEtiquetas;
      End;

    Finally
      qryRelatorio.Close;
      FreeAndNil(cdsRelato);
      FreeAndNil(dspRelato);
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  Screen.Cursor       := crDefault;
  Application.ProcessMessages;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtrCartaDes.cbbModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Down) Then
  Begin
    cbbModelo.DropDown;
  End
  Else If (Key = VK_Return) Then
  Begin
    cbbModelo.CloseUp(True);
    pProximoControle(Sender);
  End;
end;

procedure TfrmRelCtrCartaDes.chkImpEtiClick(Sender: TObject);
begin
  inherited;
  pHabilitaCamposEtiquetas;
end;

procedure TfrmRelCtrCartaDes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodCli.Text) Then
    edtNomCli.Text := 'TODOS'
  Else
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

  If fEmptyStr(edtNomCli.Text) And (Not fEmptyStr(edtCodCli.Text)) Then
  Begin
    fMensagem('AVISO', 'Código do Cliente não encontrado',['&O K']);
    edtCodCli.Clear;
    pSetFocus(edtCodCli);
  End;
end;

procedure TfrmRelCtrCartaDes.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodCli: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCodCli) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrCartaDes.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmp.Text) Then
    edtNomEmp.Text := 'TODAS'
  Else
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

  If fEmptyStr(edtNomEmp.Text) And (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    fMensagem('AVISO','Código da Empresa não encontrado', ['&O K']);
    edtCodEmp.Clear;
    pSetFocus(edtCodEmp);
  End;
end;

procedure TfrmRelCtrCartaDes.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtrCartaDes.fChamaTelaSelecaoImp: Boolean;
var
  strOrdenacao: String;
  oleDados: OleVariant;
  bVerificarEmail : boolean;
begin
  Result := False;
  Try
    pAgrupaPorCliente;

    bVerificarEmail := False;
    strOrdenacao := '';
    oleDados     := cdsRelato.Data;
    if fRetTelaSelecaoImp(oleDados, strOrdenacao, bVerificarEmail) then
    begin
      cdsRelato.Data := oleDados;
      if strOrdenacao <> '' then
        cdsRelato.IndexFieldNames := strOrdenacao;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmRelCtrCartaDes.fClienteSelecionado(strCodCli: String): Boolean;
begin
  With cdsRelato Do
  Begin
    Filter   := 'MARDES     = ' + QuotedStr('M') + ' AND ' +
                'MOSTRA     = ' + QuotedStr('S') + ' AND ' +
                'CTR_CODCLI = ' + QuotedStr(strCodCli);
    Filtered := True;
    Result   := (Not IsEmpty);
    Filter   := 'MARDES     = ' + QuotedStr('M') + ' AND ' +
                'MOSTRA     = ' + QuotedStr('S');
    Filtered := True;
  End;
end;

function TfrmRelCtrCartaDes.fGeraCartaDespesas(): Boolean;
  Var
    Word: TWord;
    strArqOri : String;
    strArqDes : String;
    strLogCit : String;
    strSQL    : String;
    strCliAnt : String;
    strDuplic : String;

    strNumDup : String;
    strParcel : String;
    strEspDoc : String;
    strCodEmp : String;

    qryCadEmp : TUniQuery;
    qryDupOri : TUniQuery;
    intLinha  : Integer;
    intQtdLin : Integer;
    intRecno  : Integer;
    fltTotOri : Double;
    fltTotJur : Double;
    fltTotCor : Double;

    procedure pGeraCabDuplicatas;
    begin
      intRecno := qryRelatorio.RecNo;
      qryRelatorio.Filtered := False;
      qryRelatorio.Filter := 'CTR_CODCLI = ' + QuotedStr(strCliAnt);
      qryRelatorio.Filtered := True;
      intQtdLin := qryRelatorio.RecordCount + 2;
      qryRelatorio.Filtered := False;
      qryRelatorio.RecNo := intRecno;

      Word.pCriaTabela('{{DUPLIC}}', intQtdLin, 7);
      intLinha := 1;

      Word.pCelulaNegrito(intLinha, 1);
      Word.pCelulaEscreve(intLinha, 1, 'DUPLICATA');
      Word.pCelulaNegrito(intLinha, 2);
      Word.pCelulaEscreve(intLinha, 2, 'DT. VENCTO.');
      Word.pCelulaNegrito(intLinha, 3);
      Word.pCelulaEscreve(intLinha, 3, 'DIAS ATRASO');
      Word.pCelulaNegrito(intLinha, 4);
      Word.pCelulaAlignRight(intLinha, 4);
      Word.pCelulaEscreve(intLinha, 4, 'VR. TITULO');
      Word.pCelulaNegrito(intLinha, 5);
      Word.pCelulaAlignRight(intLinha, 5);
      Word.pCelulaEscreve(intLinha, 5, 'JUROS PAGOS');
      Word.pCelulaNegrito(intLinha, 6);
      Word.pCelulaEscreve(intLinha, 6, 'DT. PGTO.');
      Word.pCelulaNegrito(intLinha, 7);
      Word.pCelulaAlignRight(intLinha, 7);
      Word.pCelulaEscreve(intLinha, 7, 'VR. DESPESAS');

      Inc(intLinha);
    end;

begin
  Result := false;
  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA');

    strArqOri := fRetornaPathModelo(cbbModelo.KeyValue);
    strArqOri := AnsiReplaceStr(strArqOri, '"', '');

    If FileExists(strArqOri) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   EMP_NOMEMP, ';
      strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT(", ", EMP_ENDCMP)), IF(IFNULL(EMP_BAIRRO,"") = "", "", CONCAT(", ", EMP_BAIRRO))) AS EMP_ENDERE, ';
      strSQL := strSQL + '   CONCAT(CID_NOMCID, "-" , CID_ESTADO) AS EMP_CIDADE, ';
      strSQL := strSQL + '   CID_NOMCID, ';
      strSQL := strSQL + '   EMP_C_G_C_, ';
      strSQL := strSQL + '   EMP_FONE01, ';
      strSQL := strSQL + '   EMP_F_A_X_, ';
      strSQL := strSQL + '   EMP_C_E_P_  ';
      strSQL := strSQL + ' FROM   ';
      strSQL := strSQL + '   CADEMP ';
      strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = EMP_CODCID ';
      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   EMP_CODEMP = "' + VS_strCodEmp +  '"  ';
      qryCadEmp := fCriaQuery(Self);
      With qryCadEmp, SQL Do
      Begin
        Clear;
        Add(strSQL);
        Open;
      End;

      Word := TWord.fCriarWord(Self);

      With qryRelatorio Do
      Begin
        First;
        While Not Eof Do
        Begin

          If (Not fClienteSelecionado(FieldByName('CTR_CODCLI').AsString)) Then
          Begin
            Next;
            Continue;
          End;

          strCliAnt := FieldByName('CTR_CODCLI').AsString;
          //Screen.Cursor := crHourGlass;
          Application.ProcessMessages;

          fltTotOri := 0;
          fltTotJur := 0;
          fltTotCor := 0;

          strArqDes := ExtractFilePath(Application.ExeName) + 'CARTAS DE COBRANCA\CARTA_DE_COBRANCA_DESPESAS' + FormatDateTime('yyyymmdd', Date) + '-' + FieldByName('CTR_CODCLI').AsString + '.DOC';
          If FileExists(strArqDes) Then
            DeleteFile(strArqDes);

          CopyFile(pChar(strArqOri), pChar(strArqDes), False);

          If Word = Nil Then
            Exit;

          If Not Word.AbrirArquivo(strArqDes) Then
          Begin
            fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
            Exit;
          End;

          Word.pGoToPageHeader;

          strLogCit := ExtractFilePath(Application.ExeName) + 'CITEL.BMP';

          Word.pInsereImagem(IfThen(FileExists(fCfgSis('PATLOG')), fCfgSis('PATLOG'), strLogCit));

          Word.pReplace('{{NOMEMP}}', qryCadEmp.FieldByName('EMP_NOMEMP').AsString);
          Word.pReplace('{{ENDEMP}}', qryCadEmp.FieldByName('EMP_ENDERE').AsString);
          Word.pReplace('{{CIDEMP}}', qryCadEmp.FieldByName('EMP_CIDADE').AsString);
          Word.pReplace('{{FONEMP}}', fFormataFone(qryCadEmp.FieldByName('EMP_FONE01').AsString));
          Word.pReplace('{{FAXEMP}}', fFormataFone(qryCadEmp.FieldByName('EMP_F_A_X_').AsString));

          Word.pGoToMainDocument;

          Word.pReplace('{{NOMCID}}', qryCadEmp.FieldByName('CID_NOMCID').AsString);
          Word.pReplace('{{CLINOM}}', FieldByName('CLI_NOMCLI').AsString);
          Word.pReplace('{{NOMREP}}', 'REPRESENTANTE: ' + FieldByName('CLI_NOMREP').AsString);
          Word.pReplace('{{CLIEND}}', FieldByName('CLI_ENDERE').AsString + ', ' +
                                      FieldByName('CLI_ENDNUM').AsString + ' - '+
                                      FieldByName('CLI_ENDCOM').AsString);
          Word.pReplace('{{CLIBAI}}', FieldByName('CLI_BAIRRO').AsString);
          Word.pReplace('{{CLICID}}', FieldByName('CID_NOMCID').AsString);
          Word.pReplace('{{CLIEST}}', FieldByName('CID_ESTADO').AsString);
          Word.pReplace('{{CLICEP}}', fFormataCEP(FieldByName('CLI_C_E_P_').AsString));
          Word.pReplace('{{CLIDOC}}', fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, FPais));
          Word.pReplace('{{NOMEMP}}', qryCadEmp.FieldByName('EMP_NOMEMP').AsString);

          pGeraCabDuplicatas;

          While (FieldByName('CTR_CODCLI').AsString = strCliAnt) Do
          Begin

            strSQL := '';
            strSQL := strSQL + ' SELECT ';
            strSQL := strSQL + '   CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC,"-",CTR_CODEMP)  AS NUMDUP, ';
            strSQL := strSQL + '   CTR_DTAREC                                                   AS DTABAI, ';
            strSQL := strSQL + '   CTR_DTAVEN                                                   AS DTAVEN, ';
            strSQL := strSQL + '   DATEDIFF(CTR_DTAREC, CTR_DTAVEN)                             AS ATRASO, ';
            strSQL := strSQL + '   (CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) AS VALORI, ';
            strSQL := strSQL + '   CTR_VALJUR                                                   AS VALJUR  ';
            strSQL := strSQL + ' FROM   ';
            strSQL := strSQL + FieldByName('TABELA').AsString;
            strSQL := strSQL + ' WHERE    ';
            strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
            strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
            strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
            strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
            strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';

            strDuplic := Copy(FieldByName('CTR_HIST02').AsString, 22, 100);

            strNumDup := LeftStr(strDuplic, Pos('-', strDuplic) -1);
            System.Delete(strDuplic, 1, Pos('-', strDuplic));

            strParcel := MidStr(strDuplic, 1, Pos('-', strDuplic) -1);
            System.Delete(strDuplic, 1, Pos('-', strDuplic));

            strEspDoc := MidStr(strDuplic, 1, Pos('-', strDuplic) -1);
            System.Delete(strDuplic, 1, Pos('-', strDuplic));

            strCodEmp := LeftStr(strDuplic, 3);


            qryDupOri := fCriaQuery(Self);
            qryDupOri.SQL.Clear;
            qryDupOri.SQL.Add(strSQL);
            qryDupOri.ParamByName('NUMDUP').AsString := strNumDup;
            qryDupOri.ParamByName('PARCEL').AsString := strParcel;
            qryDupOri.ParamByName('ESPDOC').AsString := strEspDoc;
            qryDupOri.ParamByName('CODEMP').AsString := strCodEmp;
            qryDupOri.ParamByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
            qryDupOri.Open;

            Word.pCelulaEscreve(intLinha, 1, qryDupOri.FieldByName('NUMDUP').AsString);
            Word.pCelulaEscreve(intLinha, 2, FormatDateTime('dd/mm/yyyy', qryDupOri.FieldByName('DTAVEN').AsDateTime));
            Word.pCelulaEscreve(intLinha, 3, qryDupOri.FieldByName('ATRASO').AsString);
            Word.pCelulaAlignRight(intLinha, 4);
            Word.pCelulaEscreve(intLinha, 4, FormatFloat(',0.00', qryDupOri.FieldByName('VALORI').AsFloat));
            Word.pCelulaAlignRight(intLinha, 5);
            Word.pCelulaEscreve(intLinha, 5, FormatFloat(',0.00', qryDupOri.FieldByName('VALJUR').AsFloat));
            Word.pCelulaEscreve(intLinha, 6, FormatDateTime('dd/mm/yyyy', qryDupOri.FieldByName('DTABAI').AsDateTime));
            Word.pCelulaAlignRight(intLinha, 7);
            Word.pCelulaEscreve(intLinha, 7, FormatFloat(',0.00', FieldByName('CTR_CORRIGIDO').AsFloat));
            fltTotOri := fltTotOri + qryDupOri.FieldByName('VALORI').AsFloat;
            fltTotJur := fltTotJur + qryDupOri.FieldByName('VALJUR').AsFloat;
            fltTotCor := fltTotCor + FieldByName('CTR_CORRIGIDO').AsFloat;
            Next;
            Inc(intLinha);

            FreeAndNil(qryDupOri);

            If Eof Then
              Break;
          End;

          Word.pReplace('{{TOTDUP}}', FormatFloat(',0.00', fltTotCor));
          Word.pReplace('{{VALEXT}}', fRetExtensoNumero(FloatToStr(fltTotCor)));
          Word.pReplace('{{NOMPOR}}', FieldByName('POR_NOMPOR').AsString);

          Word.pCelulaNegrito(intLinha + 1, 3);
          Word.pCelulaAlignRight(intLinha + 1, 3);
          Word.pCelulaEscreve(intLinha + 1, 3, 'TOTAIS:');
          Word.pCelulaNegrito(intLinha + 1, 4);
          Word.pCelulaAlignRight(intLinha + 1, 4);
          Word.pCelulaEscreve(intLinha + 1, 4, FormatFloat(',0.00', fltTotOri));
          Word.pCelulaNegrito(intLinha + 1, 5);
          Word.pCelulaAlignRight(intLinha + 1, 5);
          Word.pCelulaEscreve(intLinha + 1, 5, FormatFloat(',0.00', fltTotJur));
          Word.pCelulaNegrito(intLinha + 1, 7);
          Word.pCelulaAlignRight(intLinha + 1, 7);
          Word.pCelulaEscreve(intLinha + 1, 7, FormatFloat(',0.00', fltTotCor));

          Word.pSalvar;

          If (edtDestino.Text = 'I') Then
            TCfgRel.pPrintReport(Self.Name, ExtractFileName(strArqDes), strNomImp, Word);

          Word.pFechar;

          Application.ProcessMessages;

          If (edtDestino.Text = 'V') Then
            pExecArquivo(strArqDes, Handle);

          //Screen.Cursor := crDefault;
        End;
      End;
      FreeAndNil(Word);
      Result := True;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Modelo de Carta não encontrado!', ['&O k']);
      Result := False;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmRelCtrCartaDes.fImprimeEtiquetaClienteLaser: Boolean;
  Var
    prmDllRel: TParamDllEtiquetas;
Begin
  prmDllRel := TParamDllEtiquetas.Create;
  With prmDllRel Do
  Begin
    If (fCfgSis('ETICLI') = 'L') Then
      tpeTipEtq := tpeClienteLaser
    Else
      tpeTipEtq := tpeClienteArgox;

    strCamBus := 'CLI_NOMCLI';
    blnEdrCob := rdbEndCob.Checked;
    strLisReg := fRetAutoIncremCliente;
    intQtdEti := StrToInt(edtQtdEti.Text);
  End;
  Result := fImprimeEtiqueta(prmDllRel);
  FreeAndNil(prmDllRel);
end;

procedure TfrmRelCtrCartaDes.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtrCartaDes.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := FPais;

 // objFuncMacro := fGetTFuncMacro;

  qryModelos.Connection := frmModulo.GetCurrentConnection;
  qryEmpresa.Connection := frmModulo.GetCurrentConnection;
end;

procedure TfrmRelCtrCartaDes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtrCartaDes.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  //edtTaxJur.Text := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  inherited;
  qryModelos.Close;
  qryModelos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryModelos.Open;

  If Not (fVerificaAcessoSistema('COBIMP', strLoginUsuarioLogado)) Then
  Begin
    edtDestino.Text := 'I';
    edtDestino.Enabled := False;
    edtDestino.TabStop := False;
    shpLiberado.Brush.Color := clRed;
  End
  Else
    shpLiberado.Brush.Color := clGreen;    

  pHabilitaCamposEtiquetas;
end;

function TfrmRelCtrCartaDes.fRetAutoIncremCliente: String;
begin
  Result := '';
  With cdsRelato Do
  Begin
    First;
    While Not Eof Do
    Begin
      If (RecNo = 1) Then
        Result := FieldByName('AUTINC').AsString
      Else
        Result := Result + ',' + FieldByName('AUTINC').AsString;
      Next;
    End;
  End;
end;

function TfrmRelCtrCartaDes.fRetornaPathModelo(strCodMod: String): String;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT       ';
  strSQL := strSQL + '  CAR_PATCAR ';
  strSQL := strSQL + 'FROM         ';
  strSQL := strSQL + '  CARDES     ';
  strSQL := strSQL + 'WHERE        ';
  strSQL := strSQL + '  CAR_CODCAR = :CODMOD AND ';
  strSQL := strSQL + '  CAR_CODEMP = :CODEMP     ';
  qryAux := fCriaQuery(Self);
  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODMOD').AsString := strCodMod;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('CAR_PATCAR').AsString
    Else
      Result := '';
  End;
end;

function TfrmRelCtrCartaDes.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
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
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = cbbModelo) Then
    Begin
      If fEmptyStr(cbbModelo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione um Modelo de Carta!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtQtdEti) And (edtQtdEti.Enabled) Then
    Begin
      If (fEmptyStr(edtQtdEti.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de etiquetas deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToInt(edtQtdEti.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de etiquetas deve ser maior que zero!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelCtrCartaDes.fVirgulaPontoFloatStr(strValor: String): String;
begin
  Result := AnsiReplaceStr(strValor,',','.');
end;

procedure TfrmRelCtrCartaDes.pAgrupaPorCliente;
Var
  strCliAnt: String;
  intPosPri: Integer;
  intPosAtu: Integer;
  fltValCor: Double;
  fltValPen: Double;
begin
  With cdsRelato Do
  Begin
    IndexFieldNames := 'CTR_CODCLI';
    First;
    strCliAnt := '';
    intPosPri := 1;
    While Not Eof Do
    Begin
      If (FieldByName('CTR_CODCLI').AsString <> strCliAnt) Then
      Begin
        strCliAnt := FieldByName('CTR_CODCLI').AsString;
        intPosPri := RecNo;
      End
      Else
      Begin
        fltValCor := FieldByName('CTR_CORRIGIDO').AsFloat;
        fltValPen := FieldByName('CTR_VALDUP').AsFloat;

        Edit;
        FieldByName('MOSTRA').AsString := 'N';
        Post;

        intPosAtu := RecNo;
        RecNo := intPosPri;

        Edit;
        FieldByName('CTR_CORRIGIDO').AsFloat := FieldByName('CTR_CORRIGIDO').AsFloat + fltValCor;
        FieldByName('CTR_VALDUP').AsFloat    := FieldByName('CTR_VALDUP').AsFloat + fltValPen;
        FieldByName('QTDTIT').AsInteger      := FieldByName('QTDTIT').AsInteger + 1;  
        Post;

        RecNo := intPosAtu;
      End;

      Next;
    End;
    Filter := 'MOSTRA =  ' + QuotedStr('S');
    Filtered := True;
  End;
end;

procedure TfrmRelCtrCartaDes.pAtribuiCamposUso;
begin
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

 // cpuCampos := fGetTCamposUso;
  cpuCampos.AdicionaCampos(cdsRelato, 'CADCLI');
end;

procedure TfrmRelCtrCartaDes.pAtualizaCamposUso;
begin
  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TfrmRelCtrCartaDes.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtrCartaDes.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

procedure TfrmRelCtrCartaDes.pHabilitaCamposEtiquetas;
begin
  edtQtdEti.Enabled := chkImpEti.Checked;
  pnlEndere.Enabled := chkImpEti.Checked;
  pnlTipImp.Enabled := chkImpEti.Checked;
end;

procedure TfrmRelCtrCartaDes.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
  Begin
    Exit;
  End;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
    Begin
      blnUltimoReg := True;
    End;

    objFuncMacro.pEscreveLinha(strArqTxt, AnsiString(arrLinEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinEti, 0);
end;

procedure TfrmRelCtrCartaDes.pImpEtiquetas;
begin
  fMensagem('ATENÇÃO!','Prepare a impressora ' + IfThen(rdbImpLas.Checked, 'laser/argox', 'matricial') + ' para a imprimir a(s) etiqueta(s)!', ['&O k']);
  intColAtu := 1;
  If (rdbImpLas.Checked) Then
    fImprimeEtiquetaClienteLaser
  Else
    pImpEtiquetasMatricial;
end;

procedure TfrmRelCtrCartaDes.pImpEtiquetasMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    qryCfgRel  : TUniQuery;
    intConEti  : Integer;
    intQtdEti  : Integer;
begin
  qryCfgRel := fCriaQuery(Self);

  pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');

  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  With cdsRelato Do
  Begin

    intQtdTopo := fRetTopoEtiqueta('CLI');

    For intContador := 1 to intQtdTopo Do
    Begin
      objFuncMacro.pEscreveLinha(strArqTxt, ' ', False, strNomImp, strNomPro, strDesPro);
    End;

    First;

    intQtdEti := StrToInt(edtQtdEti.Text);

    While Not Eof Do
    Begin

      Application.ProcessMessages;
      pAtualizaCamposUso;
      Application.ProcessMessages;

      For intConEti := 1 To intQtdEti Do
        pImpRegistro;

      Application.ProcessMessages;

      Next;
    End;

    pImpArrLinhasEti;
  End;
  FreeAndNil(qryCfgRel);
end;

procedure TfrmRelCtrCartaDes.pImpRegistro;
  Var
    intQtdCol: Integer;
    intQtdOri: Integer;
    intContad: Integer;
    intLinAtu: Integer;
    intLinha : Integer;
    intLinAnt: Integer;
    intNumCol: Integer;
    intQtdEti: Integer;
    intLinEti: Integer;
    strNumCol: String;
    strLinha : String;
    strSQL   : String;
    qryCnfEti: TUniQuery;
begin
  intLinAtu := 1;
  intLinha  := 0;
  intLinEti := 0;
  intQtdEti := 1;

  strSQL    := '';
  strSQL    := strSQL + 'SELECT ';
  strSQL    := strSQL + '  * ';
  strSQL    := strSQL + 'FROM ';
  strSQL    := strSQL + '  CNFETI ';
  strSQL    := strSQL + 'WHERE ';
  strSQL    := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL    := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL    := strSQL + 'ORDER BY ';
  strSQL    := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfEti := fCriaQuery(Self);
  With qryCnfEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := 'CLI';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    First;

    intQtdOri := FieldByName('CNF_QTDCOL').AsInteger;
    intQtdCol := intQtdOri;

    If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
      intQtdCol := intQtdEti;

    If (intColAtu <= 1) Then
    Begin
      objFuncMacro.pI_LinhasEti(Self, cpuCampos, strLinha, intLinAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
      objFuncMacro.pEscreveLinha(strArqTxt,AnsiString(strLinha), True, strNomImp, strNomPro, strDesPro);
    End;
    Next;

    If (Length(arrLinEti) = 0) Then
    Begin
      If (RecordCount > 0) Then
        SetLength(arrLinEti, RecordCount-1)
      Else
        SetLength(arrLinEti, 0);
    End;

    While (Not Eof) Do
    Begin

      pAtualizaCamposUso;

      strLinha := '';

      For intContad := intColAtu To IfThen(intQtdEti = 1, intColAtu, intQtdCol) Do
      Begin

        strNumCol := fStrZero(IntToStr(intContad), 03);
        intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

        intLinAnt := Length(arrLinEti[intLinEti]);
        objFuncMacro.pI_LinhasEti(Self, cpuCampos, strLinha, intLinAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intLinAnt), qryCnfEti);

        arrLinEti[intLinEti] := arrLinEti[intLinEti] + strLinha;
        strLinha := ''; //Se desistir da matriz, tirar essa linha

      End;

      Inc(intLinEti);
      Next;

    End;

    Inc(intColAtu, intQtdEti);
//    Dec(intQtdEti, (intQtdOri+1) - (intColAtu - intQtdEti));

    If (intColAtu > intQtdOri) Then
    Begin
      pImpArrLinhasEti;
      intColAtu := 1;
    End;

  End;
  FreeAndNil(qryCnfEti);
end;

end.
