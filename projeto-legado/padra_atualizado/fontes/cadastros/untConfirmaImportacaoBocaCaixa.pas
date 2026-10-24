unit untConfirmaImportacaoBocaCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar,
  cxCheckBox, System.StrUtils, UniClientDataSet, System.UITypes,
  cxTextEdit, Vcl.Grids, Vcl.DBGrids, EditFocus, Math;

type
  TfrmConfirmaImportacaoBocaCaixa = class(TfrmPaiConfirma)
    dtsItens: TDataSource;
    grpLegenda: TGroupBox;
    shpProdutoComInconsistencia: TShape;
    lblProdutoComInconsistencia: TLabel;
    cxgProdutosImportadosDBTableView1: TcxGridDBTableView;
    cxgProdutosImportadosLevel1: TcxGridLevel;
    cxgProdutosImportados: TcxGrid;
    shpProdutoOk: TShape;
    lblProdutoOk: TLabel;
    pnlTopo: TPanel;
    rdgOpcoesPesquisa: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgProdutosImportadosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure rdgOpcoesPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgProdutosImportadosDBTableView1EditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    FCdsFormBocaCaixa : TUniClientDataSet;
    procedure pFiltrarItens(blnApenasInconsistentes: Boolean; blnApeSInconsit : Boolean = False);
    procedure pValidaCorrecao;
    function fValidaInconsist : Boolean;
    function fImportaDados(pgbStatus: TcxProgressBar): Boolean;
    function fRetSQlInclusaoGrid : string;
    function fRetStrCodIte : string;
    procedure pClonaDataSet(var pgbStatus: TcxProgressBar);
    property strCodIte : string Read fRetStrCodIte;
  public
    { Public declarations }
    cdsArqv : TUniClientDataSet;
    property cdsFormBocaCaixa : TUniClientDataSet read FCdsFormBocaCaixa write FCdsFormBocaCaixa;
  end;

implementation

uses
  untGravando,
  untConsultas,
  untTypesSistema,
  untFuncoesSimples,
  untBocaCaixa;

{$R *.dfm}

function TfrmConfirmaImportacaoBocaCaixa.fImportaDados(pgbStatus: TcxProgressBar): Boolean;
Begin
  Result := fValidaInconsist;

  If Result then
     if (fMensagem('ATENÇÃO!', 'Ainda há inconsistências na grade. Ao confirmar, apenas os produtos sem inconsistências serão importados para o Ajuste.' + #13#10 +
                'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2) then
        Exit;

  pClonaDataSet(pgbStatus);
End;

procedure TfrmConfirmaImportacaoBocaCaixa.btnConfirmaClick(Sender: TObject);
Var
  frmGravando : TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    try
      frmGravando.fExecutarAcao := fImportaDados;
      frmGravando.lblGravando.Caption := 'Aguarde... Processando Itens...';
      frmGravando.Showmodal;
      Self.ModalResult := mrOk;
      CloseModal;
    except
      on e : exception do
      begin
        fMensagem('ATENÇÃO!', 'Houve um erro de transferência de dados.', ['&Sim']);
        pMensagensErro(e.Message, '[TfrmConfirmaImportacaoBocqaCaixa.fImportaDados]');
        pFreeAndNil(frmGravando);
      end;
    end;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.pClonaDataSet(var pgbStatus: TcxProgressBar);
var
  intContador : Integer;
  qryTemp : TUniQuery;
  arrCamposArqv : array of string;
  strNomeCampo : string;
begin
  strNomeCampo := EmptyStr;
  qryTemp := fCriaQuery;
  try
    arrCamposArqv := ['PREMIN', 'COMVAR'];
    pFiltrarItens(True, True);
    dtsItens.DataSet.DisableControls;
    qryTemp.SQL.Text := fRetSQlInclusaoGrid;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.Open;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := qryTemp.RecordCount;
    qryTemp.First;
    while not qryTemp.Eof do
    begin
      If cdsArqv.Locate('CODITE', qryTemp.FieldByName('CODITE').AsString, []) Then
      Begin
        cdsFormBocaCaixa.Append;
        for intContador := 0 to Pred(qryTemp.FieldCount) do
        begin
          strNomeCampo := qryTemp.FieldDefList[intContador].Name;
          if AnsiMatchText(strNomeCampo, arrCamposArqv) then
            cdsFormBocaCaixa.FieldByName(strNomeCampo).AsFloat := cdsArqv.FieldByName(strNomeCampo).AsFloat
          else
            cdsFormBocaCaixa.FieldByName(strNomeCampo).AsString := qryTemp.Fields[intContador].AsString;
        end;
        cdsFormBocaCaixa.Post;
      End;

      qryTemp.Next;
      pgbStatus.Position :=  pgbStatus.Position + 1;
      Application.ProcessMessages;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.cxgProdutosImportadosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strInconsist : string;
begin
  inherited;

  strInconsist := '';
  strInconsist := VarToString(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cdsArqv.FieldCount -1]);

  If cdsArqv.RecordCount = 0 Then
    Exit;

  ACanvas.Font.Color := clBlack;
  If fEmptyStr(strInconsist) then
    ACanvas.Brush.Color := shpProdutoOk.Brush.Color
  Else
    ACanvas.Brush.Color := shpProdutoComInconsistencia.Brush.Color;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.cxgProdutosImportadosDBTableView1EditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  Sender.Controller.EditingController.Edit.PostEditValue;
  pValidaCorrecao;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirma.Click;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.FormShow(Sender: TObject);
begin
  inherited;
  dtsItens.DataSet := cdsArqv;
end;

function TfrmConfirmaImportacaoBocaCaixa.fRetSQlInclusaoGrid: string;
begin
  Result := '';
  Result := Result +'SELECT                                ';
  Result := Result +'  C.ITE_CODITE AS CODITE,             ';
  Result := Result +'  C.ITE_DESITE AS DESITE,             ';
  Result := Result +'  C.ITE_CODGRU AS CODGRU,             ';
  Result := Result +'  C.ITE_CODUNI AS CODUNI,             ';
  Result := Result +'  U.UNI_SIGUNI AS UNIDAD,             ';
  Result := Result +'  I.ITE_PRECUS AS PRECUS,             ';
  Result := Result +'  I.ITE_PREVE1 AS PREVEN,             ';
  Result := Result +'  0.00 AS PREMIN,                     ';
  Result := Result +'  0.00 AS COMVAR,                     ';
  Result := Result +'  NULL AS DTACAD                      ';
  Result := Result +'FROM                                  ';
  Result := Result +'  CADITE C,                           ';
  Result := Result +'  ITEGER I,                           ';
  Result := Result +'  CADUNI U                            ';
  Result := Result +'WHERE C.ITE_CODITE = I.ITE_CODITE     ';
  Result := Result +'  AND C.ITE_CODUNI = U.UNI_CODUNI     ';
  Result := Result +'  AND C.ITE_ITEATI = "S"              ';
  Result := Result +'  AND I.ITE_CODEMP = :CODEMP          ';
  Result := Result +'  AND I.ITE_CODITE IN ('+strCodIte+') ';
  Result := Result +'ORDER BY C.ITE_DESITE                 ';
end;

function TfrmConfirmaImportacaoBocaCaixa.fRetStrCodIte: string;
begin
  Result := '';
  cdsArqv.First;
  while not cdsArqv.Eof do
  begin
    Result := Result + QuotedStr(FormatFloat('00000', StrToInt(cdsArqv.FieldByName('CODITE').AsString))) + ',';
    cdsArqv.Next;
  end;

  if Copy(Result, Length(Result), Length(Result)) = ',' then
    Result := Result + Copy(Result, 1, Length(Result) -1);
end;

function TfrmConfirmaImportacaoBocaCaixa.fValidaInconsist: Boolean;
begin
  Result := False;
  pFiltrarItens(True);
  if cdsArqv.RecordCount > 0 then
    Result := True;
  pFiltrarItens(False);
end;

procedure TfrmConfirmaImportacaoBocaCaixa.rdgOpcoesPesquisaClick(
  Sender: TObject);
begin
  inherited;
  Case rdgOpcoesPesquisa.ItemIndex Of
    0: pFiltrarItens(False);
    1: pFiltrarItens(True);
  End;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.pFiltrarItens(blnApenasInconsistentes: Boolean; blnApeSInconsit : Boolean = False);
begin
  if blnApeSInconsit then
    cdsArqv.Filter := 'INCONSISTENCIA = '+QuotedStr('')
  else
    cdsArqv.Filter := 'INCONSISTENCIA <> '+QuotedStr('');
  cdsArqv.Filtered := blnApenasInconsistentes;
end;

procedure TfrmConfirmaImportacaoBocaCaixa.pValidaCorrecao;
var
  intLinha, intColuna : Integer;
  strInconsist : string;
  lstInconsist  : TStringList;
begin
  strInconsist := '';
  lstInconsist := TStringList.Create;
  lstInconsist.Delimiter := ';';
  cdsArqv.Edit;
  try
    for intLinha := 0 to Pred(cdsArqv.RecordCount) do
    begin
      for intColuna := 0 to Pred(cdsArqv.FieldCount) do
      begin
        if cdsArqv.FieldDefList[intColuna].Name = 'INCONSISTENCIA' then
          Continue;

        strInconsist := EmptyStr;
        strInconsist := TInconsistencia.fValidaInconsistencia(intLinha,
                                                              arrColunas[intColuna],
                                                              cdsArqv.Fields[intColuna].AsString,
                                                              cdsArqv.Fields[intColuna].DataType,
                                                              cdsArqv.Fields[intColuna].Required);
       if not strInconsist.IsEmpty then
         lstInconsist.Add(strInconsist);
      end;
    end;
    cdsArqv.FieldByName('INCONSISTENCIA').AsString := lstInconsist.Text;
    cdsArqv.Post;
  finally
    FreeAndNil(lstInconsist);
  end;
end;

end.
