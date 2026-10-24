unit untCustosVariaveis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmCustosVariaveis = class(TfrmPai)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblProduto: TLabel;
    lblReferencia: TLabel;
    Label5: TLabel;
    lblTitBocaDeCaixa: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblBocaDeCaixa: TLabel;
    lblIcms: TLabel;
    lblImpostosFederais: TLabel;
    lblDespesasOperacionais: TLabel;
    lblUnidade: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
  private
    { Private declarations }
  public
    class procedure pMostra(strCodProduto, strDescProduto, strUnidade, strReferencia: String; fltBocaCaixa, fltIcms, fltImpFed, fltDesOpe: Double);
  end;

var
  frmCustosVariaveis: TfrmCustosVariaveis;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmCustosVariaveis }

class procedure TfrmCustosVariaveis.pMostra(strCodProduto, strDescProduto,
  strUnidade, strReferencia: String; fltBocaCaixa, fltIcms, fltImpFed, fltDesOpe: Double);
begin
  pCriarFormularios(TfrmCustosVariaveis, frmCustosVariaveis);
  Try
    frmCustosVariaveis.lblProduto.Caption := strCodProduto + ' - ' + strDescProduto;
    frmCustosVariaveis.lblUnidade.Caption := strUnidade;
    frmCustosVariaveis.lblReferencia.Caption := strReferencia;
    frmCustosVariaveis.lblTitBocaDeCaixa.Caption := fCfgSis('DOVCPP', varString);
    frmCustosVariaveis.lblBocaDeCaixa.Caption := FormatFloat('0.00', fltBocaCaixa);
    frmCustosVariaveis.lblIcms.Caption := FormatFloat('0.00', fltIcms);
    frmCustosVariaveis.lblImpostosFederais.Caption := FormatFloat('0.00', fltImpFed);
    frmCustosVariaveis.lblDespesasOperacionais.Caption := FormatFloat('0.00', fltDesOpe);

    frmCustosVariaveis.ShowModal;
  Finally
    FreeAndNil(frmCustosVariaveis);
  End;
end;

end.
