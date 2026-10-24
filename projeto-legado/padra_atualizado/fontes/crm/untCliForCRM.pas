unit untCliForCRM;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus,Buttons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxGroupBox, cxRadioGroup, BitBtnLockedIncrem, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, StdCtrls, frxClass, frxExportCSVTestabilidade, cxButtons,
  dxGDIPlusClasses, cxImage;

type
  TfrmCliForCRM = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCliente: TPanel;
    imgCliente: TcxImage;
    pnlProspecto: TPanel;
    imgProspecto: TcxImage;
    pnlFornecedor: TPanel;
    imgFornecedor: TcxImage;
    lblCliente: TLabel;
    lblFornecedor: TLabel;
    lblProspecto: TLabel;
    tmrKeyDown: TTimer;
    Shape1: TShape;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure pOnClick(Sender: TObject);
    procedure pnlClienteMouseEnter(Sender: TObject);
    procedure pnlProspectoMouseEnter(Sender: TObject);
    procedure pnlFornecedorMouseEnter(Sender: TObject);
    procedure tmrKeyDownTimer(Sender: TObject);
  private
    { Private declarations }
    pnlFoco: TPanel;
    procedure pFocarAnterior;
    procedure pFocarProximo;
    procedure pSetaPanelFoco(pnlFocar: TPanel);
  public
    { Public declarations }
    blnConfirma: Boolean;
    intOpcaoSel: Integer;

    function CountOpcoesCRM: Integer;
    function RetornaUnicaOpcao: Integer;
  end;

implementation

uses Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCliForCRM.pOnClick(Sender: TObject);
begin
  inherited;
  If Assigned(Sender) And TcxImage(Sender).Enabled Then
  Begin
    intOpcaoSel := TComponent(Sender).Tag;
    blnConfirma := True;
    Close;
  End;
end;

function TfrmCliForCRM.CountOpcoesCRM: Integer;
begin
  Result := 0;
  If pnlCliente.Enabled    Then Inc(Result);
  If pnlProspecto.Enabled  Then Inc(Result);
  If pnlFornecedor.Enabled Then Inc(Result);
end;

procedure TfrmCliForCRM.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  intOpcaoSel := -1;
  pSetaPanelFoco(pnlCliente);
end;

procedure TfrmCliForCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pOnClick(pnlFoco);
  End;
end;

procedure TfrmCliForCRM.pFocarAnterior;
begin
  If pnlFoco = pnlCliente Then
    pSetaPanelFoco(pnlFornecedor)
  Else If pnlFoco = pnlProspecto Then
    pSetaPanelFoco(pnlCliente)
  Else If pnlFoco = pnlFornecedor Then
    pSetaPanelFoco(pnlProspecto);
end;

procedure TfrmCliForCRM.pFocarProximo;
begin
  If pnlFoco = pnlCliente Then
    pSetaPanelFoco(pnlProspecto)
  Else If pnlFoco = pnlProspecto Then
    pSetaPanelFoco(pnlFornecedor)
  Else If pnlFoco = pnlFornecedor Then
    pSetaPanelFoco(pnlCliente);
end;

procedure TfrmCliForCRM.pnlClienteMouseEnter(Sender: TObject);
begin
  inherited;
  pSetaPanelFoco(pnlCliente);
end;

procedure TfrmCliForCRM.pnlFornecedorMouseEnter(Sender: TObject);
begin
  inherited;
  pSetaPanelFoco(pnlFornecedor);
end;

procedure TfrmCliForCRM.pnlProspectoMouseEnter(Sender: TObject);
begin
  inherited;
  pSetaPanelFoco(pnlProspecto);
end;

procedure TfrmCliForCRM.pSetaPanelFoco(pnlFocar: TPanel);
begin
  If pnlFoco = pnlFocar Then
    Exit;

  tmrKeyDown.Enabled := False;

  If pnlFoco <> nil Then
  Begin
    pnlFoco.BorderStyle := bsNone;
    pnlFoco.BevelOuter  := bvNone;
  End;

  pnlFocar.BorderStyle := bsSingle;
  pnlFocar.BevelOuter  := bvRaised;

  pnlFoco := pnlFocar;

  tmrKeyDown.Enabled := True;
end;

function TfrmCliForCRM.RetornaUnicaOpcao: Integer;
begin
  If pnlCliente.Enabled Then
    Result := pnlCliente.Tag

  Else If pnlProspecto.Enabled Then
    Result := pnlProspecto.Tag

  Else If pnlFornecedor.Enabled Then
    Result := pnlFornecedor.Tag

  Else
    Result := -1;
end;

procedure TfrmCliForCRM.tmrKeyDownTimer(Sender: TObject);
begin
  inherited;
  If fKeyIsDown(VK_LEFT) Or fKeyIsDown(VK_UP) Then
    pFocarAnterior
  Else If fKeyIsDown(VK_RIGHT) Or fKeyIsDown(VK_DOWN) Then
    pFocarProximo
  Else If fKeyIsDown(VK_ESCAPE) Then
  Begin
    tmrKeyDown.Enabled := False;
    Self.Close;
  End;
end;

end.
