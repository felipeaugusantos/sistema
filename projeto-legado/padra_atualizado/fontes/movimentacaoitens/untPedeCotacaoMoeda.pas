unit untPedeCotacaoMoeda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus;

type
  TInfoCotacao = (infoNFE, infoPedidoEmDolar, infoItemEmDolar, infoNaoPedirCotacao);

  TfrmPedeCotacaoMoeda = class(TfrmPaiConfirma)
    lblCotDol: TLabel;
    edtCotDol: TEditFocus;
    mmoNotifica: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    infCotacao: TInfoCotacao;

    Class function fPedeCotacaoMoeda(Var fltCotMoe: Double; infCotacao: TInfoCotacao): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmPedeCotacaoMoeda.FormCreate(Sender: TObject);
  Var
    fltCotacao: Double;
begin
  inherited;

  fltCotacao     := fCampoTabela('MOE_DOLVEN', 'CADMOE', ['MOE_DTAMOE'], [VS_Date]);
  edtCotDol.Text := FormatFloat(fMskDigitos(4), fltCotacao);
end;

procedure TfrmPedeCotacaoMoeda.FormShow(Sender: TObject);
begin
  inherited;

  Case infCotacao Of
    infoNFE:           Begin
                         mmoNotifica.Lines.Add('');
                         mmoNotifica.Lines.Add(' O pedido de compra está em dólar.');
                         mmoNotifica.Lines.Add(' Será necessário informar a cotação do dólar para a comparação de preços.');

                         If fCfgSis('ATPRAU', varBoolean) Then
                         Begin
                           mmoNotifica.Lines.Add(' Posteriormente a cotação poderá ser utilizada para possível atualização de preços');
                           mmoNotifica.Lines.Add(' de produtos que estejam cadastrados em dólar.');
                         End;
                       end;

    infoPedidoEmDolar: Begin
                         mmoNotifica.Lines.Add('');
                         mmoNotifica.Lines.Add(' Há pedido(s) de compra em dólar.');
                         mmoNotifica.Lines.Add(' Será necessário informar a cotação do dólar para a conversão dos valores em Real.');
                       end;

    infoItemEmDolar: Begin
                       mmoNotifica.Lines.Add('');
                       mmoNotifica.Lines.Add(' Há produtos cadastrados em dólar.');
                       mmoNotifica.Lines.Add(' Será necessário informar a cotação do dólar para possível atualização de preços.');
                     end;
  End;

  pSetFocus(edtCotDol);
end;

function TfrmPedeCotacaoMoeda.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCotDol) Then
    Begin

      If fStrToFloat(edtCotDol.Text) <= 0 Then
      Begin
        pMensagemOk('A cotação do dólar deve ser maior que zero!');
        Result := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Class function TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(Var fltCotMoe: Double; infCotacao: TInfoCotacao): Boolean;
  Var
    frmPedeCotacaoMoeda: TfrmPedeCotacaoMoeda;
Begin
  pCriarFormularios(TfrmPedeCotacaoMoeda, frmPedeCotacaoMoeda);

  frmPedeCotacaoMoeda.infCotacao := InfCotacao;

  If frmPedeCotacaoMoeda.ShowModal = mrOk Then
  Begin
    Result    := True;
    fltCotMoe := fStrToFloat(frmPedeCotacaoMoeda.edtCotDol.Text);
  End Else
  Begin
    Result := False;
    fltCotMoe := 0;
  End;

  pFreeAndNil(frmPedeCotacaoMoeda);
End;


end.
