unit untFatDigRomaneioLoteSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmFatDigRomaneioLoteSeparacao = class(TfrmPaiConfirma)
    Label1: TLabel;
    edtNumLot: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function fLoteEncontrado: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  Uni, untFuncoesSimples;

{$R *.dfm}

{ TfrmFatDigRomaneioLoteSeparacao }

procedure TfrmFatDigRomaneioLoteSeparacao.btnConfirmaClick(Sender: TObject);
begin
  if (Not fVerificaCampos) Then
    Exit;

  If (fMensagem('', 'Deseja realmente limpar a separação de todos os pedidos do lote de separação de romaneio ' + edtNumLot.Text + '?', ['&Sim', '&Não'], 1) = 2) Then
    Exit;

  inherited;
end;

procedure TfrmFatDigRomaneioLoteSeparacao.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatDigRomaneioLoteSeparacao.fLoteEncontrado: Boolean;
begin
  Result := not fEmptyStr(fCampoTabela('AUTOINCREM', 'ROMLGE', ['RLG_NUMLOT', 'RLG_CODEMP'], [edtNumLot.Text, VS_strCodEmp]));

  if not Result then
    fMensagem('ATENÇÃO!', 'Lote de Separação não encontrado!', ['&O k']);

end;

procedure TfrmFatDigRomaneioLoteSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumLot);
end;

function TfrmFatDigRomaneioLoteSeparacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumLot) Then
    Begin

      If fEmptyStr(edtNumLot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Nº do Lote!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Not fLoteEncontrado Then
          Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
