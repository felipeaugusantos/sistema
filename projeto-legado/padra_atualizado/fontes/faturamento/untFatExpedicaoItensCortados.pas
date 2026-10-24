unit untFatExpedicaoItensCortados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, DB, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,
  MemDS, DBAccess, Uni, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, untPaiOrdena, untIZClient, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatExpedicaoItensCortados = class(TfrmPai)
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1TableView1: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1TableView1CODITE: TcxGridDBColumn;
    cxGridCitel1TableView1CODFAB: TcxGridDBColumn;
    cxGridCitel1TableView1LOCEST: TcxGridDBColumn;
    cxGridCitel1TableView1DESITE: TcxGridDBColumn;
    cxGridCitel1TableView1MLTVEN: TcxGridDBColumn;
    cxGridCitel1TableView1UNIDAD: TcxGridDBColumn;
    cxGridCitel1TableView1QTDCOR: TcxGridDBColumn;
    cxGridCitel1TableView1ENTSAI: TcxGridDBColumn;
    dtsDados: TDataSource;
    cxGridCitel1TableView1SALDIS: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    cdsConsulta : IZClient;
    procedure pCalcularQuantidadeCortada;
    procedure pRemoverNaoCortados;
    function fGetSql: String;
    function fGetSqlPedidoCortado: String;
    procedure pAjustaSequencia;
    function fTemPedidoAutomaticoVendaDireta: Boolean;
  public
    { Public declarations }
    stlPedidos : TStringList;
    cdsIteExp : IZClient;
    blnVendaPerdidaAutomatica: Boolean;
  end;

implementation

{$R *.dfm}

uses untFatGor, untZClient, untFuncFatTypes;

function TfrmFatExpedicaoItensCortados.fGetSql: String;
  Var
    intPed : Integer;
    objPedido : TPedidoVenda;
Begin
  Result := '';
  Result := Result + ' SELECT D.AUTOINCREM AS AUTINC, ';
  Result := Result + '        D.FDO_CODITE AS CODITE, ';
  Result := Result + '        I.ITE_CODFAB AS CODFAB, ';
  Result := Result + '        G.ITE_LOCFIS AS LOCEST, ';
  Result := Result + '        D.FDO_DESCRI AS DESITE, ';
  Result := Result + '        G.ITE_SALDOS AS SALEST, ';
  Result := Result + '        I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '        U.UNI_SIGUNI AS UNIDAD, ';
  Result := Result + '        D.FDO_QTDITE - D.FDO_QTDBAI AS QTDITE, ';
  Result := Result + '        0.0000 AS QTDEXP, ';
  Result := Result + '        0.0000 AS QTDCOR, ';
  Result := Result + '        999999 AS SEQUEN, ';
  Result := Result + '        IF(LEFT(D.FDO_CLAFIS, 1) < "5", "E", "S") AS ENTSAI, ';
  Result := Result + fSQLSaldoDisponivel('G', True, False, True,
                                          fCfgSis('ENTFUT', varBoolean),
                                          fCfgSis('ORDPRO', varBoolean)) + ' AS SALDIS ';
  Result := Result + '   FROM FATDOR D ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + '                     AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  Result := Result + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + ' WHERE IFNULL(FDO_PROEMB, "N") <> "S" ';
  Result := Result + '   AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
  Result := Result + '   AND (D.FDO_QTDITE - D.FDO_QTDBAI) > 0 ';
  Result := Result + '   AND ( ';
  For intPed := 0 To stlPedidos.Count -1 Do
  Begin
    objPedido  := TPedidoVenda(stlPedidos.Objects[intPed]);
    Result := Result + ' (FDO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ';
    Result := Result + '  FDO_SEQGER = ' + QuotedStr(objPedido.strSeqGer) + ' AND ';
    Result := Result + '  FDO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ';
    Result := Result + '  FDO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ' AND ';
    Result := Result + '  FDO_CODCLI = ' + QuotedStr(objPedido.strCodCli) + ') ';
    If intPed < stlPedidos.Count -1 Then
      Result := Result + ' OR ';
  End;
  Result := Result + ' ) ';
End;

function TfrmFatExpedicaoItensCortados.fGetSqlPedidoCortado: String;
var
  intPed : Integer;
  objPedido : TPedidoVenda;
Begin
  Result := '';
  Result := Result + 'SELECT D.VPD_CODITE AS CODITE, ';
  Result := Result + '       C.ITE_CODFAB AS CODFAB, ';
  Result := Result + '       I.ITE_LOCFIS AS LOCEST, ';
  Result := Result + '       C.ITE_DESITE AS DESITE, ';
  Result := Result + '       C.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '       U.UNI_SIGUNI AS UNIDAD, ';
  Result := Result + '       CAST(999999 AS SIGNED) AS SEQUEN, ';
  Result := Result + '       CAST(SUM(D.VPD_QTDITE) AS DECIMAL (12, 4)) AS QTDCOR, ';
  Result := Result + '       CAST(" " AS CHAR(1)) AS ENTSAI, ';
  Result := Result + fSQLSaldoDisponivel('I', True, False, True,
                                          fCfgSis('ENTFUT', varBoolean),
                                          fCfgSis('ORDPRO', varBoolean)) + ' AS SALDIS ';
  Result := Result + 'FROM MOVVPG G ';
  Result := Result + 'INNER JOIN MOVVPD D ';
  Result := Result + 'ON(G.VPG_CODIGO = D.VPD_CODIGO) ';
  Result := Result + 'INNER JOIN CADITE C ';
  Result := Result + 'ON(D.VPD_CODITE = C.ITE_CODITE) ';
  Result := Result + 'INNER JOIN ITEGER I ';
  Result := Result + 'ON (C.ITE_CODITE = I.ITE_CODITE AND I.ITE_CODEMP = D.VPD_CODEMP) ';
  Result := Result + 'INNER JOIN CADUNI U ';
  Result := Result + 'ON(U.UNI_CODUNI = C.ITE_CODUNI) ';
  Result := Result + 'WHERE D.VPD_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
  Result := Result + '   AND ( ';

  For intPed := 0 To stlPedidos.Count -1 Do
  Begin
    objPedido  := TPedidoVenda(stlPedidos.Objects[intPed]);

    Result := Result + '(G.VPG_NUMDOC = '+QuotedStr(objPedido.strNumDoc)+' AND ';
    Result := Result + 'G.VPG_ESPDOC = '+QuotedStr(objPedido.strEspDoc)+' AND ';
    Result := Result + 'G.VPG_CODEMP = '+QuotedStr(objPedido.strCodEmp)+' AND ';
    Result := Result + 'G.VPG_CODCLI = '+QuotedStr(objPedido.strCodCli)+') ';
    If intPed < stlPedidos.Count -1 Then
      Result := Result + ' OR ';
  End;
  Result := Result + ' ) ';
  Result := Result + ' GROUP BY CODITE, CODFAB, LOCEST, DESITE, MLTVEN, UNIDAD ';

End;

procedure TfrmFatExpedicaoItensCortados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Assigned(stlPedidos) Then
    FreeAndNil(stlPedidos);
end;

procedure TfrmFatExpedicaoItensCortados.FormCreate(Sender: TObject);
begin
  inherited;
  cdsIteExp := TZClient.Create(Self, '');
  blnVendaPerdidaAutomatica := False;
  stlPedidos := TStringList.Create;
end;

procedure TfrmFatExpedicaoItensCortados.FormShow(Sender: TObject);
begin
  inherited;
  if (blnVendaPerdidaAutomatica) and (fTemPedidoAutomaticoVendaDireta) then
  begin
    cdsConsulta := TZClient.Create(Self, fGetSqlPedidoCortado);
    cxGridCitel1TableView1ENTSAI.Visible := False;
  end
  else
    cdsConsulta := TZClient.Create(Self, fGetSQL);

  dtsDados.DataSet := cdsConsulta.fGetDataset;
  cdsConsulta.fAbreClient();

  TFloatField(cdsConsulta.FieldByName('QTDCOR')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsConsulta.FieldByName('MLTVEN')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsConsulta.FieldByName('SALDIS')).DisplayFormat := fMskDigitos(4);

  if (blnVendaPerdidaAutomatica) and (fTemPedidoAutomaticoVendaDireta) then
    pAjustaSequencia
  else
    pCalcularQuantidadeCortada;

  pRemoverNaoCortados;

end;

function TfrmFatExpedicaoItensCortados.fTemPedidoAutomaticoVendaDireta: Boolean;
var
  strAutInc: string;
begin
  Result := False;
  for strAutInc in stlPedidos do
  begin
    if not (fPedidoGeraPedencia(strAutInc)) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TfrmFatExpedicaoItensCortados.pAjustaSequencia;
var
  intCnt : Integer;
Begin
  intCnt := 0;

  cdsIteExp.First;
  While Not cdsIteExp.Eof Do
  Begin
    intCnt := intCnt + 1;
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('SEQUEN').AsInteger := intCnt;
    cdsConsulta.Post;
    cdsIteExp.Next;
  End;
  cdsConsulta.IndexFieldNames := 'SEQUEN';
End;

procedure TfrmFatExpedicaoItensCortados.pCalcularQuantidadeCortada;
  Var
    intCnt : Integer;
Begin
  intCnt := 0;

  cdsIteExp.First;
  While Not cdsIteExp.Eof Do
  Begin
    If (cdsConsulta.Locate('AUTINC', cdsIteExp.FieldByName('AUTOINCREM').AsString, [])) Then
    Begin
      intCnt := intCnt + 1;
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('QTDEXP').AsFloat := cdsIteExp.FieldByName('QTDEXP').AsFloat;
      cdsConsulta.FieldByName('QTDCOR').AsFloat := cdsConsulta.FieldByName('QTDITE').AsFloat - cdsConsulta.FieldByName('QTDEXP').AsFloat;
      cdsConsulta.FieldByName('SEQUEN').AsInteger := intCnt;
      cdsConsulta.Post;
    End;
    cdsIteExp.Next;
  End;
  cdsConsulta.IndexFieldNames := 'SEQUEN';
End;

procedure TfrmFatExpedicaoItensCortados.pRemoverNaoCortados;
Begin
  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    If cdsConsulta.FieldByName('QTDCOR').AsFloat <= 0 Then
      cdsConsulta.Delete
    Else
      cdsConsulta.Next;
  End;
End;

end.


