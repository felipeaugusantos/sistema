unit untDMPlugin;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, System.Types, System.UITypes,
  FMX.ImgList, FMX.Graphics, untInterfacePlugin;

type
  TDMPlugin = class(TDataModule)
    imgIcones: TImageList;
    procedure DataModuleDestroy(Sender: TObject);
  public
    procedure pInicializa(const AHost: IHost);
  end;

  procedure pMostraDashboard(const AHost: IHost);
  procedure pInicializaPlugin(const AHost: IHost);

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses untFmxDashboard;

{$R *.dfm}

{ TDMPlugin }

procedure TDMPlugin.DataModuleDestroy(Sender: TObject);
begin
  TBitmapCodecManager.UnInitialize;
  TCanvasManager.UnInitialize;
end;

procedure TDMPlugin.pInicializa(const AHost: IHost);
var
  size: TSizeF;
  data: TBitmapData;
  arrBitmap: Array Of Integer;
  i, j: Integer;
  alpha: Integer;
begin
  size.cx := TAMANHO_ICONE;
  size.cy := TAMANHO_ICONE;
  SetLength(arrBitmap, TAMANHO_ICONE * TAMANHO_ICONE);

  If imgIcones.Bitmap(size, 0).Map(TMapAccess.Read, data) Then
    For i := 0 To data.Height - 1 Do
      For j := 0 To data.Width - 1 Do
      Begin
        alpha := TAlphaColorRec(data.GetPixel(i, j)).A;
        alpha := alpha * $1000000;
        arrBitmap[i * TAMANHO_ICONE + j] := alpha + TAlphaColorRec.ColorToRGB(data.GetPixel(i, j));
      End;

  AHost.pAddMenu(['Principal', 'Faturamento', 'Dashboard'], 'DASHBOARD', 'pMostraDashboard');
  AHost.pAddMenu(['Direitos de Acesso', 'Dashboard', 'Visualizar margem de lucro'], 'DASHBOARD_VER_MARGEM', '');
  AHost.pAddMenu(['Direitos de Acesso', 'Dashboard', 'Visualizar vendas geral'], 'DASHBOARD_VER_GERAL', '');
  AHost.pAddMenu(['Direitos de Acesso', 'Dashboard', 'Visualizar vendas equipe'], 'DASHBOARD_VER_EQUIPE', '');
  AHost.pAddButton(arrBitmap, 'DASHBOARD', 'pMostraDashboard');
end;

procedure pMostraDashboard(const AHost: IHost);
begin
  fmxDashboard := TfmxDashboard.Create(nil);
  Try
    fmxDashboard.qryAux    := AHost.fGetQuery();
    fmxDashboard.strCodEmp := AHost.fGetEmpresa();
    fmxDashboard.strLogOpe := AHost.fGetUsuario();
    fmxDashboard.ShowModal;
  Finally
    FreeAndNil(fmxDashboard);
  End;
end;

procedure pInicializaPlugin(const AHost: IHost);
var
  dtmPlugin: TDMPlugin;
begin
  dtmPlugin := TDMPlugin.Create(nil);
  Try
    dtmPlugin.pInicializa(AHost);
  Finally
    FreeAndNil(dtmPlugin);
  End;
end;

end.
