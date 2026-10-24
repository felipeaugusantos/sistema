unit untUtilMenuPAFNFCe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untUtilMenuPAFNFCeIdentificacao;

type
  TfrmUtilMenuPAFNFCe = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    btnIdentificacao: TBitBtnLocked;
    btnRegistros: TBitBtnLocked;
    btnVendas: TBitBtnLocked;
    btnRequisicoes: TBitBtnLocked;
    btnControle: TBitBtnLocked;
    procedure btnIdentificacaoClick(Sender: TObject);
    procedure btnRegistrosClick(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
    procedure btnRequisicoesClick(Sender: TObject);
    procedure btnControleClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

//var
  //frmUtilMenuPAFNFCe: TfrmUtilMenuPAFNFCe;

implementation

uses
  untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmUtilMenuPAFNFCe }

procedure TfrmUtilMenuPAFNFCe.btnIdentificacaoClick(Sender: TObject);
begin
  inherited;

  pCriarForm(TfrmUtilMenuPAFNFCeIdentificacao);
end;

procedure TfrmUtilMenuPAFNFCe.btnRegistrosClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
   prcExecutaRelatorio(302, 16945, [9686,9687,9688,9689,9690,9691,9692,9693,9694,9695],
                       [],
                       [],
                       nil,
                       nil,
                       False);
  End;

end;

procedure TfrmUtilMenuPAFNFCe.btnVendasClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
   prcExecutaRelatorio(355, 16946, [9686,9695,9697,9698,9699,9700],
                       [],
                       [],
                       nil,
                       nil,
                       False);
  End;
end;

procedure TfrmUtilMenuPAFNFCe.btnRequisicoesClick(Sender: TObject);
begin
  inherited;

  {If Assigned(prcExecutaRelatorio) Then
  begin
   prcExecutaRelatorio(356, 16947, [],
                       [],
                       [],
                       nil,
                       nil,
                       False);
  End;}
  pMensagemOk('Este PAF-NFC-e não executa funções de atendimento de mesas,' + #13#10 +
            'não podendo ser utilizado por estabelecimento que necessite desse recurso.');
end;

procedure TfrmUtilMenuPAFNFCe.btnControleClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
   prcExecutaRelatorio(425, 11160, [],
                       [],
                       [],
                       nil,
                       nil,
                       False);
  End;

end;

end.

