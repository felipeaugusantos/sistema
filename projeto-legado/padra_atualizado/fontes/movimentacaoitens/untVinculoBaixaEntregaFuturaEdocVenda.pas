unit untVinculoBaixaEntregaFuturaEdocVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untZClient, untFuncoesSimples, cxButtonEdit,
  System.Actions, Vcl.ActnList, cxGridBandedTableView, cxGridDBBandedTableView,
  Datasnap.DBClient, Uni, System.StrUtils, cxButtons,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untMsgLiberacao;

type
  TTipoValidacao = (ldEncotrou,
                    ldItensDisponiveis,
                    ldEncontrouItens,
                    ldCFOP,
                    ldOk,
                    ldIndefinido);

  TTipoResultadoValidacao = (rvNaoEncontrou,
                             rvItensIndisponiveis,
                             rvNaoEncontrouItens,
                             rvCFOPInvalido,
                             rvOk,
                             rvIndefinido);


  TfrmVinculoBaixaEntregaFuturaEdocVenda = class(TfrmPaiConfirma)
    dtsItens: TDataSource;
    Panel1: TPanel;
    cxItens: TcxGridCitel;
    cxItensView: TcxGridDBTableViewCitel;
    cxItensCODITE: TcxGridDBColumn;
    cxItensDESCRI: TcxGridDBColumn;
    cxItensSIGUNI: TcxGridDBColumn;
    cxItensQTDITE: TcxGridDBColumn;
    cxItensQTDATD: TcxGridDBColumn;
    cxItensLvl: TcxGridLevel;
    Panel2: TPanel;
    ActionList1: TActionList;
    actVincularx922: TAction;
    Splitter1: TSplitter;
    cxItensMARCAD: TcxGridDBColumn;
    Panel3: TPanel;
    btnMarcaDesmarca: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    cxGrid: TcxGrid;
    cxbands: TcxGridDBBandedTableView;
    cxGridLevel1: TcxGridLevel;
    cxbandsColumn1: TcxGridDBBandedColumn;
    cxbandsColumn2: TcxGridDBBandedColumn;
    cxbandsColumn3: TcxGridDBBandedColumn;
    cxbandsColumn4: TcxGridDBBandedColumn;
    cxbandsColumn5: TcxGridDBBandedColumn;
    cxbandsColumn6: TcxGridDBBandedColumn;
    cxbandsColumn7: TcxGridDBBandedColumn;
    dtsVinculo: TDataSource;
    cxbandsColumn8: TcxGridDBBandedColumn;
    Panel4: TPanel;
    btnRemoveVinculo: TBitBtnLocked;
    btnRemoverTodosVinculos: TBitBtnLocked;
    btnHlpImp: TcxButton;
    frxHelp: TfrxReport;
    cx: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actVincularx922Execute(Sender: TObject);

    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);

    procedure cxItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dtsVinculoUpdateData(Sender: TObject);
    procedure btnRemoverTodosVinculosClick(Sender: TObject);
    procedure btnRemoveVinculoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  protected
    FPreNota: Boolean;
    FAutIncGerEle: String;
    FConverteEmbalagens: Boolean;
    procedure pIniciaProcesso;
    procedure pPreparaCdsVinculoPreNota;
    procedure pLimpacdsPreNotaVinculos;

  private
    qryConsulta: TUniQuery;
    cdsTmp: TZClient;
    FLstItensMarcados: TStringList;
    objLiberacao : TLiberacao;
    blnCarregaPreDefida: Boolean;
    { Private declarations }
    function fGetSQLEstruturaItens: string;
    function fGetSQLEstruturaItensEntrada: string;
    function fGetSQLEstruturaItensPreNota: String;

    function fGetSQLEstruturaVinculo: String;
    function fGetSQLEstruturaVinculoEntrada: String;
    function fGetSQLEstruturaVinculoPreNota: String;
    function fGetSQLEstruturaPreNotaVinculos: String;

    function fTemVinculo: boolean;
    procedure pMarcaDesmarcaUnitario(blnExibeMensagem: boolean);

    procedure pGerenciaLista;
    procedure pMarcaDesmarcaTotal(blnMarcar: boolean);
    function fLocalizaDocumento: TTipoResultadoValidacao;
    function fGetQtdMarcada: Integer;
    function fx922InformadoAindaTemSaldo(strCodIte: string): boolean;
    procedure pMontaFiltroCDS(cds: TZClient; Filtro: String);
    procedure pRelacionarDocumentoComCdsItens;
    procedure pInsereNovaLinhaVinculo;
    procedure pGerenciaVisualizaoVinculados(blnOrigemMarcadoTodos: Boolean = False);
    procedure pRemoverVinculo;
    procedure pReduzirQtdAtd(qtdReduzir: Double; id: string);
    procedure pAjustarCdsVinculoComMaisDeUmVazio(id: string = '');
    procedure pRemoveTodosOsVinculos;
    procedure pAjustaQuantidade;
    function fTemPredefinicao: boolean;
    procedure pSetaIndex;
    procedure pSetaIndexParaGravacao;


  public
    cdsItens: TZClient;
    cdsVinculo: TZClient;
    cdsPreNotaVinculos: TZClient;
    blnJaLiberado: Boolean;
    class function fVincularX922_x117(strAutInc: string; AConverteEmbalagen: Boolean;  APreNota: Boolean = False): boolean; overload;
    class function fVincularX922_x117(strAutInc: string): boolean; overload;
    class function fTemCFOP_922: Boolean;
    class function fTemCFOP_117: Boolean;
    procedure pAtualizarAutoincrem(strOldAutoIncrem, strNewAutoincrem: String);
    function fGravaVinculosNoBanco(strPreNota: String = ''): Boolean;
    procedure pRestauraID;
    function fGetPedidosDefinidosNa922: String;
    function fRetornaPedidoComSaldoAVincular(strAutDetEle: String): String;
    { Public declarations }
  end;

var
  frmVinculoBaixaEntregaFuturaEdocVenda: TfrmVinculoBaixaEntregaFuturaEdocVenda;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncFat;

{ TfrmVinculoBaixaEntregaFuturaEdocVenda }

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  FAutIncGerEle := '';
  FPreNota := False;
  blnCarregaPreDefida := False;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pIniciaProcesso;
begin
  cdsItens := TZClient.Create(Nil, fGetSQLEstruturaItens);
  cdsItens.fAbreClient(True, 'TfrmListaProdutosFCIDivergenteNFE.FormCreate');
  cdsVinculo := TZClient.Create(Nil, fGetSQLEstruturaVinculo);
  cdsVinculo.fAbreClient(True, 'TfrmListaProdutosFCIDivergenteNFE.FormCreate');
  cdsTmp := TZClient.Create(nil, '');

  cdsPreNotaVinculos := TZClient.Create(Nil, fGetSQLEstruturaPreNotaVinculos);
  cdsPreNotaVinculos.fAbreClient(True, 'TfrmListaProdutosFCIDivergenteNFE.FormCreate');

  {Insere o registro para multiplos itens selecionados}
  cdsVinculo.Insert;
  cdsVinculo.FieldByName('CODITE').AsString := '00000';
  cdsVinculo.FieldByName('CODEMP').AsString := VS_strCodEmp;
  cdsVinculo.FieldByName('ESPDOC').AsString := 'NF';
  cdsVinculo.Post;
  FLstItensMarcados := TStringList.Create;
  cdsItens.AfterScroll := cdsItensAfterScroll;
  dtsItens.DataSet := cdsItens;
  dtsVinculo.DataSet := cdsVinculo;
  qryConsulta := fCriaQuery;
  blnJaLiberado := False;

end;


procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsItens);
  FreeAndNil(cdsVinculo);
  FreeAndNil(qryConsulta);
  FreeAndNil(cdsTmp);
  FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key Of
    VK_SPACE: btnMarcaDesmarca.Click;
    VK_F4:    btnMarcaTodos.Click;
    VK_F5:    btnDesmarcaTodos.Click;
    VK_F6:    btnRemoverTodosVinculos.Click;
    VK_F7:    btnRemoveVinculo.Click;
  end;
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fRetornaPedidoComSaldoAVincular(strAutDetEle: String): String;
begin
  cdsPreNotaVinculos.First;
  cdsPreNotaVinculos.Filtered := False;
  cdsPreNotaVinculos.Filter := 'ID = ' + QuotedStr(strAutDetEle);
  cdsPreNotaVinculos.Filtered := True;
  while not cdsPreNotaVinculos.Eof Do
  Begin
    If cdsPreNotaVinculos.FieldByName('USOU').AsInteger = 0 Then
    Begin
      cdsPreNotaVinculos.Edit;
      cdsPreNotaVinculos.FieldByName('USOU').AsInteger := 1;
      cdsPreNotaVinculos.Post;
      Exit(cdsPreNotaVinculos.FieldByName('PEDCOM').AsString);
    End;
    cdsPreNotaVinculos.Next
  End;

end;

class function TfrmVinculoBaixaEntregaFuturaEdocVenda.fTemCFOP_117: Boolean;
  var
    qryQuery: TUniQuery;
begin
  qryQuery := fCriaQuery;
  Try
    qryQuery.SQL.Add('SELECT ENT_CODITE');
    qryQuery.SQL.Add('  FROM TMP_ENTMER ');
    qryQuery.SQL.Add(' WHERE (RIGHT(ENT_CLAFIS,  3) = "117 " OR  RIGHT(ENT_CLAFIS,  3) = "116")');

    qryQuery.Open;

    Result := Not qryQuery.IsEmpty

  Finally
    FreeAndNil(qryQuery);
  End;
end;

class function TfrmVinculoBaixaEntregaFuturaEdocVenda.fTemCFOP_922: Boolean;
  var
    qryQuery: TUniQuery;
begin
  qryQuery := fCriaQuery;
  Try
    qryQuery.SQL.Add('SELECT ENT_CODITE');
    qryQuery.SQL.Add('  FROM TMP_ENTMER ');
    qryQuery.SQL.Add(' WHERE (RIGHT(ENT_CLAFIS,  3) = "922")');

    qryQuery.Open;

    Result := Not qryQuery.IsEmpty
  Finally
    FreeAndNil(qryQuery);
  End;
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fTemPredefinicao: boolean;
var qryCons: TuniQuery;
begin
  qryCons := fCriaQuery;
  Try
    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT COUNT(1) AS QTD ');
    qryCons.SQL.Add('  FROM TMP_ENTMER ');
    qryCons.SQL.Add(' INNER JOIN PNENFU ON NFU_NFX117 = ENT_AUTELE ');
    qryCons.SQL.Add(' INNER JOIN MOVDET ON MOVDET.AUTOINCREM = NFU_NFX922 ');
    qryCons.SQL.Add(' INNER JOIN DETELE ON DETELE.AUTOINCREM = NFU_NFX117 ');
    qryCons.SQL.Add(' INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER ');
    qryCons.SQL.Add(' WHERE GERELE.AUTOINCREM = "' + FAutIncGerEle + '" ');

    qryCons.Open;

    Result := qryCons.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fTemVinculo: boolean;
begin
  cdsTmp.Data := cdsVinculo.Data;
  pMontaFiltroCDS(cdsTmp, 'DOC922 <> ' + QuotedStr(''));
  Result := Not cdsTmp.IsEmpty;
end;

class function TfrmVinculoBaixaEntregaFuturaEdocVenda.fVincularX922_x117(
  strAutInc: string; AConverteEmbalagen: Boolean; APreNota: Boolean): boolean;
begin
  If not Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
  Begin
    pCriarFormularios(TfrmVinculoBaixaEntregaFuturaEdocVenda, frmVinculoBaixaEntregaFuturaEdocVenda);
    frmVinculoBaixaEntregaFuturaEdocVenda.FPreNota := APreNota;
    frmVinculoBaixaEntregaFuturaEdocVenda.FAutIncGerEle := strAutInc;
    frmVinculoBaixaEntregaFuturaEdocVenda.FConverteEmbalagens := AConverteEmbalagen;

    frmVinculoBaixaEntregaFuturaEdocVenda.pIniciaProcesso;
  End;

  If frmVinculoBaixaEntregaFuturaEdocVenda.cdsItens.IsEmpty Then
  Begin
    FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
    Result := True;
  End
  Else
  Begin
    frmVinculoBaixaEntregaFuturaEdocVenda.cdsVinculo.Filtered := False;
    frmVinculoBaixaEntregaFuturaEdocVenda.cdsItens.Filtered := False;

    frmVinculoBaixaEntregaFuturaEdocVenda.cdsVinculo.AddIndex('idxItem', 'ID' ,[IxPrimary]);
    frmVinculoBaixaEntregaFuturaEdocVenda.cdsVinculo.IndexName := 'idxItem';

    frmVinculoBaixaEntregaFuturaEdocVenda.cdsItens.AddIndex('idxCodIte', 'ENT_CODITE' ,[IxPrimary]);
    frmVinculoBaixaEntregaFuturaEdocVenda.cdsItens.IndexName := 'idxCodIte';

    result := frmVinculoBaixaEntregaFuturaEdocVenda.Showmodal = mrOk;
  End;
end;

class function TfrmVinculoBaixaEntregaFuturaEdocVenda.fVincularX922_x117(strAutInc: String): boolean;
begin
  Try
    If strAutInc <> '' Then
      FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
    If not Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
    Begin
      pCriarFormularios(TfrmVinculoBaixaEntregaFuturaEdocVenda, frmVinculoBaixaEntregaFuturaEdocVenda);
      frmVinculoBaixaEntregaFuturaEdocVenda.FAutIncGerEle := strAutInc;
      frmVinculoBaixaEntregaFuturaEdocVenda.blnCarregaPreDefida := frmVinculoBaixaEntregaFuturaEdocVenda.fTemPredefinicao;
      frmVinculoBaixaEntregaFuturaEdocVenda.pIniciaProcesso;

      If (frmVinculoBaixaEntregaFuturaEdocVenda.blnCarregaPreDefida) And (strAutInc <> '') And (Not frmVinculoBaixaEntregaFuturaEdocVenda.cdsVinculo.IsEmpty) Then
      Begin
        frmVinculoBaixaEntregaFuturaEdocVenda.pSetaIndex;
        frmVinculoBaixaEntregaFuturaEdocVenda.pAjustaQuantidade;
        frmVinculoBaixaEntregaFuturaEdocVenda.pSetaIndexParaGravacao;
      End;
    End;

    If (frmVinculoBaixaEntregaFuturaEdocVenda.blnCarregaPreDefida) And
       (Not frmVinculoBaixaEntregaFuturaEdocVenda.cdsItens.IsEmpty) then
    Begin
      Result := True;
      Exit;
    End;

    If frmVinculoBaixaEntregaFuturaEdocVenda.cdsItens.IsEmpty Then
    Begin
      FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
      Result := True;
    End
    Else
    Begin
      frmVinculoBaixaEntregaFuturaEdocVenda.pSetaIndex;
      result := frmVinculoBaixaEntregaFuturaEdocVenda.Showmodal = mrOk;
    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(E.Message, '[TfrmVinculoBaixaEntregaFuturaEdocVenda.fVincularX922_x117]');
      If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
        FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
      Result := False;
    End;
  End;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pSetaIndex;
begin
  cdsVinculo.Filtered := False;
  cdsItens.Filtered := False;

  cdsVinculo.AddIndex('idxItem', 'ID' ,[IxPrimary]);
  cdsVinculo.IndexName := 'idxItem';

  cdsItens.AddIndex('idxCodIte', 'ENT_CODITE' ,[IxPrimary]);
  cdsItens.IndexName := 'idxCodIte';
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pSetaIndexParaGravacao;
begin
  cdsVinculo.DeleteIndex('idxItem');
  cdsItens.DeleteIndex('idxCodIte');

  cdsVinculo.AddIndex('idxItem', 'ID' ,[IxPrimary]);
  cdsVinculo.IndexName := 'idxItem';
  cdsItens.AddIndex('idxItem', 'ID' ,[IxPrimary]);
  cdsItens.IndexName := 'idxItem';
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetPedidosDefinidosNa922: String;
var strAutIncMovDet: String;
begin
  cdsVinculo.Filtered := False;
  cdsVinculo.First;
  strAutIncMovDet := '';
  While not cdsVinculo.Eof Do
  Begin
    If cdsVinculo.FieldByName('DOC922').AsString <> '' Then
      strAutIncMovDet := strAutIncMovDet + '"' + cdsVinculo.FieldByName('DOC922').AsString + '"';
    cdsVinculo.Next;
  End;

  strAutIncMovDet := AnsiReplaceStr(strAutIncMovDet, '""', '","');
  If strAutIncMovDet = '' Then
    Exit('');

  qryConsulta.SQL.Clear;

  qryConsulta.SQL.Add('SELECT   GROUP_CONCAT(DISTINCT PCMGER.AUTOINCREM) AS PEDIDOS  FROM MOVDET');
  qryConsulta.SQL.Add('INNER JOIN GERELE ON GER_DOCENT = MOVDET.DET_NUMDOC');
  qryConsulta.SQL.Add('                 AND GER_ESPENT = MOVDET.DET_ESPDOC');
  qryConsulta.SQL.Add('                 AND GER_EMPENT = MOVDET.DET_CODEMP');
  qryConsulta.SQL.Add('                 AND GER_CODFOR = MOVDET.DET_CODFOR');
  qryConsulta.SQL.Add('INNER JOIN DETELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM AND DETELE.DET_CODITE =  MOVDET.DET_CODITE');
  qryConsulta.SQL.Add('INNER JOIN DEFBAI ON DEFBAI.DEF_AUTELE  = DETELE.AUTOINCREM');
  qryConsulta.SQL.Add('INNER JOIN PCMGER ON PCMGER.AUTOINCREM = DEF_AUTPCG');
  qryConsulta.SQL.Add(' WHERE MOVDET.AUTOINCREM IN(' + strAutIncMovDet + ')');
  qryConsulta.Open;

  Result := qryConsulta.FieldByName('PEDIDOS').AsString;
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetQtdMarcada: Integer;
begin
  Result := FLstItensMarcados.Count;
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaItensEntrada: string;
Begin
  Result := Result + 'SELECT ENT_CODITE, ';
  Result := Result + '       ENT_DESITE, ';
  Result := Result + '       ENT_AUTELE, ';
  If fCfgSis('CNVEMB')  <> 'N' Then
    Result := Result + '     IF(IFNULL(ENT_EMBALA, 0) = 0, 1, ENT_EMBALA) * ENT_QTDITE AS ENT_QTDITE, '
  Else
    Result := Result + '       ENT_QTDITE, ';
  Result := Result + '       (SELECT UNI_SIGUNI FROM CADUNI';
  Result := Result + '         WHERE UNI_CODUNI = ENT_CODUNI) AS ENT_SIGUNI, ';
  Result := Result + '       ENT_CODFOR, ';
  Result := Result + '       0.0000 AS QTDVIN, ';
  Result := Result + '       0 AS MARCAD, ';
  Result := Result + '       AUTOINCREMENTO_GRAVACAO AS ID, ';
  Result := Result + '       CONVERT(" ", CHAR(20)) AS OLDID ';

  Result := Result + '  FROM TMP_ENTMER ';
  Result := Result + ' WHERE LOCATE(RIGHT(ENT_CLAFIS, 3), "_116_117") > 0 ';


End;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaItensPreNota: string;
  var
    intDecQua: Integer;
    strEmbala, strDecQua: String;
Begin
  intDecQua := fCfgSis('DEQTPC', varInteger);
  strDecQua := IntToStr(intDecQua);

  strEmbala := fSQLEmbala('C', 'F', 'GER_CODFOR', True);

  Result := '';
  Result := Result + ' SELECT DET_CODITE AS ENT_CODITE, ';
  Result := Result + '        C.ITE_DESITE AS ENT_DESITE,  ';
  Result := Result + '      DETELE.AUTOINCREM AS  ENT_AUTELE, ';

  If (fCfgSis('CNVEMB') <> 'N') And FConverteEmbalagens Then
    Result := Result + '   ROUND(ROUND(I10_QCOM , ' + strDecQua + ') *  ' + strEmbala + ' , ' + strDecQua + ') AS ENT_QTDITE,   '
  Else
    Result := Result + '   I10_QCOM    AS ENT_QTDITE,     ';
  Result := Result + '        UNI_SIGUNI AS ENT_SIGUNI, ';
  Result := Result + '        GER_CODFOR AS ENT_CODFOR, ';
  Result := Result + '        0.0000 AS QTDVIN, ';
  Result := Result + '        0 AS MARCAD, ';
  Result := Result + '        DETELE.AUTOINCREM  AS ID, ';
  Result := Result + '        CONVERT(" ", CHAR(20)) AS OLDID ';
  Result := Result + '   FROM GERELE ';
  Result := Result + '    INNER JOIN DETELE ON DETELE.DET_SEQGER =  GERELE.AUTOINCREM ';
  Result := Result + '    LEFT JOIN CADITE C ON C.ITE_CODITE = DET_CODITE ';
  Result := Result + '    LEFT  JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '    LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ';
  Result := Result + '                          F.ITE_CODFOR =   GER_CODFOR     ';
  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := Result + '  AND (SELECT COUNT(*) FROM TABPRE      ';
    Result := Result + '       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End Else
  Begin
    Result := Result + '  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ';
    Result := Result + '                       WHERE FF.ITE_CODITE = C.ITE_CODITE AND    ';
    Result := Result + '                             FF.ITE_CODFOR = GER_CODFOR)         ';
  End;

  Result := Result + '   WHERE GERELE.AUTOINCREM = "'+FAutIncGerEle+'"';
  Result := Result + '     AND LOCATE(RIGHT(I08_CFOP,  3), "_117_116") > 0 ';
End;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaPreNotaVinculos: String;
begin
  Result := '';
  Result := 'SELECT ';
  Result := Result + '        CONVERT("", CHAR(20)) AS DOC922,';
  Result := Result + '        CONVERT("", CHAR(20))  AS ID, ';
  Result := Result + '        CONVERT("", CHAR(12)) AS PEDCOM,';
  Result := Result + '        0.0000 AS QTDTOT, ';
  Result := Result + '        0 AS USOU ';
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaItens: string;
begin
  Result := '';
  If FPreNota Then
    Result := fGetSQLEstruturaItensPreNota
  Else
    Result := fGetSQLEstruturaItensEntrada
end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaVinculoEntrada: String;
begin
  Result := '';
  Result := Result + ' SELECT ENT_CODITE AS CODITE,';
  Result := Result + '        ENT_DESITE AS DESITE, ';
  Result := Result + '        ENT_AUTELE, ';
  If Not blnCarregaPreDefida Then
  Begin
    Result := Result + '        0.0000 AS QTDVIN, ';
    Result := Result + '        CONVERT("' + VS_strCodEmp + '", CHAR(3)) AS CODEMP,';
    Result := Result + '        CONVERT("", CHAR(12)) AS NUMDOC,';
    Result := Result + '        CONVERT("", CHAR(2)) AS ESPDOC,';
    Result := Result + '        CONVERT("", CHAR(3)) AS SERDOC,';
    Result := Result + '        CONVERT("", CHAR(20)) AS DOC922,';
    Result := Result + '        AUTOINCREMENTO_GRAVACAO AS ID, ';
    Result := Result + '        CONVERT(" ", CHAR(20)) AS OLDID ';
    Result := Result + '   FROM TMP_ENTMER';
  End
  Else
  Begin
    Result := Result + '        NFU_QTDATD AS QTDVIN, ';
    Result := Result + '        DET_CODEMP AS CODEMP,';
    Result := Result + '        DET_NUMDOC AS NUMDOC,';
    Result := Result + '        DET_ESPDOC AS ESPDOC,';
    Result := Result + '        DET_SERIE_ AS SERDOC,';
    Result := Result + '        NFU_NFX922 AS DOC922,';
    Result := Result + '        AUTOINCREMENTO_GRAVACAO AS ID, ';
    Result := Result + '        ENT_AUTELE AS OLDID ';
    Result := Result + '        FROM ';
    Result := Result + '          TMP_ENTMER ';
    Result := Result + '          INNER JOIN PNENFU ON NFU_NFX117 = ENT_AUTELE ';
    Result := Result + '          INNER JOIN MOVDET ON MOVDET.AUTOINCREM = NFU_NFX922 ';
    Result := Result + '          INNER JOIN DETELE ON DETELE.AUTOINCREM = NFU_NFX117 ';
    Result := Result + '          INNER join GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER ';
    Result := Result + '        WHERE GERELE.AUTOINCREM = "' + FAutIncGerEle + '" ';
  End;

end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaVinculoPreNota: String;
begin
  Result := '';
  Result := Result + ' SELECT DET_CODITE AS CODITE,';
  Result := Result + '        C.ITE_DESITE AS DESITE, ';
  Result := Result + '        0.0000 AS QTDVIN, ';
  Result := Result + '        CONVERT("' + VS_strCodEmp + '", CHAR(3)) AS CODEMP,';
  Result := Result + '        CONVERT("", CHAR(12)) AS NUMDOC,';
  Result := Result + '        CONVERT("", CHAR(2)) AS ESPDOC,';
  Result := Result + '        CONVERT("", CHAR(3)) AS SERDOC,';
  Result := Result + '        CONVERT("", CHAR(20)) AS DOC922,';
  Result := Result + '        DETELE.AUTOINCREM AS ID, ';
  Result := Result + '        0.0000 AS QTDPRENOTA, ';
  Result := Result + '        CONVERT(" ", CHAR(20)) AS OLDID ';

  Result := Result + '   FROM GERELE ';
  Result := Result + '    INNER JOIN DETELE ON DETELE.DET_SEQGER =  GERELE.AUTOINCREM ';
  Result := Result + '    LEFT JOIN CADITE C ON C.ITE_CODITE = DET_CODITE ';
  Result := Result + '   WHERE GERELE.AUTOINCREM = "'+FAutIncGerEle+'"';
  Result := Result + '     AND LOCATE(RIGHT(I08_CFOP,  3), "_117_116") > 0 ';

end;


function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGetSQLEstruturaVinculo: String;
begin
  If FPreNota Then
    Result := fGetSQLEstruturaVinculoPreNota
  Else
    Result := fGetSQLEstruturaVinculoEntrada
End;

//Controle das marcações

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pGerenciaLista;
begin
  If cdsItens.FieldByName('MARCAD').AsInteger = 0 Then
  Begin
    If FLstItensMarcados.IndexOf('"' + cdsItens.FieldByName('ENT_CODITE').AsString + '",') >= 0 Then
      FLstItensMarcados.Delete(FLstItensMarcados.IndexOf('"' + cdsItens.FieldByName('ENT_CODITE').AsString + '",'));
  End
  Else
    FLstItensMarcados.Add('"' + cdsItens.FieldByName('ENT_CODITE').AsString + '",');
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pInsereNovaLinhaVinculo;
begin
  cdsVinculo.Insert;
  cdsVinculo.FieldByName('CODITE').AsString := cdsItens.FieldByName('ENT_CODITE').AsString;
  cdsVinculo.FieldByName('DESITE').AsString := cdsItens.FieldByName('ENT_DESITE').AsString;
  cdsVinculo.FieldByName('CODEMP').AsString := VS_StrCodEmp;
  cdsVinculo.FieldByName('ID').AsString     := cdsItens.FieldByName('ID').AsString;;
  cdsVinculo.Post;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pMarcaDesmarcaTotal(
  blnMarcar: boolean);
begin
  cdsItens.DisableControls;
  cdsItens.First;
  While not cdsItens.Eof do
  Begin
    If ((blnMarcar) And (cdsItens.FieldByName('MARCAD').AsInteger = 0)) Or
       ((Not blnMarcar) And (cdsItens.FieldByName('MARCAD').AsInteger = 1)) Then
      pMarcaDesmarcaUnitario(False);
    cdsItens.Next;
  End;
  cdsItens.EnableControls;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pMarcaDesmarcaUnitario;
begin
  If cdsItens.FieldByName('QTDVIN').AsFloat = cdsItens.FieldByName('ENT_QTDITE').AsFloat Then
  Begin
    If blnExibeMensagem Then
      pMensagemOk('Esse item já foi atendido completamente, não pode mais ser marcado.');
    Exit;
  End;    
  cdsItens.Edit;
  cdsItens.FieldByName('MARCAD').AsInteger := IIf(cdsItens.FieldByName('MARCAD').AsInteger = 0, 1, 0);
  cdsItens.Post;
  pGerenciaLista;
  If fGetQtdMarcada > 1 Then
  Begin
    cdsItens.AfterScroll := nil;
    cdsVinculo.AfterScroll := Nil;
  End
  Else
    cdsItens.AfterScroll := cdsItensAfterScroll;

end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pMontaFiltroCDS(cds: TZClient;
  Filtro: String);
begin
  cds.Filtered := False;
  cds.Filter := Filtro;
  cds.Filtered := True;

end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnDesmarcaTodosClick(
  Sender: TObject);
begin
  pMarcaDesmarcaTotal(False);
  pGerenciaVisualizaoVinculados;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnHlpImpClick(
  Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnMarcaDesmarcaClick(
  Sender: TObject);
begin
  pMarcaDesmarcaUnitario(True);
  pGerenciaVisualizaoVinculados;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnMarcaTodosClick(
  Sender: TObject);
begin
  pMarcaDesmarcaTotal(True);
  pGerenciaVisualizaoVinculados(True);
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnRemoverTodosVinculosClick(
  Sender: TObject);
begin
  inherited;
  If Not fTemVinculo Then
    Exit;

  If fMensagem('','Ao confirmar irá remover todas as vinculações já criadas. prosseguir?:', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  pRemoveTodosOsVinculos;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnRemoveVinculoClick(
  Sender: TObject);
begin
  inherited;

  cdsItens.AfterScroll := nil;
  cdsVinculo.AfterScroll := nil;
  Try
    pReduzirQtdAtd(cdsVinculo.FieldByName('QTDVIN').AsFloat,
                   cdsVinculo.FieldByName('ID').AsString);
    pRemoverVinculo;

  Finally
    pAjustarCdsVinculoComMaisDeUmVazio(cdsItens.FieldByName('ID').AsString);
    cdsItens.Filtered := False;
    cdsItens.AfterScroll   := cdsItensAfterScroll;
    cdsItensAfterScroll(cdsItens)
  End
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnSairClick(Sender: TObject);
begin
  inherited;
  If Not fTemVinculo Then
    Exit;

  pRemoveTodosOsVinculos;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pReduzirQtdAtd(qtdReduzir: Double; id: string);
Begin
  pMontaFiltroCDS(cdsItens, 'ID = ' + QuotedStr(id));
  cdsItens.Edit;
  cdsItens.FieldByName('QTDVIN').AsFloat := cdsItens.FieldByName('QTDVIN').AsFloat - qtdReduzir;
  cdsItens.Post;
End;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pAjustaQuantidade;
  var fltTotal: Double;
begin
  cdsItens.First;
  While not cdsItens.Eof Do
  Begin

    fltTotal := 0;
    while not cdsVinculo.Eof Do
    Begin
      fltTotal := fltTotal + cdsVinculo.FieldByName('QTDVIN').AsFloat;
      cdsVinculo.Next;
    End;
    If fltTotal > 0 Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('QTDVIN').AsFloat := fltTotal;
      cdsItens.Post;
    End;
    cdsItens.Next;
  End;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pAjustarCdsVinculoComMaisDeUmVazio(id: string = '');
  procedure pAjusta;
  Begin
    If (cdsVinculo.IsEmpty) Or (cdsVinculo.RecordCount = 1) Then
      Exit;

    While Not (cdsVinculo.RecordCount = 1) do
    Begin
      cdsVinculo.Delete;
    End;
  End;

begin
  If id = ''  Then
  Begin
    cdsItens.Filtered := False;
    While Not cdsItens.Eof Do
    Begin
      pMontaFiltroCDS(cdsVinculo, 'DOC922 = ' + QuotedStr('') + ' AND ID = ' + QuotedStr(cdsItens.FieldByName('ID').AsString));
      pAjusta;
      cdsItens.Next;
    End;
  End
  Else
  Begin
    pMontaFiltroCDS(cdsVinculo, 'DOC922 = ' + QuotedStr('') + ' AND ID = ' + QuotedStr(id));
    pAjusta;
  End;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pRemoverVinculo;
Begin
  cdsVinculo.Edit;
  cdsVinculo.FieldByName('NUMDOC').AsString := '';
  cdsVinculo.FieldByName('ESPDOC').AsString := '';
  cdsVinculo.FieldByName('SERDOC').AsString := '';
  cdsVinculo.FieldByName('QTDVIN').AsFloat  := 0;
  cdsVinculo.FieldByName('DOC922').AsString := '';
  cdsVinculo.Post;
End;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pRemoveTodosOsVinculos;
begin
  FreeAndNil(cdsItens);
  FreeAndNil(cdsVinculo);

  cdsItens := TZClient.Create(Nil, fGetSQLEstruturaItens);
  cdsItens.fAbreClient(True, 'TfrmListaProdutosFCIDivergenteNFE.FormCreate');
  cdsVinculo := TZClient.Create(Nil, fGetSQLEstruturaVinculo);
  cdsVinculo.fAbreClient(True, 'TfrmListaProdutosFCIDivergenteNFE.FormCreate');
  {Insere o registro para multiplos itens selecionados}
  cdsVinculo.Insert;
  cdsVinculo.FieldByName('CODITE').AsString :=IIF((fTamCodIte = 5),'00000','0000000') ;
  cdsVinculo.FieldByName('CODEMP').AsString := VS_strCodEmp;
  cdsVinculo.FieldByName('ESPDOC').AsString := 'NF';
  cdsVinculo.Post;
  FLstItensMarcados.Clear;
  cdsItens.AfterScroll := cdsItensAfterScroll;
  dtsItens.DataSet := cdsItens;
  dtsVinculo.DataSet := cdsVinculo;
  qryConsulta := fCriaQuery;
  blnJaLiberado := False;

  cdsVinculo.AddIndex('idxItem', 'ID' ,[IxPrimary]);
  cdsVinculo.IndexName := 'idxItem';

  cdsItens.AddIndex('idxCodIte', 'ENT_CODITE' ,[IxPrimary]);
  cdsItens.IndexName := 'idxCodIte';

end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pRestauraID;

begin
  dtsVinculo.OnUpdateData := nil;
  cdsItens.AfterScroll := nil;
  cdsItens.Filtered := False;

  cdsVinculo.DeleteIndex('idxItem');
  cdsItens.DeleteIndex('idxItem');

  cdsItens.First;
  While not cdsItens.Eof do
  Begin
    if Not fEmptyStr(cdsItens.FieldByName('OLDID').AsString) Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ID').AsString := cdsItens.FieldByName('OLDID').AsString;
      cdsItens.FieldByName('OLDID').AsString := '';
      cdsItens.Post;
    end;
    cdsItens.Next;
  End;

  cdsVinculo.Filtered := False;
  cdsVinculo.First;
  While not cdsVinculo.Eof do
  Begin
    if Not fEmptyStr(cdsVinculo.FieldByName('OLDID').AsString) Then
    Begin
      cdsVinculo.Edit;
      cdsVinculo.FieldByName('ID').AsString := cdsVinculo.FieldByName('OLDID').AsString;
      cdsVinculo.FieldByName('OLDID').AsString := '';
      cdsVinculo.Post;
    End;
    cdsVinculo.Next;
  end;

  cdsVinculo.AddIndex('idxItem', 'ID' ,[IxPrimary]);
  cdsVinculo.IndexName := 'idxItem';
  cdsItens.AddIndex('idxItem', 'ID' ,[IxPrimary]);
  cdsItens.IndexName := 'idxItem';

  dtsVinculo.OnUpdateData := dtsVinculoUpdateData;
  cdsItens.AfterScroll := cdsItensAfterScroll;

end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.cdsItensAfterScroll(
  DataSet: TDataSet);
begin
  pGerenciaVisualizaoVinculados;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pGerenciaVisualizaoVinculados(blnOrigemMarcadoTodos: Boolean = False);
Begin
  If blnOrigemMarcadoTodos And (fGetQtdMarcada > 0) Then
  Begin
    cdsItens.First;
    While Not cdsItens.FieldByName('MARCAD').AsInteger = 1 do
      cdsItens.next;
  End;

  If fGetQtdMarcada > 1 Then
  Begin
    pMontaFiltroCDS(cdsVinculo, IIF((fTamCodIte = 5), 'CODITE = '+QuotedStr('00000'),'CODITE = '+QuotedStr('0000000')));
    cxbands.Bands[0].Visible := False;
    Exit;
  End
  Else
  //If (fGetQtdMarcada <= 1) Or (cdsItens.FieldByName('MARCAD').AsInteger = 0) Then
  Begin
    pMontaFiltroCDS(cdsVinculo, 'CODITE = ' + QuotedStr(cdsItens.FieldByName('ENT_CODITE').AsString));
    cxbands.Bands[0].Visible := True;
  End;
End;


procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.cxItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxItensQTDITE.Index]) =
     VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxItensQTDATD.Index]) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
    ACanvas.Font.Color := clBlack;
  End
  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxItensMARCAD.Index]) = '1' Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
end;

//Controle das seleções.

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fLocalizaDocumento: TTipoResultadoValidacao;
  procedure pSetaClausulasWhere;
  Begin
    qryConsulta.SQL.Add(' WHERE G.GER_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('   AND G.GER_ESPDOC = :ESPDOC');
    qryConsulta.SQL.Add('   AND IFNULL(G.GER_SERIE_, "") = :SERDOC');
    qryConsulta.SQL.Add('   AND G.GER_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('   AND G.GER_CODFOR = :CODFOR');
  End;

  procedure pSetaParamentros;
  Begin
    qryConsulta.ParamByName('NUMDOC').AsString := cdsVinculo.FieldByName('NUMDOC').AsString;
    qryConsulta.ParamByName('ESPDOC').AsString := cdsVinculo.FieldByName('ESPDOC').AsString;
    qryConsulta.ParamByName('SERDOC').AsString := cdsVinculo.FieldByName('SERDOC').AsString;
    qryConsulta.ParamByName('CODEMP').AsString := cdsVinculo.FieldByName('CODEMP').AsString;
    qryConsulta.ParamByName('CODFOR').AsString := cdsItens.FieldByName('ENT_CODFOR').AsString;
  End;

  procedure pMontaSQL(TipoValidacao: TTipoValidacao);
  Begin
    qryConsulta.Sql.Clear;
    qryConsulta.SQL.Add('SELECT ');

    If TipoValidacao = ldItensDisponiveis Then
    Begin
      qryConsulta.SQL.Add(' D.AUTOINCREM AS SEQDET, ');
      qryConsulta.SQL.Add(' D.DET_CODITE AS CODITE, ');
      qryConsulta.SQL.Add(' (SUM(DET_QTDITE) - (SUM(IFNULL(DET_QTDEFT, 0)) + IFNULL((SELECT  SUM(NFU_QTDATD) FROM PNENFU  ');
      qryConsulta.SQL.Add('                                                         INNER JOIN DETELE ON DETELE.AUTOINCREM = NFU_NFX117  ');
      qryConsulta.SQL.Add('                                                         INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER  ');
      qryConsulta.SQL.Add('                                                         WHERE NFU_NFX922 = D.AUTOINCREM  ');
      qryConsulta.SQL.Add('                                                         AND GERELE.GER_DOCENT IS NULL), 0)))  AS QTDDIS ');
    End
    Else
    Begin
      qryConsulta.SQL.Add('  G.AUTOINCREM ');
      If TipoValidacao = ldEncontrouItens Then
      Begin
        qryConsulta.SQL.Add(' ,(SUM(DET_QTDITE) - (SUM(IFNULL(DET_QTDEFT, 0)) + IFNULL((SELECT  SUM(NFU_QTDATD) FROM PNENFU  ');
        qryConsulta.SQL.Add('                                                         INNER JOIN DETELE ON DETELE.AUTOINCREM = NFU_NFX117  ');
        qryConsulta.SQL.Add('                                                         INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER  ');
        qryConsulta.SQL.Add('                                                         WHERE NFU_NFX922 = D.AUTOINCREM  ');
        qryConsulta.SQL.Add('                                                         AND GERELE.GER_DOCENT IS NULL), 0)))  AS QTDDIS ');
      End;
    End;

    qryConsulta.SQL.Add('FROM MOVGER G');

    If TipoValidacao in [ldItensDisponiveis, ldEncontrouItens]   Then
      qryConsulta.SQL.Add(' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM');
    pSetaClausulasWhere;

    If TipoValidacao = ldCFOP Then
       qryConsulta.SQL.Add('   AND LOCATE(RIGHT(GER_CLAFIS, 3), "_922") > 0');

    If TipoValidacao in [ldItensDisponiveis, ldEncontrouItens] Then
    Begin

      {qryConsulta.SQL.Add('   AND (DET_QTDITE > (IFNULL(DET_QTDEFT, 0) + IFNULL((SELECT  SUM(NFU_QTDATD) FROM PNENFU  ');
      qryConsulta.SQL.Add('                                                      INNER JOIN DETELE ON DETELE.AUTOINCREM = NFU_NFX117  ');
      qryConsulta.SQL.Add('                                                      INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER  ');
      qryConsulta.SQL.Add('                                                      WHERE NFU_NFX922 = D.AUTOINCREM  ');
      qryConsulta.SQL.Add('                                                        AND GERELE.GER_DOCENT IS NULL), 0)))  '); }
      If fGetQtdMarcada = 0 Then
        qryConsulta.SQL.Add(' AND DET_CODITE = ' + QuotedStr(cdsItens.FieldByName('ENT_CODITE').AsString))
      Else If (fGetQtdMarcada > 0) AND (FLstItensMarcados.Count > 0) Then
       qryConsulta.SQL.Add(' AND DET_CODITE IN (' + FLstItensMarcados.Text +  '"")');


      qryConsulta.SQL.Add(' ');
      qryConsulta.SQL.Add(' GROUP BY DET_CODITE ');
      qryConsulta.SQL.Add(' HAVING QTDDIS > 0 ');
    End;
  End;

  function fValida(TipoValidacao: TTipoValidacao): boolean;
  Begin
    pMontaSQL(TipoValidacao);
    pSetaParamentros;
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
  End;

begin
  Result := rvIndefinido;
  Try
    If (cdsVinculo.FieldByName('NUMDOC').AsString <> '') And
       (cdsVinculo.FieldByName('ESPDOC').AsString <> '') Then
    Begin
      If Not fValida(ldEncotrou) Then
        Exit(rvNaoEncontrou);
      If Not fValida(ldCFOP) Then
        Exit(rvCFOPInvalido);
      If Not fValida(ldEncontrouItens) Then
        Exit(rvNaoEncontrouItens);
      //  fValida(ldItensDisponiveis) Essa validação tem que ser a ultima pois
      //o retorno  desse sql e a propria query sera ultizada com o resultado
      If Not fValida(ldItensDisponiveis) Then
        Exit(rvItensIndisponiveis);
      Result := rvOk;
    End
    Else
      Result := rvIndefinido;
  Finally
    If (Result <> rvOk) Then
      pRemoverVinculo;
  End;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.dtsVinculoUpdateData(
  Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dtsVinculo.DataSet.FieldByName('NUMDOC').AsString) Then
       dtsVinculo.DataSet.FieldByName('NUMDOC').AsString := fStrZero(cdsVinculo.FieldByName('NUMDOC').AsString, fTamNumDoc);
  If Not ((cdsVinculo.FieldByName('NUMDOC').AsString <> '') And
          (cdsVinculo.FieldByName('ESPDOC').AsString <> '') And
          (cdsVinculo.FieldByName('SERDOC').AsString <> '')) Then
    Exit;

  cdsItens.AfterScroll := Nil;
  cdsVinculo.AfterScroll := Nil;
  dtsVinculo.OnUpdateData := nil;
  cdsItens.DisableControls;
  cdsVinculo.DisableControls;
  Try
    Case fLocalizaDocumento of
      rvNaoEncontrou: pMensagemOk('O Documento informado não foi encontrado.');
      rvCFOPInvalido: pMensagemOK('O CFOP do documento não pode ser diferente de x922.');
      rvItensIndisponiveis: pMensagemOK('Todos os itens deste documento já esta relacionado com outro documemento.');
      rvNaoEncontrouItens: pMensagemOK('Os itens deste documento não são os que estamos utilizando no momento.');
      rvOk: pRelacionarDocumentoComCdsItens;
    End;
  Finally
    cdsItens.AfterScroll := cdsItensAfterScroll;

    dtsVinculo.OnUpdateData := dtsVinculoUpdateData;
    cdsVinculo.EnableControls;
    cdsItens.EnableControls;
  End;

end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fx922InformadoAindaTemSaldo(strCodIte: String): boolean;
  var fltAcumulada: Double;
begin
  cdsTmp.Data := cdsVinculo.Data;
  //  bkpFiltro := '';
  //  If cdsVinculo.Filtered Then
  //     bkpFiltro := cdsVinculo.Filter;
  pMontaFiltroCDS(cdsTmp, 'DOC922 = ' + QuotedStr(qryConsulta.FieldByName('SEQDET').AsString) +
                          ' AND CODITE = ' + QuotedStr(strCodIte));
  Result := cdsTmp.IsEmpty;
  If not Result Then
  Begin
    fltAcumulada := 0;
    While not cdsTmp.Eof do
    Begin
      fltAcumulada := fltAcumulada + cdsTmp.FieldByName('QTDVIN').AsFloat;
      cdsTmp.Next;
    End;
    Result := (fltAcumulada < qryConsulta.FieldByName('QTDDIS').AsFloat);
  End;
end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pRelacionarDocumentoComCdsItens;
var
  fltQtdIteFaltante,
  fltQtdDisponivel,
  fltRelacionado: double;
  strNumDoc,
  strEspdoc,
  strSerie_: String;
  blnItemNaoVinculado: Boolean;
  procedure pProcessa(blnMultiplos: boolean);
  Begin
    fltQtdIteFaltante := cdsItens.FieldByName('ENT_QTDITE').AsFloat -
                         cdsItens.FieldByName('QTDVIN').AsFloat;
    fltQtdDisponivel  := qryConsulta.FieldByName('QTDDIS').AsFloat;

    cdsItens.Edit;
    If fltQtdIteFaltante <= fltQtdDisponivel Then
    Begin
      cdsItens.FieldByName('QTDVIN').AsFloat := cdsItens.FieldByName('ENT_QTDITE').AsFloat;
      fltRelacionado := fltQtdIteFaltante;
    End
    Else
    Begin
      cdsItens.FieldByName('QTDVIN').AsFloat := fltQtdDisponivel;
      fltRelacionado := fltQtdDisponivel;
    End;
    //Se o item foi atendido completamente desmarca, e não permiti mais marcalo.
    If  cdsItens.FieldByName('QTDVIN').AsFloat = cdsItens.FieldByName('ENT_QTDITE').AsFloat Then
    Begin
      cdsItens.FieldByName('MARCAD').AsInteger := 0;
      pGerenciaLista;
    End;

    cdsItens.Post;

    cdsVinculo.Edit;
    If blnMultiplos Then
    Begin
     cdsVinculo.FieldByName('NUMDOC').AsString := strNumDoc;
     cdsVinculo.FieldByName('ESPDOC').AsString := strEspdoc;
     cdsVinculo.FieldByName('SERDOC').AsString := strSerie_;
    End;

    cdsVinculo.FieldByName('DOC922').AsString := qryConsulta.FieldByName('SEQDET').AsString;
    cdsVinculo.FieldByName('QTDVIN').AsFloat := fltRelacionado;
    cdsVinculo.Post;

    If cdsItens.FieldByName('QTDVIN').AsFloat < cdsItens.FieldByName('ENT_QTDITE').AsFloat Then
      pInsereNovaLinhaVinculo;

  End;
begin
  // Um documento para varios itens.
  blnItemNaoVinculado := False;
  If cdsVinculo.FieldByName('CODITE').AsString = IIF((fTamCodIte = 5),'00000','0000000') Then
  Begin
    Try
      strNumDoc := cdsVinculo.FieldByName('NUMDOC').AsString;
      strEspdoc := cdsVinculo.FieldByName('ESPDOC').AsString;
      strSerie_ := cdsVinculo.FieldByName('SERDOC').AsString;
      qryConsulta.First;
      While Not qryConsulta.Eof Do
      Begin
        pMontaFiltroCDS(cdsItens,'MARCAD = 1 AND ENT_CODITE = ' + QuotedStr(qryConsulta.FieldByName('CODITE').AsString));
        If Not cdsItens.IsEmpty Then
        Begin
          If fx922InformadoAindaTemSaldo(qryConsulta.FieldByName('CODITE').AsString) Then
          Begin
            pMontaFiltroCDS(cdsVinculo, 'ID = ' + QuotedStr(cdsItens.FieldByName('ID').AsString) + 'AND ' +
                                        'DOC922 = ' + QuotedStr(''));

            If Not cdsVinculo.IsEmpty Then
              pProcessa(true);
          end
          Else
          begin
            blnItemNaoVinculado := True;
            pRemoverVinculo;
          End;

        End;
        qryConsulta.Next;
      End;

      If blnItemNaoVinculado Then
        pMensagemOk('Exitem Itens desse documento x922 que já estão completamente relacionado com um documento x117 ou x116.');
      pMontaFiltroCDS(cdsVinculo, 'CODITE = ' + QuotedStr(IIF((fTamCodIte = 5),'00000','0000000')));
      If Not cdsVinculo.IsEmpty Then
        pRemoverVinculo;

    Finally
      cdsItens.Filtered := False;
      cdsVinculo.Filtered := False;
    End;
  End
  //Item a Item
  Else
  Begin
      If fx922InformadoAindaTemSaldo(cdsItens.FieldByName('ENT_CODITE').AsString) Then
        pProcessa(False)
      Else
      Begin
        pRemoverVinculo;
        pMensagemOk('O Item desse documento x922 já esta completamente relacionado com um documento x117 ou x116.');
      End;
  End
end;


procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.actVincularx922Execute(
  Sender: TObject);
var strNumDoc,
    strEspDoc,
    strSerDoc: String;
    Linha: Integer;
begin
  Linha := cdsItens.RecNo;
  If cdsVinculo.FieldByName('NUMDOC').AsString <> '' Then
     btnRemoveVinculo.Click;
  cdsItens.RecNo := Linha;
  If fPesqNotasx922(Self,
                    strNumDoc,
                    strSerDoc,
                    strEspDoc,
                    IIf(fGetQtdMarcada = 0 , QuotedStr(cdsItens.FieldByName('ENT_CODITE').AsString), FLstItensMarcados.Text +  '""'),
                    cdsItens.FieldByName('ENT_CODFOR').AsString) Then
  Begin
    cdsVinculo.Edit;
    cdsVinculo.FieldByName('NUMDOC').AsString := strNumDoc;
    cdsVinculo.FieldByName('ESPDOC').AsString := strSerDoc;
    cdsVinculo.FieldByName('SERDOC').AsString := strEspdoc;
    cdsVinculo.Post;
  End;
End;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pLimpacdsPreNotaVinculos;
begin
  while not cdsPreNotaVinculos.IsEmpty do
  Begin
    cdsPreNotaVinculos.Delete;
  End;
End;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pPreparaCdsVinculoPreNota;

begin

  If Not FPreNota Then
    Exit;
  if not cdsPreNotaVinculos.IsEmpty Then
    pLimpacdsPreNotaVinculos;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT  PCG_NUMPED, DEFBAI.DEF_QTDITE -');
  qryConsulta.SQL.Add('        (IFNULL(DET_QTDEFT, 0) + IFNULL((SELECT  SUM(NFU_QTDATD) FROM PNENFU');
  qryConsulta.SQL.Add('                                                            INNER JOIN DETELE ON DETELE.AUTOINCREM = NFU_NFX117');
  qryConsulta.SQL.Add('                                                            INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER');
  qryConsulta.SQL.Add('                                                            WHERE NFU_NFX922 = MOVDET.AUTOINCREM');
  qryConsulta.SQL.Add('                                                            AND GERELE.GER_DOCENT IS NULL), 0)) AS QTDDIS ');
  qryConsulta.SQL.Add('FROM MOVDET');
  qryConsulta.SQL.Add('INNER JOIN GERELE ON GER_DOCENT = MOVDET.DET_NUMDOC');
  qryConsulta.SQL.Add('                 AND GER_ESPENT = MOVDET.DET_ESPDOC');
  qryConsulta.SQL.Add('                 AND GER_EMPENT = MOVDET.DET_CODEMP');
  qryConsulta.SQL.Add('                 AND GER_CODFOR = MOVDET.DET_CODFOR');
  qryConsulta.SQL.Add('INNER JOIN DETELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM AND DETELE.DET_CODITE =  MOVDET.DET_CODITE');
  qryConsulta.SQL.Add('INNER JOIN DEFBAI ON DEFBAI.DEF_AUTELE  = DETELE.AUTOINCREM');
  qryConsulta.SQL.Add('INNER JOIN PCMGER ON PCMGER.AUTOINCREM = DEF_AUTPCG');
  qryConsulta.SQL.Add(' WHERE MOVDET.AUTOINCREM IN(:DOC922)');
  cdsVinculo.Filtered := False;
  cdsVinculo.First;
  while not cdsVinculo.Eof do
  begin
    qryConsulta.Close;
    qryConsulta.ParamByName('DOC922').AsString := cdsVinculo.FieldByName('DOC922').AsString;
    qryConsulta.Open;
    while not qryConsulta.Eof Do
    Begin

      cdsPreNotaVinculos.Insert;
      cdsPreNotaVinculos.FieldByName('DOC922').AsString :=cdsVinculo.FieldByName('DOC922').AsString;
      cdsPreNotaVinculos.FieldByName('ID').AsString :=cdsVinculo.FieldByName('ID').AsString;
      cdsPreNotaVinculos.FieldByName('PEDCOM').AsString := qryConsulta.FieldByName('PCG_NUMPED').AsString;
      cdsPreNotaVinculos.FieldByName('QTDTOT').AsFloat := qryConsulta.FieldByName('QTDDIS').AsFloat;
      cdsPreNotaVinculos.FieldByName('USOU').AsFloat := 0;
      cdsPreNotaVinculos.Post;
      qryConsulta.Next;
    End;
    cdsVinculo.Next;
  End;

end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.btnConfirmaClick(
  Sender: TObject);
  const    cTitulo = 'ITENS SEM VINCULO COM DOCUMENTO X922.';
  var
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;


  function fDocumentosSemVinculo: boolean;
  Begin
    pMontaFiltroCDS(cdsItens,   'ENT_QTDITE <> QTDVIN');
    Result := not cdsItens.IsEmpty;
  End;
begin
  inherited;
  If fDocumentosSemVinculo Then
  Begin
    If FPreNota Then
    Begin
      pMensagemOk('Existe itens sem vinculos com x922');
      cdsItens.Filtered := False;
      cdsItens.Filter := '';
      ModalResult := mrNone;
      Exit;
    End;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto(cTitulo);
    ModalResult := mrOk;


    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'ITEM'       , 60  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'QTD. ITEM'  , 15 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'QTD. VINC.' , 15 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    While Not cdsItens.Eof Do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('ITEM'       , cdsItens.FieldByName('ENT_CODITE').AsString + ' - ' +cdsItens.FieldByName('ENT_DESITE').AsString , 60 , alEsquerda);
      objLinha.pAddColuna('QTD. ITEM'  , cdsItens.FieldByName('ENT_QTDITE').AsString                                                      , 15 , alDireita );
      objLinha.pAddColuna('QTD. VINC.' , cdsItens.FieldByName('QTDVIN').AsString                                                          , 15 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
      cdsItens.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    If Not blnJaLiberado Then
    Begin

      objLiberacao.strDirAce := 'DCVINC';
      objLiberacao.strMsgSen := cTitulo;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;

      if not objLiberacao.fLibera Then
        ModalResult := mrAbort
    End;
  End;
  If  ModalResult = mrOk Then
  Begin
    pPreparaCdsVinculoPreNota;


    blnJaLiberado := True;
    cdsVinculo.DeleteIndex('idxItem');
    cdsItens.DeleteIndex('idxCodIte');

    cdsVinculo.AddIndex('idxItem', 'ID' ,[IxPrimary]);
    cdsVinculo.IndexName := 'idxItem';
    cdsItens.AddIndex('idxItem', 'ID' ,[IxPrimary]);
    cdsItens.IndexName := 'idxItem';
  End;

end;

procedure TfrmVinculoBaixaEntregaFuturaEdocVenda.pAtualizarAutoincrem(
  strOldAutoIncrem, strNewAutoincrem: String);
begin
  cdsItens.AfterScroll := Nil;
  dtsVinculo.OnUpdateData := Nil;
  cdsItens.Filtered := False;
  Try
    If cdsItens.FindKey([strOldAutoIncrem]) Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('OLDID').AsString := cdsItens.FieldByName('ID').AsString;
      cdsItens.FieldByName('ID').AsString := strNewAutoincrem;
      cdsItens.Post;

      pMontaFiltroCDS(cdsVinculo, 'ID = ' + QuotedStr(strOldAutoIncrem) + ' AND QTDVIN > 0') ;

      While not cdsVinculo.Eof Do
      Begin
        cdsVinculo.Edit;
        cdsVinculo.FieldByName('OLDID').AsString := cdsVinculo.FieldByName('ID').AsString;
        cdsVinculo.FieldByName('ID').AsString := strNewAutoincrem;
        cdsVinculo.Post;
      End;
    End;
  Finally
    cdsItens.AfterScroll := cdsItensAfterScroll;
    dtsVinculo.OnUpdateData := dtsVinculoUpdateData;
  End

end;

function TfrmVinculoBaixaEntregaFuturaEdocVenda.fGravaVinculosNoBanco(strPreNota: String = ''): Boolean;
  var strSQLUpd922Qtd: string;
begin
  pMontaFiltroCDS(cdsVinculo, 'QTDVIN > 0');
  If cdsVinculo.IsEmpty Then
    Exit(True);
  qryConsulta.SQL.Clear;
  strSQLUpd922Qtd := '';
  Try
    If FPreNota Then
      qryConsulta.SQL.Add('INSERT INTO PNENFU (NFU_NFX922, NFE_PREELE, NFU_NFX117, NFU_QTDATD) VALUES ')
    Else
      qryConsulta.SQL.Add('INSERT INTO VENFUT (FUT_NFX922, FUT_NFX117, FUT_QTDATD) VALUES ');

    cdsVinculo.First;
    //Inserir devidos valores
    While not cdsVinculo.EoF do
    Begin
      qryConsulta.SQL.Add('(' + QuotedStr(cdsVinculo.FieldByName('DOC922').AsString) + ', ');
      If FPreNota Then
        qryConsulta.SQL.Add(QuotedStr(strPreNota) + ', ');
      qryConsulta.SQL.Add(QuotedStr(cdsVinculo.FieldByName('ID').AsString) + ', ');
      qryConsulta.SQL.Add(ReplaceStr(cdsVinculo.FieldByName('QTDVIN').AsString, ',','.') + ')');

      If Not FPreNota Then
        strSQLUpd922Qtd := strSQLUpd922Qtd + 'UPDATE MOVDET SET DET_QTDEFT = IFNULL(DET_QTDEFT, 0) + ' +
                           ReplaceStr(cdsVinculo.FieldByName('QTDVIN').AsString, ',','.') +
                           ' WHERE AUTOINCREM = ' + QuotedStr(cdsVinculo.FieldByName('DOC922').AsString) + ';';

      cdsVinculo.Next;
      If Not cdsVinculo.Eof Then
        qryConsulta.SQL.Add(',');
    End;
    qryConsulta.ExecSQL;
    //ajusta os documentos x922
    qryConsulta.SQL.Clear;
    If not FPreNota Then
    begin
      qryConsulta.SQL.Add(strSQLUpd922Qtd);
      qryConsulta.ExecSQL;
    End;
    Result := True;
  except
    on e:Exception do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TfrmVinculoBaixaEntregaFuturaEdocVenda.fGravaVinculosNoBanco]');
    End;
  end;
end;

end.

