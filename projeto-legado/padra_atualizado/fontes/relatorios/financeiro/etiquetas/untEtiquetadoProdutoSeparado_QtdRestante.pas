unit untEtiquetadoProdutoSeparado_QtdRestante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untCfgGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, untZClient,
  cxCurrencyEdit, untConsultas, untTypesSistema, untFuncoesSimples, untFuncoesConsulta,
  Datasnap.DBClient, UniClientDataSet, Vcl.Grids, Vcl.DBGrids, dxCore;

type
  TfrmEtiquetadoProdutoSeparado_QtdRestante = class(TfrmPai)
    pnlPedido: TPanel;
    cxgDados: TcxGridCitel;
    cxDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    Label1: TLabel;
    edtNumPed: TEditFocus;
    edtEspPed: TEditFocus;
    btnCarrega: TBitBtnLocked;
    dtsDados: TDataSource;
    cxDadosColumn1: TcxGridDBColumn;
    cxDadosColumn2: TcxGridDBColumn;
    cxDadosColumn3: TcxGridDBColumn;
    cxDadosColumn4: TcxGridDBColumn;
    cxDadosQTDSEP: TcxGridDBColumn;
    cxDadosQTDFRA: TcxGridDBColumn;
    cxDadosQTDPAC: TcxGridDBColumn;
    cxDadosColumn8: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    edtCodEmpresa: TEditFocus;
    Label2: TLabel;
    edtDesEmpresa: TEditFocus;
    btnImprimir: TBitBtnLocked;
    cdsDadosEtiquetas: TUniClientDataSet;
    cxDadosColumn5: TcxGridDBColumn;
    cxDadosCODFAB: TcxGridDBColumn;
    cxDadosBARRAS: TcxGridDBColumn;
    cxDadosMARCA: TcxGridDBColumn;
    cxDadosREFERE: TcxGridDBColumn;
    cxDadosQTDPED: TcxGridDBColumn;
    cxDadosNUMLOTE: TcxGridDBColumn;
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure btnCarregaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cxDadosQTDPACPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxDadosQTDFRAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);


  private
    objCfgGri: TCfgGrid;
    qryDados: TZClient;
    arrLinEmp: TConsultasArray;

    procedure pGetSQL;
    procedure onBeforePost(DataSet: TDataSet);
    function  fValidaQuantidadeFracionada: Boolean;
    procedure pMontaEstruturaEtiqueta;
    procedure pAlimentaEtruturaEtiqueta;
    function fValidaQtdEtiqueta: Boolean;
    procedure pOrdenarDataSet;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEtiquetadoProdutoSeparado_QtdRestante: TfrmEtiquetadoProdutoSeparado_QtdRestante;

implementation

uses
  TypesRel, untFuncoesEtiquetas;



{$R *.dfm}

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.btnCarregaClick(
  Sender: TObject);
begin
  inherited;

  If Assigned(qryDados) Then
    FreeAndNil(qryDados);

  qryDados := TZClient.Create(nil);
  dtsDados.DataSet := qryDados;

  If Not Assigned(objCfgGri) Then
  Begin
    objCfgGri := TCfgGrid.Create(Self, cxDados, 'Etiqueta do Produto Separado - Etiqueta da Quantidade Restante da Embalagem Aberta', [], strLoginUsuarioLogado, True, False, []);
    objCfgGri.fCarregarConfiguracaoGrid;
  End;

  pGetSQL;

  qryDados.fAbreClient(False,'[TfrmEtiquetadoProdutoSeparado_QtdRestante.btnCarregaClick]');

  If qryDados.IsEmpty Then
  Begin
    pMensagemOk('Sem dados para exibir!');
    Exit;
  End;

  pnlPedido.Enabled := False;
  qryDados.BeforePost := onBeforePost;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.btnImprimirClick(
  Sender: TObject);
  var prmDllEtq: TParamDllEtiquetas;
begin
  inherited;
  If fValidaQtdEtiqueta Then
  Begin
    pMontaEstruturaEtiqueta;
    pAlimentaEtruturaEtiqueta;
    prmDllEtq := TParamDllEtiquetas.Create;
    Try
      prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));
      prmDllEtq.tpeTipEtq := IIf(fCfgSis('ETISER', varString) = 'L', tpeEtiquetaDoProdutoSeparado, tpeEtiquetaDoProdutoSeparadoArgox);
      prmDllEtq.cdsDadosEtiqueta := cdsDadosEtiquetas;
      prmDllEtq.intQtdEti := 1;

      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetasSeparacaoQtdRestante');
    Finally
      FreeAndNil(prmDllEtq);
    End;
    Close;
  End
  Else
    pMensagemOk('Nenhuma quantidade informada! ');

end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.cxDadosQTDFRAPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
 var
   fltQtdSeparada: Double;
   fltQtdFraciona: Double;
   strErro: String;
begin
  inherited;
  // QTD FRACIONADA         =
  // DIGITADO PELO USUARIO. TRAZER FDO_QTDSEP COMO SUGESTAO.
  // DEIXAR ESTA COLUNA EM ABERTA CLARINHO, PRA INDICAR ISSO. PERMITIR SOMENTE > 0 E <= QTD SEPARADA
  fltQtdSeparada := 0;
  If (cxDados.DataController.Values[cxDados.DataController.FocusedRecordIndex,  cxDadosQTDSEP.Index]) <> null then
    fltQtdSeparada := (cxDados.DataController.Values[cxDados.DataController.FocusedRecordIndex,  cxDadosQTDSEP.Index]);
  fltQtdFraciona := IIf(fEmptyStr(DisplayValue), 0, DisplayValue);


  If fltQtdFraciona > fltQtdSeparada  Then
    strErro := 'Quantidade Fracionada deve ser menor ou igual a quantidade separada!';

  If fltQtdFraciona = 0 Then
  Begin
    qryDados.FieldByName('FDO_QTDFRA').AsCurrency := 0;
    qryDados.FieldByName('FDO_QTDPAC').AsCurrency := 0;
  End;

  If strErro <> '' Then
  Begin
    DisplayValue := FormatFloat('#0.00', fltQtdSeparada);
    pMensagemOk(strErro);
  End;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.cxDadosQTDPACPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  var fltQtdFraciona: Double;
begin
  inherited;
  IF fEmptyStr(DisplayValue) Then
    DisplayValue := 0;
  If DisplayValue <= 0 then
  Begin
     pMensagemOk('A Quantidade do Pacote deve ser maior que zero');
    DisplayValue := FormatFloat('#0.00', 1);
  End;
  fltQtdFraciona := 0;
  If (cxDados.DataController.Values[cxDados.DataController.FocusedRecordIndex,  cxDadosQTDFRA.Index]) <> null then
    fltQtdFraciona := (cxDados.DataController.Values[cxDados.DataController.FocusedRecordIndex,  cxDadosQTDFRA.Index]);


  If (DisplayValue - fltQtdFraciona) < 0 Then
  Begin
     pMensagemOk('A Quantidade do Pacote deve ser maior que a quantidade fracionada');
     DisplayValue := FormatFloat('#0.00', fltQtdFraciona);
  End;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.edtCodEmpresaExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
  If edtNumPed.Text <> '' Then
    btnCarrega.Click;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.edtCodEmpresaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, True) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.FormCloseQuery(
  Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  If Not pnlPedido.Enabled Then
    If fPergunta('Deseja filtrar outro pedido?') Then
    Begin
      CanClose := False;
      pnlPedido.Enabled := True;
      edtNumPed.Clear;
      pSetFocus(edtNumPed);
      qryDados.Close;
    End;

end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmpresa.Text := VS_StrCodEmp;
  edtCodEmpresa.OnExit(Sender);
end;


procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.FormDestroy(
  Sender: TObject);
begin
  If Assigned(objCfgGri) Then
  Begin
    objCfgGri.fSalvarConfiguracaoGrid;
    FreeAndNil(objCfgGri);
  End;
  inherited;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 then
    btnImprimir.Click;
  If Key = 27 then
    btnSair.Click;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumPed);
end;

function  TfrmEtiquetadoProdutoSeparado_QtdRestante.fValidaQuantidadeFracionada: Boolean;
Begin
  Result := False;
  If qryDados.FieldByName('FDO_QTDFRA').AsFloat >= 0 then
    If qryDados.FieldByName('FDO_QTDFRA').AsFloat <= qryDados.FieldByName('FDO_QTDSEP').AsFloat then
      Result := True;
end;

procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.onBeforePost(DataSet: TDataSet);
begin
  If  fValidaQuantidadeFracionada Then
    If qryDados.FieldByName('FDO_QTDPAC').AsFloat > 0 then
      qryDados.FieldByName('FDO_QTDRES').AsFloat := qryDados.FieldByName('FDO_QTDPAC').AsFloat - qryDados.FieldByName('FDO_QTDFRA').AsFloat


end;


procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.pGetSQL;
begin
  qryDados.qryQuery.SQL.Add('SELECT FDO_CODITE,');
  qryDados.qryQuery.SQL.Add('       FDO_DESCRI, ');
  qryDados.qryQuery.SQL.Add('       FDO_NUMDOC, ');
  qryDados.qryQuery.SQL.Add('       ITE_CODFAB, ');
  qryDados.qryQuery.SQL.Add('       ITE_CODBAR, ');
  qryDados.qryQuery.SQL.Add('       FDO_UNIDAD,');
  qryDados.qryQuery.SQL.Add('       FDO_QTDITE - IFNULL( FDO_QTDBAI, 0 ) AS FDO_QTDITE,'); //QTD PEDIDO
  qryDados.qryQuery.SQL.Add('       FDO_QTDITE - IFNULL( FDO_QTDBAI, 0 ) AS FDO_QTDSEP,');                                         //QTD SEPARADA
  qryDados.qryQuery.SQL.Add('       FDO_QTDSEP AS FDO_QTDFRA,');                               // QTD FRACIONADA
  qryDados.qryQuery.SQL.Add('       0.0000 AS FDO_QTDPAC,');                               // QTD PACOTE
  qryDados.qryQuery.SQL.Add('       0.0000 AS FDO_QTDRES, ');                                //QTD NOVA ETIQ EMB ABERT
  qryDados.qryQuery.SQL.Add('       1 AS ITE_QTDETI, ');
  qryDados.qryQuery.SQL.Add('       LOT_LOCFIS,  ');
  qryDados.qryQuery.SQL.Add('       LOT_NUMLOT, ');
  qryDados.qryQuery.SQL.Add('       CADMAR.MAR_DESMAR, ');
  qryDados.qryQuery.SQL.Add('       CADITE.ITE_BARRAS, ');
  qryDados.qryQuery.SQL.Add('       CADITE.ITE_REFERE ');
  qryDados.qryQuery.SQL.Add('  FROM FATDOR');
  qryDados.qryQuery.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
  qryDados.qryQuery.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN CADLOT ON LOT_NUMLOT =  FDO_NUMLOT AND LOT_CODITE = FDO_CODITE AND LOT_CODEMP = FDO_CODEMP ');
  qryDados.qryQuery.SQL.Add(' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR');
  qryDados.qryQuery.SQL.Add(' WHERE TRUE');
  qryDados.qryQuery.SQL.Add('   AND FDO_NUMDOC = "'+edtNumPed.Text+'"');
  qryDados.qryQuery.SQL.Add('   AND FDO_ESPDOC = "PD"');
  qryDados.qryQuery.SQL.Add('   AND FDO_CODEMP = "'+edtCodEmpresa.Text+'"');
  qryDados.qryQuery.SQL.Add('   AND FDO_IDEPRO = "NOR" AND IFNULL( FDO_CODACA, "" ) = ""');
  qryDados.qryQuery.SQL.Add('   AND ITE_DESITE <> "ITEM ESPECIAL"');
end;


procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.pAlimentaEtruturaEtiqueta;
Var
  intContador: Integer;
begin
  pOrdenarDataSet;
  If Assigned(qryDados) Then
  Begin
    qryDados.First;
    While not qryDados.Eof Do
    Begin
      // Etiqueta da saida
      If (qryDados.FieldByName('FDO_QTDFRA').AsFloat > 0) Then
      Begin
        For intContador := 1 To qryDados.FieldBYName('ITE_QTDETI').AsInteger Do
        Begin
          cdsDadosEtiquetas.Append;
          cdsDadosEtiquetas.FieldByName('CODIGO').AsInteger := qryDados.RecNo;
          cdsDadosEtiquetas.FieldByName('CODITE').AsString := qryDados.FieldByName('FDO_CODITE').AsString;
          cdsDadosEtiquetas.FieldByName('DESITE').AsString := qryDados.FieldByName('FDO_DESCRI').AsString;
          cdsDadosEtiquetas.FieldByName('CODFAB').AsString := qryDados.FieldByName('ITE_CODFAB').AsString;
          cdsDadosEtiquetas.FieldByName('CODBAR').AsString := qryDados.FieldByName('ITE_CODBAR').AsString;
          cdsDadosEtiquetas.FieldByName('LOCFIS').AsString := qryDados.FieldByName('LOT_LOCFIS').AsString;
          cdsDadosEtiquetas.FieldByName('QTDETI').AsFloat  := qryDados.FieldByName('FDO_QTDFRA').AsFloat;
          cdsDadosEtiquetas.FieldByName('MOVIME').AsString := 'F';
          cdsDadosEtiquetas.FieldByName('PEDIDO').AsString := qryDados.FieldByName('FDO_NUMDOC').AsString;
          cdsDadosEtiquetas.FieldByName('EXPMOV').AsString := 'PEDIDO Nº'+ qryDados.FieldByName('FDO_NUMDOC').AsString;
          cdsDadosEtiquetas.FieldByName('NUMLOT').AsString := qryDados.FieldByName('LOT_NUMLOT').AsString;
          cdsDadosEtiquetas.Post;
        End;
      End;

      If qryDados.FieldByName('FDO_QTDRES').AsFloat > 0 Then
      Begin
        // Etiqueta da sobra
        cdsDadosEtiquetas.Append;
        cdsDadosEtiquetas.FieldByName('CODIGO').AsInteger := qryDados.RecNo;
        cdsDadosEtiquetas.FieldByName('CODITE').AsString := qryDados.FieldByName('FDO_CODITE').AsString;
        cdsDadosEtiquetas.FieldByName('DESITE').AsString := qryDados.FieldByName('FDO_DESCRI').AsString;
        cdsDadosEtiquetas.FieldByName('CODFAB').AsString := qryDados.FieldByName('ITE_CODFAB').AsString;
        cdsDadosEtiquetas.FieldByName('CODBAR').AsString := qryDados.FieldByName('ITE_CODBAR').AsString;
        cdsDadosEtiquetas.FieldByName('LOCFIS').AsString := qryDados.FieldByName('LOT_LOCFIS').AsString;
        cdsDadosEtiquetas.FieldByName('QTDETI').AsFloat  := qryDados.FieldByName('FDO_QTDRES').AsFloat;
        cdsDadosEtiquetas.FieldByName('MOVIME').AsString := 'R';
        cdsDadosEtiquetas.FieldByName('PEDIDO').AsString := qryDados.FieldByName('FDO_NUMDOC').AsString;
        cdsDadosEtiquetas.FieldByName('EXPMOV').AsString := 'ESTOQUE ' + qryDados.FieldByName('LOT_LOCFIS').AsString;
        cdsDadosEtiquetas.FieldByName('NUMLOT').AsString := qryDados.FieldByName('LOT_NUMLOT').AsString;
        cdsDadosEtiquetas.Post;
      End;
      qryDados.Next;
    End;
  End;
end;


procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.pMontaEstruturaEtiqueta;
var qryEtiqueta: TZClient;
begin
  qryEtiqueta := TZClient.Create(nil);
  Try
    qryEtiqueta.qryQuery.SQL.Add('SELECT ITE_CODITE AS CODITE,');
    qryEtiqueta.qryQuery.SQL.Add('       ITE_CODFAB AS CODFAB,');
    qryEtiqueta.qryQuery.SQL.Add('       ITE_CODBAR AS CODBAR,');
    qryEtiqueta.qryQuery.SQL.Add('       ITE_DESITE AS DESITE,');
    qryEtiqueta.qryQuery.SQL.Add('       0 AS CODIGO,');
    qryEtiqueta.qryQuery.SQL.Add('       LOT_LOCFIS AS LOCFIS,');
    qryEtiqueta.qryQuery.SQL.Add('       LOT_SALDOS AS QTDETI,');
    qryEtiqueta.qryQuery.SQL.Add('       CAST("" AS CHAR(1)) AS MOVIME,');
    qryEtiqueta.qryQuery.SQL.Add('       FDO_NUMDOC AS PEDIDO,');
    qryEtiqueta.qryQuery.SQL.Add('       CAST("" AS CHAR(255)) AS EXPMOV,');
    qryEtiqueta.qryQuery.SQL.Add('       LOT_NUMLOT AS NUMLOT');
    qryEtiqueta.qryQuery.SQL.Add(' FROM CADITE, CADLOT, FATDOR');
    qryEtiqueta.qryQuery.SQL.Add('WHERE FALSE');
    qryEtiqueta.fAbreClient(False,'[TfrmEtiquetadoProdutoSeparado_QtdRestante.pMontaEstruturaEtiqueta]');
    cdsDadosEtiquetas.Data := qryEtiqueta.Data;
  Finally
    FreeAndNil(qryEtiqueta);

  End;
end;

function TfrmEtiquetadoProdutoSeparado_QtdRestante.fValidaQtdEtiqueta: Boolean;
Begin

  Result := False;

  If Assigned(qryDados) Then
  Begin
    qryDados.First;
    While (Not qryDados.Eof) And (Not Result)  Do
    Begin
      If ((qryDados.FieldByName('FDO_QTDRES').AsFloat > 0) OR (qryDados.FieldByName('FDO_QTDFRA').AsFloat > 0)) Then
        Result := True;

      qryDados.Next;
    End;

    qryDados.First;
  End

End;


procedure TfrmEtiquetadoProdutoSeparado_QtdRestante.pOrdenarDataSet;
var
  intContador: Integer;
  strIndice, strDesc, strNome: String;
  idxOpcao: TIndexOptions;
begin
  idxOpcao := [];
  // percorre os campos "ordenados" da grid
  for intContador := 0 to cxDados.SortedItemCount - 1 do
  begin
    // adiciona a var "S"
    strIndice := IIF(intContador = 0, cxDados.SortedItems[intContador].DataBinding.FilterFieldName, strIndice + ';' + cxDados.SortedItems[intContador].DataBinding.FilterFieldName);
    // se for descendente coloca em strDesc
    if cxDados.SortedItems[intContador].SortOrder = soDescending then
    begin
      idxOpcao := [ixDescending];
      if strDesc = '' then
        strDesc := cxDados.SortedItems[intContador].DataBinding.FilterFieldName
      else
        strDesc := strDesc + ';' + cxDados.SortedItems[intContador].DataBinding.FilterFieldName;
    end;
  end;
  strNome := FormatDateTime('NNSSZZZ', VS_Date );
  qryDados.IndexDefs.Clear;
  qryDados.IndexDefs.Add(strNome, strIndice, idxOpcao);
  qryDados.IndexDefs[qryDados.IndexDefs.Count-1].DescFields := strDesc;
  qryDados.IndexDefs[qryDados.IndexDefs.Count-1].Fields := strIndice;
  qryDados.IndexName := strNome;
end;

end.
