unit untManutencaoEquipamentoInternoLiberacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untZClient,
  cxProgressBar, untTypesSistema, untEditorFastImpressao, TypesRel;

type
  TfrmManutencaoEquipamentoInternoLiberacao = class(TfrmPai)
    cxgvLista: TcxGridDBTableViewCitel;
    cxgListaLevel1: TcxGridLevel;
    cxgLista: TcxGridCitel;
    cxgvListaCodSolicitacao: TcxGridDBColumn;
    cxgvListaDataSolicitacao: TcxGridDBColumn;
    cxgvListaOperador: TcxGridDBColumn;
    cxgvListaDepartamento: TcxGridDBColumn;
    cxgvListaPrioridade: TcxGridDBColumn;
    cxgvListaStatus: TcxGridDBColumn;
    btnLiberar: TBitBtnLocked;
    btnReprovar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    cxgvListaMARDES: TcxGridDBColumn;
    pnlLegenda: TPanel;
    lblLegendaPrioridadeBaixa: TLabel;
    shpLegendaPrioridadeBaixa: TShape;
    lblLegendaPrioridadeMedia: TLabel;
    shpLegendaPrioridadeMedia: TShape;
    lblLegendaPrioridadeAlta: TLabel;
    shpLegendaPrioridadeAlta: TShape;
    lblLegendaPrioridade: TLabel;
    cxgvListaMEI_DESMAN: TcxGridDBColumn;
    btnImprimr: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnLiberarClick(Sender: TObject);
    procedure btnReprovarClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgvListaCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimrClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    cdsLista: TZClient;
    dtsLista: TDataSource;

    procedure pCriarCdsLista;
    function fLiberar(pgbProgresso: TcxProgressBar): Boolean;
    function fRejeitar(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMarcarTodos(blnMarcar: Boolean);
    procedure pImprimir(strCodLay, strCodSol: String);
  public
    { Public declarations }
  end;

var
  frmManutencaoEquipamentoInternoLiberacao: TfrmManutencaoEquipamentoInternoLiberacao;

implementation

{$R *.dfm}

Uses
  untManutencaoEquipamentoInterno, untGravando, untFuncoesSimples;

procedure TfrmManutencaoEquipamentoInternoLiberacao.pImprimir(strCodLay, strCodSol: String);
Var
  objImpressao: TEditorFastImpressao;
Begin
  objImpressao := TEditorFastImpressao.Create(Nil);
  try
    objImpressao.recDocume.strCodLay := strCodLay;
    objImpressao.recDocume.strNumDoc := strCodSol;
    objImpressao.recDocume.strCodEmp := VS_strCodEmp;
    objImpressao.recDocume.strEspDoc := 'SME';
    objImpressao.tpeTipoEtiqueta     := tpeSolicitacaoManutencaoEquipamentos;
    objImpressao.recDocume.intQtdImp := 1;
    objImpressao.recDocume.blnVisPdf := True;
    objImpressao.recDocume.strSaida  := 'P';
    objImpressao.fImprimeDocumento(tpaNormal, '', '');
  Finally
    FreeAndNil(objImpressao);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.btnImprimrClick(
  Sender: TObject);
Var
  strCodLay: String;
Begin
  strCodLay := fCampoTabela('LAY_CODLAY','LAYETI',['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'],[ARR_TIPO_LAYOUT[tpeSolicitacaoManutencaoEquipamentos], 'S', VS_strCodEmp]);
  if Not fEmptyStr(strCodLay) Then
    pImprimir(strCodLay, cdsLista.FieldByName('MEI_CODIGO').AsString)
  Else
    fMensagem('ATENÇÃO', 'Não existe layout disponível para continuar!', ['&O k']);
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.btnLiberarClick(
  Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'Liberando Solicitações';
    frmGravando.fExecutarAcao := fLiberar;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.btnMarcarClick(
  Sender: TObject);
begin
  inherited;
  cdsLista.Edit;
  cdsLista.FieldbyName('MARDES').AsString := IIF(cdsLista.FieldbyName('MARDES').AsString = 'M', 'D', 'M');
  cdsLista.Post;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.btnMarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcarTodos(btnMarcarTodos.Tag = 0);
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.btnReprovarClick(
  Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'Negando Solicitações';
    frmGravando.fExecutarAcao := fRejeitar;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.cxgvListaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaPrioridade.Index] = 'Baixa') Then
  Begin
    ACanvas.Brush.Color := clWebLightGreen;
    ACanvas.Font.Color := clWindowText;
  End
  Else
  Begin
    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaPrioridade.Index] = 'Média') Then
    Begin
      ACanvas.Brush.Color := clWebGreenYellow;
      ACanvas.Font.Color := clWindowText;
    End
    Else
    Begin
      If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaPrioridade.Index] = 'Alta') Then
      Begin
        ACanvas.Brush.Color := clWebLightSalmon;
        ACanvas.Font.Color := clWindowText;
      End;
    End;
  End;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaMARDES.Index] = 'M') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clWindowText;
  End;
end;

function TfrmManutencaoEquipamentoInternoLiberacao.fLiberar(
  pgbProgresso: TcxProgressBar): Boolean;
var
  blnGravouDados: Boolean;
begin
  Result := False;

  cdsLista.DisableControls;
  Try
    cdsLista.Filtered := False;
    cdsLista.Filter   := 'MARDES = ' + QuotedStr('M');
    cdsLista.Filtered := True;

    If cdsLista.IsEmpty Then
    begin
      pMensagemOk('Nenhuma solicitação marcada para liberação!');
      Exit;
    end;

    If fMensagem('','Tem certeza que deseja liberar as solicitações marcadas?',  ['&Sim', '&Não']) = 1 Then
    Begin
      blnGravouDados := True;
      fStartTransaction;

      While (Not cdsLista.Eof) Do
      Begin
        if not TManutencaoEquipamentoInterno.fAtualizarStatus(cdsLista.FieldByName('AUTOINCREM').AsString, tsAprovada) then
        begin
          blnGravouDados := False;
          Break;
        end;

        cdsLista.Next;
      End;

      if blnGravouDados then
      begin
        fCommit;
        pMensagemOk('Solicitações liberadas com sucesso!');
        TManutencaoEquipamentoInterno.pCarregaListaSolicitacoes(tsAberto, cdsLista);
        pMarcarTodos(False);
      end
      else
      begin
        fRollBack;
        pMensagemOk('Erro ao liberar solicitações!');
      end;
    End;
  Finally
    cdsLista.Filtered := False;
    cdsLista.Filter := '';
    cdsLista.EnableControls;
  End;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarCdsLista;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.FormDestroy(
  Sender: TObject);
begin
  inherited;

  FreeAndNil(dtsLista);
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnMarcar.Click;
    VK_F5    : btnMarcarTodos.Click;
  End;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.FormShow(Sender: TObject);
begin
  inherited;

  TManutencaoEquipamentoInterno.pCarregaListaSolicitacoes(tsAberto, cdsLista);
end;

function TfrmManutencaoEquipamentoInternoLiberacao.fRejeitar(
  pgbProgresso: TcxProgressBar): Boolean;
var
  blnGravouDados: Boolean;
begin
  Result := False;

  cdsLista.DisableControls;
  Try
    cdsLista.Filtered := False;
    cdsLista.Filter   := 'MARDES = ' + QuotedStr('M');
    cdsLista.Filtered := True;

    If cdsLista.IsEmpty Then
    begin
      pMensagemOk('Nenhuma solicitação marcada para rejeição!');
      Exit;
    end;

    If fMensagem('','Tem certeza que deseja rejeitar as solicitações marcadas?',  ['&Sim', '&Não']) = 1 Then
    Begin
      blnGravouDados := True;
      fStartTransaction;

      While (Not cdsLista.Eof) Do
      Begin
        if not TManutencaoEquipamentoInterno.fAtualizarStatus(cdsLista.FieldByName('AUTOINCREM').AsString, tsNegada) then
        begin
          blnGravouDados := False;
          Break;
        end;

        cdsLista.Next;
      End;

      if blnGravouDados then
      begin
        fCommit;
        pMensagemOk('Solicitações negadas com sucesso!');
        TManutencaoEquipamentoInterno.pCarregaListaSolicitacoes(tsAberto, cdsLista);
        pMarcarTodos(False);
      end
      else
      begin
        fRollBack;
        pMensagemOk('Erro ao negar solicitações!');
      end;
    End;
  Finally
    cdsLista.Filtered := False;
    cdsLista.Filter := '';
    cdsLista.EnableControls;
  End;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.pCriarCdsLista;
begin
  if Assigned(cdsLista) then
    FreeAndNil(cdsLista);

  cdsLista := TZClient.Create(Self);
  cdsLista.Close;
  cdsLista.FieldDefs.Clear;
  cdsLista.FieldDefs.Add('AUTOINCREM', ftString, 20);
  cdsLista.FieldDefs.Add('MEI_CODIGO', ftString, 10);
  cdsLista.FieldDefs.Add('MEI_DTACAD', ftString, 255);
  cdsLista.FieldDefs.Add('MEI_OPECAD', ftString, 255);
  cdsLista.FieldDefs.Add('MEI_DEPART', ftString, 20);
  cdsLista.FieldDefs.Add('MEI_PRIORI', ftString, 10);
  cdsLista.FieldDefs.Add('MEI_STATUS', ftString, 255);
  cdsLista.FieldDefs.Add('MEI_DESMAN', ftString, 800);
  cdsLista.FieldDefs.Add('MEI_TIPVIN', ftInteger);
  cdsLista.FieldDefs.Add('MEI_NUMDOC', ftString, 20);
  cdsLista.FieldDefs.Add('MARDES', ftString, 1);
  cdsLista.CreateDataSet;
  cdsLista.Open;
  cdsLista.EmptyDataSet;

  dtsLista := TDataSource.Create(nil);
  dtsLista.DataSet := cdsLista;

  cxgvLista.DataController.DataSource := dtsLista;
end;

procedure TfrmManutencaoEquipamentoInternoLiberacao.pMarcarTodos(
  blnMarcar: Boolean);
begin
  if cdsLista.IsEmpty then
    Exit;

  cdsLista.DisableControls;

  try
    cdsLista.First;

    while not cdsLista.Eof do
    begin
      cdsLista.Edit;
      cdsLista.FieldbyName('MARDES').AsString := IIF(blnMarcar, 'M', 'S');
      cdsLista.Post;

      cdsLista.Next;
    end;

    btnMarcarTodos.Tag := IIF(blnMarcar, 1, 0);
  finally
    cdsLista.EnableControls;
  end;
end;

end.
