unit Principal.View.Frame.FMXDashTipoEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, StrUtils, FMX.Ani,
  Principal.View.Interfaces, FMX.Layouts;

type
  TframeTipoEmpresa = class(TFrame)
    recFaturamento: TRectangle;
    recOrigem: TRectangle;
    efeOrigem: TShadowEffect;
    efeFaturamento: TShadowEffect;
    lblFaturamento: TLabel;
    lblOrigem: TLabel;
    patOrigem: TPath;
    lblTipoEmpresa: TLabel;
    cirOrigem: TCircle;
    patFaturamento: TPath;
    cirFaturamento: TCircle;
    layTipoEmpresa: TLayout;
    procedure recFaturamentoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure recOrigemMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    procedure SelecionaTipoEmpresa(Sender: TObject);
    procedure MarcaTipoEmpresa(Sender: TObject);
    procedure DesmarcaTipoEmpresa(Sender: TObject);
  public
    { Public declarations }
    objDash : IDashboard;
    strTipoEmpresa : String;
    procedure CarregaDefault;
  end;

Const
  AzulCitel = TAlphaColor($FF00AAE4);

implementation

{$R *.fmx}

{ TframeTipoEmpresa }

procedure TframeTipoEmpresa.CarregaDefault;
begin
  strTipoEmpresa := LeftStr(objDash.RetornaTipoEmpresa, 1);

  If (strTipoEmpresa = 'F') Then
    SelecionaTipoEmpresa(recFaturamento)
  Else
    SelecionaTipoEmpresa(recOrigem);

  layTipoEmpresa.Visible := True;
end;

procedure TframeTipoEmpresa.DesmarcaTipoEmpresa(Sender: TObject);
Var
  LRectangle: TRectangle;
  LCircle   : TCircle;
  LPath     : TPath;
begin
  LRectangle := TRectangle(Sender);
  LCircle    := TCircle(FindComponent('cir' + Copy(LRectangle.Name, 4, 30)));
  LPath      := TPath(FindComponent('pat' + Copy(LRectangle.Name, 4, 30)));

  LRectangle.Stroke.Color := TAlphaColorRec.White;
  LPath.Visible           := False;
  LCircle.Visible         := True;
end;

procedure TframeTipoEmpresa.MarcaTipoEmpresa(Sender: TObject);
Var
  LRectangle: TRectangle;
  LCircle   : TCircle;
  LPath     : TPath;
begin
  LRectangle := TRectangle(Sender);
  LCircle    := TCircle(FindComponent('cir' + Copy(LRectangle.Name, 4, 30)));
  LPath      := TPath(FindComponent('pat' + Copy(LRectangle.Name, 4, 30)));

  LRectangle.Stroke.Color := AzulCitel;
  LPath.Visible           := True;
  LCircle.Visible         := False;
end;

procedure TframeTipoEmpresa.recFaturamentoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  If (Copy(TRectangle(Sender).Name,4,1) <> strTipoEmpresa) Then
    SelecionaTipoEmpresa(Sender);
end;

procedure TframeTipoEmpresa.recOrigemMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  If (Copy(TRectangle(Sender).Name,4,1) <> strTipoEmpresa) Then
    SelecionaTipoEmpresa(Sender);
end;

procedure TframeTipoEmpresa.SelecionaTipoEmpresa(Sender: TObject);
begin
  MarcaTipoEmpresa(Sender);
  strTipoEmpresa := Copy(TRectangle(Sender).Name,4,1);

  If ContainsStr(TRectangle(Sender).Name, 'Faturamento') Then
    DesmarcaTipoEmpresa(recOrigem)
  Else
    DesmarcaTipoEmpresa(recFaturamento);
end;

end.
