unit untRelEstConferenciaDevAD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, BitBtnLockedIncrem, Buttons, Mask, MaskEditFocus, DB, UniClientDataSet,
  Uni, StrUtils, untFuncoesSimples, untTypesSistema, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmRelEstConferenciaDevAD = class(TfrmPaiRelatorio)
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label4: TLabel;
    Label2: TLabel;
    edtSerie: TEditFocus;
    Label3: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    chkExiSomDiv: TCheckBox;
    frxRelatorioM: TfrxReport;
    cdsRelatorio: TUniClientDataSet;
    cdsRelatorioDET_NUMDOC: TStringField;
    cdsRelatorioDET_ESPDOC: TStringField;
    cdsRelatorioDET_CODEMP: TStringField;
    cdsRelatorioDOCUMENTO: TStringField;
    cdsRelatorioQUEBRA: TStringField;
    cdsRelatorioDET_CODITE: TStringField;
    cdsRelatorioDET_DESCRI: TStringField;
    cdsRelatorioDET_CODUNI: TStringField;
    cdsRelatorioDET_QTDDEV: TFloatField;
    cdsRelatorioDET_UNIDEV: TFloatField;
    cdsRelatorioDET_TOTDEV: TFloatField;
    cdsRelatorioDET_QTDADE: TFloatField;
    cdsRelatorioDET_UNIADE: TFloatField;
    cdsRelatorioDET_TOTADE: TFloatField;
    cdsRelatorioDET_QTDDIF: TFloatField;
    cdsRelatorioDET_UNIDIF: TFloatField;
    cdsRelatorioDET_TOTDIF: TFloatField;
    cdsRelatorioDET_DTAENT: TDateTimeField;
    frxRelatorioJ: TfrxReport;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNumDocChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    strCliente: String;
    arrCliente: TConsultasArray;
    procedure pSetaDataAtual;
  public
    { Public declarations }
  end;

implementation

uses untDivergenciasDevAD, untConsultas, untFuncoesConsulta,  untCfgRel;

{$R *.dfm}

procedure TfrmRelEstConferenciaDevAD.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    qryRelatorio: TUniQuery;
    divergencias: TDivergencias;
    diverg: TDivergencia;
    intContador: INteger;

    frxRel: TfrxReport;
    strNomeFila: String;
begin
  inherited;
  strSQL := '';
  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  G.GER_DTAENT, ';
  strSQL := strSQL + '  A.AUX_CODADE, ';
  strSQL := strSQL + '  G.GER_NUMDOC, ';
  strSQL := strSQL + '  G.GER_ESPDOC, ';
  strSQL := strSQL + '  G.GER_CODEMP, ';
  strSQL := strSQL + '  G.GER_CODCLI, ';
  strSQL := strSQL + '  G.GER_SERIE_, ';
  strSQL := strSQL + '  CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_CODEMP) AS DOCUMENTO, ';
  strSQL := strSQL + '  CONCAT(G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP, G.GER_CODCLI, G.GER_SERIE_) AS QUEBRA, ';
  strSQL := strSQL + '  "MOVGER" AS TABELA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER G ';
  strSQL := strSQL + '  JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  IFNULL(A.AUX_CODADE, "") <> "" AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC ';

  If Not fEmptyStr(edtSerie.Text) Then
    strSQL := strSQL + '  AND IFNULL(GER_SERIE_, "") = :SERIE_ ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + fStrLocate(edtCodCliente, arrCliente, 'GER_CODCLI', 'CODCLI');

  strSQL := strSQL + ' ORDER BY GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI, GER_SERIE_) ';

  qryRelatorio := fCriaQuery(Self);
  qryRelatorio.SQL.Add(strSQL);

  qryRelatorio.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If Not fEmptyStr(edtNumDoc.Text) Then
    qryRelatorio.ParamByName('NUMDOC').AsString := edtNumDoc.Text;

  If Not fEmptyStr(edtEspDoc.Text) Then
    qryRelatorio.ParamByName('ESPDOC').AsString := edtEspDoc.Text;

  If Not fEmptyStr(edtSerie.Text) Then
    qryRelatorio.ParamByName('SERIE_').AsString := edtSerie.Text;

  pSetaParam(edtCodCliente.Text, arrCliente, strCliente, 'CODCLI', qryRelatorio);

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    qryRelatorio.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryRelatorio.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text)
  End;
  qryRelatorio.Open;

  cdsRelatorio.EmptyDataSet;
  While (Not qryRelatorio.Eof) Do
  Begin
    divergencias := fRetornaInconsistencias(qryRelatorio.FieldByName('AUX_CODADE').AsString,
                                            'MOVDET',
                                            qryRelatorio.FieldByName('GER_NUMDOC').AsString,
                                            qryRelatorio.FieldByName('GER_ESPDOC').AsString,
                                            qryRelatorio.FieldByName('GER_CODEMP').AsString,
                                            qryRelatorio.FieldByName('GER_CODCLI').AsString,
                                            qryRelatorio.FieldByName('GER_SERIE_').AsString,
                                            Not chkExiSomDiv.Checked);

    For intContador := 0 To divergencias.Count -1 Do
    Begin
      diverg := divergencias[intContador];
      cdsRelatorio.Append;
      cdsRelatorioDET_DTAENT.AsDateTime := qryRelatorio.FieldByName('GER_DTAENT').AsDateTime;
      cdsRelatorioDET_NUMDOC.AsString := qryRelatorio.FieldByName('GER_NUMDOC').AsString;
      cdsRelatorioDET_ESPDOC.AsString := qryRelatorio.FieldByName('GER_ESPDOC').AsString;
      cdsRelatorioDET_CODEMP.AsString := qryRelatorio.FieldByName('GER_CODEMP').AsString;
      cdsRelatorioDOCUMENTO.AsString  := qryRelatorio.FieldByName('DOCUMENTO').AsString;
      cdsRelatorioQUEBRA.AsString     := qryRelatorio.FieldByName('QUEBRA').AsString;
      cdsRelatorioDET_CODITE.AsString := diverg.strCodIte;
      cdsRelatorioDET_DESCRI.AsString := diverg.strDesIte;
      cdsRelatorioDET_CODUNI.AsString := diverg.strUnidad;
      cdsRelatorioDET_QTDDEV.AsFloat  := diverg.fltQtdDev;
      cdsRelatorioDET_UNIDEV.AsFloat  := diverg.fltUniDev;
      cdsRelatorioDET_TOTDEV.AsFloat  := diverg.fltTotDev;
      cdsRelatorioDET_QTDADE.AsFloat  := diverg.fltQtdAde;
      cdsRelatorioDET_UNIADE.AsFloat  := diverg.fltUniAde;
      cdsRelatorioDET_TOTADE.AsFloat  := diverg.fltTotAde;
      cdsRelatorioDET_QTDDIF.AsFloat  := diverg.fltQtdDif;
      cdsRelatorioDET_UNIDIF.AsFloat  := diverg.fltUniDif;
      cdsRelatorioDET_TOTDIF.AsFloat  := diverg.fltTotDif;
      cdsRelatorio.Post;
    End;

    qryRelatorio.Next;
    FreeAndNil(Divergencias);
  End;

  cdsRelatorio.IndexFieldNames := 'DET_DTAENT;DET_NUMDOC;DET_ESPDOC;DET_CODEMP;DET_CODEMP';

  If Not cdsRelatorio.IsEmpty Then
  Begin
    If strTipImp = 'M' Then
    Begin
      frxRel := frxRelatorioM;
    End
    Else
    Begin
      frxRel := frxRelatorioJ;
      frxRel.PrintOptions.PrintMode := pmScale;
      frxRel.PrintOptions.PrintOnSheet := 9;
    End;

    frxRel.Script.Variables['NOMREL'] := 'CONFERENCIA DE DEVOLUCOES X ADS';
    frxRel.Script.Variables['CLIENTE'] := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrCliente, strCliente, 'CLIENTE');

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      frxRel.Script.Variables['PERIODO'] := 'PERIODO: TOTAL'
    Else
      frxRel.Script.Variables['PERIODO'] := 'PERIODO: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

    frxRel.Script.Variables['DIVERGENCIAS'] := 'MOSTRAR SOMENTE DIVERGENCIAS: ' + IIF(chkExiSomDiv.Checked, 'SIM', 'NAO');

    pCarregaConfImpr(qryCfgRel, Self.Name);
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    frxRel.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');

    If edtDestino.Text = 'V' Then
    Begin
      If frxRel.PrepareReport Then
        pPreviewReport(Self.Name, Self.Caption, frxRel);
    End
    Else
    Begin
      If frxRel.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomeFila, frxRel);
    End;
  End
  Else
  Begin
    pTabelaVazia;
    pSetFocus(edtNumDoc);
  End;

  cdsRelatorio.IndexFieldNames := '';

  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstConferenciaDevAD.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrCliente, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmRelEstConferenciaDevAD.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstConferenciaDevAD.edtNumDocChange(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtNumDoc.Text)) Or
     (Not fEmptyStr(edtEspDoc.Text)) Or
     (Not fEmptyStr(edtSerie.Text)) Then
  Begin
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;
  End
  Else
  Begin
    pSetaDataAtual;
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
  End;
end;

procedure TfrmRelEstConferenciaDevAD.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsRelatorioDET_CODITE);
  cdsRelatorio.CreateDataSet;
  pSetaDataAtual;
end;

procedure TfrmRelEstConferenciaDevAD.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmRelEstConferenciaDevAD.pSetaDataAtual;
begin
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

end.
