unit untPanelCxBotoesAcoesNovaConsulta;

interface
Uses
  ExtCtrls,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  Classes,
  untClassPanelCx,
  untPnlBotoesAcoesNovaConsulta,
  BitBtnLockedIncrem,
  untIConsultaComp,
  untIConsulta,
  untIDicionario,
  untTypesSistema;

Type
  TPanelCxBotoesAcoesNovaConsulta = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlBotoesAcoesNovaConsultaClass;
    FstrTabPre: string;
    FstrIdePro: string;
    FTipoConsulta: TTipoConsultaTinta;
    Ftinta: IConsulta;
    FconsultaComp: IConsultaComp;
    FdicRetorno: IDicionario;
    procedure SetStrTabPre(const Value: string);
    procedure SetStrIdePro(const Value: string);
  public
    frmPnlCon: TfrmPnlBotoesAcoesNovaConsulta;
    constructor Create(TfrmPnlCon: TfrmPnlBotoesAcoesNovaConsultaClass; TipoConsulta: TTipoConsultaTinta; Tinta: IConsulta; const consultaComp: IConsultaComp; dicRetorno: IDicionario = Nil); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;

    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
    property strTabPre: string Read FstrTabPre write SetStrTabPre;
    property strIdePro: string Read FstrIdePro write SetStrIdePro;
End;

implementation

{ TPanelCxBotoesAcoesNovaConsulta }

constructor TPanelCxBotoesAcoesNovaConsulta.Create(TfrmPnlCon: TfrmPnlBotoesAcoesNovaConsultaClass; TipoConsulta: TTipoConsultaTinta; Tinta: IConsulta; const consultaComp: IConsultaComp; dicRetorno: IDicionario);
begin
  inherited Create;
  FTipoConsulta := TipoConsulta;
  FTinta := Tinta;
  FConsultaComp := consultaComp;
  FTfrmCo := TfrmPnlCon;
  FdicRetorno := dicRetorno;
end;

procedure TPanelCxBotoesAcoesNovaConsulta.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  inherited;
  frmPnlCon := FTfrmCo.Create(FTipoConsulta, FstrTabPre, FTinta, FConsultaComp, FdicRetorno);
  frmPnlCon.strIdePro := FstrIdePro;
  frmPanel  := frmPnlCon;
  frmPnlCon.cdsConsulta := cdsConsulta;
  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxBotoesAcoesNovaConsulta.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;


procedure TPanelCxBotoesAcoesNovaConsulta.SetStrIdePro(const Value: string);
begin
  FstrIdePro := Value;
end;

procedure TPanelCxBotoesAcoesNovaConsulta.SetStrTabPre(const Value: string);
begin
  FstrTabPre := Value;
end;

end.



