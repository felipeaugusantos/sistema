{*********************************************************}
{* QCK DO RELATORIO DE ORDEM DE PRODUÇÃO                 *}
{*                                                       *}
{* DATA......: 24/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untQckOrdProdProg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiQck, RLPreviewForm, RLParser, RLReport;

type
  TfrmQckOrdProdProg = class(TfrmPaiQck)
    rllCliente: TRLLabel;
    rllVendedor: TRLLabel;
    rllEmpresa: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    rllObs001: TRLDBText;
    rllObs002: TRLDBText;
    rllFiltro: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    rlbTotais: TRLBand;
    RLLabel12: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    rllLinGru: TRLLabel;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDetalheBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses  untFuncoesSimples, untModuloSPR;

{$R *.dfm}

procedure TfrmQckOrdProdProg.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := strOrdem;

end;

procedure TfrmQckOrdProdProg.rlbDetalheBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  With frmModuloSPR.qryRelatorio Do
  Begin
    If fEmptyStr(FieldByName('OBS001').AsString) Then
    Begin
      rllObs001.Visible := False;
      rllObs002.Visible := False;
      rlbDetalhe.Height := 17 ;
    End
    Else
    Begin
      rllObs001.Visible := True;
      rllObs002.Visible := True;
      rlbDetalhe.Height := 34;
    End;
  End;
end;

end.
