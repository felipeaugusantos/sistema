unit Principal.View.FMXCRM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.Effects, FMX.Filter.Effects,
  FMX.Layouts, FMX.Ani, FMX.ListBox, System.StrUtils;

type
  TfmxCRM = class(TForm)
    imgFoto: TImage;
    layFundo: TLayout;
    layQuadrado: TLayout;
    recCliente: TRoundRect;
    btnCliente: TSpeedButton;
    imgClienteFull: TImage;
    lblCliente: TLabel;
    imgClienteLine: TImage;
    recProspecto: TRoundRect;
    btnProspecto: TSpeedButton;
    imgProspectoFull: TImage;
    lblProspecto: TLabel;
    imgProspectoLine: TImage;
    flaQuadrado: TFlowLayout;
    recFornecedor: TRoundRect;
    btnFornecedor: TSpeedButton;
    imgFornecedorFull: TImage;
    lblFornecedor: TLabel;
    imgFornecedorLine: TImage;
    lblAcesso: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure recClienteMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure recClienteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure recClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure recClienteMouseEnter(Sender: TObject);
  private
    { Private declarations }
    recFoco : TRoundRect;

    procedure FocarAnterior;
    procedure FocarProximo;
    procedure SetaFoco(recFocar: TRoundRect);
    procedure FocarBotao(Sender: TObject);
    procedure DesfocarBotao(Sender: TObject);

    function ValidarObjetoAssinadoEHabilitado(Sender: TObject): Boolean;


  public
    { Public declarations }
    blnConfirma: Boolean;
    intOpcaoSel: Integer;

    function CountOpcoesCRM: Integer;
    function RetornaUnicaOpcao: Integer;

  end;

var
  fmxCRM: TfmxCRM;

Const
  AzulPadrao   = TAlphaColor($FF003e5a);
  AzulEscuro   = TAlphaColor($FF001830);
  AzulClaro    = TAlphaColor($FF3b6887);
  Transparente = TAlphaColor($00000000);

implementation

{$R *.fmx}

function TfmxCRM.CountOpcoesCRM: Integer;
begin
  Result := 0;
  If recCliente.Enabled    Then Inc(Result);
  If recProspecto.Enabled  Then Inc(Result);
  If recFornecedor.Enabled Then Inc(Result);
end;

procedure TfmxCRM.DesfocarBotao(Sender: TObject);
Var
  LImageFull, LImageLine: TImage;
begin
  LImageFull := TImage(FindComponent('img' + Copy(TRoundRect(Sender).Name, 4, 30) + 'Full'));
  LImageLine := TImage(FindComponent('img' + Copy(TRoundRect(Sender).Name, 4, 30) + 'Line'));

  TRoundRect(Sender).Opacity := 0.3;
  TRoundRect(Sender).Fill.Color := Transparente;
  LImageLine.Opacity := 1;
  LImageFull.Opacity := 0;
end;

procedure TfmxCRM.FocarAnterior;
begin
  If recFoco = recCliente Then
    SetaFoco(recFornecedor)

  Else If recFoco = recProspecto Then
    SetaFoco(recCliente)

  Else If recFoco = recFornecedor Then
    SetaFoco(recProspecto);
end;

procedure TfmxCRM.FocarBotao(Sender: TObject);
Var
  LImageFull, LImageLine: TImage;
begin
  LImageFull := TImage(FindComponent('img' + Copy(TRoundRect(Sender).Name, 4, 30) + 'Full'));
  LImageLine := TImage(FindComponent('img' + Copy(TRoundRect(Sender).Name, 4, 30) + 'Line'));

  TRoundRect(Sender).Opacity := 1;
  TRoundRect(Sender).Fill.Color := AzulPadrao;
  LImageFull.Opacity := 1;
  LImageLine.Opacity := 0;
end;

procedure TfmxCRM.FocarProximo;
begin
  If recFoco = recCliente Then
    SetaFoco(recProspecto)

  Else If recFoco = recProspecto Then
    SetaFoco(recFornecedor)

  Else If recFoco = recFornecedor Then
    SetaFoco(recCliente);
end;

procedure TfmxCRM.FormCreate(Sender: TObject);
begin
  blnConfirma := False;
  intOpcaoSel := -1;
  SetaFoco(recCliente);
end;

procedure TfmxCRM.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  Case Key Of
    vkEscape       : Close;
    vkReturn       : recClienteClick(recFoco);
    vkLeft, vkUp   : FocarAnterior;
    vkRight, vkDown: FocarProximo;
  End;
end;

procedure TfmxCRM.FormShow(Sender: TObject);
begin
  layFundo.Opacity := 1;
  recCliente.SetFocus;
end;

function TfmxCRM.RetornaUnicaOpcao: Integer;
begin
  If recCliente.Enabled Then
    Result := recCliente.Tag

  Else If recProspecto.Enabled Then
    Result := recProspecto.Tag

  Else If recFornecedor.Enabled Then
    Result := recFornecedor.Tag

  Else
    Result := -1;
end;

procedure TfmxCRM.SetaFoco(recFocar: TRoundRect);
begin
  If recFoco = recFocar Then
    Exit;

  If recFoco <> nil Then
    DesfocarBotao(recFoco);

  FocarBotao(recFocar);

  recFoco := recFocar;
end;

function TfmxCRM.ValidarObjetoAssinadoEHabilitado(Sender: TObject): Boolean;
begin
  Result := False;

  If Not Assigned(Sender) Then
    Exit;

  If Not TRoundRect(Sender).Enabled Then
    Exit;

  Result := True;
end;

procedure TfmxCRM.recClienteClick(Sender: TObject);
begin
  If ValidarObjetoAssinadoEHabilitado(Sender) Then
  Begin
    intOpcaoSel := TComponent(Sender).Tag;
    blnConfirma := True;
    Close;
  End;
end;

procedure TfmxCRM.recClienteMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  TRoundRect(Sender).Fill.Color := AzulEscuro;
end;

procedure TfmxCRM.recClienteMouseEnter(Sender: TObject);
begin
  SetaFoco(TRoundRect(Sender));
end;

procedure TfmxCRM.recClienteMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  TRoundRect(Sender).Fill.Color := AzulPadrao;
end;

end.
