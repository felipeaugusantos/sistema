unit untLibCartoesDefinirEmpresasEmEstabelecimentoPorRegiao;

interface

Uses System.Generics.Collections, Vcl.AppEvnts, Vcl.Menus, Vcl.Controls,
     Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, System.Classes, Vcl.ComCtrls,
     Data.DB,

     cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
     cxGridCustomView, cxGrid, cxGridCitel, frxClass, Uni, UniClientDataSet,
     frxExportCSVTestabilidade, BitBtnLockedIncrem, cxCurrencyEdit, cxTextEdit,
     cxCalc, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
     cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
     cxGridLevel, cxGridCustomTableView, cxGridTableView, cxNavigator,
     cxDataControllerConditionalFormattingRulesManagerDialog,

     untLibCartoesPaiSimples, untTCieloFuncoes, untLibCartoesInterfacesTipos,
     untCieloTipos;

type
  TfrmDefinirEmpresasEmEstabelecimentoPorRegiao = class(TfrmPaiSimples)
    dbgConsulta: TcxGridCitel;
    dbgConsultaDados: TcxGridDBBandedTableView;
    dbgConsultaDadosNUMLIBERACAO: TcxGridDBBandedColumn;
    dbgConsultaDadosNSU: TcxGridDBBandedColumn;
    dbgConsultaDadosVENCIMENTO: TcxGridDBBandedColumn;
    dbgConsultaDadosCADASTRO: TcxGridDBBandedColumn;
    dbgConsultaDadosVALOR: TcxGridDBBandedColumn;
    dbgConsultaDadosVALORSEMTAXA: TcxGridDBBandedColumn;
    dbgConsultaDadosPARCELA: TcxGridDBBandedColumn;
    dbgConsultaDadosCODEMPRESA: TcxGridDBBandedColumn;
    dbgConsultaDadosNOMEEMPRESA: TcxGridDBBandedColumn;
    dbgConsultaNivel: TcxGridLevel;
    pnlMensagem: TPanel;
    lblMensagem: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaDadosEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure dbgConsultaDadosCODEMPRESAPropertiesEditValueChanged(
      Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    FCdsConsulta: TUniClientDataset;
    FDtsConsulta: TDataSource;
    FEditandoGrid: Boolean;

    procedure pCriarDataset;
    procedure pCriarDatasetFieldString(ANomeField: string; ATamanho: Integer);
    procedure pCriarDatasetFieldDate(ANomeField: string);
    procedure pCriarDatasetFieldFloat(ANomeField: string; APrecisao: Integer);
    procedure pEditarEmpresa(ACodigoEmpresa, ANomeEmpresa: string);

    function fTodosRegistrosTemEmpresaDefinida: Boolean;
  public
    procedure pCarregarDados(AListaRegistros: TArray<TRegistroCartaoEstabelecimentoPorRegiao>);
    function fRetornaListaRegistrosEstabelecimentosRegiaoComEmpresa: TObjectList<TRegistroCartaoEstabelecimentoPorRegiao>;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils, Variants, Winapi.Windows;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.FormCreate(
  Sender: TObject);
begin
  inherited;
  pCriarDataset;
  FEditandoGrid := False;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FCdsConsulta.EmptyDataSet;
  FCdsConsulta.Close;
  FreeAndNil(FDtsConsulta);
  FreeAndNil(FCdsConsulta);
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.FormShow(
  Sender: TObject);
begin
  inherited;
  pSetFocus(dbgConsulta);
  dbgConsultaDados.Controller.FocusFirstAvailableItem;
  dbgConsultaDados.Controller.EditingController.ShowEdit;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F10) then
    btnConfirma.Click;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.pCriarDataset;
begin
  FCdsConsulta := TUniClientDataSet.Create(nil);
  FDtsConsulta := TDatasource.Create(nil);
  FDtsConsulta.Dataset := FCdsConsulta;
  dbgConsultaDados.DataController.DataSource := FDtsConsulta;
  FCdsConsulta.FetchOnDemand := False;
  pCriarDatasetFieldString('NUMLIBERACAO', 25);
  pCriarDatasetFieldString('NSU', 40);
  pCriarDatasetFieldDate('DTAVENCIMENTO');
  pCriarDatasetFieldDate('DTACADASTRO');
  pCriarDatasetFieldDate('DTAVENDA');
  pCriarDatasetFieldFloat('VALORTOTAL', 2);
  pCriarDatasetFieldFloat('VALORSEMTAXA', 2);
  pCriarDatasetFieldString('PARCELA', 1);
  pCriarDatasetFieldString('CODIGOEMPRESA', 3);
  pCriarDatasetFieldString('NOMEEMPRESA', 60);
  FCdsConsulta.CreateDataset;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.pCarregarDados(AListaRegistros: TArray<TRegistroCartaoEstabelecimentoPorRegiao>);
var
  ARegistro: TRegistroCartaoEstabelecimentoPorRegiao;
begin
  if FCdsConsulta.Active then
    FCdsConsulta.EmptyDataset
  else
    FCdsConsulta.Open;

  FCdsConsulta.DisableControls;
  try
    for ARegistro in AListaRegistros do
    begin
      FCdsConsulta.Append;
      FCdsConsulta.FieldByName('NUMLIBERACAO').AsString := ARegistro.NumLiberacao;
      FCdsConsulta.FieldByName('NSU').AsString :=  ARegistro.NSU;
      FCdsConsulta.FieldByName('DTAVENCIMENTO').AsDatetime := ARegistro.DtaVencimento;
      FCdsConsulta.FieldByName('DTACADASTRO').AsDatetime := ARegistro.DtaCadastro;
      FCdsConsulta.FieldByName('DTAVENDA').AsDatetime := ARegistro.DtaVenda;
      FCdsConsulta.FieldByName('VALORTOTAL').AsFloat := ARegistro.Valor;
      FCdsConsulta.FieldByName('VALORSEMTAXA').AsFloat := ARegistro.ValorSemTaxa;
      FCdsConsulta.FieldByName('PARCELA').AsString := ARegistro.Parcela;
      FCdsConsulta.FieldByName('CODIGOEMPRESA').AsString := '';
      FCdsConsulta.FieldByName('NOMEEMPRESA').AsString := '';
      FCdsConsulta.Post;
    end;

    FCdsConsulta.First;
  finally
    FCdsConsulta.EnableControls;
  end;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.pCriarDatasetFieldDate(
  ANomeField: string);
var
  LField: TFieldDef;
begin
  LField := FCdsConsulta.FieldDefs.AddFieldDef;
  LField.Name := ANomeField;
  LField.DataType := ftDate;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.pCriarDatasetFieldFloat(
  ANomeField: string; APrecisao: Integer);
var
  LField: TFieldDef;
begin
  LField := FCdsConsulta.FieldDefs.AddFieldDef;
  LField.Name := ANomeField;
  LField.DataType := ftFloat;
  LField.Precision := APrecisao;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.pCriarDatasetFieldString(
  ANomeField: string; ATamanho: Integer);
var
  LField: TFieldDef;
begin
  LField := FCdsConsulta.FieldDefs.AddFieldDef;
  LField.Name := ANomeField;
  LField.DataType := ftString;
  LField.Size := ATamanho;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.pEditarEmpresa(
  ACodigoEmpresa, ANomeEmpresa: string);
begin
  FCdsConsulta.Edit;
  FCdsConsulta.FieldByName('CODIGOEMPRESA').AsString := ACodigoEmpresa;
  FCdsConsulta.FieldByName('NOMEEMPRESA').AsString := ANomeEmpresa;
  FCdsConsulta.Post;
end;

function TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.fRetornaListaRegistrosEstabelecimentosRegiaoComEmpresa: TObjectList<TRegistroCartaoEstabelecimentoPorRegiao>;
var
  LListaRegistros: TObjectList<TRegistroCartaoEstabelecimentoPorRegiao>;
begin
  LListaRegistros := TObjectList<TRegistroCartaoEstabelecimentoPorRegiao>.Create(False);
  try
    FCdsConsulta.First;
    while not FCdsConsulta.Eof do
    begin
      LListaRegistros.Add(
        TRegistroCartaoEstabelecimentoPorRegiao.Create(
          FCdsConsulta.FieldByName('NUMLIBERACAO').AsString,
          FCdsConsulta.FieldByName('NSU').AsString,
          FCdsConsulta.FieldByName('DTAVENCIMENTO').AsDatetime,
          FCdsConsulta.FieldByName('DTACADASTRO').AsDatetime,
          FCdsConsulta.FieldByName('DTAVENDA').AsDatetime,
          FCdsConsulta.FieldByName('VALORTOTAL').AsFloat,
          FCdsConsulta.FieldByName('VALORSEMTAXA').AsFloat,
          FCdsConsulta.FieldByName('PARCELA').AsString,
          FCdsConsulta.FieldByName('CODIGOEMPRESA').AsString,
          FCdsConsulta.FieldByName('NOMEEMPRESA').AsString));

      FCdsConsulta.Next;
    end;

    Result := TObjectList<TRegistroCartaoEstabelecimentoPorRegiao>.Create;
    Result.AddRange(LListaRegistros.ToArray);
  finally
    FreeAndNil(LListaRegistros);
  end;
end;

function TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.fTodosRegistrosTemEmpresaDefinida: Boolean;
begin
  Result := not FCdsConsulta.Locate('CODIGOEMPRESA', '', []);
  FCdsConsulta.First;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.btnConfirmaClick(
  Sender: TObject);
begin
  ModalResult := mrNone;

  if fTodosRegistrosTemEmpresaDefinida then
    ModalResult := mrOk
  else
    TCieloFuncoes.fMensagem('', 'Para continuar com o lançamento, é necessário definir a empresa de todos os registros acima.', ['&O k']);
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.btnSairClick(
  Sender: TObject);
begin
  if (TCieloFuncoes.fMensagem('ATENÇÃO', 'Deseja sair sem efetuar os lançamentos?', ['&Sim', '&Não']) = 1) then
    ModalResult := mrCancel;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.dbgConsultaDadosCODEMPRESAPropertiesEditValueChanged(
  Sender: TObject);
var
  LConsulta: TUniQuery;
  LCodigoEmpresa, LNomeEmpresa: String;
  LEditCelula: TcxTextEdit;
  LLinhaFocada: Integer;
begin
  if FEditandoGrid then
    Exit;

  LEditCelula := TcxTextEdit(dbgConsultaDados.Controller.EditingController.Edit);

  if not Assigned(LEditCelula) then
    Exit;

  LCodigoEmpresa := '';
  LNomeEmpresa := '';
  LConsulta := VS_FuncoesExternas.fICriaQuery;
  try
    if (not TCieloFuncoes.fEmptyStr(VarToStr(LEditCelula.EditingValue))) then
    begin
      LConsulta.SQL.Text := 'SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :EMP_CODEMP';
      LConsulta.ParamByName('EMP_CODEMP').AsInteger := LEditCelula.EditingValue;
      LConsulta.Open;

      if LConsulta.Eof then
      begin
        TCieloFuncoes.fMensagem('ATENÇÃO', 'Empresa não encontrada.', ['&O k']);
      end
      else
      begin
        LCodigoEmpresa := LConsulta.FieldByName('EMP_CODEMP').AsString;
        LNomeEmpresa := LConsulta.FieldByName('EMP_NOMEMP').AsString;
      end;
    end;

    pEditarEmpresa(LCodigoEmpresa, LNomeEmpresa);

    if (not TCieloFuncoes.fEmptyStr(LCodigoEmpresa)) then
    begin
      LLinhaFocada := dbgConsultaDados.DataController.FocusedRecordIndex;
      dbgConsultaDados.Controller.FocusNextRecord(LLinhaFocada, True, True, False, False);
    end;
  finally
    FreeAndNil(LConsulta);
  end;

  inherited;
end;

procedure TfrmDefinirEmpresasEmEstabelecimentoPorRegiao.dbgConsultaDadosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  LConsulta: TUniQuery;
  LArrEmpresas: TConsultasArray;
  LLinhaFocada: Integer;
begin
  if (AItem <> Sender.FindItemByName('dbgConsultaDadosCODEMPRESA')) then
    Exit;

  if (Key = '/') then
  begin
    FEditandoGrid := True;
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    try
      if VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, Self, nil, nil, LConsulta, Key, LArrEmpresas, False) then
      begin
        pEditarEmpresa(LConsulta.FieldByName('EMP_CODEMP').AsString, LConsulta.FieldByName('EMP_NOMEMP').AsString);

        Key := #0;
        LLinhaFocada := Sender.DataController.FocusedRecordIndex;
        Sender.Controller.FocusNextRecord(LLinhaFocada, True, True, False, False);
      end;
    finally
      FEditandoGrid := False;
      FreeAndNil(LConsulta);
    end;
  end
  else if (not CharInSet(Key, ['0'..'9', '/', #8])) then
  begin
    Key := #0;
  end;

  inherited;
end;

end.
