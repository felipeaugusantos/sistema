unit AgrupamentoDeOndaDeSeparacao.Impressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Uni,
  Datasnap.Provider, UniDataSetProvider, Datasnap.DBClient, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, untCorGrid, System.UITypes,
  AgrupamentoDeOndaDeSeparacao.Funcoes;

type
  TfrmAgrupamentoDeOndaDeSeparacaoImpressao = class(TfrmPai)
    pnlRemessaDeSeparacao: TPanel;
    pnlRodape: TPanel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    dtsOndas: TDataSource;
    cdsOndas: TUniClientDataSet;
    cdsOndasMARDES: TStringField;
    dspOndas: TUniDataSetProvider;
    qryOndas: TUniQuery;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItensViewCODITE: TcxGridDBColumn;
    cxgItensViewDESCRI: TcxGridDBColumn;
    cxgItensViewQTDITE: TcxGridDBColumn;
    cxgItensViewLOCFIS: TcxGridDBColumn;
    cdsOndasCODITE: TStringField;
    cdsOndasDESCRI: TStringField;
    cdsOndasLOCFIS: TStringField;
    cdsOndasQTDITE: TFloatField;
    cxgItensViewMARDES: TcxGridDBColumn;
    cxgItensViewSTAIMP: TcxGridDBColumn;
    cdsOndasSTAIMP: TStringField;
    pnlLegendas: TPanel;
    lblItensJaImpressos: TLabel;
    shpItensJaImpressos: TShape;
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensViewDblClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);

  const
    SELECIONADO = 'M';
    DESMARCARDO = 'D';

  private

    FRemessaDeSeparacao : String;

    FCorDocSel      : TColor;
    FCorDocPosFonte : TColor;
    FCorDocPosFundo : TColor;
    FCorDocSelPos   : TColor;

    procedure CarregarCores;
    procedure Imprimir;

    procedure Marcar;
    procedure Desmarcar;
    procedure Selecionar;
    function TemSelecionado : Boolean;

    function RetornaSQL : String;

    procedure AtualizarRemessas;
    procedure AtualizarGrid;

    function RetornaItensSelecionados: TArrRecItensRemessaImp;

  public
    procedure SetRemessaDeSeparacao(ARemessaDeSeparacao : String);
  end;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

{ TfrmAgrupamentoDeOndaDeSeparacaoImpressao }

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.AtualizarGrid;
begin

  qryOndas.Close;
  qryOndas.SQL.Clear;
  qryOndas.SQL.Add(RetornaSQL);

  If qryOndas.FindParam('SEQOND') <> Nil Then
    qryOndas.ParamByName('SEQOND').AsString := FRemessaDeSeparacao;

  cdsOndas.Close;
  cdsOndas.SetProvider(dspOndas);

  qryOndas.Open;
  pSetaClient(qryOndas);
  cdsOndas.Open;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.AtualizarRemessas;
begin
  TFrmGravando.fExecutarModal(AtualizarGrid, 'Aguarde... Atualizando ondas!', '');
end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.btnDesmarcarTodosClick(Sender: TObject);
begin

  inherited;

  cdsOndas.DisableControls;

  Try

    cdsOndas.First;
    While Not cdsOndas.Eof Do
    Begin
      Desmarcar;
      cdsOndas.Next;
    End;

  Finally
    cdsOndas.EnableControls;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.btnImprimirClick(Sender: TObject);
begin

  inherited;

  If Not TemSelecionado Then
  Begin
    fMensagem('Atenção', 'É preciso selecionar o(s) item(ns) para realizar a impressão!', ['&Ok']);
    Exit;
  End;

  TFrmGravando.fExecutarModal(Imprimir, 'Aguarde... Realizando impressão!', '');

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.btnMarcarTodosClick(Sender: TObject);
begin

  inherited;

  cdsOndas.DisableControls;

  Try

    cdsOndas.First;
    While Not cdsOndas.Eof Do
    Begin
      Marcar;
      cdsOndas.Next;
    End;

  Finally
    cdsOndas.EnableControls;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.CarregarCores;
  var
    LCorGrid: TCorGrid;
begin

  Try

    LCorGrid := TCorGrid.Create('frmFatExpedicao', 'dbgPedidos');

    //FONTE - Documento posicionado fonte
    FCorDocPosFonte := LCorGrid.CarregarCor('DocPosFonte');

    //FONTE - Documento posicionado e selecionado
    FCorDocSelPos := LCorGrid.CarregarCor('DocSelPos');

    //FUNDO - Documento selecionado
    FCorDocSel := LCorGrid.CarregarCor('DocSel');

    //FUNDO - Documento posicionado fundo
    FCorDocPosFundo := LCorGrid.CarregarCor('DocPosFundo');

  Finally
    FreeAndNil(LCorGrid);
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    LLinhaPosicionada : Boolean;
begin

  inherited;

  LLinhaPosicionada := AViewInfo.Selected;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewMARDES.Index]) = SELECIONADO Then
  Begin
    If LLinhaPosicionada Then
    Begin
      ACanvas.Font.Color  := FCorDocPosFonte;
      ACanvas.Brush.Color := FCorDocPosFundo;
    End
    Else
    ACanvas.Brush.Color := FCorDocSel;
  End

  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewSTAIMP.Index]) = 'S' Then
  Begin
    If LLinhaPosicionada Then
    Begin
      ACanvas.Font.Color  := FCorDocPosFonte;
      ACanvas.Brush.Color := FCorDocPosFundo;
    End
    Else
      ACanvas.Brush.Color := shpItensJaImpressos.Brush.Color;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.cxgItensViewDblClick(
  Sender: TObject);
begin
  inherited;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  Selecionar;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.cxgItensViewKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) Or (Key = #32) Then
    Selecionar;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.Desmarcar;
begin
  cdsOndas.Edit;
  cdsOndasMARDES.AsString := DESMARCARDO;
  cdsOndas.Post;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  CarregarCores();
  cxgItensView.OnKeyDown := pOnKeyDown;
  FRemessaDeSeparacao := '';
end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.FormShow(Sender: TObject);
begin
  inherited;
  AtualizarRemessas;
  pnlRemessaDeSeparacao.Caption := 'Remessa de Separação - ' + FRemessaDeSeparacao;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.Imprimir;
  var
    LItens: TArrRecItensRemessaImp;
begin
  inherited;

  LItens := RetornaItensSelecionados;

  Try
    AgrupamentoDeOndaDeSeparacao.Funcoes.RealizarImpressao(FRemessaDeSeparacao, True, Self.Name, LItens);
  Finally
    AtualizarRemessas;
  End;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.Marcar;
begin
  cdsOndas.Edit;
  cdsOndasMARDES.AsString := SELECIONADO;
  cdsOndas.Post;
end;

function TfrmAgrupamentoDeOndaDeSeparacaoImpressao.RetornaItensSelecionados: TArrRecItensRemessaImp;
begin
  SetLength(Result, 0);

  If cdsOndas.IsEmpty Then
    Exit;

  cdsOndas.DisableControls;

  Try

    cdsOndas.First;
    While Not cdsOndas.Eof Do
    Begin

      If cdsOndasMARDES.AsString.Equals(SELECIONADO) Then
      begin
        SetLength(Result, Length(Result) + 1);
        Result[Pred(Length(Result))].strCodIte := cdsOndasCODITE.AsString.QuotedString;
        Result[Pred(Length(Result))].strLocFis := cdsOndasLOCFIS.AsString;
      end;

      cdsOndas.Next;

    End;

  Finally
    cdsOndas.EnableControls;
  End;

end;

function TfrmAgrupamentoDeOndaDeSeparacaoImpressao.RetornaSQL: String;
  const
    SQL = 'SELECT                         ' +
          '  D.FDO_CODITE      AS CODITE, ' +
          '  D.FDO_DESCRI      AS DESCRI, ' +
          '  SUM(L.LDO_QTDITE) AS QTDITE, ' +
          '  C.LOT_LOCFIS      AS LOCFIS, ' +
          '  "D" AS MARDES,               ' +
          '  IF((SELECT COUNT(*) FROM ONDIMP I     ' +
          '      WHERE I.OND_SEQOND = E.FGO_SEQOND ' +
          '        AND I.OND_CODITE = D.FDO_CODITE ' +
          '        AND I.OND_LOCFIS = C.LOT_LOCFIS) > 0, "S", "N") AS STAIMP ' +
          'FROM       ' +
          '  FATGOR F ' +
          '  INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ' +
          '  INNER JOIN FATDOR D ON (D.FDO_SEQGER = F.AUTOINCREM) ' +
          '  INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = D.AUTOINCREM) ' +
          '  INNER JOIN CADLOT C ON (C.LOT_NUMLOT = L.LDO_NUMLOT AND ' +
          '                          C.LOT_CODEMP = E.FGO_EMPEXP AND ' +
          '                          C.LOT_CODITE = D.FDO_CODITE)    ' +
          'WHERE                    ' +
          '  E.FGO_SEQOND = :SEQOND ' +
          'GROUP BY                 ' +
          '  D.FDO_CODITE, C.LOT_LOCFIS ' +
          'ORDER BY                     ' +
          '  D.FDO_DESCRI ';
begin
  Result := SQL;
end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.Selecionar;
begin

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  If (cdsOndasMARDES.AsString = SELECIONADO) Then
    Desmarcar
  Else
    Marcar;

  pSetFocus(cxgItens);

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressao.SetRemessaDeSeparacao(ARemessaDeSeparacao: String);
begin
  FRemessaDeSeparacao := ARemessaDeSeparacao;
end;

function TfrmAgrupamentoDeOndaDeSeparacaoImpressao.TemSelecionado: Boolean;
  var
    LClone: TUniClientDataSet;
begin

  Result := False;

  If Not cdsOndas.Active Then
    Exit;

  If cdsOndas.IsEmpty Then
    Exit;

  LClone := TUniClientDataSet.Create(Nil);

  Try

    pCloneDataSet(LClone, cdsOndas);

    LClone.Filtered := False;
    LClone.Filter   := 'MARDES = ' + QuotedStr(SELECIONADO);
    LClone.Filtered := True;

    Result := (LClone.RecordCount > 0);

  Finally
    FreeAndNil(LClone);
  End;

end;

end.
