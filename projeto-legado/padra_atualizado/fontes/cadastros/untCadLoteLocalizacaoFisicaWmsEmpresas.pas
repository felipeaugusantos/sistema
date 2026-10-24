unit untCadLoteLocalizacaoFisicaWmsEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, MemDS,
  DBAccess, Uni, cxTextEdit;

type
  TfrmCadLoteLocalizacaoFisicaWmsEmpresas = class(TfrmPaiConfirma)
    dsLoteEmpresas: TDataSource;
    GridTabLoteEmpresas: TcxGridDBTableViewCitel;
    GridLoteEmpresasLevel1: TcxGridLevel;
    GridLoteEmpresas: TcxGridCitel;
    GridTabLoteEmpresasLOT_CODITE: TcxGridDBColumn;
    GridTabLoteEmpresasITE_DESITE: TcxGridDBColumn;
    GridTabLoteEmpresasLOT_CODEMP: TcxGridDBColumn;
    GridTabLoteEmpresasLOT_NUMLOT: TcxGridDBColumn;
    GridTabLoteEmpresasLOT_LOCFIS: TcxGridDBColumn;
    GridTabLoteEmpresasLOC_DESCRI: TcxGridDBColumn;
    procedure GridTabLoteEmpresasEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure GridTabLoteEmpresasLOT_LOCFISPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridTabLoteEmpresasFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function fInformouLocalizacaoFisica: Boolean ;
  private
    { Private declarations }
    FblnNaoEncontrado: Boolean ;
    FblnConfirma: Boolean ;
  public
    { Public declarations }
    property blnConfirma: Boolean read FblnConfirma ;
  end;

implementation

uses untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.btnConfirmaClick(
  Sender: TObject);
begin

  if not fInformouLocalizacaoFisica then
    Exit ;

  FblnConfirma := True ;
  Close ;
end;

function TfrmCadLoteLocalizacaoFisicaWmsEmpresas.fInformouLocalizacaoFisica: Boolean;
Var
  LdtsLote: TDataSet ;
begin
  Result := False ;
  LdtsLote := dsLoteEmpresas.DataSet ;

  LdtsLote.DisableControls ;
  try
    LdtsLote.First ;
    while not LdtsLote.Eof do
    begin
      if fEmptyStr(LdtsLote.FieldByName('LOT_LOCFIS').AsString) then
      begin
        pMensagemOk('Localização Física não informada!');
        pSetFocus(GridLoteEmpresas);
        exit ;
      end ;
      LdtsLote.Next ;
    end ;
  finally
    LdtsLote.EnableControls ;
  end ;

  Result := True ;
end;

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.FormCloseQuery(
  Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if not FblnConfirma then
    if (fMensagem('AVISO', 'Ao cancelar essa operação o sistema irá gerar o lote apenas para a empresa logada e para as outras que tiveram localização física definida. Deseja realmente cancelar?', ['&Sim', '&Não']) = 2) then
      CanClose := False;
end;

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.FormCreate(Sender: TObject);
begin
  inherited;
  FblnNaoEncontrado := False ;
  FblnConfirma := False ;
end;

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  GridTabLoteEmpresasLOT_LOCFIS.Selected := True ;
  GridTabLoteEmpresasLOT_LOCFIS.Focused := True ;
end;

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.GridTabLoteEmpresasEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  LarrSel: TConsultasArray;
  LqryLocFis : TUniQuery ;
begin
  inherited;

  If not Assigned(AItem) then
    Exit;

  If not (AItem is TcxGridDBColumn) then
    Exit;

  If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'LOT_LOCFIS' then
    Exit;

  If fEntraCons(Key) Then
  Begin
    LqryLocFis := fCriaQuery(Self);
    Try
      if fPesqLocFisica(Self, Nil, Nil, LqryLocFis, Key, LarrSel, True, False, False, False, False, '', False, GridTabLoteEmpresasLOT_CODEMP.DataBinding.Field.AsString) then
      begin
        AItem.EditValue := LqryLocFis.FieldByName('LOC_CODLOC').AsString;
        If (AItem.Index + 1) < (AItem.GridView.ItemCount) then
        begin
          AItem.GridView.Items[AItem.Index + 1].EditValue := LqryLocFis.FieldByName('LOC_DESCRI').AsString;
        end;
      end ;
    finally
      FreeAndNil(LqryLocFis) ;
    end ;
  end ;
end;

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.GridTabLoteEmpresasFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if (FblnNaoEncontrado) and (APrevFocusedItem = GridTabLoteEmpresasLOT_LOCFIS) then
  begin
    FblnNaoEncontrado := False ;
    APrevFocusedItem.Focused := True ;
  end;
end;

procedure TfrmCadLoteLocalizacaoFisicaWmsEmpresas.GridTabLoteEmpresasLOT_LOCFISPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  GridTabLoteEmpresasLOC_DESCRI.DataBinding.Field.AsString := fRetNomLocFisica(TcxTextEdit(Sender).Text, GridTabLoteEmpresasLOT_CODEMP.DataBinding.Field.AsString) ;
  if fEmptyStr(GridTabLoteEmpresasLOC_DESCRI.DataBinding.Field.AsString) then
  begin
    GridTabLoteEmpresasLOT_LOCFIS.DataBinding.Field.Clear ;
    if not fEmptyStr(TcxTextEdit(Sender).Text) then
    begin
      FblnNaoEncontrado := True ;
      pMensagemOk('Localização Física não encontrada!');
    end ;
  end
  else
  begin
    GridTabLoteEmpresasLOT_LOCFIS.DataBinding.Field.AsString := TcxTextEdit(Sender).Text ;
  end ;
end;

end.
