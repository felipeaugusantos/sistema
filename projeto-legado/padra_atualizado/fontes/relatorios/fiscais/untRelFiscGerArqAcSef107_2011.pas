unit untRelFiscGerArqAcSef107_2011;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, Menus, Uni,
  Buttons, ExtCtrls, DirectoryEditFocus, StrUtils, AppEvnts, DB,
  UniClientDataSet, ComObj, ComCtrls, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, Datasnap.DBClient, 
  untFrameDirectoryEditFocus;

type
  TfrmRelFiscGerArqAcSef107_2011 = class(TfrmPai)
    pnlFundo: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblPathExp: TLabel;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    fraPathExp: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);

    procedure pCarregaEmpresa(Var qryCadEmp: TUniQuery);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    QryRelatorio : TUniQuery;

    function fRetUFEmpresa(strCodEmp: String): string;
    function fGetUnitarCreditoIcms(strCodIte: String): Double;
    function fGetSitTributariaEstadoEmpresa(strCodAbf: String): String;

    procedure pRetDadosAbfFornecedor( strCodAbf,
                                      strCodFor,
                                      strEstFor: String;
                                  Var fltAlqIcm,
                                      fltAlqRet,
                                      fltValIva,
                                      fltPerBas,
                                      fltPeBaST: Double;
                                  Var strCodSit: String );

    procedure pCalculaSubTributariaEntrada( strEstado,
                                            strCodFor,
                                            strCodIte,
                                            strCodAbf: String;
                                            fltTotIte,
                                            fltDesEsp,
                                            fltIpiEnt: Double;
                                        Var fltBasRet,
                                            fltAlqRet,
                                            fltValRet: Double );

    procedure pInsereProdutos(qryTmp: TUniQuery; strField: String);
    procedure pNotasEntradas(strCodIte: String = ''; blnPrepare: Boolean = False); // Notas de Entrada
    procedure pNotasSaidasDentroEstado(strCodIte: String = ''; blnPrepare: Boolean = False); // Notas de Saída Dentro do Estado
    procedure pNotasSaidasForaEstado(strCodIte: String = ''; blnPrepare: Boolean = False); // Notas de Saída  - Interestaduais
    procedure pNotasSaidasForaEstadoSubTri(strCodIte: String = ''; blnPrepare: Boolean = False); // Notas de Saída  - Interestaduais c/ Subst. Tributaria
    procedure pNotasSaidasConsFinal(strCodIte: String = ''; blnPrepare: Boolean = False); // Notas de Saída - Consumidor Final
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmRelFiscGerArqAcSef107_2011: TfrmRelFiscGerArqAcSef107_2011;

implementation

uses untExcel, untFuncoesGenerica, untConstantes, untTypesSistema,
  untFuncoesSimples, untConsultas, untIFuncoes, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelFiscGerArqAcSef107_2011.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cdsProdutos.Close;
  FreeAndNil(QryRelatorio);

  inherited;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsProdutosCODITE);
end;

procedure TfrmRelFiscGerArqAcSef107_2011.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  fraPathExp.edtDirectory.text := ExtractFilePath(Application.ExeName) + 'Acordo_SEFAZ_107_2011';
//  fraPathExp.edtDirectory.text := 'C:\Temp\Acordo_SEFAZ_107_2011';

  cdsProdutos.CreateDataSet;
  cdsProdutos.IndexFieldNames := 'CODITE';

  QryRelatorio := fCriaQuery;

  pSetFocus(mskDtaIni);

end;

procedure TfrmRelFiscGerArqAcSef107_2011.edtCodEmpresaKeyPress(Sender: TObject;var Key: Char);
  Var
    arrEmp : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.edtCodEmpresaExit(Sender: TObject);
  Var
    arrEmp : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
  If fEmptyStr(edtCodEmpresa.Text) Then edtDesEmpresa.Clear;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pCarregaEmpresa(Var qryCadEmp: TUniQuery);
begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pInsereProdutos(qryTmp: TUniQuery; strField: String);
begin
  qryTmp.First;
  While Not qryTmp.Eof Do
  Begin
    If Not cdsProdutos.FindKey([qryTmp.FieldByName(strField).AsString]) Then
    Begin
      cdsProdutos.Append;
      cdsProdutosCODITE.AsString := qryTmp.FieldByName(strField).AsString;
      cdsProdutos.Post;
    End; 
    qryTmp.Next;
  End;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pRetDadosAbfFornecedor( strCodAbf,
                                                                 strCodFor,
                                                                 strEstFor: String;
                                                             Var fltAlqIcm,
                                                                 fltAlqRet,
                                                                 fltValIva,
                                                                 fltPerBas,
                                                                 fltPeBaST: Double;
                                                             Var strCodSit: String );
  Var
    qryAux: TUniQuery;
    strTipAbf: String;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add(' * ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ABFICM ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ABF_CODABF = :CODABF AND ');
  qryAux.SQL.Add('  ABF_ESTADO = :ESTADO ');

  qryAux.ParamByName('CODABF').AsString := strCodAbf;
  qryAux.ParamByName('ESTADO').AsString := strEstFor;

  qryAux.Open;

  strTipAbf := fGetTipoAbfFornecedor(strCodFor);

  fltValIva := qryAux.FieldByName('ABF_IVA_ST' + strTipAbf).AsFloat;
  fltAlqIcm := qryAux.FieldByName('ABF_ALQICM' + strTipAbf).AsFloat;
  fltAlqRet := qryAux.FieldByName('ABF_ALQRET' + strTipAbf).AsFloat;
  fltPerBas := qryAux.FieldByName('ABF_BASICM' + strTipAbf).AsFloat;
  fltPeBaST := qryAux.FieldByName('ABF_BASRET' + strTipAbf).AsFloat;
  strCodSit := qryAux.FieldByName('ABF_CODSIT' + strTipAbf).AsString;

  FreeAndNil(qryAux);
end;

function TfrmRelFiscGerArqAcSef107_2011.fGetSitTributariaEstadoEmpresa(strCodAbf: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  ABF_CODSIT_SAI_CCO ');//CCO - CONTRIBUINTE CONSUMIDOR
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ABFICM ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ABF_CODABF = :CODABF AND ');
  qryAux.SQL.Add('  ABF_ESTADO = :ESTADO ');

  qryAux.ParamByName('CODABF').AsString := strCodAbf;
  qryAux.ParamByName('ESTADO').AsString := fCadEmp('ESTADO');

  qryAux.Open;

  Result := qryAux.FieldByName('ABF_CODSIT_SAI_CCO').AsString;

  FreeAndNil(qryAux);
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pCalculaSubTributariaEntrada( strEstado,
                                                                       strCodFor,
                                                                       strCodIte,
                                                                       strCodAbf: String;
                                                                       fltTotIte,
                                                                       fltDesEsp,
                                                                       fltIpiEnt: Double;
                                                                   Var fltBasRet,
                                                                       fltAlqRet,
                                                                       fltValRet: Double );
  Var
    strCodSit: String;
    fltBasIpi: Double;
    fltValIpi: Double;
    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;
    fltValIVA: Double;
    fltPerBas: Double;
    fltPeBaST: Double;
begin
  fltTotIte := fltTotIte - fltDesEsp;

  pRetDadosAbfFornecedor(strCodAbf, strCodFor, strEstado, fltAlqIcm, fltAlqRet, fltValIva, fltPerBas, fltPeBaST, strCodSit);

  strCodSit := fGetSitTributariaEstadoEmpresa(strCodAbf);//Deve olhar se a saída do produto é ST e não a entrada

  fltBasIpi := fltTotIte;
  fltValIpi := fFormataFloat(fltBasIpi * (fltIpiEnt / 100), 2);

  If fltValIpi <= 0 Then
  Begin
    fltValIpi := 0;
  End;

  fltBasIcm := fFormataFloat(fltTotIte * (fltPerBas / 100), 2);
  fltValIcm := fFormataFloat(fltBasIcm * (fltAlqIcm / 100), 2);

  If fltValIcm <= 0 Then
  Begin
    fltAlqIcm := 0;
    fltValIcm := 0;
  End;

  If Pos(strCodSit, CST_SUBSTITUICAO) > 0 Then
  Begin
    fltBasRet := fFormataFloat((fltTotIte + fltValIpi) * (fltPeBaST / 100) * fltValIva, 2);
    fltValRet := fFormataFloat(fltBasRet * (fltAlqRet / 100) - fltValIcm, 2);
  End
  Else
    fltValRet := 0;

  If fltValRet <= 0 Then
  Begin
    fltBasRet := 0;
    fltAlqRet := 0;
    fltValRet := 0;
  End;

end;

//retorna o unitario do icms da ultima nota de entrada ("<= data final")
function TfrmRelFiscGerArqAcSef107_2011.fGetUnitarCreditoIcms(strCodIte: String): Double;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE  ';
  strSQL := strSQL + '   DET_VALICM / DET_QTDITE AS UNICRE ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   DET_TIP_FC = "F"     AND ';
  strSQL := strSQL + '   DET_ESPDOC = "NF"    AND ';
  strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   DET_DTAENT <= :DTAFIN AND ';
  strSQL := strSQL + '   DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '   LOCATE(DET_CLAFIS, :CLACOM) > 0 AND ';
  strSQL := strSQL + '   DET_CODITE = :CODITE ';
  strSQL := strSQL + ' ORDER BY  ';
  strSQL := strSQL + '   DET_DTAENT DESC, DET_HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';

  With QryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLACOM').AsString := VS_strClaCom;
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := FieldByName('UNICRE').AsFloat;
  End;

end;

procedure TfrmRelFiscGerArqAcSef107_2011.pNotasEntradas(strCodIte: String; blnPrepare: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       CID_ESTADO AS ESTADO, ';
  strSQL := strSQL + '       DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       DET_HORENT AS HORDOC, ';  
  strSQL := strSQL + '       DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '       DET_QTDEMB AS QTDEMB, ';
  strSQL := strSQL + '       DET_ALQICM AS ALQICM, ';
  strSQL := strSQL + '       DET_TOTITE AS TOTITE, ';
  strSQL := strSQL + '       DET_DESESP AS DESESP, ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '     C.ITE_CODABF AS CODABF, '
  Else
    strSQL := strSQL + '     I.ITE_CODABF AS CODABF, ';

  strSQL := strSQL + '       ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '       DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       DET_VALICM AS VALICM, ';
  strSQL := strSQL + '       DET_BASRET AS BASRET, ';
  strSQL := strSQL + '       DET_VALRET AS VALRET, ';
  strSQL := strSQL + '       IF(IFNULL(DET_BASRET, 0) > 0, ROUND(DET_BASRET / DET_QTDITE, 2), "") AS BCRUNI, ';
  strSQL := strSQL + '       IF(IFNULL(DET_VALRET, 0) > 0, ROUND(DET_VALRET / DET_QTDITE, 2), "") AS ICMUNI, ';
  strSQL := strSQL + '       FOR_C_G_C_ AS FORCGC, ';
  strSQL := strSQL + '       FOR_CODFOR AS CODFOR  ';
  strSQL := strSQL + '  FROM MOVDET ';

  strSQL := strSQL + '  JOIN CADFOR ON CADFOR.FOR_CODFOR = MOVDET.DET_CODFOR ';
  strSQL := strSQL + '  JOIN CADCID ON CID_CODCID        = CADFOR.FOR_CODCID ';

  strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER I ON I.ITE_CODITE = DET_CODITE '+
                     '                     AND I.ITE_CODEMP = DET_CODEMP ';

  strSQL := strSQL + ' WHERE DET_TIP_FC = "F" ';
  strSQL := strSQL + '   AND DET_ESPDOC = "NF" ';
  strSQL := strSQL + '   AND DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
//  strSQL := strSQL + '   AND DET_CODFOR NOT IN ("' + AnsiReplaceStr(fRetForFilialTodos, '_', '","') + '") ';
  strSQL := strSQL + '   AND DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND LOCATE(DET_CLAFIS, :VALRES) > 0 ';

  If blnPrepare Then
    strSQL := strSQL + '  GROUP BY DET_CODITE '
  Else
    strSQL := strSQL + '  AND DET_CODITE = :CODITE ';

  strSQL := strSQL + '  ORDER BY DTADOC, HORDOC ';        

  With QryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('VALRES').AsString := VS_strClaCom;

    If Not fEmptyStr(strCodIte) Then
      ParamByName('CODITE').AsString := strCodIte;

    Open;

    If blnPrepare Then
    Begin
      pInsereProdutos(QryRelatorio, 'CODITE');
      Close;
    End;
  End;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pNotasSaidasDentroEstado(strCodIte: String; blnPrepare: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       CLI_C_G_C_   AS CLICGC, ';
  strSQL := strSQL + '       CID_ESTADO   AS ESTADO, ';
  strSQL := strSQL + '       D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       D.DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       D.DET_HORENT AS HORDOC, ';
  strSQL := strSQL + '       D.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '       D.DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       D.DET_VALICM AS VALICM, ';
  strSQL := strSQL + '       (D.DET_BASRET * D.DET_QTDITE) AS BASRET, ';
  strSQL := strSQL + '       (D.DET_VALRET * D.DET_QTDITE) AS VALRET  ';
  strSQL := strSQL + '  FROM MOVDET D ';
  strSQL := strSQL + '  JOIN MOVGER G ON D.DET_SEQGER      = G.AUTOINCREM ';
  strSQL := strSQL + '  JOIN CADCLI   ON D.DET_CODCLI      = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID   ON CADCLI.CLI_CODCID = CID_CODCID ';
  strSQL := strSQL + ' WHERE D.DET_ESTADO = :ESTADO ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = "C" ';
  strSQL := strSQL + '   AND D.DET_ESPDOC IN ("NF","EL","NV") ';
  strSQL := strSQL + '   AND D.DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND IFNULL(G.GER_IESCON,"") <> "" ';
  strSQL := strSQL + '   AND D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '   AND (LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) ';

  If blnPrepare Then
    strSQL := strSQL + '  GROUP BY D.DET_CODITE '
  Else
    strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSQL := strSQL + '  ORDER BY DTADOC, HORDOC ';  

  With QryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('ESTADO').AsString := fRetUFEmpresa(edtCodEmpresa.Text);

    If Not fEmptyStr(strCodIte) Then
      ParamByName('CODITE').AsString := strCodIte;    

    Open;

    If blnPrepare Then
    Begin
      pInsereProdutos(QryRelatorio, 'CODITE');
      Close;
    End;
  End;        
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pNotasSaidasForaEstado(strCodIte: String;
  blnPrepare: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       CLI_C_G_C_   AS CLICGC, ';
  strSQL := strSQL + '       CID_ESTADO   AS ESTADO, ';
  strSQL := strSQL + '       D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       D.DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       D.DET_HORENT AS HORDOC, ';
  strSQL := strSQL + '       D.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '       D.DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       D.DET_VALICM AS VALICM, ';
  strSQL := strSQL + '       ROUND((D.DET_BASICM * 12)/100, 2) AS ICM12, ';
  strSQL := strSQL + '       ROUND((D.DET_BASICM *  1)/100, 2) AS ICM01  ';
  strSQL := strSQL + '  FROM MOVDET D ';
  strSQL := strSQL + '  JOIN MOVGER G ON D.DET_SEQGER      = G.AUTOINCREM      ';
  strSQL := strSQL + '  JOIN CADCLI   ON D.DET_CODCLI      = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID   ON CADCLI.CLI_CODCID = CID_CODCID        ';
  strSQL := strSQL + ' WHERE D.DET_ESTADO <> :ESTADO ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = "C" ';
  strSQL := strSQL + '   AND D.DET_ESPDOC IN ("NF","EL","NV") ';
  strSQL := strSQL + '   AND D.DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND IFNULL(G.GER_IESCON,"") <> "" ';
//  strSQL := strSQL + '   AND D.DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '   AND D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '   AND (LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) ';

  {****************************************************}
  {* FILTRA OS DOCUMENTOS SEM SUBSTITUIÇÃO TRIBUTÁRIA *}
  {*************************************************PZ*}
  strSQL := strSQL + '   AND (IFNULL(G.GER_TOTRET, 0) = 0) ';

  If blnPrepare Then
    strSQL := strSQL + '  GROUP BY D.DET_CODITE '
  Else
    strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSQL := strSQL + '  ORDER BY DTADOC, HORDOC ';

  With QryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('ESTADO').AsString := fRetUFEmpresa(edtCodEmpresa.Text);

    If Not fEmptyStr(strCodIte) Then
      ParamByName('CODITE').AsString := strCodIte;

    Open;

    If blnPrepare Then
    Begin
      pInsereProdutos(QryRelatorio, 'CODITE');
      Close;
    End;
  End;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pNotasSaidasForaEstadoSubTri(strCodIte: String;
  blnPrepare: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       CLI_C_G_C_   AS CLICGC, ';
  strSQL := strSQL + '       CID_ESTADO   AS ESTADO, ';
  strSQL := strSQL + '       D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       D.DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       D.DET_HORENT AS HORDOC, ';
  strSQL := strSQL + '       D.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '       D.DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       D.DET_VALICM AS VALICM, ';
  strSQL := strSQL + '      (D.DET_BASRET * D.DET_QTDITE) AS BASRET, ';
  strSQL := strSQL + '      (D.DET_VALRET * D.DET_QTDITE) AS VALRET, ';
  strSQL := strSQL + '       ROUND((D.DET_BASICM * 12)/100, 2) AS ICM12, ';
  strSQL := strSQL + '       ROUND((D.DET_BASICM *  1)/100, 2) AS ICM01  ';
  strSQL := strSQL + '  FROM MOVDET D ';
  strSQL := strSQL + '  JOIN MOVGER G ON D.DET_SEQGER      = G.AUTOINCREM ';
  strSQL := strSQL + '  JOIN CADCLI   ON D.DET_CODCLI      = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID   ON CADCLI.CLI_CODCID = CID_CODCID ';
  strSQL := strSQL + ' WHERE D.DET_ESTADO <> :ESTADO ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = "C" ';
  strSQL := strSQL + '   AND D.DET_ESPDOC IN ("NF","EL","NV") ';
  strSQL := strSQL + '   AND D.DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND IFNULL(G.GER_IESCON,"") <> "" ';
//  strSQL := strSQL + '   AND D.DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '   AND D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '   AND (LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) ';

  {****************************************************}
  {* FILTRA OS DOCUMENTOS COM SUBSTITUIÇÃO TRIBUTÁRIA *}
  {*************************************************PZ*}
  strSQL := strSQL + '   AND (IFNULL(G.GER_TOTRET, 0) > 0) ';

  If blnPrepare Then
    strSQL := strSQL + '  GROUP BY D.DET_CODITE '
  Else
    strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSQL := strSQL + '  ORDER BY DTADOC, HORDOC ';

  With QryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('ESTADO').AsString := fRetUFEmpresa(edtCodEmpresa.Text);

    If Not fEmptyStr(strCodIte) Then
      ParamByName('CODITE').AsString := strCodIte;

    Open;

    If blnPrepare Then
    Begin
      pInsereProdutos(QryRelatorio, 'CODITE');
      Close;
    End;
  End;
end;

procedure TfrmRelFiscGerArqAcSef107_2011.pNotasSaidasConsFinal(strCodIte: String; blnPrepare: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '       CLI_C_G_C_   AS CLICGC, ';
  strSQL := strSQL + '       CID_ESTADO   AS ESTADO, ';
  strSQL := strSQL + '       G.GER_IESCON AS IESCON, ';
  strSQL := strSQL + '       D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '       D.DET_DTAENT AS DTADOC, ';
  strSQL := strSQL + '       D.DET_HORENT AS HORDOC, ';
  strSQL := strSQL + '       D.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '       D.DET_BASICM AS BASICM, ';
  strSQL := strSQL + '       D.DET_VALICM AS VALICM, ';
  strSQL := strSQL + '       (D.DET_BASRET * D.DET_QTDITE) AS BASRET, ';
  strSQL := strSQL + '       (D.DET_VALRET * D.DET_QTDITE) AS VALRET  ';
  strSQL := strSQL + '  FROM MOVDET D ';
  strSQL := strSQL + '  JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '  JOIN CADCLI   ON D.DET_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID   ON CLI_CODCID   = CID_CODCID ';
  strSQL := strSQL + ' WHERE D.DET_TIP_FC = "C" ';
  strSQL := strSQL + '   AND D.DET_ESPDOC IN ("NF","EL","NV") ';
  strSQL := strSQL + '   AND D.DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND IFNULL(G.GER_IESCON,"") = "" ';
//  strSQL := strSQL + '   AND D.DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '   AND D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '   AND (LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) ';

  If blnPrepare Then
    strSQL := strSQL + '  GROUP BY D.DET_CODITE '
  Else
    strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSQL := strSQL + '  ORDER BY DTADOC, HORDOC ';    

  With QryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString := VS_strClaVen;

    If Not fEmptyStr(strCodIte) Then
      ParamByName('CODITE').AsString := strCodIte;

    Open;

    If blnPrepare Then
    Begin
      pInsereProdutos(QryRelatorio, 'CODITE');
      Close;
    End;
  End;
end;

function TfrmRelFiscGerArqAcSef107_2011.fRetUFEmpresa(
  strCodEmp: String): string;
  Var
    qryEmp : TUniQuery;
begin
  qryEmp := fCriaQuery(Self);
  qryEmp.SQL.Add('SELECT CID_ESTADO ');
  qryEmp.SQL.Add('  FROM CADEMP, CADCID ');
  qryEmp.SQL.Add(' WHERE EMP_CODCID = CID_CODCID ');
  qryEmp.SQL.Add('   AND EMP_CODEMP = :CODEMP ');
  qryEmp.ParamByName('CODEMP').AsString := strCodEmp;
  qryEmp.Open;
  Result := qryEmp.FieldByName('CID_ESTADO').AsString;
  qryEmp.Close;
  FreeANdNil(qryEmp);
end;

function TfrmRelFiscGerArqAcSef107_2011.fValidaCampos(Sender: TWinControl;
           blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave )) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Inicial deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Final deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Data Inicial deve ser menor que a Data Final!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO','O código da empresa deve ser preenchido!',['&OK']);
        Result := False;
      End;

    End

    Else
    If (Sender  = fraPathExp) Then
    Begin

      If fEmptyStr(fraPathExp.edtDirectory.text) Then
      Begin
        fMensagem('ATENÇÃO','O Path para geração do arquivo deve ser preenchido!', ['&OK']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFiscGerArqAcSef107_2011.btnConfirmaClick(Sender: TObject);

  function fBarraNoFinal(strPath: String) : String;
    Var
      strTmp : String;
  Begin
    strTmp := strPath;
    If Not (strTmp[Length(strTmp)] = '\') Then
      Result := strTmp + '\'
    Else
      Result := strTmp;
  End;

  Var
    objExcel : TExcel;
    qryEmp : TUniQuery;

    fltBasRetEnt : Double;
    fltAlqRetEnt : Double;
    fltValRetEnt : Double;

    fltIcmSaiInternas : Real;
    fltIcmSaiInterEst : Real;
    fltIcmSaiIntEstST : Real;
    fltIcmSaiIConsFin : Real;

    fltTotIcmsSaiInte : Real;
    fltTotIcmsSaiFora : Real;

    fltCredIcmsUnitar : Real;
    fltCredIcmConsIte : Real;

begin
  inherited; 

  If Not fVerificaCampos Then
    Exit;

  Screen.Cursor := crHourGlass;
  fraPathExp.edtDirectory.text := fBarraNoFinal(fraPathExp.edtDirectory.text);
  qryEmp := fCriaQuery(Self);

  Try
    If Not DirectoryExists(fraPathExp.edtDirectory.text) Then
      ForceDirectories(fraPathExp.edtDirectory.text);
    btnConfirma.Enabled := False;
    pnlInfo.Caption := 'Gerando Arquivos...';
    pnlInfo.Repaint;
    cdsProdutos.EmptyDataSet;
    Application.ProcessMessages;

    qryEmp.SQL.Add('SELECT * ');
    qryEmp.SQL.Add('FROM CADEMP ');
    qryEmp.SQL.Add('WHERE EMP_CODEMP = :CODEMP ');
    qryEmp.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    qryEmp.Open;

    pNotasEntradas('', True);
    pNotasSaidasDentroEstado('', True);
    pNotasSaidasForaEstado('', True);
    pNotasSaidasForaEstadoSubTri('', True);
    pNotasSaidasConsFinal('', True);

    objExcel := TExcel.fCriarExcel(Self);

    pgbProgresso.Max := cdsProdutos.RecordCount;

    fltTotIcmsSaiInte := 0;
    fltTotIcmsSaiFora := 0;

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin

      pgbProgresso.Position := cdsProdutos.RecNo;
      Application.ProcessMessages;
      fltIcmSaiInternas := 0;
      fltIcmSaiInterEst := 0;
      fltIcmSaiIntEstST := 0;
      fltIcmSaiIConsFin := 0;

//      fltTotIcmsSaiInte := 0;
//      fltTotIcmsSaiFora := 0;

      fltCredIcmsUnitar := fGetUnitarCreditoIcms(cdsProdutosCODITE.AsString);

      With objExcel Do
      Begin
        objExcel.CriarArquivo(fraPathExp.edtDirectory.text + 'Acordo_SEFAZ_107_2011_' + cdsProdutosCODITE.AsString);

        PintarTudo(Branco);
        DefinirFonte(Times, 08);

        Escrever(02, 01, 'ANEXO ÚNICO DO TERMO DE ACORDO SEFAZ Nº 107/2011');
        Negrito (02, 01, True);
        Mesclar('A2', 'Q2');
        Alinhamento('A2', 'A2', Centro);

        Escrever(03, 01, 'TERMO DE ACORDO DE SUBSTITUIÇÃO TRIBUTÁRIA');
        Negrito (03, 01, True);
        Mesclar('A3', 'Q3');
        Alinhamento('A3', 'A3', Centro);

        Escrever(04, 01, 'DEMONSTRATIVO DO CÁLCULO DO ICMS-ST A RECOLHER');
        Negrito (04, 01, True);
        Mesclar('A4', 'Q4');
        Alinhamento('A4', 'A4', Centro);

        Bordas('A8',  'H15', True, True, True, True);
        Bordas('I8',  'Q15', True, True, True, True);
        Bordas('A18', 'K19', True, True, True, True);

        Escrever(08, 01, ' QUADRO 01 - Razão Social - Período: ' + mskDtaIni.Text + ' a ' + mskDtaFin.Text);
        Negrito (08, 01, True);
        Mesclar('A8', 'G8');
        Escrever(10, 01, fRetNomeEmpresaSelec(edtCodEmpresa.Text));
        Negrito (10, 01, True);
        Escrever(11, 01, fRetEnderecoEmpresa(edtCodEmpresa.Text));
        Negrito (11, 01, True);
        Escrever(12, 01, qryEmp.FieldByName('EMP_BAIRRO').AsString);
        Negrito (12, 01, True);
        Escrever(13, 01, 'CNPJ: ' + fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, fSetaPais));
        Negrito (13, 01, True);
        Escrever(14, 01, 'I.ESTADUAL: ' + qryEmp.FieldByName('EMP_I_E_S_').AsString);
        Negrito (14, 01, True);

        Escrever(08, 09, ' QUADRO 02');
        Negrito (08, 09, True);
        Mesclar('I8', 'P8');
        Escrever(09, 09, 'Produto: ');
        Negrito (09, 09, True);
        Escrever(09, 10, fRetNomProduto(cdsProdutosCODITE.AsString));
        CorFonte('J9', 'J9', Vermelho);
        Negrito (09, 10, True);
        Mesclar('J9', 'Q9');

        Escrever(18, 01, ' QUADRO 03 - NOTAS FISCAIS DE ENTRADA');
        Escrever(20, 01, 'CNPJ REMETENTE');
        Bordas('A20', 'A20');
        Escrever(20, 02, 'UF');
        Bordas('B20', 'B20');
        Escrever(20, 03, 'N° NF');
        Bordas('C20', 'C20');
        Escrever(20, 04, 'DATA');
        Bordas('D20', 'D20');
        Escrever(20, 05, 'QUANT.');
        Bordas('E20', 'E20');
        Escrever(20, 06, 'B.CALC.');
        Bordas('F20', 'F20');
        Escrever(20, 07, 'ICMS');
        Bordas('G20', 'G20');
        Escrever(20, 08, 'B.CALC.R');
        Bordas('H20', 'H20');
        Escrever(20, 09, 'ICMS R.');
        Bordas('I20', 'I20');
        Escrever(20, 10, 'BCR.UNIT.');
        Bordas('J20', 'J20');
        Escrever(20, 11, 'ICMS R.UNIT.');
        Bordas('K20', 'K20');
        Mesclar('A18', 'K18');

        CorFundo('A18', 'K20', RGB(135,200,250));

        LinhaAtual := 20;

        pNotasEntradas(cdsProdutosCODITE.AsString);

        With QryRelatorio Do
        Begin
          While Not Eof Do
          Begin
            ProximaLinha;

            pCalculaSubTributariaEntrada( FieldByName('ESTADO').AsString,
                                          FieldByName('CODFOR').AsString,
                                          FieldByName('CODITE').AsString,
                                          FieldByName('CODABF').AsString,
                                          FieldByName('TOTITE').AsFloat,
                                          FieldByName('DESESP').AsFloat,
                                          FieldByName('IPIENT').AsFloat,
                                          fltBasRetEnt,
                                          fltAlqRetEnt,
                                          fltValRetEnt );

            Escrever(LinhaAtual, 01, fFormataCpfCgc(FieldByName('FORCGC').AsString, fSetaPais));
            Escrever(LinhaAtual, 02, FieldByName('ESTADO').AsString);
            Escrever(LinhaAtual, 03, FieldByName('NUMDOC').AsString);
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', FieldByName('DTADOC').AsDateTime));
            Escrever(LinhaAtual, 05, FieldByName('QTDITE').AsString);
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 06, FieldByName('BASICM').AsString);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, FieldByName('VALICM').AsString);
            FormatoNumerico(LinhaAtual, 07);
//            Escrever(LinhaAtual, 08, FieldByName('BASRET').AsString);
            Escrever(LinhaAtual, 08, fltBasRetEnt);
            FormatoNumerico(LinhaAtual, 08);
//            Escrever(LinhaAtual, 09, FieldByName('VALRET').AsString);
            Escrever(LinhaAtual, 09, fltValRetEnt);
            FormatoNumerico(LinhaAtual, 09);
//            Escrever(LinhaAtual, 10, FieldByName('BCRUNI').AsString);
            Escrever(LinhaAtual, 10, fltBasRetEnt / FieldByName('QTDITE').AsFloat);
            FormatoNumerico(LinhaAtual, 10);
//            Escrever(LinhaAtual, 11, FieldByName('ICMUNI').AsString);
            Escrever(LinhaAtual, 11, fltValRetEnt / FieldByName('QTDITE').AsFloat);
            FormatoNumerico(LinhaAtual, 11);

            Alinhamento('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), Centro);
            Negrito('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), True);

            Next;
          End;
        End;

        ProximaLinha;
        ProximaLinha;

        Escrever(ProximaLinha, 01, ' QUADRO 04 - NOTAS FISCAIS DE SAÍDAS INTERNAS');
        Bordas('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), True, True, True, True);
        CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), RGB(135,200,250));
        Mesclar('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));

        ProximaLinha;
        ProximaLinha;

        Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
        Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 02, 'UF');
        Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 03, 'N° NF');
        Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 04, 'DATA');
        Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 05, 'QUANT.');
        Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 06, 'B.CALC.');
        Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 07, 'ICMS');
        Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 08, 'B.CALC.R');
        Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 09, 'ICMS R.');
        Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
        CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), RGB(135,200,250));

        pNotasSaidasDentroEstado(cdsProdutosCODITE.AsString);

        With QryRelatorio Do
        Begin
          While Not Eof Do
          Begin

            ProximaLinha;

            Escrever(LinhaAtual, 01, fFormataCpfCgc(FieldByName('CLICGC').AsString, fSetaPais));
            Escrever(LinhaAtual, 02, FieldByName('ESTADO').AsString);
            Escrever(LinhaAtual, 03, FieldByName('NUMDOC').AsString);
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', FieldByName('DTADOC').AsDateTime));
            Escrever(LinhaAtual, 05, FieldByName('QTDITE').AsString);
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 06, FieldByName('BASICM').AsString);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, FieldByName('VALICM').AsString);
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 08, FieldByName('BASRET').AsString);
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 09, FieldByName('VALRET').AsString);
            FormatoNumerico(LinhaAtual, 09);
            fltIcmSaiInternas := fltIcmSaiInternas + FieldByName('VALRET').AsFloat;
            fltTotIcmsSaiInte := fltTotIcmsSaiInte + FieldByName('VALRET').AsFloat;

            Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Centro);
            Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

            Next;
          End;

          ProximaLinha;
          Escrever(LinhaAtual, 08, 'TOTAL A');
          Escrever(LinhaAtual, 09, FloatToStr(fltIcmSaiInternas));
          FormatoNumerico(LinhaAtual, 09);
          Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Centro);
          Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

        End;

        ProximaLinha;
        ProximaLinha;

        Escrever(ProximaLinha, 01, ' QUADRO 05 - NOTAS FISCAIS DE SAÍDAS INTERESTADUAIS');
        Bordas('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual+1), True, True, True, True);
        CorFundo('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual+1), RGB(135,200,250));
        Mesclar('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));

        ProximaLinha;
        ProximaLinha;

        Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
        Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 02, 'UF');
        Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 03, 'N° NF');
        Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 04, 'DATA');
        Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 05, 'QUANT.');
        Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 06, 'B.CALC.');
        Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 07, 'ICMS 12%');
        Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 08, 'ICMS 1%');
        Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
        CorFundo('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), RGB(135,200,250));

        pNotasSaidasForaEstado(cdsProdutosCODITE.AsString);

        With QryRelatorio Do
        Begin
          While Not Eof Do
          Begin

            ProximaLinha;

            Escrever(LinhaAtual, 01, fFormataCpfCgc(FieldByName('CLICGC').AsString, fSetaPais));
            Escrever(LinhaAtual, 02, FieldByName('ESTADO').AsString);
            Escrever(LinhaAtual, 03, FieldByName('NUMDOC').AsString);
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', FieldByName('DTADOC').AsDateTime));
            Escrever(LinhaAtual, 05, FieldByName('QTDITE').AsString);
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 06, FieldByName('BASICM').AsString);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, FieldByName('ICM12').AsString);
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 08, FieldByName('ICM01').AsString);
            FormatoNumerico(LinhaAtual, 08);
            fltIcmSaiInterEst := fltIcmSaiInterEst + FieldByName('ICM01').AsFloat;
            fltTotIcmsSaiFora := fltTotIcmsSaiFora + FieldByName('ICM01').AsFloat;

            Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Centro);
            Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

            Next;
          End;

          ProximaLinha;
          Escrever(LinhaAtual, 07, 'TOTAL B');
          Escrever(LinhaAtual, 08, FloatToStr(fltIcmSaiInterEst));
          FormatoNumerico(LinhaAtual, 08);
          Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Centro);
          Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

        End;

        ProximaLinha;
        ProximaLinha;

        Escrever(ProximaLinha, 01, ' QUADRO 06 - NOTAS FISCAIS DE SAÍDAS INTERESTADUAIS COM SUBSTITUIÇÃO TRIBUTÁRIA');
        Bordas('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual+1), True, True, True, True);
        CorFundo('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual+1), RGB(135,200,250));
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));

        ProximaLinha;
        ProximaLinha;

        Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
        Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 02, 'UF');
        Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 03, 'N° NF');
        Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 04, 'DATA');
        Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 05, 'QUANT.');
        Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 06, 'B.CALC.');
        Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 07, 'ICMS 12%');
        Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 08, 'ICMS 1%');
        Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 09, 'B.CALC.R');
        Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 10, 'ICMS R.');
        Bordas('J' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        CorFundo('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), RGB(135,200,250));

        pNotasSaidasForaEstadoSubTri(cdsProdutosCODITE.AsString);

        With QryRelatorio Do
        Begin
          While Not Eof Do
          Begin

            ProximaLinha;

            Escrever(LinhaAtual, 01, fFormataCpfCgc(FieldByName('CLICGC').AsString, fSetaPais));
            Escrever(LinhaAtual, 02, FieldByName('ESTADO').AsString);
            Escrever(LinhaAtual, 03, FieldByName('NUMDOC').AsString);
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', FieldByName('DTADOC').AsDateTime));
            Escrever(LinhaAtual, 05, FieldByName('QTDITE').AsString);
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 06, FieldByName('BASICM').AsString);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, FieldByName('ICM12').AsString);
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 08, FieldByName('ICM01').AsString);
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 09, FieldByName('BASRET').AsString);
            FormatoNumerico(LinhaAtual, 09);
            Escrever(LinhaAtual, 10, FieldByName('VALRET').AsString);
            FormatoNumerico(LinhaAtual, 10);
            fltIcmSaiIntEstST := fltIcmSaiIntEstST + FieldByName('ICM01').AsFloat;
            fltTotIcmsSaiFora := fltTotIcmsSaiFora + FieldByName('ICM01').AsFloat;

            Alinhamento('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), Centro);
            Negrito('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual), True);

            Next;
          End;

          ProximaLinha;
          Escrever(LinhaAtual, 07, 'TOTAL C');
          Escrever(LinhaAtual, 08, FloatToStr(fltIcmSaiIntEstST));
          FormatoNumerico(LinhaAtual, 08);
          Alinhamento('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Centro);
          Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

        End;

        ProximaLinha;
        ProximaLinha;

        Escrever(ProximaLinha, 01, ' QUADRO 07 - NOTAS FISCAIS DE SAÍDAS CONSUMIDOR FINAL');
        Bordas('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), True, True, True, True);
        CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual+1), RGB(135,200,250));
        Mesclar('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));

        ProximaLinha;
        ProximaLinha;

        Escrever(LinhaAtual, 01, 'CNPJ DESTINATÁRIO');
        Bordas('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 02, 'UF');
        Bordas('B' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 03, 'N° NF');
        Bordas('C' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 04, 'DATA');
        Bordas('D' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 05, 'QUANT.');
        Bordas('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 06, 'B.CALC.');
        Bordas('F' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 07, 'ICMS');
        Bordas('G' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 08, 'CRED.ICMS');
        Bordas('H' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
        Escrever(LinhaAtual, 09, 'ICMS A PAGAR');
        Bordas('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
        CorFundo('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), RGB(135,200,250));

        pNotasSaidasConsFinal(cdsProdutosCODITE.AsString);

        With QryRelatorio Do
        Begin
          While Not Eof Do
          Begin

            ProximaLinha;

            fltCredIcmConsIte := fStrToFloat(FloatToStrF(FieldByName('QTDITE').AsFloat * fltCredIcmsUnitar, ffFixed, 15, 2));

            Escrever(LinhaAtual, 01, fFormataCpfCgc(FieldByName('CLICGC').AsString, fSetaPais));
            Escrever(LinhaAtual, 02, FieldByName('ESTADO').AsString);
            Escrever(LinhaAtual, 03, FieldByName('NUMDOC').AsString);
            FormatoNumerico(LinhaAtual, 04, '@');
            Escrever(LinhaAtual, 04, FormatDateTime('DD/MM/YYYY', FieldByName('DTADOC').AsDateTime));
            Escrever(LinhaAtual, 05, FieldByName('QTDITE').AsString);
            FormatoNumerico(LinhaAtual, 05);
            Escrever(LinhaAtual, 06, FieldByName('BASICM').AsString);
            FormatoNumerico(LinhaAtual, 06);
            Escrever(LinhaAtual, 07, FieldByName('VALICM').AsString);
            FormatoNumerico(LinhaAtual, 07);
            Escrever(LinhaAtual, 08, FloatToStr(fltCredIcmConsIte));
            FormatoNumerico(LinhaAtual, 08);
            Escrever(LinhaAtual, 09, FloatToStr(FieldByName('VALICM').AsFloat - fltCredIcmConsIte));//ICMS A PAGAR VALICM - CRED.ICMS
            FormatoNumerico(LinhaAtual, 09);

            fltIcmSaiIConsFin := fltIcmSaiIConsFin + (FieldByName('VALICM').AsFloat - fltCredIcmConsIte);
            fltTotIcmsSaiInte := fltTotIcmsSaiInte + (FieldByName('VALICM').AsFloat - fltCredIcmConsIte);

            Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Centro);
            Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

            Next;
          End;

          ProximaLinha;
          Escrever(LinhaAtual, 08, 'TOTAL D');
          Escrever(LinhaAtual, 09, FloatToStr(fltIcmSaiIConsFin));
          FormatoNumerico(LinhaAtual, 09);
          Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Centro);
          Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

        End;

        ProximaLinha;
        ProximaLinha;

        Escrever(ProximaLinha,  01, ' QUADRO 08 ');  // 2
        Escrever(LinhaAtual, 04, 'TOTAL A (+)');
        Escrever(LinhaAtual, 07, 'TOTAL B (+)');
        Escrever(LinhaAtual, 10, 'TOTAL C (+)');
        Escrever(LinhaAtual, 13, 'TOTAL D (+)');
        Escrever(LinhaAtual, 15, ' ');
        Escrever(LinhaAtual, 16, 'TOTAL E = TOTAL A + TOTAL B + TOTAL C + TOTAL D');
        Escrever(LinhaAtual, 17, ' ');
        ProximaLinha;
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Icms-ST a recolher nas');
        Escrever(LinhaAtual, 06, 'Icms a recolher nas');
        Escrever(LinhaAtual, 09, 'Icms a recolher nas saídas');
        Escrever(LinhaAtual, 12, 'Icms a recolher nas');
        Escrever(LinhaAtual, 15, 'Valor a recolher a título de ST');
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'saídas internas');
        Escrever(LinhaAtual, 06, 'saídas interestaduais');
        Escrever(LinhaAtual, 09, 'interestaduais com Sit. Trib.');
        Escrever(LinhaAtual, 12, 'saídas a consumidor final');
        Escrever(LinhaAtual, 15, '(cláusula terceira Termo de Acordo SEFAZ Nº 107/2011)');
        ProximaLinha;
        Escrever(LinhaAtual, 04, fltIcmSaiInternas);
        FormatoNumerico(LinhaAtual, 04);
        Escrever(LinhaAtual, 07, fltIcmSaiInterEst);
        FormatoNumerico(LinhaAtual, 07);
        Escrever(LinhaAtual, 10, fltIcmSaiIntEstST);
        FormatoNumerico(LinhaAtual, 10);
        Escrever(LinhaAtual, 13, fltIcmSaiIConsFin);
        FormatoNumerico(LinhaAtual, 13);
        Escrever(LinhaAtual, 16, fltIcmSaiInternas+fltIcmSaiInterEst+fltIcmSaiIntEstST+fltIcmSaiIConsFin);
        FormatoNumerico(LinhaAtual, 16);

        Mesclar('A'     + IntToStr(LinhaAtual-4), 'B' + IntToStr(LinhaAtual-4));
        Bordas('A'      + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), True, True, True, True);
        Alinhamento('A' + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), Esquerda);

        Mesclar('C'     + IntToStr(LinhaAtual-1), 'E' + IntToStr(LinhaAtual-1));
        Mesclar('C'     + IntToStr(LinhaAtual-2), 'E' + IntToStr(LinhaAtual-2));
        Bordas('C'      + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), True, True, True, True);
        Alinhamento('C' + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), Centro);

        Mesclar('F'     + IntToStr(LinhaAtual-1), 'H' + IntToStr(LinhaAtual-1));
        Mesclar('F'     + IntToStr(LinhaAtual-2), 'H' + IntToStr(LinhaAtual-2));
        Bordas('F'      + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), True, True, True, True);
        Alinhamento('F' + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), Centro);

        Mesclar('I'     + IntToStr(LinhaAtual-1), 'K' + IntToStr(LinhaAtual-1));
        Mesclar('I'     + IntToStr(LinhaAtual-2), 'K' + IntToStr(LinhaAtual-2));
        Bordas('I'      + IntToStr(LinhaAtual)  , 'K' + IntToStr(LinhaAtual-4), True, True, True, True);
        Alinhamento('I' + IntToStr(LinhaAtual)  , 'K' + IntToStr(LinhaAtual-4), Centro);
        
        Mesclar('L'     + IntToStr(LinhaAtual-1), 'N' + IntToStr(LinhaAtual-1));
        Mesclar('L'     + IntToStr(LinhaAtual-2), 'N' + IntToStr(LinhaAtual-2));
        Bordas('L'      + IntToStr(LinhaAtual)  , 'N' + IntToStr(LinhaAtual-4), True, True, True, True);
        Alinhamento('L' + IntToStr(LinhaAtual)  , 'N' + IntToStr(LinhaAtual-4), Centro);

        Mesclar('O'     + IntToStr(LinhaAtual-1), 'Q' + IntToStr(LinhaAtual-1));
        Mesclar('O'     + IntToStr(LinhaAtual-2), 'Q' + IntToStr(LinhaAtual-2));
        Bordas('O'      + IntToStr(LinhaAtual)  , 'Q' + IntToStr(LinhaAtual-4), True, True, True, True);
        Alinhamento('O' + IntToStr(LinhaAtual)  , 'Q' + IntToStr(LinhaAtual-4), Centro);

        CorFundo('A'    + IntToStr(LinhaAtual), 'Q' + IntToStr(LinhaAtual-4), RGB(135,200,250));

        AutoAjuste;
        SalvarArquivo;
        FecharArquivo;

      End;
      cdsProdutos.Next;

    End;

    With objExcel Do
    Begin
      objExcel.CriarArquivo(fraPathExp.edtDirectory.text + 'Acordo_SEFAZ_107_2011_TOTAIS');

      PintarTudo(Branco);
      DefinirFonte(Times, 08);

      Escrever(02, 01, 'ANEXO ÚNICO DO TERMO DE ACORDO SEFAZ Nº 107/2011');
      Negrito (02, 01, True);
      Mesclar('A2', 'M2');
      Alinhamento('A2', 'A2', Centro);

      Escrever(03, 01, 'TERMO DE ACORDO DE SUBSTITUIÇÃO TRIBUTÁRIA');
      Negrito (03, 01, True);
      Mesclar('A3', 'M3');
      Alinhamento('A3', 'A3', Centro);

      Escrever(04, 01, 'DEMONSTRATIVO DO CÁLCULO DO ICMS-ST A RECOLHER');
      Negrito (04, 01, True);
      Mesclar('A4', 'M4');
      Alinhamento('A4', 'A4', Centro);

      Bordas('A8',  'H15', True, True, True, True);
      Bordas('I8',  'M15', True, True, True, True);

      Escrever(08, 01, ' QUADRO 01 - Razão Social - Periodo: ' + mskDtaIni.Text + ' a ' + mskDtaFin.Text);
      Negrito (08, 01, True);
      Mesclar('A8', 'G8');
      Escrever(10, 01, fRetNomeEmpresaSelec(edtCodEmpresa.Text));
      Negrito (10, 01, True);
      Escrever(11, 01, fRetEnderecoEmpresa(edtCodEmpresa.Text));
      Negrito (11, 01, True);
      Escrever(12, 01, qryEmp.FieldByName('EMP_BAIRRO').AsString);
      Negrito (12, 01, True);
      Escrever(13, 01, 'CNPJ: ' + fFormataCpfCgc(qryEmp.FieldByName('EMP_C_G_C_').AsString, fSetaPais));
      Negrito (13, 01, True);
      Escrever(14, 01, 'I.ESTADUAL: ' + qryEmp.FieldByName('EMP_I_E_S_').AsString);
      Negrito (14, 01, True);

      Escrever(08, 09, ' QUADRO 02');
      Negrito (08, 09, True);
      Mesclar('I8', 'L8');
      Escrever(09, 09, 'Produto: ');
      Negrito (09, 09, True);
      Escrever(09, 10, 'TODOS');
      CorFonte('J9', 'J9', Vermelho);
      Negrito (09, 10, True);
      Mesclar('J9', 'M9');

      LinhaAtual := 17;

      Escrever(ProximaLinha,  01, ' QUADRO 03 ');  // 2
      Escrever(LinhaAtual, 04, 'TOTAL A (+)');
      Escrever(LinhaAtual, 07, 'TOTAL B (+)');
      Escrever(LinhaAtual, 11, 'TOTAL C = TOTAL A + TOTAL B');
      ProximaLinha;
      ProximaLinha;
      Escrever(LinhaAtual, 03, 'Icms-ST a recolher nas saídas internas');
      Escrever(LinhaAtual, 06, 'Icms a recolher nas saídas interestaduais');
      Escrever(LinhaAtual, 09, 'Valor a recolher a título de ST');
      ProximaLinha;
      Escrever(LinhaAtual, 03, '(TOTAL DO PERÍODO)');
      Escrever(LinhaAtual, 06, '(TOTAL DO PERÍODO)');
      Escrever(LinhaAtual, 09, '(cláusula terceira Termo de Acordo SEFAZ Nº 107/2011)');
      ProximaLinha;
      Escrever(LinhaAtual, 04, fltTotIcmsSaiInte);
      FormatoNumerico(LinhaAtual, 04);
      Escrever(LinhaAtual, 07, fltTotIcmsSaiFora);
      FormatoNumerico(LinhaAtual, 07);
      Escrever(LinhaAtual, 11, fltTotIcmsSaiInte+fltTotIcmsSaiFora);
      FormatoNumerico(LinhaAtual, 11);

      Mesclar('A'     + IntToStr(LinhaAtual-4), 'B' + IntToStr(LinhaAtual-4));
      Bordas('A'      + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('A' + IntToStr(LinhaAtual)  , 'B' + IntToStr(LinhaAtual-4), Esquerda);

      Mesclar('C'     + IntToStr(LinhaAtual-1), 'E' + IntToStr(LinhaAtual-1));
      Mesclar('C'     + IntToStr(LinhaAtual-2), 'E' + IntToStr(LinhaAtual-2));
      Bordas('C'      + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('C' + IntToStr(LinhaAtual)  , 'E' + IntToStr(LinhaAtual-4), Centro);

      Mesclar('F'     + IntToStr(LinhaAtual-1), 'H' + IntToStr(LinhaAtual-1));
      Mesclar('F'     + IntToStr(LinhaAtual-2), 'H' + IntToStr(LinhaAtual-2));
      Bordas('F'      + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('F' + IntToStr(LinhaAtual)  , 'H' + IntToStr(LinhaAtual-4), Centro);

      Mesclar('I'     + IntToStr(LinhaAtual-1), 'M' + IntToStr(LinhaAtual-1));
      Mesclar('I'     + IntToStr(LinhaAtual-2), 'M' + IntToStr(LinhaAtual-2));
      Bordas('I'      + IntToStr(LinhaAtual)  , 'M' + IntToStr(LinhaAtual-4), True, True, True, True);
      Alinhamento('I' + IntToStr(LinhaAtual)  , 'M' + IntToStr(LinhaAtual-4), Centro);

      CorFundo('A'    + IntToStr(LinhaAtual), 'M' + IntToStr(LinhaAtual-4), RGB(255,250,130));

      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

    End;

    fMensagem('', 'O arquivo de exportação foi gerado com sucesso!', ['&OK']);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelFiscGerArqAcSef107_2011.btnConfirmaClick]');
  End;

  Screen.Cursor := crDefault;
  pgbProgresso.Position := 0;
  qryEmp.Close;
  FreeAndNil(qryEmp);
  FreeAndNil(objExcel);

  pnlInfo.Caption := '';
  btnConfirma.Enabled := True;
end;

end.
