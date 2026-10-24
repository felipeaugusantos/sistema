unit Contabilidade.View.PeriodoDatasPeriodicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, EditFocus, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Contabilidade.Classes.TPeriodoDatas;

type
  TGetPeriodoDatasPeriodicos = class
  public
    class function fRetornaDatasPeriodicos(var AarrDatas: TArrayPeriodoDatas): Boolean ;
  end ;

  TfrmPeriodoDatasPeriodicos = class(TfrmPaiConfirmaContabilidade)
    cdsDatas: TUniClientDataSet;
    cdsDatasCODIGO: TAutoIncField;
    cdsDatasDATA_: TDateField;
    edtDtaLanc: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtQtdPeriodos: TEditFocus;
    Label3: TLabel;
    rgDiaFixo: TRadioGroup;
    dsDatas: TDataSource;
    Label4: TLabel;
    edtDias: TEditFocus;
    GridTab: TcxGridDBTableView;
    GridLevel1: TcxGridLevel;
    Grid: TcxGrid;
    GridTabCODIGO: TcxGridDBColumn;
    GridTabDATA_: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgDiaFixoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rgDiaFixoEnter(Sender: TObject);
    procedure rgDiaFixoExit(Sender: TObject);
  private
    { Private declarations }
    FblnConfirma: Boolean ;
    FarrDatas: TArrayPeriodoDatas ;
    procedure pDiasPeriodicidade(const AblnHabilitar: Boolean) ;
    procedure PUsarDiaFixo(const AblnHabilitar: Boolean) ;
    procedure pProcessaPeriodoDatas ;
  public
    { Public declarations }
    property Confirmado: Boolean read FblnConfirma ;
    property Datas: TArrayPeriodoDatas read FarrDatas ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples ;

{$R *.dfm}

procedure TfrmPeriodoDatasPeriodicos.btnConfirmaClick(Sender: TObject);
begin

  if not fVerificaCampos then
    Exit ;

  if cdsDatas.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Nenhuma Data de Lançamento Calculada!', ['&Ok']);
    pSetFocus(edtDtaLanc) ;
    exit ;
  end ;

  FblnConfirma := True ;
  Close ;
end;

procedure TfrmPeriodoDatasPeriodicos.FormCreate(Sender: TObject);
begin
  inherited;
  FblnConfirma := False ;
  SetLength(FarrDatas, 0);
  edtDtaLanc.Date := VS_Date ;
  cdsDatas.CreateDataSet ;
  cdsDatas.Open ;
end;

procedure TfrmPeriodoDatasPeriodicos.FormShow(Sender: TObject);
begin
  inherited;
  pDiasPeriodicidade(False) ;
  pUsarDiaFixo(False) ;
end;

function TfrmPeriodoDatasPeriodicos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin
    if Sender = edtDtaLanc Then
    begin
      edtDtaLanc.PostEditValue ;
      if VarIsNull(edtDtaLanc.EditValue)  Then
      begin
        fMensagem('ATENÇÃO!', 'Data Lançamento Não Informada!', ['&Ok']);
        Result := False;
      end;
    end
    else if Sender = edtQtdPeriodos then
    begin
      if  StrToIntDef(edtQtdPeriodos.Text, 0) <= 0 Then
      begin
        fMensagem('ATENÇÃO!', 'Quantidade Periodos Inválida!', ['&Ok']);
        Result := False;
      end;
      if StrToIntDef(edtQtdPeriodos.Text, 0) = 1 then
      begin
        pDiasPeriodicidade(False) ;
        pUsarDiaFixo(False) ;
        pProcessaPeriodoDatas ;
      end
      else
        pUsarDiaFixo(StrToIntDef(edtQtdPeriodos.Text, 0) > 1) ;
    end
    else if Sender = rgDiaFixo then
    begin
      if rgDiaFixo.ItemIndex = 1 then
        pProcessaPeriodoDatas ;
    end
    else if Sender = edtDias then
    begin
      if rgDiaFixo.ItemIndex = 0 then
      begin
        if  StrToIntDef(edtDias.Text, 0) <= 0 Then
        begin
          fMensagem('ATENÇÃO!', 'Periodicidade (Dias) Inválido!', ['&Ok']);
          Result := False;
        end
        else
          pProcessaPeriodoDatas ;
      end ;
    end ;

  end;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmPeriodoDatasPeriodicos.pDiasPeriodicidade(
  const AblnHabilitar: Boolean);
begin
  edtDias.Enabled := AblnHabilitar ;
end;

procedure TfrmPeriodoDatasPeriodicos.pProcessaPeriodoDatas;
var
  LobjDatas: TPeriodoDatas ;
  LintCnt: Integer ;
begin
  LobjDatas := TPeriodoDatas.Create ;
  try
    LobjDatas.DataLancamento := edtDtaLanc.Date ;
    LobjDatas.QtdPeriodos := StrToIntDef(edtQtdPeriodos.Text, 0) ;
    LobjDatas.UsarDiaFixo := rgDiaFixo.ItemIndex = 1 ;
    LobjDatas.DiasPeriodicidade := StrToIntDef(edtDias.Text, 0) ;
    FarrDatas := LobjDatas.fCalculaPeriodoDatas ;
    cdsDatas.EmptyDataSet ;
    for LintCnt := Low(FarrDatas) to High(FarrDatas) do
    begin
      cdsDatas.Append ;
      cdsDatas.FieldByName('DATA_').AsDateTime := FarrDatas[LintCnt] ;
      cdsDatas.Post ;
    end ;
    cdsDatas.First ;
  finally
    FreeAndNil(LobjDatas) ;
  end ;
end;

procedure TfrmPeriodoDatasPeriodicos.pUsarDiaFixo(const AblnHabilitar: Boolean);
begin
  rgDiaFixo.Enabled := AblnHabilitar ;
end;

procedure TfrmPeriodoDatasPeriodicos.rgDiaFixoClick(Sender: TObject);
begin
  inherited;
  pDiasPeriodicidade(TRadioGroup(Sender).ItemIndex <> 1) ;
end;

procedure TfrmPeriodoDatasPeriodicos.rgDiaFixoEnter(Sender: TObject);
begin
  inherited;
  keybd_event(ord(#9), MapVirtualKey(ord(#9), 0),0, 0);
end;

procedure TfrmPeriodoDatasPeriodicos.rgDiaFixoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(Sender as TWinControl) ;
end;

{ TGetPeriodoDatasPeriodicos }

class function TGetPeriodoDatasPeriodicos.fRetornaDatasPeriodicos(
   var AarrDatas: TArrayPeriodoDatas): Boolean;
var
  LfrmDatasPeriodicos: TfrmPeriodoDatasPeriodicos ;
begin

  pCriarFormularios(TfrmPeriodoDatasPeriodicos, LfrmDatasPeriodicos);
  Try
    LfrmDatasPeriodicos.showModal;
    Result := LfrmDatasPeriodicos.Confirmado ;
    if Result then
    begin
      AarrDatas := LfrmDatasPeriodicos.Datas ;
    end ;
  Finally
    pFreeAndNil(LfrmDatasPeriodicos);
  End;

end;

end.
