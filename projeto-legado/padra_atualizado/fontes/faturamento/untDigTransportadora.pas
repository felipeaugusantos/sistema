unit untDigTransportadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untDadosFechamentoPedidoTransportadoraFrame, untFuncFat;

type
  TfrmDigTransportadora = class(TfrmPaiConfirma)
    fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame;
    pnlPrincipal: TPanel;
    procedure fraTransportadoraedtValFreChange(Sender: TObject);
    procedure fraTransportadoraedtValFreEnter(Sender: TObject);
    procedure fraTransportadoraedtValFreExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private

  public
    objVenda: TFatVenda;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigTransportadora.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrNone;

  If Not fraTransportadora.fConfirmaDados Then
    Exit;

  ModalResult := mrOk;

end;

procedure TfrmDigTransportadora.FormCreate(Sender: TObject);
begin
  inherited;
  fraTransportadora.OnFormCreate;
end;

procedure TfrmDigTransportadora.FormDestroy(Sender: TObject);
begin
  inherited;
  fraTransportadora.OnFormDestroy;
end;

procedure TfrmDigTransportadora.FormShow(Sender: TObject);
begin
  inherited;
  fraTransportadora.objVenda  := objVenda;
  fraTransportadora.strCodTra := objVenda.strCodTra;

  fraTransportadora.btnCalcularFrete.Visible := False;

  fraTransportadora.OnFormShow;
end;

procedure TfrmDigTransportadora.fraTransportadoraedtValFreChange(Sender: TObject);
begin
  inherited;
  objVenda.fltValFre := fStrToFloat(fraTransportadora.edtValFre.Text);
end;

procedure TfrmDigTransportadora.fraTransportadoraedtValFreEnter(Sender: TObject);
begin
  inherited;
  fraTransportadora.pCalculaFreteSugestao;

  If fraTransportadora.blnSomenExibirSugestFrete Then
  Begin
    fraTransportadora.HintControler.ShowHint(Self.Left + fraTransportadora.edtValFre.Left + fraTransportadora.edtValFre.Width,
                                             15 + Self.Top + fraTransportadora.edtValFre.Top + fraTransportadora.edtValFre.Height,
                                             'Valor do frete sugestão: ' + FormatFloat('#,##0.00', objVenda.fltFreSug), '');
  End;

end;

procedure TfrmDigTransportadora.fraTransportadoraedtValFreExit(Sender: TObject);
begin
  inherited;
  fraTransportadora.HintControler.HideHint;
end;

function TfrmDigTransportadora.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := (inherited fValidaCampos(Sender, blnBuscaPorChave));

  If Result Then
    Result := fraTransportadora.fValidaCampos(Sender, blnBuscaPorChave);

  If Not Result Then
    pSetFocus(Sender);

end;

end.
