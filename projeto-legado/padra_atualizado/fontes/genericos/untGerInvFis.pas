unit untGerInvFis;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZSqlMonitor, ComCtrls, ExtCtrls, DB,
  ZAbstractTable, Uni,   cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel;

type
  TfrmGerInvFis = class(TForm)
    pnlFundo: TPanel;
    tmrFecha: TTimer;
    imgGravando: TImage;
    lblGerInv: TcxLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
  private
    { Private declarations }
    blnLibera: Boolean;
    blnFecha : Boolean;
  public
    { Public declarations }
  end;

var
  frmGerInvFis: TfrmGerInvFis;

implementation

uses untFuncBoleto, untFuncoes, untfuncoesSimples, untCadIte;

{$R *.dfm}

procedure TfrmGerInvFis.FormActivate(Sender: TObject);
begin

  If blnLibera Then
  Begin
    Application.ProcessMessages;
    blnLibera := False;
    tmrFecha.Enabled := True;
    pGeraInventarioEstoque;
    blnFecha := True;

  End;

end;

procedure TfrmGerInvFis.FormCreate(Sender: TObject);
begin
  blnLibera := True;
  Self.Constraints.MaxHeight := Self.Height;
  Self.Constraints.MaxWidth  := Self.Width;
  Self.Constraints.MinHeight := Self.Height;
  Self.Constraints.MinWidth  := Self.Width;
  blnFecha := False;

end;

procedure TfrmGerInvFis.tmrFechaTimer(Sender: TObject);
begin
  if blnFecha then
    Close
  Else
  Begin
    lblGerInv.Tag := lblGerInv.Tag + 1;
    if lblGerInv.Tag > 3 Then
      lblGerInv.Tag := 0;

    lblGerInv.Caption :=  fPadR('Gerando Inventário Físico', lblGerInv.Tag, '.');

    Application.ProcessMessages;
  End;  

end;

end.

