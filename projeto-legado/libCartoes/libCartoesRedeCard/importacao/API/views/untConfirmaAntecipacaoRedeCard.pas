unit untConfirmaAntecipacaoRedeCard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untLibCartoesPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, System.StrUtils,

  untTRedeCardFuncoes;

type
  TfrmConfirmaAntecipacaoRedeCard = class(TfrmPai)
    pnlRecebaHoje: TPanel;
    pnlTotais: TPanel;
    lblContinuarHoje: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Panel2: TPanel;
    lblContinuarUtil: TPanel;
    Label20: TLabel;
    Panel4: TPanel;
    Label12: TLabel;
    lblHoje: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    pnlTotalTaxa: TPanel;
    pnlTotalAntecipacao: TPanel;
    Label22: TLabel;
    lblTotalAntecipado: TLabel;
    Label24: TLabel;
    pnlTotalDesconto: TPanel;
    Label1: TLabel;
    lblTotalDesconto: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    lblTotalTaxa: TLabel;
    Label7: TLabel;
    pnlTotalAntecipacaoUtil: TPanel;
    Label2: TLabel;
    lblTotalAntecipadoUtil: TLabel;
    Label26: TLabel;
    pnlTotalLiquidoUtil: TPanel;
    pnlTotalDescontoUtil: TPanel;
    Label6: TLabel;
    lblTotalDescontoUtil: TLabel;
    Label28: TLabel;
    pnlTotalTaxaUtil: TPanel;
    Label5: TLabel;
    lblTotalTaxaUtil: TLabel;
    Label9: TLabel;
    Label18: TLabel;
    lblTotalLiquidoUtil: TLabel;
    pnlTotalLiquido: TPanel;
    Label8: TLabel;
    lblTotalLiquido: TLabel;
    Panel3: TPanel;
    lblPrazoHoje: TLabel;
    Panel5: TPanel;
    procedure FormShow(Sender: TObject);
    procedure lblContinuarHojeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblContinuarUtilClick(Sender: TObject);
  private
    { Private declarations }
    FContinuar: Boolean;
    FProximoDiaUtil:Boolean;
    function RetornaMensagemLiberacao(ADiaUtil:Boolean): String;
  public
    { Public declarations }
    property Continuar : Boolean  Read FContinuar;
    property ProximoDiaUtil : Boolean  Read FProximoDiaUtil;
  end;

implementation

{$R *.dfm}

procedure TfrmConfirmaAntecipacaoRedeCard.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmConfirmaAntecipacaoRedeCard.FormShow(Sender: TObject);
begin
  inherited;
  FContinuar := False;
  FProximoDiaUtil := False;

  If (TRedeCardFuncoes.RetornaHoraServidor > StrToTime('14:20:00')) Then
  Begin
    lblPrazoHoje.Font.Color := clRed;
    lblHoje.Font.Color := clRed;
  End;
end;

procedure TfrmConfirmaAntecipacaoRedeCard.lblContinuarHojeClick(Sender: TObject);
begin
  inherited;


  If (TRedeCardFuncoes.RetornaHoraServidor > StrToTime('14:20:00')) Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'Depois das 14h:20, só será possível solicitar a'+
                                           ' antecipação para receber em até 1 dia útil.', ['&O k']);
    Exit;
  End;


  If TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'A simulação será efetivada e o valor será antecipado.' +#13#10+
                                            'Deseja realmente continuar?',['&Sim', '&Não'],2) = 2 Then
  Exit;


  If Not VS_FuncoesExternas.fIPedirLiberacao('PEREFEANTREDCARD',
                                             'Efetivar Antecipação RedeCard',
                                             RetornaMensagemLiberacao(False)) Then
    Exit;

  FContinuar := True;
  FProximoDiaUtil := False;
  btnSair.Click;
end;

procedure TfrmConfirmaAntecipacaoRedeCard.lblContinuarUtilClick(
  Sender: TObject);
begin
  inherited;
  If TRedeCardFuncoes.fMensagem('ATENÇÃO!', 'A simulação será efetivada e o valor será antecipado.' +#13#10+
                                            'Deseja realmente continuar?',['&Sim', '&Não'],2) = 2 Then
  Exit;

  If Not VS_FuncoesExternas.fIPedirLiberacao('PEREFEANTREDCARD',
                                             'Efetivar Antecipação RedeCard',
                                             RetornaMensagemLiberacao(True)) Then
    Exit;

  FContinuar := True;
  FProximoDiaUtil := True;
  btnSair.Click;
end;

function TfrmConfirmaAntecipacaoRedeCard.RetornaMensagemLiberacao(ADiaUtil: Boolean): String;
  Var
    LMensagem : String;
begin

  If ADiaUtil Then
  Begin
    LMensagem := 'Receba no próximo dia Útil' + #13 + #13;

    LMensagem := LMensagem + 'Total Antecipado: '+ lblTotalAntecipadoUtil.Caption + #13;
    LMensagem := LMensagem + 'Total Desconto..: '+ lblTotalDescontoUtil.Caption + #13;
    LMensagem := LMensagem + 'Taxa Aplicada...: '+ lblTotalTaxaUtil.Caption + #13;
    LMensagem := LMensagem + 'Total Líquido...: '+ lblTotalLiquidoUtil.Caption;
  End
  Else
  Begin
    LMensagem := 'Receba hoje na sua conta' + #13 + #13;

    LMensagem := LMensagem + 'Total Antecipado: '+ lblTotalAntecipado.Caption + #13;
    LMensagem := LMensagem + 'Total Desconto..: '+ lblTotalDesconto.Caption + #13;
    LMensagem := LMensagem + 'Taxa Aplicada...: '+ lblTotalTaxa.Caption + #13;
    LMensagem := LMensagem + 'Total Líquido...: '+ lblTotalLiquido.Caption;

  End;

  Result := AnsiReplaceStr(LMensagem,'R$ ','');

end;

end.
