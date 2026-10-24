unit untSolicitaLocalizacaoFisicaTransitoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Uni, Data.DB,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus;

type
  TfrmSolicitaLocalizacaoFisicaTransitoria = class(TfrmPaiConfirma)
    pnlTitulo: TPanel;
    lblMensagem: TLabel;
    pnlLocalizacao: TPanel;
    Label1: TLabel;
    edtCodigoLocalizacaoFisica: TEditFocus;
    edtDescricaoLocalizacaoFisica: TEditFocus;
    procedure edtCodigoLocalizacaoFisicaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoLocalizacaoFisicaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private

  public

  end;


implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, untCadLocFisica;

{$R *.dfm}

procedure TfrmSolicitaLocalizacaoFisicaTransitoria.edtCodigoLocalizacaoFisicaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqLocFisica(Self, edtCodigoLocalizacaoFisica, Nil, Nil, Key, arrSel, True,False, False, True) then
    fValidaCampos(edtCodigoLocalizacaoFisica, True);
end;
procedure TfrmSolicitaLocalizacaoFisicaTransitoria.edtCodigoLocalizacaoFisicaKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
  var
    frmCadLocFisica: TfrmCadLocFisica;
begin
  If (Key = VK_INSERT) Then
  Begin
    pCriarFormularios(TfrmCadLocFisica, frmCadLocFisica);
    frmCadLocFisica.blnTransitorio    := True;
    frmCadLocFisica.ShowModal;
    edtCodigoLocalizacaoFisica.Text   := frmCadLocFisica.strCodLocal;
    edtDescricaoLocalizacaoFisica.Text:= frmCadLocFisica.strDescLocal;
    FreeAndNil(frmCadLocFisica);
  End;

  inherited;

end;


function TfrmSolicitaLocalizacaoFisicaTransitoria.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  qryCADLOC : TUniQuery;
begin
  Result := True;

  try
    If (Sender = edtCodigoLocalizacaoFisica) Then
    Begin
      qryCADLOC := fCriaQuery(nil);
      try
        if fEmptyStr(edtCodigoLocalizacaoFisica.Text) then
        begin
          pMensagemOk('Informe o código da localização física');
          exit(false);
        end;

        if blnBuscaPorChave then
          edtDescricaoLocalizacaoFisica.Clear;

        qryCADLOC.SQL.Add('SELECT                                        ');
        qryCADLOC.SQL.Add('  LOC_DESCRI,                                 ');
        qryCADLOC.SQL.Add('  LOC_TRANSI                                  ');
        qryCADLOC.SQL.Add('FROM                                          ');
        qryCADLOC.SQL.Add('  CADLOC                                      ');
        qryCADLOC.SQL.Add('WHERE LOC_CODLOC = :CODIGO_LOCALIZACAO_FISICA ');
        qryCADLOC.SQL.Add('  AND LOC_CODEMP = :CODIGO_EMPRESA            ');

        qryCADLOC.ParamByName('CODIGO_EMPRESA').AsString := VS_strCodEmp;
        qryCADLOC.ParamByName('CODIGO_LOCALIZACAO_FISICA').AsString := edtCodigoLocalizacaoFisica.Text;
        qryCADLOC.Open;

        if qryCADLOC.isEmpty then
        begin
          pMensagemOk('Localização física não encontrada!');
          Exit(False);
        end
        else if qryCADLOC.FieldByName('LOC_TRANSI').AsString <> 'S' then
        begin
          pMensagemOk('A localização física informada não é transitória!');
          Exit(False);
        end;

        if blnBuscaPorChave then
        begin
          edtDescricaoLocalizacaoFisica.Text := qryCADLOC.FieldByName('LOC_DESCRI').AsString;
          blnMudarFoco := False;
          pSetFocus(btnConfirma);
        end;

        qryCADLOC.Close;

      finally
        FreeAndNil(qryCADLOC);
      end;



    end;

  finally

    If Not Result Then
      pSetFocus(Sender);

  end;

end;

end.
