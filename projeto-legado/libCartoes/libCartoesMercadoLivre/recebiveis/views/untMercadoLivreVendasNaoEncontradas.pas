unit untMercadoLivreVendasNaoEncontradas;

interface

uses Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.AppEvnts,
     Vcl.Menus, Vcl.Controls, Vcl.Buttons, Vcl.Forms, System.Classes,
     System.SysUtils, System.Math, Winapi.Windows,

     Uni, UniClientDataSet, cxControls, cxLookAndFeels, cxCheckBox,
     cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxStyles,
     cxCustomData, cxFilter, cxData, cxDataStorage, cxGraphics, cxGridCitel,
     cxGridDBTableView, cxGrid, cxNavigator,
     cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
     cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
     cxGridTableView, cxCurrencyEdit, cxCalendar, cxTextEdit, frxClass,
     frxExportCSVTestabilidade, BitBtnLockedIncrem,

     untLibCartoesPaiSimples, untTMercadoLivreFuncoes, untLibCartoesInterfacesTipos;

type
  TfrmMercadoLivreVendasNaoEncontradas = class(TfrmPaiSimples)
    btnConfirmar: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    dbgVendas: TcxGridCitel;
    dbgVendasDados: TcxGridDBTableViewCitel;
    dbgVendasDadosMARCADO: TcxGridDBColumn;
    dbgVendasDadosREL_NUMNSU: TcxGridDBColumn;
    dbgVendasDadosORDEID: TcxGridDBColumn;
    dbgVendasDadosREL_DTA_CV: TcxGridDBColumn;
    dbgVendasDadosREL_VALBRU: TcxGridDBColumn;
    dbgVendasDadosREL_VALTAX: TcxGridDBColumn;
    dbgVendasDadosREL_VALFRE: TcxGridDBColumn;
    dbgVendasDadosREL_VALLIQ: TcxGridDBColumn;
    dbgVendasDadosREL_DESCRI: TcxGridDBColumn;
    dbgVendasNivel: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure dbgVendasDadosMARCADOPropertiesEditValueChanged(Sender: TObject);
    procedure dbgVendasDadosDblClick(Sender: TObject);
    procedure dbgVendasDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    FDatasetVendas: TUniClientDataSet;
    FDataSource: TDataSource;
    FQtdMarcadas: Integer;
    FIncluiuVendas: Boolean;

    procedure pCarregaVendas(AAutoIncremRelatorio: Integer);
    procedure pMarcaTodas(AMarcar: Boolean);
    procedure pInverteMarcacao;
    procedure pAtualizaBotoes;
    function fGridFocado: Boolean;
  public
    class function fExecutar(AAutoIncremRelatorio: Integer): Boolean;
  end;

implementation

uses untTMercadoLivreInclusaoVendas;

{$R *.dfm}

class function TfrmMercadoLivreVendasNaoEncontradas.fExecutar(AAutoIncremRelatorio: Integer): Boolean;
  Var
    LForm: TfrmMercadoLivreVendasNaoEncontradas;
begin
  LForm := Nil;
  Try
    TMercadoLivreFuncoes.pCriarFormularios(TfrmMercadoLivreVendasNaoEncontradas, LForm);
    LForm.pCarregaVendas(AAutoIncremRelatorio);
    LForm.ShowModal;
    Result := LForm.FIncluiuVendas;
  Finally
    FreeAndNil(LForm);
  End;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.FormCreate(Sender: TObject);
  Var
    LLarguraColunas,
    LIndice: Integer;
begin
  inherited;

  LLarguraColunas := 0;
  For LIndice := 0 To dbgVendasDados.ColumnCount - 1 Do
    If dbgVendasDados.Columns[LIndice].Visible Then
      Inc(LLarguraColunas, dbgVendasDados.Columns[LIndice].Width);

  ClientWidth := Min(LLarguraColunas + GetSystemMetrics(SM_CXVSCROLL) + 8,
                     Screen.WorkAreaWidth - 40);
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.FormDestroy(Sender: TObject);
begin
  dbgVendasDados.DataController.DataSource := Nil;
  If Assigned(FDataSource) Then
    FreeAndNil(FDataSource);

  TMercadoLivreFuncoes.FreeAndNilDatasets(FDatasetVendas);
  inherited;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.FormShow(Sender: TObject);
begin
  inherited;
  TMercadoLivreFuncoes.pSetFocus(dbgVendas);
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If fGridFocado And (Key = VK_RETURN) Then
  Begin
    pInverteMarcacao;
    Key := 0;
    Exit;
  End;

  If (Key = VK_F10) Then
    btnConfirmar.Click
  Else If (Key = VK_F7) Then
    btnMarcarTodas.Click
  Else If (Key = VK_F8) Then
    btnDesmarcarTodas.Click
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click
  Else
    inherited;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.pCarregaVendas(AAutoIncremRelatorio: Integer);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT 0 AS MARCADO, ' +
                          '       R.REL_CODEMP, R.REL_NUMNSU, R.REL_DESCRI, R.REL_DTA_CV, ' +
                          '       COALESCE(R.REL_DTAVEN, R.REL_DTAPAG) AS DTAVEN, ' +
                          '       R.REL_VALBRU, R.REL_VALTAX, R.REL_VALFRE, R.REL_VALCUP, R.REL_VALLIQ, ' +
                          '       COALESCE((SELECT MAX(M.MER_ORD_ID) ' +
                          '                   FROM MER_MLPGTO M ' +
                          '                  WHERE M.MER_CODAUT = R.REL_CODAUT ' +
                          '                    AND M.MER_SHP_ID = R.REL_NUMNSU), R.REL_CODAUT) AS ORDEID ' +
                          'FROM REL_CONITE R ' +
                          'WHERE R.REL_RELINC = :RELINC ' +
                          '  AND R.REL_TIPREG = "INCONSISTENCIA" ' +
                          '  AND R.REL_DESCRI IN (:DESVEN, :DESMAQ) ' +
                          'ORDER BY R.REL_DTAVEN, R.REL_DTA_CV';
    LConsulta.ParamByName('RELINC').AsInteger := AAutoIncremRelatorio;
    LConsulta.ParamByName('DESVEN').AsString := TMercadoLivreInclusaoVendas.INCONSISTENCIA_VENDA;
    LConsulta.ParamByName('DESMAQ').AsString := TMercadoLivreInclusaoVendas.INCONSISTENCIA_MAQUININHA;
    LConsulta.Open;

    FDatasetVendas := TMercadoLivreFuncoes.CriarClientDataSet(LConsulta);
    FDatasetVendas.First;

    FDataSource := TDataSource.Create(Nil);
    FDataSource.AutoEdit := False;
    FDataSource.DataSet := FDatasetVendas;

    dbgVendasDados.DataController.DataSource := FDataSource;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  FIncluiuVendas := False;
  pAtualizaBotoes;
end;

function TfrmMercadoLivreVendasNaoEncontradas.fGridFocado: Boolean;
begin
  Result := Assigned(FDatasetVendas) And
            (Not FDatasetVendas.IsEmpty) And
            Assigned(ActiveControl) And
            ((ActiveControl = dbgVendas) Or dbgVendas.ContainsControl(ActiveControl));
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.pInverteMarcacao;
begin
  If (Not Assigned(FDatasetVendas)) Or FDatasetVendas.IsEmpty Then
    Exit;

  FDatasetVendas.Edit;
  FDatasetVendas.FieldByName('MARCADO').AsInteger := 1 - FDatasetVendas.FieldByName('MARCADO').AsInteger;
  FDatasetVendas.Post;

  pAtualizaBotoes;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.pMarcaTodas(AMarcar: Boolean);
  Var
    LRecNo,
    LIndice,
    LPosicao: Integer;
    LVisivel: TArray<Boolean>;
begin
  If (Not Assigned(FDatasetVendas)) Or FDatasetVendas.IsEmpty Then
    Exit;

  SetLength(LVisivel, FDatasetVendas.RecordCount);
  For LIndice := 0 To dbgVendasDados.DataController.FilteredRecordCount - 1 Do
    LVisivel[dbgVendasDados.DataController.FilteredRecordIndex[LIndice]] := True;

  LRecNo := FDatasetVendas.RecNo;
  FDatasetVendas.DisableControls;
  Try
    LPosicao := 0;
    FDatasetVendas.First;
    While Not FDatasetVendas.Eof Do
    Begin
      If LVisivel[LPosicao] Then
      Begin
        FDatasetVendas.Edit;
        FDatasetVendas.FieldByName('MARCADO').AsInteger := Ord(AMarcar);
        FDatasetVendas.Post;
      End;

      Inc(LPosicao);
      FDatasetVendas.Next;
    End;
  Finally
    FDatasetVendas.RecNo := LRecNo;
    FDatasetVendas.EnableControls;
  End;

  pAtualizaBotoes;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.pAtualizaBotoes;
  Var
    LRecNo: Integer;
begin
  FQtdMarcadas := 0;

  If Assigned(FDatasetVendas) And (Not FDatasetVendas.IsEmpty) Then
  Begin
    LRecNo := FDatasetVendas.RecNo;
    FDatasetVendas.DisableControls;
    Try
      FDatasetVendas.First;
      While Not FDatasetVendas.Eof Do
      Begin
        Inc(FQtdMarcadas, FDatasetVendas.FieldByName('MARCADO').AsInteger);
        FDatasetVendas.Next;
      End;
    Finally
      FDatasetVendas.RecNo := LRecNo;
      FDatasetVendas.EnableControls;
    End;
  End;

  btnConfirmar.Enabled := FQtdMarcadas > 0;
  btnDesmarcarTodas.Enabled := FQtdMarcadas > 0;
  btnMarcarTodas.Enabled := Assigned(FDatasetVendas) And (FQtdMarcadas < FDatasetVendas.RecordCount);
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  pMarcaTodas(True);
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  pMarcaTodas(False);
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.btnConfirmarClick(Sender: TObject);
  Var
    LRecNo: Integer;
begin
  inherited;
  If FQtdMarcadas = 0 Then
  Begin
    TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Nenhuma venda foi marcada.', ['&OK']);
    Exit;
  End;

  LRecNo := FDatasetVendas.RecNo;
  FDatasetVendas.DisableControls;
  Try
    FIncluiuVendas := TMercadoLivreInclusaoVendas.fIncluirVendas(FDatasetVendas);
  Finally
    FDatasetVendas.RecNo := LRecNo;
    FDatasetVendas.EnableControls;
  End;

  If FIncluiuVendas Then
    Self.Close;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.dbgVendasDadosMARCADOPropertiesEditValueChanged(
  Sender: TObject);
begin
  If (dbgVendasDados.DataController.LockCount > 0) Then
    Exit;

  dbgVendasDados.DataController.BeginUpdate;
  Try
    pInverteMarcacao;
  Finally
    dbgVendasDados.DataController.EndUpdate;
  End;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.dbgVendasDadosDblClick(Sender: TObject);
begin
  pInverteMarcacao;
  inherited;
end;

procedure TfrmMercadoLivreVendasNaoEncontradas.dbgVendasDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgVendasDadosMARCADO.Index] = 1 Then
    ACanvas.Font.Color := clBlue;
end;

end.
