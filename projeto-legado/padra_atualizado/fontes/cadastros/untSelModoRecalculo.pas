unit untSelModoRecalculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untTypesTabelaPreco;

type
  TfrmSelModoRecalculo = class(TfrmPaiConfirma)
    rdgTipAltGer: TRadioGroup;
    rdgOpcRecalc: TRadioGroup;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    blnConfirmado: Boolean;
    { Public declarations }
    class function fSelecionaModoRecalculo: TOpcRecalculoTabelas;
  end;

var
  frmSelModoRecalculo: TfrmSelModoRecalculo;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmSelModoRecalculo }

procedure TfrmSelModoRecalculo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirmado := True;
end;

procedure TfrmSelModoRecalculo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmado := False;
end;

procedure TfrmSelModoRecalculo.FormShow(Sender: TObject);
begin
  inherited;
  If fCfgSis('FORCAL') ='P' Then
    frmSelModoRecalculo.rdgTipAltGer.ItemIndex := 0
  Else
    frmSelModoRecalculo.rdgTipAltGer.ItemIndex := 1;
end;

class function TfrmSelModoRecalculo.fSelecionaModoRecalculo: TOpcRecalculoTabelas;
begin
  Result.TipoCalculoMargemPreven := tcmNaoDefinido;
  pCriarFormularios(TfrmSelModoRecalculo, frmSelModoRecalculo);
  Try
     frmSelModoRecalculo.ShowModal;
     If frmSelModoRecalculo.blnConfirmado Then
     begin
       if frmSelModoRecalculo.rdgTipAltGer.ItemIndex = 0 then
         Result.TipoCalculoMargemPreven := tcmVenda
       Else
         Result.TipoCalculoMargemPreven := tcmMargem;

       if frmSelModoRecalculo.rdgOpcRecalc.ItemIndex = 0 then
         Result.OpcTabelasReprocessa := topctrTodas
       Else
         Result.OpcTabelasReprocessa := topctrApenasAtivas;
     End;
  Finally
     FreeAndNil(frmSelModoRecalculo);
  End;
end;

end.
