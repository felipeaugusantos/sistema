unit Contabilidade.View.ApuracaoLucroRealLalurLacsAjustes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  Contabilidade.Interfaces, MemDS, DBAccess, Uni, Datasnap.DBClient,
  UniClientDataSet, cxCalc, cxRadioGroup, cxContainer, cxGroupBox, cxButtons,
  cxProgressBar, cxTextEdit, cxLabel, dxBarBuiltInMenu, cxGridCustomPopupMenu,
  cxGridPopupMenu;

type
  TfrmApuracaoLucroRealLalurLacsAjustes = class(TfrmPaiConfirmaContabilidade)
    dsAjustes: TDataSource;
    GridAjustesTableView: TcxGridDBTableViewCitel;
    GridAjustesLevel1: TcxGridLevel;
    GridAjustes: TcxGridCitel;
    GridAjustesTableViewARE_TIPLAN: TcxGridDBColumn;
    GridAjustesTableViewARE_NATAJU: TcxGridDBColumn;
    GridAjustesTableViewNAT_DESCRI: TcxGridDBColumn;
    GridAjustesTableViewARE_DTALAN: TcxGridDBColumn;
    GridAjustesTableViewARE_CODCON: TcxGridDBColumn;
    GridAjustesTableViewNCO_DESCRI: TcxGridDBColumn;
    GridAjustesTableViewARE_VALLAN: TcxGridDBColumn;
    GridAjustesTableViewARE_EMPLAN: TcxGridDBColumn;
    GridAjustesTableViewEMP_NOMEMP: TcxGridDBColumn;
    GridAjustesTableViewARE_LANCON: TcxGridDBColumn;
    GridAjustesTableViewHISTORICO: TcxGridDBColumn;
    GridAjustesTableViewAUTOINCREM: TcxGridDBColumn;
    GridAjustesTableViewARE_HISPAD: TcxGridDBColumn;
    GridAjustesTableViewPAD_DESCRI: TcxGridDBColumn;
    GridAjustesTableViewARE_HISTOR: TcxGridDBColumn;
    StyleRepository: TcxStyleRepository;
    EstiloManual: TcxStyle;
    btnIncluir: TcxButton;
    btnEditar: TcxButton;
    btnExcluir: TcxButton;
    btnGerar: TcxButton;
    pnlLegenda: TPanel;
    edtLegendaManual: TcxTextEdit;
    cxLabel1: TcxLabel;
    GridPopupMenu: TcxGridPopupMenu;
    GridAjustesTableViewARE_CREDEB: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure GridAjustesTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FStrCodigoApuracaoLalur: string ;
    FStrCodigoApuracaoLacs: string ;
    FllTipo: TLacsLalur ;
    FQryAjustes: TUniQuery ;
    FdtaVigenciaInicial: TDateTime ;
    FdtaVigenciaFinal: TDateTime ;
    FecEncerramento: TEncerramentoContabil ;
    FstrCodEmp: String ;
    function fIncluirAlterarAjuste(const ABlnIncluir: boolean):boolean ;
    function fConfirmarGerarAjustes(APgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(APgbProgresso: TcxProgressBar; strTexto: String);
    function fIsAssignedProgresso(APgbProgresso: TcxProgressBar): boolean;
  public
    { Public declarations }
    property CodigoApuracaoLalur: string read FStrCodigoApuracaoLalur write FStrCodigoApuracaoLalur ;
    property CodigoApuracaoLacs: string read FStrCodigoApuracaoLacs write FStrCodigoApuracaoLacs ;
    property Tipo: TLacsLalur read FllTipo write FllTipo ;
    property VigenciaInicial: TDateTime read FdtaVigenciaInicial write FdtaVigenciaInicial ;
    property VigenciaFinal: TDateTime read FdtaVigenciaFinal write FdtaVigenciaFinal ;
    property EncerramentoContabil: TEncerramentoContabil read FecEncerramento write FecEncerramento ;
    property CodEmp: String read FstrCodEmp write FstrCodEmp;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples ,
  Contabilidade.View.ApuracaoLucroRealLalurLacsAjustesAlterar,
  Contabilidade.Classes.ApuracaoLucroRealLalurLacs, Contabilidade.Funcoes, strUtils ;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.btnEditarClick(Sender: TObject);
var
  LStrAutoInc: string ;
  LStrCodigoApuracao: string ;
begin
  inherited;
  if not fValidaRegistroSelecionadoAjustes(FQryAjustes) then
  begin
    exit ;
  end;

  if not fPodeAlterar(FQryAjustes) then
  begin
    exit ;
  end;
    
  if fIncluirAlterarAjuste(False) then
  begin
    LStrAutoInc := GridAjustesTableViewAUTOINCREM.DataBinding.Field.AsString ;
    LStrCodigoApuracao := iif(FllTipo = llLalur, FStrCodigoApuracaoLalur, FStrCodigoApuracaoLacs) ;
    pCarregaDadosAjustes(FQryAjustes, LStrCodigoApuracao, FdtaVigenciaInicial, FdtaVigenciaFinal, FllTipo, FecEncerramento, FstrCodEmp) ;
    FQryAjustes.Locate('AUTOINCREM', LStrAutoInc, [loCaseInsensitive]) ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.btnExcluirClick(
  Sender: TObject);
var
  LStrCodigoApuracao: string ;
begin
  inherited;
  if not fValidaRegistroSelecionadoAjustes(FQryAjustes) then
  begin
    exit ;
  end;

  if fMensagem('ATENÇÃO!','Confirma a exclusão? ', ['&Sim', '&Não'], 2) = 2 then
  begin
    Exit;
  end;

  if fExcluiApuracaoAjustes(FQryAjustes.FieldByName('AUTOINCREM').AsString) then
  begin
    LStrCodigoApuracao := iif(FllTipo = llLalur, FStrCodigoApuracaoLalur, FStrCodigoApuracaoLacs) ;
    pCarregaDadosAjustes(FQryAjustes, LStrCodigoApuracao, FdtaVigenciaInicial, FdtaVigenciaFinal, FllTipo, FecEncerramento, FstrCodEmp) ;
    pSetFocus(GridAjustes) ;
  end;
  
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.btnGerarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!','Gerar Ajustes dos Lançamentos Contábeis? ', ['&Sim', '&Não'], 2) = 2 then
  begin
    Exit;
  end;

  Try
    fChamaTelaGravando(fConfirmarGerarAjustes) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
    
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.btnIncluirClick(
  Sender: TObject);
var
  LStrCodigoApuracao: string ;
begin
  inherited;
  if fIncluirAlterarAjuste(True) then
  begin
    LStrCodigoApuracao := iif(FllTipo = llLalur, FStrCodigoApuracaoLalur, FStrCodigoApuracaoLacs) ;
    pCarregaDadosAjustes(FQryAjustes, LStrCodigoApuracao, FdtaVigenciaInicial, FdtaVigenciaFinal, FllTipo, FecEncerramento, FstrCodEmp) ;
  end;
end;

function TfrmApuracaoLucroRealLalurLacsAjustes.fIncluirAlterarAjuste(const ABlnIncluir: boolean): boolean;
var
  LfrmApuracaoLucroRealLalurLacsAjustesAlterar: TfrmApuracaoLucroRealLalurLacsAjustesAlterar ;
  LRegDados: TDadosAPUARE ;
  LStrCodigoApuracao: string ;
begin
  Result := False ;
  LStrCodigoApuracao := iif(FllTipo = llLalur, FStrCodigoApuracaoLalur, FStrCodigoApuracaoLacs) ;
  pCriarFormularios(TfrmApuracaoLucroRealLalurLacsAjustesAlterar, LfrmApuracaoLucroRealLalurLacsAjustesAlterar) ;
  try
    LfrmApuracaoLucroRealLalurLacsAjustesAlterar.CodEmp := FstrCodEmp ;
    LfrmApuracaoLucroRealLalurLacsAjustesAlterar.VigenciaInicial := FdtaVigenciaInicial ;
    LfrmApuracaoLucroRealLalurLacsAjustesAlterar.VigenciaFinal := FdtaVigenciaFinal ;
    LfrmApuracaoLucroRealLalurLacsAjustesAlterar.CodigoApuracao := LStrCodigoApuracao ;
    LfrmApuracaoLucroRealLalurLacsAjustesAlterar.Tipo := FllTipo ;
    if ABlnIncluir then
    begin
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.AutoIncAjuste := '' ;
    end
    else
    begin
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.AutoIncAjuste := GridAjustesTableViewAUTOINCREM.DataBinding.Field.AsString ;
      ///carrega as informações para alteração
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_DTALAN.Date := GridAjustesTableViewARE_DTALAN.DataBinding.Field.AsDateTime ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_HISPAD.Text := GridAjustesTableViewARE_HISPAD.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtDesPad.Text := GridAjustesTableViewPAD_DESCRI.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_HISTOR.Text := GridAjustesTableViewARE_HISTOR.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_CODCON.Text := GridAjustesTableViewARE_CODCON.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtDesCon.Text := GridAjustesTableViewNCO_DESCRI.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_VALLAN.Value := GridAjustesTableViewARE_VALLAN.DataBinding.Field.AsFloat ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_NATAJU.Text := GridAjustesTableViewARE_NATAJU.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtDesAju.Text := GridAjustesTableViewNAT_DESCRI.DataBinding.Field.AsString ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.rgARE_TIPLAN.ItemIndex := iif(GridAjustesTableViewARE_TIPLAN.DataBinding.Field.AsString = 'A', 0, 1) ;
      LfrmApuracaoLucroRealLalurLacsAjustesAlterar.rgARE_CREDEB.ItemIndex := iif(GridAjustesTableViewARE_CREDEB.DataBinding.Field.AsString = 'D', 0, 1) ;
      ///
    end;
    if LfrmApuracaoLucroRealLalurLacsAjustesAlterar.ShowModal = mrOK then
    begin
      LRegDados.strAUTOINCREM := LfrmApuracaoLucroRealLalurLacsAjustesAlterar.AutoIncAjuste ;
      LRegDados.strARE_CODVRE := LStrCodigoApuracao ;
      LRegDados.dtaARE_DTALAN := LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_DTALAN.Date ;
      LRegDados.intARE_HISPAD := strtointDef(LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_HISPAD.Text,0) ;
      LRegDados.strARE_HISTOR := LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_HISTOR.Text ;
      LRegDados.strARE_EMPLAN := FstrCodEmp ;
      LRegDados.fltARE_VALLAN := LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_VALLAN.Value ;
      LRegDados.strARE_CODCON := fSemMascaraPlaNco(LfrmApuracaoLucroRealLalurLacsAjustesAlterar.edtARE_CODCON.Text) ;
      LRegDados.strARE_TPLACO := fRetTplacoEmpresaLogada(FstrCodEmp) ;
      LRegDados.strARE_CREDEB := ifthen(LfrmApuracaoLucroRealLalurLacsAjustesAlterar.rgARE_CREDEB.ItemIndex = 0, 'D', 'C') ;
      ////processo de incluir ou altera dados
      Result := fPersisteApuracaoAjustes(LRegDados) ;
    end;
  finally
    pFreeAndNil(LfrmApuracaoLucroRealLalurLacsAjustesAlterar);
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.FormCreate(Sender: TObject);
begin
  inherited;
  FQryAjustes := fCriaQuery() ;
  edtLegendaManual.StyleDisabled.Color := EstiloManual.Color ;
  edtLegendaManual.StyleDisabled.BorderColor := EstiloManual.Color ;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FQryAjustes) then
  begin
    FreeAndNil(FQryAjustes) ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.FormShow(Sender: TObject);
var
  LStrCodigoApuracao: string ;
begin
  inherited;
  dsAjustes.Enabled := False ;
  try
    LStrCodigoApuracao := iif(FllTipo = llLalur, FStrCodigoApuracaoLalur, FStrCodigoApuracaoLacs) ;
    pCarregaDadosAjustes(FQryAjustes, LStrCodigoApuracao, FdtaVigenciaInicial, FdtaVigenciaFinal, FllTipo, FecEncerramento, FstrCodEmp) ;
    dsAjustes.DataSet := FQryAjustes ;
  finally
    dsAjustes.Enabled := True ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.GridAjustesTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      ARowInfo := GridAjustesTableView.DataController.GetRowInfo(ARecord.Index);
      If fEmptyStr(VarToStr(GridAjustesTableView.DataController.Values[ARowInfo.RecordIndex,
                  GridAjustesTableView.GetColumnByFieldName('ARE_LANCON').Index])) Then
      Begin
        AStyle := EstiloManual;
      End;
    end;
  end;
end;

function TfrmApuracaoLucroRealLalurLacsAjustes.fConfirmarGerarAjustes(
  APgbProgresso: TcxProgressBar): Boolean;
var
  LStrCodigoApuracao: string ;
begin
  Result := True ;

  pSetaTextoProgresso(APgbProgresso, 'Gerando Ajustes...');
  ///quando gerar os ajustes sempre irá gerar o lalur/lacs
  fGerarAjustes(FStrCodigoApuracaoLalur, FdtaVigenciaInicial, FdtaVigenciaFinal, llLalur, APgbProgresso, FecEncerramento, FstrCodEmp) ;
  fGerarAjustes(FStrCodigoApuracaoLacs, FdtaVigenciaInicial, FdtaVigenciaFinal, llLacs, APgbProgresso, FecEncerramento, FstrCodEmp) ;

  LStrCodigoApuracao := iif(FllTipo = llLalur, FStrCodigoApuracaoLalur, FStrCodigoApuracaoLacs) ;
  pCarregaDadosAjustes(FQryAjustes, LStrCodigoApuracao, FdtaVigenciaInicial, FdtaVigenciaFinal, FllTipo, FecEncerramento, FstrCodEmp) ;

end;

procedure TfrmApuracaoLucroRealLalurLacsAjustes.pSetaTextoProgresso(APgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(APgbProgresso) then
  Begin
    TLabel(GetParentForm(ApgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

function TfrmApuracaoLucroRealLalurLacsAjustes.fIsAssignedProgresso(
  APgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(APgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(ApgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

end.
