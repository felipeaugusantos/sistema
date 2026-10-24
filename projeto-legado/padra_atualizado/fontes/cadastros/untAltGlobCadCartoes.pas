unit untAltGlobCadCartoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, cxTextEdit,
  Datasnap.DBClient, UniClientDataSet,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, MemDS, DBAccess, Uni,
  cxContainer, cxProgressBar, untClassesAltGlobCadCartoes, cxPropertiesStore,
  cxRadioGroup;

type
  TfrmAltGlobCadCartoes = class(TfrmPai)
    dsCartoes: TDataSource;
    pnFiltro: TPanel;
    GridCartoesLevel: TcxGridLevel;
    GridCartoes: TcxGridCitel;
    GridTabCartoes: TcxGridDBBandedTableView;
    GridTabCartoesCAR_CODCAR: TcxGridDBBandedColumn;
    GridTabCartoesCAR_DESCAR: TcxGridDBBandedColumn;
    GridTabCartoesCAR_CODEMP: TcxGridDBBandedColumn;
    GridTabCartoesEMP_NOMFAN: TcxGridDBBandedColumn;
    GridTabCartoesCAR_TFTRED: TcxGridDBBandedColumn;
    GridTabCartoesCAR_TFTBAN: TcxGridDBBandedColumn;
    GridTabCartoesCAR_TFRED2: TcxGridDBBandedColumn;
    GridTabCartoesCAR_TFBAN2: TcxGridDBBandedColumn;
    GridPopupMenu: TcxGridPopupMenu;
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnLimpaFiltros: TBitBtnLocked;
    btnConfirmaAlt: TBitBtnLocked;
    btnSair2: TBitBtnLocked;
    GuardaConfColGridAltGlobCadCartoes: TcxPropertiesStore;
    GridTabCartoesCAR_STATUS: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnLimpaFiltrosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FcdsCartoes: TUniClientDataSet ;
    procedure pMarcaDesmarca(const AblnMarcar: Boolean);
    function fGravaDados(cxProgresso: TcxProgressBar): Boolean;
    function fTemLinhasSelecionadas: Boolean;
    procedure pAjustaDataSource(AcdsDados: TUniClientDataSet) ;
    procedure pCarregaListaAutoIncs(var AlstAutoIncs: TListaAutoIncremCadCar) ;
  public
    { Public declarations }
  end;

implementation

uses
  untAltGlobCadCartoesAlt, untFuncoesSimples;

{$R *.dfm}

procedure TfrmAltGlobCadCartoes.btnConfirmaAltClick(Sender: TObject);
var
  LblnRetorno: Boolean ;
begin
  inherited;

  if not fTemLinhasSelecionadas then
  begin
    fMensagem('','Nenhuma linha selecionada!',['&OK']);
    pSetFocus(GridCartoes);
    Exit ;
  end ;

  If fMensagem('','Confirma alteração de dados?',['&Sim','&Não']) = 1 Then
  begin
    LblnRetorno := fChamaTelaGravando(fGravaDados, 'Gravando dados, aguarde...') ;
    if LblnRetorno then
    begin
      fMensagem('','Dados atualizados!',['&OK']);
      pSetFocus(GridCartoes);
    end ;
  end
  else
    pSetFocus(GridCartoes);

end;

procedure TfrmAltGlobCadCartoes.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca(False);
  pSetFocus(GridCartoes) ;
end;

procedure TfrmAltGlobCadCartoes.btnLimpaFiltrosClick(Sender: TObject);
begin
  inherited;
  GridTabCartoes.DataController.Filter.Clear ;
  GridTabCartoes.Controller.ApplyFindFilterText('');
end;

procedure TfrmAltGlobCadCartoes.btnMarcarClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca(True);
  pSetFocus(GridCartoes) ;
end;

function TfrmAltGlobCadCartoes.fGravaDados(
  cxProgresso: TcxProgressBar): Boolean;
var
  LfrmAltGlobCadCartoesAlt: TfrmAltGlobCadCartoesAlt ;
  LrecCartao: TDadosAtualizarCartao ;
  LlstAutoIncs: TListaAutoIncremCadCar ;
  LarrAtualizar: TArrayDadosAtualizarCartao ;
begin
  pCriarFormularios(TfrmAltGlobCadCartoesAlt, LfrmAltGlobCadCartoesAlt) ;
  LlstAutoIncs := TListaAutoIncremCadCar.Create ;
  try
    LfrmAltGlobCadCartoesAlt.ShowModal ;
    Result := LfrmAltGlobCadCartoesAlt.Confirma ;
    if Result then
    begin
      FillChar(LrecCartao, SizeOf(LrecCartao), #0);
      LrecCartao.CAR_TFTRED := LfrmAltGlobCadCartoesAlt.CAR_TFTRED ;
      LrecCartao.CAR_TFTBAN := LfrmAltGlobCadCartoesAlt.CAR_TFTBAN ;
      LrecCartao.CAR_STATUS := LfrmAltGlobCadCartoesAlt.CAR_STATUS ;
      LrecCartao.CAR_TFRED2 := LfrmAltGlobCadCartoesAlt.CAR_TFRED2 ;
      LrecCartao.CAR_TFBAN2 := LfrmAltGlobCadCartoesAlt.CAR_TFBAN2 ;
      LarrAtualizar[dacsClisitef] := LfrmAltGlobCadCartoesAlt.ClisiTefSelecionado ;
      LarrAtualizar[dacsNcr] := LfrmAltGlobCadCartoesAlt.NcrSelecionado ;
      pCarregaListaAutoIncs(LlstAutoIncs) ;
      Result := TDadosAlteracaoGlobalCartoes.fAtualizarDados(LrecCartao, LlstAutoIncs, LarrAtualizar) ;
      if Result then
      begin
        pAjustaDataSource(Nil) ;
        try
          Result := TDadosAlteracaoGlobalCartoes.fCarregarDados(FcdsCartoes) ;
        finally
          pAjustaDataSource(FcdsCartoes) ;
        end ;
      end ;
    end ;
  finally
    pFreeAndNil(LfrmAltGlobCadCartoesAlt) ;
    FreeAndNil(LlstAutoIncs) ;
  end;
end;

procedure TfrmAltGlobCadCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  try
    GuardaConfColGridAltGlobCadCartoes.StoreTo ;
  except
    on E: Exception do
    begin
      pGravarErro(True, e.Message, Self.Caption);
    end ;
  end ;

end;

procedure TfrmAltGlobCadCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  FcdsCartoes := Nil ;

  if TDadosAlteracaoGlobalCartoes.fCarregarDados(FcdsCartoes) then
    pAjustaDataSource(FcdsCartoes) ;

  try
    GuardaConfColGridAltGlobCadCartoes.RestoreFrom ;
  except
    on E: Exception do
    begin
      pGravarErro(True, e.Message, Self.Caption);
    end ;
  end ;

end;

procedure TfrmAltGlobCadCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) And (Assigned(ActiveControl)) And (ActiveControl.Name = '') Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  Case Key Of
    VK_F2 : btnMarcar.Click;
    VK_F3 : btnDesmarcar.Click;
    VK_F8 : btnLimpaFiltros.Click;
    VK_F10: btnConfirmaAlt.Click;
  End;
end;

procedure TfrmAltGlobCadCartoes.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(GridCartoes) ;
end;

function TfrmAltGlobCadCartoes.fTemLinhasSelecionadas: Boolean;
begin
  Result := GridTabCartoes.Controller.SelectedRecordCount > 0 ;
end;

procedure TfrmAltGlobCadCartoes.pAjustaDataSource(
  AcdsDados: TUniClientDataSet);
begin
  dsCartoes.Enabled := False ;
  dsCartoes.DataSet := AcdsDados ;
  dsCartoes.Enabled := True ;
end;

procedure TfrmAltGlobCadCartoes.pCarregaListaAutoIncs(
  var AlstAutoIncs: TListaAutoIncremCadCar);
var
  LintCnt: Integer ;
  LintRecIdx, LintColIdx: Integer;
  LvarOutputVal: Variant;
begin
  AlstAutoIncs.Clear ;
  for LintCnt := 0 to GridTabCartoes.Controller.SelectedRecordCount-1 do
  begin
    LintRecIdx := GridTabCartoes.Controller.SelectedRecords[LintCnt].RecordIndex;
    LintColIdx := GridTabCartoes.DataController.GetItemByFieldName('CAR_CODCAR').Index;
    LvarOutputVal := GridTabCartoes.DataController.Values[LintRecIdx, LintColIdx];
    VarCast(LvarOutputVal, LvarOutputVal, varString);
    AlstAutoIncs.Add(LvarOutputVal) ;
  end ;
end;

procedure TfrmAltGlobCadCartoes.pMarcaDesmarca(const AblnMarcar: Boolean);
begin
  if AblnMarcar then
    GridTabCartoes.Controller.SelectAll
  else
    GridTabCartoes.Controller.ClearSelection ;
end;

end.
