unit untCadastroCartaoTefConferencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, dxBarBuiltInMenu,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxDropDownEdit, untRegrasCadastroCartaoTef;

type
  TfrmCadastroCartaoTefConferencia = class(TfrmPaiConfirma)
    pgConferencia: TPageControl;
    tsBandeira: TTabSheet;
    tsAdquirente: TTabSheet;
    dsBandeira: TDataSource;
    dsAdquirente: TDataSource;
    GridBandeiraTableView: TcxGridDBTableViewCitel;
    GridBandeiraLevel: TcxGridLevel;
    GridBandeira: TcxGridCitel;
    GridAdquirenteTableView: TcxGridDBTableViewCitel;
    GridAdquirenteLevel: TcxGridLevel;
    GridAdquirente: TcxGridCitel;
    GridBandeiraTableViewAUTOINCREM: TcxGridDBColumn;
    GridBandeiraTableViewBAN_CODBAN: TcxGridDBColumn;
    GridBandeiraTableViewBAN_NOMBAN: TcxGridDBColumn;
    GridBandeiraTableViewAUXILI: TcxGridDBColumn;
    GridBandeiraTableViewSTATUS: TcxGridDBColumn;
    GridBandeiraTableViewTEMTEF: TcxGridDBColumn;
    GridAdquirenteTableViewAUTOINCREM: TcxGridDBColumn;
    GridAdquirenteTableViewADQ_CODADQ: TcxGridDBColumn;
    GridAdquirenteTableViewADQ_NOMADQ: TcxGridDBColumn;
    GridAdquirenteTableViewAUXILI: TcxGridDBColumn;
    GridAdquirenteTableViewSTATUS: TcxGridDBColumn;
    GridAdquirenteTableViewTEMTEF: TcxGridDBColumn;
    GridPopupBandeira: TcxGridPopupMenu;
    GridPopupAdquirente: TcxGridPopupMenu;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure GridAdquirenteTableViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridBandeiraTableViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridBandeiraTableViewAUXILIPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridAdquirenteTableViewAUXILIPropertiesEditValueChanged(
      Sender: TObject);
    function fTemAssociacao(const Acds: TUniClientDataSet; const ANomeColuna: String; const AValor: String): Boolean ;
  private
    { Private declarations }
    FblnBandeira  : Boolean ;
    FblnAdquirente: Boolean ;
    FcdsConfBandeira: TUniClientDataSet ;
    FcdsConfAdquirente: TUniClientDataSet ;
    FSugAdquirentes: TCarregaAdquirentesTef ;
    FSugBandeiras: TCarregaBandeirasTef ;
    FcdsCloneBandeira: TUniClientDataSet ;
    FcdsCloneAdquirente: TUniClientDataSet ;
    FcdsOriginalBandeira: TUniClientDataSet ;
    FcdsOriginalAdquirente: TUniClientDataSet ;
    procedure pCarregarConferenciaBandeira() ;
    procedure pCarregarConferenciaAdquirente() ;
    procedure pCarregaSugestoesBandeira() ;
    procedure pCarregaSugestoesAdquirente() ;
    function fProcessarGridBandeiraAjustada: Boolean ;
    function fProcessarGridAdquirenteAjustada: Boolean ;
    procedure pBandeiraAfterPost(DataSet: TDataSet) ;
    procedure pAdquirenteAfterPost(DataSet: TDataSet) ;
    procedure pClonaCds(var AcdsClone: TUniClientDataSet; const AcdsOrigem: TUniClientDataSet) ;
    procedure pFocoGrid ;
  public
    { Public declarations }
    property Bandeira: Boolean read FblnBandeira write FblnBandeira;
    property Adquirente: Boolean read FblnAdquirente write FblnAdquirente;
  end;

  TClassCadastroCartaoTefConferencia = class
  public
    class function fExecutar(const AConfBandeira, AConfAdquirente: Boolean): Boolean ;
  end ;

implementation

uses untFuncoesSimples ;

{$R *.dfm}

{ TClassCadastroCartaoTefConferencia }

class function TClassCadastroCartaoTefConferencia.fExecutar(const AConfBandeira, AConfAdquirente: Boolean): Boolean;
var
  LfrmCadastroCartaoTefConferencia : TfrmCadastroCartaoTefConferencia;
begin
  pCriarFormularios(TfrmCadastroCartaoTefConferencia, LfrmCadastroCartaoTefConferencia);
  try
    LfrmCadastroCartaoTefConferencia.Bandeira := AConfBandeira ;
    LfrmCadastroCartaoTefConferencia.Adquirente := AConfAdquirente ;
    Result := LfrmCadastroCartaoTefConferencia.ShowModal = mrOk ;
    if not result then
      fMensagem('ATENÇÃO!', 'Conferência cancelada pelo operador!', ['&Ok']);
  finally
    pFreeAndNil(LfrmCadastroCartaoTefConferencia);
  end;
end;

procedure TfrmCadastroCartaoTefConferencia.btnConfirmaClick(Sender: TObject);
begin

  if not fProcessarGridAdquirenteAjustada then
    Exit ;

  if not fProcessarGridBandeiraAjustada then
    Exit ;

  ModalResult := mrOk ;

end;

function TfrmCadastroCartaoTefConferencia.fTemAssociacao(
  const Acds: TUniClientDataSet; const ANomeColuna, AValor: String): Boolean;
begin
  if fEmptyStr(AValor) then
    Exit(False) ;

  Result := Acds.Locate(ANomeColuna, AValor, [loCaseInsensitive])  ;
end;

procedure TfrmCadastroCartaoTefConferencia.FormCreate(Sender: TObject);
begin
  inherited;
  FcdsConfBandeira   := nil ;
  FcdsConfAdquirente := nil ;

  FcdsCloneBandeira   := nil ;
  FcdsCloneAdquirente := nil ;

  FcdsOriginalBandeira    := nil ;
  FcdsOriginalAdquirente  := nil ;

  FblnBandeira   := False ;
  FblnAdquirente := False ;

  FSugAdquirentes := TCarregaAdquirentesTef.Create ;
  FSugBandeiras   := TCarregaBandeirasTef.Create ;

  pCarregaSugestoesAdquirente ;
  pCarregaSugestoesBandeira ;
end;

procedure TfrmCadastroCartaoTefConferencia.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsConfBandeira) then
    FreeAndNil(FcdsConfBandeira) ;

  if Assigned(FcdsConfAdquirente) then
    FreeAndNil(FcdsConfAdquirente) ;

  if Assigned(FcdsCloneBandeira) then
    FreeAndNil(FcdsCloneBandeira) ;

  if Assigned(FcdsCloneAdquirente) then
    FreeAndNil(FcdsCloneAdquirente) ;

  if Assigned(FcdsOriginalBandeira) then
    FreeAndNil(FcdsOriginalBandeira) ;

  if Assigned(FcdsOriginalAdquirente) then
    FreeAndNil(FcdsOriginalAdquirente) ;

  FreeAndNil(FSugAdquirentes) ;
  FreeAndNil(FSugBandeiras) ;
end;

procedure TfrmCadastroCartaoTefConferencia.FormShow(Sender: TObject);
var
  LPrimeiraTab: TTabSheet ;
begin
  inherited;
  LPrimeiraTab := Nil ;
  if FblnBandeira then
    LPrimeiraTab := tsBandeira ;

  tsBandeira.TabVisible := FblnBandeira ;

  if FblnAdquirente then
    if Assigned(LPrimeiraTab) then
      LPrimeiraTab := tsBandeira ;

  tsAdquirente.TabVisible := FblnAdquirente ;

  pgConferencia.ActivePage := LPrimeiraTab ;

  pCarregarConferenciaBandeira ;
  pCarregarConferenciaAdquirente ;
  pFocoGrid ;
end;

function TfrmCadastroCartaoTefConferencia.fProcessarGridAdquirenteAjustada: Boolean;
var
  LintCnt: Integer;
  LComboBoxProps: TcxComboBoxProperties;
  LstrValorSelecionado: String ;
  LvarValorSelecionado: Variant ;
  LintIndex: Integer ;
  LAdquirente: TItemAdquirenteTef ;
  LstrStatus: String ;
  LstrAutoInc: String ;
  LstrDescricao: String ;
  LblnTemAjusteManual: Boolean ;
begin
  Result := True ;
  LblnTemAjusteManual := False ;

  if not FblnAdquirente then
    Exit ;

  for LintCnt := 0 to GridAdquirenteTableView.DataController.RecordCount - 1 do
  begin
    LstrStatus := VarToStr(GridAdquirenteTableView.DataController.Values[LintCnt, GridAdquirenteTableViewSTATUS.Index]) ;
    if LstrStatus = STATUS_AJUSTADO then
    begin
      LblnTemAjusteManual := True ;
      break ;
    end ;
  end ;

  LComboBoxProps := TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties) ;

  fStartTransaction ;
  try
    if LblnTemAjusteManual then
    begin
      for LintCnt := 0 to GridAdquirenteTableView.DataController.RecordCount - 1 do
      begin
        LstrStatus := VarToStr(GridAdquirenteTableView.DataController.Values[LintCnt, GridAdquirenteTableViewSTATUS.Index]) ;
        if LstrStatus = STATUS_AJUSTADO then
        begin
          LstrValorSelecionado := '' ;
          LAdquirente := Nil ;
          LvarValorSelecionado := GridAdquirenteTableView.DataController.Values[LintCnt, GridAdquirenteTableViewAUXILI.Index] ;
          if not VarIsNull(LvarValorSelecionado) then
            LstrValorSelecionado :=  VarToStr(LvarValorSelecionado) ;

          if not fEmptyStr(LstrValorSelecionado) then
          begin
            LintIndex := LComboBoxProps.Items.IndexOf(LstrValorSelecionado) ;
            if LintIndex <> -1 then
              LAdquirente := LComboBoxProps.Items.Objects[LintIndex] as TItemAdquirenteTef ;
          end ;

          if Assigned(LAdquirente) then
          begin
            LstrAutoInc   := VarToStr(GridAdquirenteTableView.DataController.Values[LintCnt, GridAdquirenteTableViewAUTOINCREM.Index]) ;
            LstrDescricao := VarToStr(GridAdquirenteTableView.DataController.Values[LintCnt, GridAdquirenteTableViewADQ_NOMADQ.Index]) ;
            Result := FSugAdquirentes.fPersistirBanco(LAdquirente, LstrAutoInc, LstrDescricao) ;
          end ;
        end ;

      end ;
    end ;

    FSugAdquirentes.fPersistirBanco(True) ;

    fCommit ;
  except
    on E: EUniError do
    begin
      fRollBack;
      pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[TfrmCadastroCartaoTefConferencia.fProcessarGridAdquirenteAjustada]');
    end ;
  end ;

end;

function TfrmCadastroCartaoTefConferencia.fProcessarGridBandeiraAjustada: Boolean;
var
  LintCnt: Integer;
  LComboBoxProps: TcxComboBoxProperties;
  LstrValorSelecionado: String ;
  LvarValorSelecionado: Variant ;
  LintIndex: Integer ;
  LBandeira: TItemBandeiraTef ;
  LstrStatus: String ;
  LstrAutoInc: String ;
  LstrDescricao: String ;
  LblnTemAjusteManual: Boolean ;
begin
  Result := True ;
  LblnTemAjusteManual := False ;

  if not FblnBandeira then
    Exit ;

  for LintCnt := 0 to GridBandeiraTableView.DataController.RecordCount - 1 do
  begin
    LstrStatus := VarToStr(GridBandeiraTableView.DataController.Values[LintCnt, GridBandeiraTableViewSTATUS.Index]) ;
    if LstrStatus = STATUS_AJUSTADO then
    begin
      LblnTemAjusteManual := True ;
      break ;
    end ;
  end ;

  LComboBoxProps := TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties) ;

  fStartTransaction ;
  try
    if LblnTemAjusteManual then
    begin
      for LintCnt := 0 to GridBandeiraTableView.DataController.RecordCount - 1 do
      begin
        LstrStatus := VarToStr(GridBandeiraTableView.DataController.Values[LintCnt, GridBandeiraTableViewSTATUS.Index]) ;

        if LstrStatus = STATUS_AJUSTADO then
        begin

          LstrValorSelecionado := '' ;
          LBandeira := Nil ;
          LvarValorSelecionado := GridBandeiraTableView.DataController.Values[LintCnt, GridBandeiraTableViewAUXILI.Index] ;
          if not VarIsNull(LvarValorSelecionado) then
            LstrValorSelecionado :=  VarToStr(LvarValorSelecionado) ;

          if not fEmptyStr(LstrValorSelecionado) then
          begin
            LintIndex := LComboBoxProps.Items.IndexOf(LstrValorSelecionado) ;
            if LintIndex <> -1 then
              LBandeira := LComboBoxProps.Items.Objects[LintIndex] as TItemBandeiraTef ;
          end ;

          if Assigned(LBandeira) then
          begin
            LstrAutoInc   := VarToStr(GridBandeiraTableView.DataController.Values[LintCnt, GridBandeiraTableViewAUTOINCREM.Index]) ;
            LstrDescricao := VarToStr(GridBandeiraTableView.DataController.Values[LintCnt, GridBandeiraTableViewBAN_NOMBAN.Index]) ;
            Result := FSugBandeiras.fPersistirBanco(LBandeira, LstrAutoInc, LstrDescricao) ;
          end ;

        end ;

      end ;
    end ;

    FSugBandeiras.fPersistirBanco(True) ;

    fCommit ;
  except
    on E: EUniError do
    begin
      fRollBack;
      pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[TfrmCadastroCartaoTefConferencia.fProcessarGridBandeiraAjustada]');
    end ;
  end ;

end;

procedure TfrmCadastroCartaoTefConferencia.GridAdquirenteTableViewAUXILIPropertiesEditValueChanged(
  Sender: TObject);
var
  LintIndex: Integer ;
  LAdquirente: TItemAdquirenteTef ;
begin
  inherited;
  if fTemAssociacao(FcdsCloneAdquirente, 'AUXILI', TcxComboBox(Sender).Text) then
  begin
    fMensagem('ATENÇÃO!', format('Sugestão já associada na adquirente [%s - %s]!', [FcdsCloneAdquirente.FieldByName('ADQ_CODADQ').AsString, FcdsCloneAdquirente.FieldByName('ADQ_NOMADQ').AsString]), ['&Ok']);
    TcxComboBox(Sender).Undo ;
    Exit ;
  end ;

  TcxComboBox(Sender).PostEditValue ;

  GridAdquirenteTableViewAUXILI.DataBinding.Field.AsString := TcxComboBox(Sender).Text ;
  if fEmptyStr(GridAdquirenteTableViewAUXILI.DataBinding.Field.AsString) then
  begin
    GridAdquirenteTableViewSTATUS.DataBinding.Field.AsString := STATUS_PENDENTE ;
    FcdsOriginalAdquirente.Locate('ADQ_CODADQ', GridAdquirenteTableViewADQ_CODADQ.DataBinding.Field.AsString, [loCaseInsensitive]) ;
    GridAdquirenteTableViewADQ_NOMADQ.DataBinding.Field.AsString := FcdsOriginalAdquirente.FieldByName('ADQ_NOMADQ').AsString ;
  end
  else
  begin
    GridAdquirenteTableViewSTATUS.DataBinding.Field.AsString := STATUS_AJUSTADO ;
    LintIndex := TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties).Items.IndexOf(GridAdquirenteTableViewAUXILI.DataBinding.Field.AsString) ;
    if LintIndex <> -1 then
    begin
      LAdquirente := TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties).Items.Objects[LintIndex] as TItemAdquirenteTef ;
      GridAdquirenteTableViewADQ_NOMADQ.DataBinding.Field.AsString := LAdquirente.Descricao ;
    end ;
  end ;

end;

procedure TfrmCadastroCartaoTefConferencia.GridAdquirenteTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
  LvarValor: Variant ;
  LstrValor: String ;
begin
  inherited;
  LvarValor := Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, GridAdquirenteTableViewTEMTEF.Index] ;
  if not VarIsNull(LvarValor) then
  begin
    LstrValor := trim(VarToStr(LvarValor)) ;
    if LstrValor = '1' then
      AAllow := False ;
  end ;
end;

procedure TfrmCadastroCartaoTefConferencia.GridBandeiraTableViewAUXILIPropertiesEditValueChanged(
  Sender: TObject);
var
  LintIndex: Integer ;
  LBandeira: TItemBandeiraTef ;
begin
  inherited;

  if fTemAssociacao(FcdsCloneBandeira, 'AUXILI', TcxComboBox(Sender).Text) then
  begin
    fMensagem('ATENÇÃO!', format('Sugestão já associada na bandeira [%s - %s]!', [FcdsCloneBandeira.FieldByName('BAN_CODBAN').AsString, FcdsCloneBandeira.FieldByName('BAN_NOMBAN').AsString]), ['&Ok']);
    TcxComboBox(Sender).Undo ;
    Exit ;
  end ;

  TcxComboBox(Sender).PostEditValue ;

  GridBandeiraTableViewAUXILI.DataBinding.Field.AsString := TcxComboBox(Sender).Text ;
  if fEmptyStr(GridBandeiraTableViewAUXILI.DataBinding.Field.AsString) then
  begin
    GridBandeiraTableViewSTATUS.DataBinding.Field.AsString := STATUS_PENDENTE ;
    FcdsOriginalBandeira.Locate('BAN_CODBAN', GridBandeiraTableViewBAN_CODBAN.DataBinding.Field.AsString, [loCaseInsensitive]) ;
    GridBandeiraTableViewBAN_NOMBAN.DataBinding.Field.AsString := FcdsOriginalBandeira.FieldByName('BAN_NOMBAN').AsString ;
  end
  else
  begin
    GridBandeiraTableViewSTATUS.DataBinding.Field.AsString := STATUS_AJUSTADO ;
    LintIndex := TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties).Items.IndexOf(GridBandeiraTableViewAUXILI.DataBinding.Field.AsString) ;
    if LintIndex <> -1 then
    begin
      LBandeira := TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties).Items.Objects[LintIndex] as TItemBandeiraTef ;
      GridBandeiraTableViewBAN_NOMBAN.DataBinding.Field.AsString := LBandeira.Descricao ;
    end ;
  end ;

end;

procedure TfrmCadastroCartaoTefConferencia.GridBandeiraTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
  LvarValor: Variant ;
  LstrValor: String ;
begin
  inherited;
  LvarValor := Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, GridBandeiraTableViewTEMTEF.Index] ;
  if not VarIsNull(LvarValor) then
  begin
    LstrValor := trim(VarToStr(LvarValor)) ;
    if LstrValor = '1' then
      AAllow := False ;
  end ;
end;

procedure TfrmCadastroCartaoTefConferencia.pAdquirenteAfterPost(
  DataSet: TDataSet);
begin
  pClonaCds(FcdsCloneAdquirente, FcdsConfAdquirente) ;
end;

procedure TfrmCadastroCartaoTefConferencia.pBandeiraAfterPost(
  DataSet: TDataSet);
begin
  pClonaCds(FcdsCloneBandeira, FcdsConfBandeira) ;
end;

procedure TfrmCadastroCartaoTefConferencia.pCarregarConferenciaAdquirente;
begin
  if not FblnAdquirente then
    Exit ;

  if TRegrasCadastroCartaoTef.fCarregaConferenciaCdAdqC(FcdsConfAdquirente) then
  begin
    dsAdquirente.DataSet := FcdsConfAdquirente ;
    FcdsConfAdquirente.AfterPost := pAdquirenteAfterPost ;
    pClonaCds(FcdsCloneAdquirente, FcdsConfAdquirente) ;
    pClonaCds(FcdsOriginalAdquirente, FcdsConfAdquirente) ;
  end ;

end;

procedure TfrmCadastroCartaoTefConferencia.pCarregarConferenciaBandeira;
begin
  if not FblnBandeira then
    Exit ;

  if TRegrasCadastroCartaoTef.fCarregaConferenciaCadBan(FcdsConfBandeira) then
  begin
    dsBandeira.DataSet := FcdsConfBandeira ;
    FcdsConfBandeira.AfterPost := pBandeiraAfterPost ;
    pClonaCds(FcdsCloneBandeira, FcdsConfBandeira) ;
    pClonaCds(FcdsOriginalBandeira, FcdsConfBandeira) ;
  end ;

end;

procedure TfrmCadastroCartaoTefConferencia.pCarregaSugestoesAdquirente;
var
  LAdquirente: TItemAdquirenteTef ;
begin
  TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties).Items.BeginUpdate ;
  try
    TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties).Items.Clear ;
    for LAdquirente in FSugAdquirentes.Adquirentes do
    begin
      TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties).Items.AddObject(LAdquirente.Descricao, LAdquirente) ;
    end ;
  finally
    TcxComboBoxProperties(GridAdquirenteTableViewAUXILI.Properties).Items.EndUpdate ;
  end ;
end;

procedure TfrmCadastroCartaoTefConferencia.pCarregaSugestoesBandeira;
var
  LBandeira: TItemBandeiraTef ;
begin
  TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties).Items.BeginUpdate ;
  try
    TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties).Items.Clear ;
    for LBandeira in FSugBandeiras.Bandeiras do
    begin
      TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties).Items.AddObject(LBandeira.Descricao, LBandeira) ;
    end ;
  finally
    TcxComboBoxProperties(GridBandeiraTableViewAUXILI.Properties).Items.EndUpdate ;
  end ;
end;

procedure TfrmCadastroCartaoTefConferencia.pClonaCds(
  var AcdsClone: TUniClientDataSet; const AcdsOrigem: TUniClientDataSet);
begin
  if Assigned(AcdsClone) then
    FreeAndNil(AcdsClone) ;

  AcdsClone := TUniClientDataSet.Create(nil);

  pCloneDataSet(AcdsClone, AcdsOrigem) ;
end;

procedure TfrmCadastroCartaoTefConferencia.pFocoGrid;
begin
  if pgConferencia.ActivePage = tsBandeira then
    pSetFocus(GridBandeira)
  else if pgConferencia.ActivePage = tsAdquirente then
    pSetFocus(GridAdquirente) ;
end;

end.
