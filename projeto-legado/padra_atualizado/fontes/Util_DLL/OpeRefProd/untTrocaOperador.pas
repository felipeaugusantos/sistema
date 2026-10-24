unit untTrocaOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untFuncoesConsulta, untTypesSistema, untFuncoesSimples, untConsultas;

type
  TfrmTrocaOperador = class(TfrmPaiConfirma)
    Label1: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    pnlBotoesSQLTrace: TPanel;
    btnIniciarSQLTrace: TSpeedButton;
    btnPausarSQLTrace: TSpeedButton;
    btnSalvarSQLTrace: TSpeedButton;
    lblNSQLTrace: TLabel;
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  private
    { Private declarations }
  public
    class function fChamaTelaTrocaOperador(strOperadorOriginal: String): String;
    { Public declarations }
  end;

var
  frmTrocaOperador: TfrmTrocaOperador;

implementation


{$R *.dfm}

procedure TfrmTrocaOperador.btnSairClick(Sender: TObject);
begin
  edtCodOpe.Text := '';
  inherited;

end;

procedure TfrmTrocaOperador.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
var arrCodOpe: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self,
                   edtCodOpe,
                   edtDesOpe,
                   Nil,
                   Key,
                   arrCodOpe,
                   False, {blnConSim}
                   False, // blnAtivos: Boolean = False;                   {* Somente Operadores Ativos                   *}
                   False, // blnGerentes: Boolean = False;                 {* Somente Operadores Gerentes                 *}
                   False, // blnMecanicos: Boolean = False;                {* Somente Operadores Mecânicos                *}
                   False, // blnVenRepre: Boolean = False;                 {* Somente Vendedor Interno/Representante Externo *}
                   True) Then //blnCompradores
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

class function TfrmTrocaOperador.fChamaTelaTrocaOperador(strOperadorOriginal: String): String;
var frmTroca: TfrmTrocaOperador;
begin
  pCriarFormularios(TfrmTrocaOperador, frmTroca);
  Try
    frmTroca.ShowModal;
    Result := frmTroca.edtCodOpe.text;
    If fEmptyStr(Result) Then
      result :=  strOperadorOriginal
  Finally
    FreeAndNil(frmTroca);
  End;
end;

function TfrmTrocaOperador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Sender = edtCodOpe Then
  Begin
    If fEmptyStr(edtCodOpe.Text) Then
      edtDesOpe.Clear
    Else
    Begin
      edtDesOpe.Text := fRetNomeOperador(edtCodOpe.Text);
      If fEmptyStr(edtDesOpe.Text) Then
      begin
        pMensagemOk('Operador não encontrado!');
        Result := false;
      end;
    End;
  end;
end;

end.
