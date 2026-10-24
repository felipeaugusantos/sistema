{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************PZ*}
unit untPanelCxPreFiltro;

interface
Uses
  ExtCtrls,
  TypInfo,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  strUtils,
  Classes,
  untClassPanelCx,
  untFuncoesSimples,
  BitBtnLockedIncrem,
  untFatComboVenda,
  untCadPro,
  untGerMat,
  untNovoProduto;

Type
  TPanelCxPreFiltro = class;

  TfrmPnlPreFiltro = class(TForm)
  private
    FObjPreFiltro: TPanelCxPreFiltro;
  public
    property objPreFiltro: TPanelCxPreFiltro read FObjPreFiltro write FObjPreFiltro;
  end;

  TfrmPnlPreFiltroClass = Class Of TfrmPnlPreFiltro;

  TPanelCxPreFiltro = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlPreFiltroClass;
    FSQLPreFiltro: String;
    procedure pAjustarPreFiltro;
  public
    frmPnlCon: TfrmPnlPreFiltro;
    strNomForm: String;
    strTabPre : String;

    constructor Create(TfrmPnlCon: TfrmPnlPreFiltroClass); reintroduce;
    destructor  Destroy; reintroduce;
    procedure pCriaForm(NewDockSite  : TWinControl;
                        DropControl  : TControl;
                        cdsConsulta  : TUniClientDataSet;
                        btnConfirma  : TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

    function fGetSQLPreFiltro(): String; override;

    procedure pSetSQLPreFiltro(strSQL: String);
  End;

implementation

constructor TPanelCxPreFiltro.Create(TfrmPnlCon: TfrmPnlPreFiltroClass);
begin
  inherited Create;
  FTfrmCo   := TfrmPnlCon;
end;

procedure TPanelCxPreFiltro.pAjustarPreFiltro;
begin
  frmPnlCon.WindowState := wsMaximized;
  frmPnlCon.Align := alClient;
end;

procedure TPanelCxPreFiltro.pCriaForm(NewDockSite: TWinControl;
                                 DropControl  : TControl;
                                 cdsConsulta  : TUniClientDataSet;
                                 btnConfirma  : TBitBtnLocked;
                                 cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPanel  := frmPnlCon;
  frmPnlCon.objPreFiltro := Self;

  prcAtualizar := pAjustarPreFiltro;
  pgcDropControl := DropControl;
  With frmPnlCon Do
  Begin
    DropControl.Height := ClientHeight;
    DropControl.Width  := ClientWidth;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxPreFiltro.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TPanelCxPreFiltro.pSetSQLPreFiltro(strSQL: String);
begin
  FSQLPreFiltro := strSQL;
end;

destructor TPanelCxPreFiltro.Destroy;
begin
  inherited destroy;
end;

function TPanelCxPreFiltro.fGetSQLPreFiltro: String;
begin
  Result := FSQLPreFiltro;
end;

end.
