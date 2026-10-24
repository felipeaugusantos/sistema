unit AgrupamentoDeOndaDeSeparacao.Impressao.Vias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, QColorLabel;

type
  TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias = class(TfrmPaiConfirma)
    lblSaidaVideoImpressora: TColorLabel;
    edtSaida: TEditFocus;
    lblSaida: TLabel;
    edtQtdVias: TEditFocus;
    lblQtdVias: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  const
    VIDEO      = 'V';
    IMPRESSORA = 'I';
  private
    FQtdVias   : Integer;
    FTipoSaida : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    property QtdVias   : Integer Read FQtdVias;
    property TipoSaida : String  Read FTipoSaida;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  FQtdVias := 1;

  If Not fEmptyStr(edtQtdVias.Text) Then
    FQtdVias := StrToInt(edtQtdVias.Text);

  FTipoSaida := edtSaida.Text;

end;

procedure TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias.FormCreate(Sender: TObject);
begin
  inherited;
  FQtdVias   := 1;
  FTipoSaida := IMPRESSORA;
end;

function TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtSaida) Then
    Begin

      If fEmptyStr(edtSaida.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Saída não pode ser vazio!', ['&Ok']);
        Result := False;
      End

      Else If (Pos(edtSaida.Text, 'V_I_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Saída deve ser preenchido com ''V'' ou ''I''!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtQtdVias) Then
    Begin

      If fEmptyStr(edtQtdVias.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Qtd. Vias não pode ser vazio!', ['&Ok']);
        Result := False;
      End

      Else If (StrToInt(edtQtdVias.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Qtd. Vias não pode ser preenchido com valores negativos/zero!', ['&Ok']);
        Result := False;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.
