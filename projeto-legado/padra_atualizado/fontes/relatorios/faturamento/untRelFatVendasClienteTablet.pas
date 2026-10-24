unit untRelFatVendasClienteTablet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, DB, Uni, MaskUtils, StrUtils,
  UniClientDataSet, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmRelFatVendasClienteTablet = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCliente: TPanel;
    pnlMovimento: TPanel;
    shpCliente: TShape;
    shpMovimento: TShape;
    dbgDados: TDBGridCitel;
    pnlTotais: TPanel;
    Shape1: TShape;
    edtTotIte: TEditFocus;
    edtTotIpi: TEditFocus;
    edtValTot: TEditFocus;
    edtDesEsp: TEditFocus;
    lblTitDesESp: TLabel;
    edtDtaEnt: TEditFocus;
    edtNumDoc: TEditFocus;
    edtDocOri: TEditFocus;
    pnlAdicionais: TPanel;
    shpAdicionais: TShape;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lbl1: TLabel;
    lblCndPag: TLabel;
    edtDesItem: TEditFocus;
    edtDesMarca: TEditFocus;
    edtMens001: TEditFocus;
    edtMens002: TEditFocus;
    edtTransp: TEditFocus;
    edtFormas: TEditFocus;
    edtCodCnd: TEditFocus;
    edtCndPgto: TEditFocus;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    dtsRelVenCli: TDataSource;
    Label12: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCliente: TLabel;
    cdsRelVenCli: TUniClientDataSet;
    cdsRelVenCliCODITE: TStringField;
    cdsRelVenCliDESCRI: TStringField;
    cdsRelVenCliQTDITE: TFloatField;
    cdsRelVenCliUNITAR: TFloatField;
    cdsRelVenCliTOTITE: TFloatField;
    cdsRelVenCliTOTCUS: TFloatField;
    cdsRelVenCliMARGEM: TFloatField;
    cdsRelVenCliDESMAR: TStringField;
    cdsRelVenCliMEN001: TStringField;
    cdsRelVenCliMEN002: TStringField;
    cdsRelVenCliTRANSP: TStringField;
    cdsRelVenCliCNDCOD: TStringField;
    cdsRelVenCliNUMDOC: TStringField;
    cdsRelVenCliDOCORI: TStringField;
    cdsRelVenCliNUMLOT: TStringField;
    cdsRelVenCliDOCUME: TStringField;
    cdsRelVenCliESPDOC: TStringField;
    cdsRelVenCliCODEMP: TStringField;
    cdsRelVenCliCODCLI: TStringField;
    cdsRelVenCliCNDFAT: TStringField;
    cdsRelVenCliDTAENT: TDateField;
    cdsRelVenCliDESESP: TFloatField;
    cdsRelVenCliTOTIPI: TFloatField;
    cdsRelVenCliTOTGER: TFloatField;
    procedure pMostrarProdutos(strNumDoc, strEspDoc, strCodEmp: String; blnSelDocumentosP: Boolean=False; strCodCli: String='');
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pAtualizaTotal;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAdicionaNaTemporaria(DataSet: TDataSet);

    function fRetornaDataInicial(blnInicial: Boolean): String;
  public
    { Public declarations }
    blnSelDocumentos: Boolean;
    blnVeioDoTelemarketing : Boolean;
    blnVeioDoTablet        : Boolean;
    strCodRedeLojasCliente: String;
  end;


implementation

uses
 untIFuncoes, untConstantes, untModulo,  untFuncoesSimples;

{$R *.dfm}

{ TfrmRelFatVendasClienteTablet }

procedure TfrmRelFatVendasClienteTablet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsRelVenCli.DataSet.AfterScroll := Nil;

  If dtsRelVenCli.DataSet.Active Then
    dtsRelVenCli.DataSet.Close;

  cdsRelVenCli.Close;    
end;

procedure TfrmRelFatVendasClienteTablet.FormCreate(Sender: TObject);
begin
  inherited;
  blnSelDocumentos := False;
  blnVeioDoTelemarketing := FALSE;
  blnVeioDoTablet        := False;
  strCodRedeLojasCliente := '';

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
  edtDocOri.MaxLength := edtNumDoc.MaxLength;
  edtDocOri.TamCampo  := edtNumDoc.MaxLength;

  pSetaCodIte(cdsRelVenCliCODITE);
  cdsRelVenCli.CreateDataSet;
end;

procedure TfrmRelFatVendasClienteTablet.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmRelFatVendasClienteTablet.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaTotal;

  (dtsRelVenCli.DataSet.FieldByName('TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
  (dtsRelVenCli.DataSet.FieldByName('QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
//  (dtsRelVenCli.DataSet.FieldByName('TOTCUS') As TFloatField).DisplayFormat := '#,##0.00';
//  (dtsRelVenCli.DataSet.FieldByName('MARGEM') As TFloatField).DisplayFormat := '#,##0.00';

  pAtualizaDados(Nil);
  dtsRelVenCli.DataSet.AfterScroll := pAtualizaDados;

  If Not fCfgSis('USACND', varBoolean) Then
  Begin
    edtCodCnd.Visible := False;
    edtCndPgto.Left   := edtCodCnd.Left;
    edtCndPgto.Width  := edtCndPgto.Width + edtCodCnd.Width + 1;
  End;

  If (Not fCfgSis('MARFAT', varBoolean)) Or (Not blnSelDocumentos) Then
  Begin
//    dtsRelVenCli.DataSet.FieldByName('TOTCUS').Visible := False;
//    dtsRelVenCli.DataSet.FieldByName('MARGEM').Visible := False;
//    dbgDados.Columns[05].Visible := False;
//    dbgDados.Columns[06].Visible := False;
//    lblTitCusto.Visible  := False;
//    lblTitMar.Visible := False;
//    edtCusto.Visible  := False;
//    edtMargem.Visible := False;
  End;
end;

procedure TfrmRelFatVendasClienteTablet.pAdicionaNaTemporaria(
  DataSet: TDataSet);
begin
  With cdsRelVenCli Do
  Begin
    DataSet.First;
    While Not DataSet.Eof Do
    Begin
      Append;
      FieldByName('CODITE').AsString := DataSet.FieldByName('CODITE').AsString;
      FieldByName('DESCRI').AsString := DataSet.FieldByName('DESCRI').AsString;
      FieldByName('QTDITE').AsFloat  := DataSet.FieldByName('QTDITE').AsFloat;
      FieldByName('UNITAR').AsFloat  := DataSet.FieldByName('UNITAR').AsFloat;
      FieldByName('TOTITE').AsFloat  := DataSet.FieldByName('TOTITE').AsFloat;
      FieldByName('TOTCUS').AsFloat  := DataSet.FieldByName('TOTCUS').AsFloat;
      FieldByName('MARGEM').AsFloat  := DataSet.FieldByName('MARGEM').AsFloat;
      FieldByName('DESMAR').AsString := DataSet.FieldByName('DESMAR').AsString;
      FieldByName('MEN001').AsString := DataSet.FieldByName('MEN001').AsString;
      FieldByName('MEN002').AsString := DataSet.FieldByName('MEN002').AsString;
      FieldByName('TRANSP').AsString := DataSet.FieldByName('TRANSP').AsString;
      FieldByName('CNDCOD').AsString := DataSet.FieldByName('CNDCOD').AsString;
      FieldByName('NUMDOC').AsString := DataSet.FieldByName('NUMDOC').AsString;
      FieldByName('DOCORI').AsString := DataSet.FieldByName('DOCORI').AsString;
      FieldByName('NUMLOT').AsString := DataSet.FieldByName('NUMLOT').AsString;
      FieldByName('DOCUME').AsString := DataSet.FieldByName('DOCUME').AsString;
      FieldByName('ESPDOC').AsString := DataSet.FieldByName('ESPDOC').AsString;
      FieldByName('CODEMP').AsString := DataSet.FieldByName('CODEMP').AsString;
      FieldByName('CODCLI').AsString := DataSet.FieldByName('CODCLI').AsString;
      FieldByName('CNDFAT').AsString := DataSet.FieldByName('CNDFAT').AsString;
      FieldByName('DTAENT').AsDateTime := DataSet.FieldByName('DTAENT').AsDateTime;
      FieldByName('DESESP').AsFloat  := DataSet.FieldByName('DESESP').AsFloat;
      FieldByName('TOTIPI').AsFloat  := DataSet.FieldByName('TOTIPI').AsFloat;
      FieldByName('TOTGER').AsFloat  := DataSet.FieldByName('TOTGER').AsFloat;
      Post;
      DataSet.Next;
    End;
  End;
end;

procedure TfrmRelFatVendasClienteTablet.pAtualizaDados(DataSet: TDataSet);
  Var
    strFormas: String;
    qryFormas: TUniQuery;
begin
  edtDesItem.Text  := dtsRelVenCli.DataSet.FieldByName('DESCRI').AsString;
  edtDesMarca.Text := dtsRelVenCli.DataSet.FieldByName('DESMAR').AsString;
  edtMens001.Text  := dtsRelVenCli.DataSet.FieldByName('MEN001').AsString;
  edtMens002.Text  := dtsRelVenCli.DataSet.FieldByName('MEN002').AsString;
  edtTransp.Text   := dtsRelVenCli.DataSet.FieldByName('TRANSP').AsString;
  edtCndPgto.Text  := FormatMaskText(MASK_CONPAG,
                                     dtsRelVenCli.DataSet.FieldByName('CNDFAT').AsString);
  edtCodCnd.Text   := dtsRelVenCli.DataSet.FieldByName('CNDCOD').AsString;

  edtDtaEnt.Text := DateTimeToStr(dtsRelVenCli.DataSet.FieldByName('DTAENT').AsDateTime);
  edtNumDoc.Text := dtsRelVenCli.DataSet.FieldByName('NUMDOC').AsString;
  edtDocOri.Text := dtsRelVenCli.DataSet.FieldByName('DOCORI').AsString;

  If Not fEmptyStr(dtsRelVenCli.DataSet.FieldByName('NUMLOT').AsString) Then
  Begin
    lblNumLot.Visible := True;
    edtNumLot.Visible := True;
    edtNumLot.Text := dtsRelVenCli.DataSet.FieldByName('NUMLOT').AsString;
  End
  Else
  Begin
    lblNumLot.Visible := False;
    edtNumLot.Visible := False;
  End;

  Try
    qryFormas := fCriaQuery(Self);
    pSomaFormasPagamento(dtsRelVenCli.DataSet.FieldByName('DOCUME').AsString,
                         dtsRelVenCli.DataSet.FieldByName('ESPDOC').AsString,
                         dtsRelVenCli.DataSet.FieldByName('CODEMP').AsString,
                         dtsRelVenCli.DataSet.FieldByName('CODCLI').AsString,
                         qryFormas);
    With qryFormas Do
    Begin
      While Not Eof Do
      Begin
        strFormas := strFormas +
                     FieldByName('DESCRI').AsString + ':' +
                     fPadL(FormatFloat('#0.00', FieldByName('VALMOD').AsFloat), 13) + '  ';
        Next;
      End;
    End;
    edtFormas.Text := strFormas;
  Finally
    FreeAndNil(qryFormas);
  End;
end;

procedure TfrmRelFatVendasClienteTablet.pAtualizaTotal;
  Var
    fltValIte: Double;
    fltTotCus: Double;
    fltDesEsp: Double;
    fltTotIpi: Double;
    fltVTotal: Double;
    blnMarFat: Boolean;

    strNumDoc,
    strMarMkp: String;
Begin

  Try

    fltValIte := 0;
    fltDesEsp := 0;
    fltTotCus := 0;
    fltTotIpi := 0;
    fltVTotal := 0;
    blnMarFat := fCfgSis('MARFAT', varBoolean);
    strMarMkp := fCfgSis('MARMKP');

    With dtsRelVenCli.DataSet Do
    Begin
      First;
      While Not Eof Do
      Begin
        Application.ProcessMessages;

        fltValIte := fltValIte + FieldByName('TOTITE').AsFloat;
        fltDesEsp := fltDesEsp + Abs(FieldByName('DESESP').AsFloat);
        fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
        fltTotIpi := fltTotIpi + FieldByName('TOTIPI').AsFloat;
        fltVTotal := fltVTotal + FieldByName('TOTGER').AsFloat;

        strNumDoc := FieldByName('NUMDOC').AsString;

        If (blnMarFat) And (blnSelDocumentos) Then
        Begin
          Edit;
          FieldByName('MARGEM').AsFloat  := fCalculaPrecoVenda(2,FieldByName('TOTCUS').AsFloat,FieldByName('TOTITE').AsFloat,0,0,0,0,0,
            strMarMkp);
          Post;
        End;

        Next;
      End;
      First;

      {************************************}
      {* VERIFICA SE VAI APARECER O TOTAL *}
      {* DE DESCONTO ESPECIAL             *}
      {*********************************AF*}
      If (fltDesEsp > 0) Then
      Begin
        lblTitDesESp.Visible := True;
        edtDesEsp.Visible := True;
        edtDesEsp.Text := FloatToStrF(fltDesEsp,ffFixed,12,2);
      End
      Else
      Begin
        lblTitDesESp.Visible := False;
        edtDesEsp.Visible := False;
      End;

      {************************************}
      {* VERIFICA SE VAI APARECER O TOTAL *}
      {* DE MARGEM                        *}
      {*********************************AF*}
      If (blnMarFat) And (blnSelDocumentos) Then
      Begin
//        lblTitMar.Visible := True;
//        edtMargem.Visible := True;
        {*************************************}
        {* VALITE JA ESTA SUBTRAIDO O DESESP *}
        {**********************************AF*}
//        edtMargem.Text := FloatToStrF(fCalculaPrecoVenda(2,fltTotCus,fltValIte,0,0,0,0,0),ffFixed,12,2);
      End
      Else
      Begin
//        lblTitMar.Visible := False;
//        edtMargem.Visible := False;
      End;

      edtTotIte.Text  := FloatToStrF(fltValIte,ffFixed,12,2);
//      edtCusto.Text   := FloatToStrF(fltTotCus,ffFixed,12,2);
      edtTotIpi.Text  := FloatToStrF(fltTotIpi,ffFixed,12,2);
      edtValTot.Text  := FloatToStrF(fltVTotal - fltDesEsp, ffFixed, 12, 2);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAtualizaTotal;]');
    End;
  End;
end;

procedure TfrmRelFatVendasClienteTablet.pMostrarProdutos(strNumDoc, strEspDoc,
  strCodEmp: String; blnSelDocumentosP: Boolean; strCodCli: String);
  Var
    strSQL: String;
    strSQLPrinc : String;
    strSQLNotGer: String;
    strSQLDelNotGer: String;
    qryCons: TUniQuery;

begin
  strSQLPrinc      := '';
  strSQLNotGer     := '';
  strSQLDelNotGer  := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  IF(IFNULL(CLI_FONE01, "") = "", " ", CLI_FONE01) AS FONE01, ';
  strSQL := strSQL + '  CONCAT(CID_CODCID ," - ", CID_NOMCID ) AS NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO AS ESTADO, ';
  strSQL := strSQL + '  OPE_NOMOPE AS VENDED, ';
  strSQL := strSQL + '  IF(IFNULL(G.GER_MEN001, "") = "", " ", G.GER_MEN001) AS MEN001, ';
  strSQL := strSQL + '  IF(IFNULL(G.GER_MEN002, "") = "", " ", G.GER_MEN002) AS MEN002, ';
  strSQL := strSQL + '  IF(IFNULL(G.GER_MEN003, "") = "", " ", G.GER_MEN003) AS MEN003, ';
  strSQL := strSQL + '  IF(IFNULL(G.GER_MEN004, "") = "", " ", G.GER_MEN004) AS MEN004, ';
  strSQL := strSQL + '  IFNULL(CONCAT(G.GER_CODTRA,"-",TRA_NOMTRA), " ") AS TRANSP, ';
  strSQL := strSQL + '  IF(IFNULL(DET_CONPAG, "") = "", " ", DET_CONPAG) AS CNDFAT, '; // PARA USO NO RELATÓRIO DE VENDAS F9

  If fCfgSis('USACND', varBoolean) Then
  Begin
    strSQL := strSQL + '  IFNULL(CONCAT(CND_CNDPAG," - ",CND_DESCRI), " ") AS CNDPAG, ';
    strSQL := strSQL + '  CND_CODIGO AS CNDCOD, ';
  End
   Else
  Begin
     strSQL := strSQL + '  IF(IFNULL(DET_CONPAG, "") = "", " ", DET_CONPAG) AS CNDPAG, ';
    strSQL := strSQL + '  NULL AS CNDCOD, ';
  End;

  strSQL := strSQL + '  DET_DTAENT, ';
  strSQL := strSQL + '  DATE_FORMAT(DET_DTAENT,"%d/%m/%y") AS DTAENT, ';
  strSQL := strSQL + '  CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS NUMDOC, ';
  strSQL := strSQL + '  CONCAT(DET_ESPDOC,"-",DET_NUMDOC) AS NUMESP, ';
  strSQL := strSQL + '  DET_NUMDOC AS DOCUME, ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  DET_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  DET_CODITE AS CODITE, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '  DET_NUMLOT AS NUMLOT, ';
  strSQL := strSQL + '  " "        AS CONARQ, ';
  strSQL := strSQL + '  DET_REFERE AS REFERE, ';
  strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  MAR_CODMAR AS CODMAR, ';
  strSQL := strSQL + '  DET_DESESP AS DESESP, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_UNITAR), DET_UNITAR)) AS UNITAR, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) AS QTDITE, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS TOTITE, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTCUS), DET_TOTCUS) AS TOTCUS, ';
  strSQL := strSQL + '  0.000 AS MARGEM, ';
  strSQL := strSQL + '  DET_VALIPI AS TOTIPI, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') > 0, 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF), DET_TOTITE + DET_VALIPI - DET_DESESP - DET_DESCFF)) AS TOTGER, ';
  strSQL := strSQL + '  DET_ALQIPI AS ALQIPI, ';
  strSQL := strSQL + '  IF(LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0, CONCAT(DET_DOCDEV,"-",DET_ESPDEV), CONCAT(DET_NUM_PD, "-", DET_ESP_PD)) AS DOCORI, ';
  strSQL := strSQL + '  " " AS DOCCAN, ';
  strSQL := strSQL + '  CONCAT(ITE_CODFOR, "-", FOR_NOMFOR) AS NOMFOR, ';
  strSQL := strSQL + '  (SELECT IF(IFNULL(R.GER_NOMREC, "") = "", " ", R.GER_NOMREC) ';
  strSQL := strSQL + '     FROM ROMGERX R WHERE R.GER_NUMDOC = G.GER_NUMDOC AND      ';
  strSQL := strSQL + '                          R.GER_ESPDOC = G.GER_ESPDOC AND      ';
  strSQL := strSQL + '                          R.GER_CODEMP = G.GER_CODEMP AND      ';
  strSQL := strSQL + '                          R.GER_CODCLI = G.GER_CODCLI LIMIT 1) AS NOMREC, ';
  strSQL := strSQL + '  CONCAT(DET_CODDIV, "-", ';
  strSQL := strSQL + '         (SELECT DIV_NOMDIV FROM CADDIV WHERE DIV_CODDIV = DET_CODDIV)) AS NOMDIV, ';
  strSQL := strSQL + '  D.DET_CLAFIS AS CLAFIS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON DET_CODVEN = OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';
  strSQL := strSQL + '  JOIN CADITE ON DET_CODITE = ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON D.DET_UNIDAD = UNI_CODUNI ';

  strSQL := strSQL + '  INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';

  strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = G.GER_CODTRA  ';
  strSQL := strSQL + '  JOIN CADFOR ON ITE_CODFOR = FOR_CODFOR ';

  If fCfgSis('USACND', varBoolean) Then
    strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = DET_CODCND ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_TIP_FC = "C" ';

  If (fCfgSis('MOSMCL') = '3') Then
    strSQL := strSQL + ' AND (DET_NUMFAT IS NULL OR DET_NUMFAT = "")  ';

  strSQL := strSQL + ' AND (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0)  ';
  strSQL := strSQL + ' AND DET_PROEMB <> "S"  ';
  strSQL := strSQL + ' AND DET_DTAENT BETWEEN ' + QuotedStr(fRetornaDataInicial(TRUE)) + ' AND ' + QuotedStr(fRetornaDataInicial(FALSE));

  If Not fCfgSis('ENTBRF', varBoolean) Then
    strSQL := strSQL + ' AND (DET_ESPDOC <> "BR") AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0 ';

  If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + ' AND CLI_CODCLI = :CODCLI ';

  strSQL := strSQL + '  AND LOCATE(DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  strSQL := strSQL + '  AND ( DET_CODCLI IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '  OR ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
   strSQL := strSQL + ') ';

  strSQL := strSQL + '  GROUP BY D.AUTOINCREM ';

  strSQLNotGer := strSQL;
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVGER', 'NOTGER');
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVDET', 'NOTDET');
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'MOVTRI', 'NOTTRI');
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_DESCFF', '0.0000');
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_NUM_PD', '""');
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'DET_ESP_PD', '""');

  If (fCfgSis('MOSMCL') = '3') Then
    strSQLNotGer := AnsiReplaceStr(strSQLNotGer, ' (DET_NUMFAT IS NULL OR DET_NUMFAT = "") AND ', '');

  If (Pos(fCfgSis('MOSMCL'),'2_3_') > 0) Then
  Begin
    strSQL := strSQL + ' UNION ALL ' + strSQLNotGer;

    If Not fEmptyStr(strSQLDelNotGer) Then
      strSQL := strSQL + ' UNION ALL ' + strSQLDelNotGer;
  End;

  strSQL := strSQL + ' ORDER BY ';

  strSQL := strSQL + '  DET_DTAENT DESC, NUMESP LIMIT ' + IfThen(fEmptyStr(fCfgSis('QTDRVT')),'5',fCfgSis('QTDRVT'));

  strSQLPrinc := strSQL;

  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SQL_NO_CACHE   ');

      SQL.Add('   *                   ');

      SQL.Add(' FROM                  ');
      SQL.Add('   (' + strSQLPrinc + ') AS VENCLI ');

      SQL.Add(' ORDER BY              ');
      SQL.Add('   DET_DTAENT DESC, NUMESP  ');

      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If Not fEmptyStr(strCodCli) Then
        ParamByName('CODCLI').AsString := strCodCli;
      Open;

      lblCliente.Caption := 'Cliente: ' + FieldByName('CODCLI').AsString + ' - ' +
        FieldByName('NOMCLI').AsString;

      pAdicionaNaTemporaria(qryCons);
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmRelFatVendasClienteTablet.fRetornaDataInicial(blnInicial: Boolean): String;
var
  qryCons: TUniQuery;
begin
  Result := '';

  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CURRENT_DATE() AS DTAINI ');
      Open;

      Result := IfThen(blnInicial,
                    FormatDateTime('yyyy-mm-dd', FieldByName('DTAINI').AsDateTime - 360),
                    FormatDateTime('yyyy-mm-dd', FieldByName('DTAINI').AsDateTime));
    End;
  Finally
    FreeAndNil(qryCons);
  End;

end;


end.
