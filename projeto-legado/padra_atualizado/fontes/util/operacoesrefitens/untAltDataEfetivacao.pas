unit untAltDataEfetivacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus,
  untFuncoesSimples;

type
  TfrmAltDataEfetivacao = class(TfrmPaiConfirma)
    Label1: TLabel;
    mskDtaPre: TMaskEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Function fMudaDataEfetivacao(dtaDtaOld, dtaDtaNew: TDateTime): Boolean;


  public
    { Public declarations }

    dtaDtaPre: TDateTime;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmAltDataEfetivacao: TfrmAltDataEfetivacao;

implementation

{$R *.dfm}

Uses
  Uni;

Function TfrmAltDataEfetivacao.fMudaDataEfetivacao(dtaDtaOld, dtaDtaNew: TDateTime): Boolean;
  Var
    qryPreIte: TUniQuery;
Begin

  Try
    qryPreIte := fCriaQuery;

    With qryPreIte, SQL Do
    Begin
      Add('UPDATE PREITE SET ');
      Add('  PRE_DTAPRE = :DTANEW');
      Add('WHERE ');
      Add(' PRE_DTAPRE = :DTAOLD AND ');
      Add(' PRE_CODEMP = :CODEMP');

      ParamByName('DTAOLD').AsDateTime := dtaDtaOld;
      ParamByName('DTANEW').AsDateTime := dtaDtaNew;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;

      ExecSQL;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmAltDataEfetivacao.fMudaDataEfetivacao]');
    End;
  End;

  FreeAndNil(qryPreIte);
End;

procedure TfrmAltDataEfetivacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

  If modalResult = mrOk Then
  Begin

    If fVerificaCampos And fPergunta('Confirma a alteração da data de efetivação para ' + mskDtaPre.Text + '?') Then
    Begin

      If fMudaDataEfetivacao(dtaDtaPre, StrToDate(mskDtaPre.Text)) Then
        pMensagemOk('Alteração realizada com sucesso!')
      Else
        Action := caNone;

    End

    Else
      Action := caNone;

  End;

end;

function TfrmAltDataEfetivacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaPre) Then
    Begin

      If StrToDateDef(mskDtaPre.Text, -1) = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Data inválida!', ['&O k']);
        Result := False;
      End

      Else If fEmptyStr(fTiraCaracEspeciais(mskDtaPre.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If (StrToDate(mskDtaPre.Text) < VS_Date) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data não pode ser menor que a Data Atual!', ['&O k']);
        Result := False;
      End

      Else If dtaDtaPre = StrToDate(mskDtaPre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A efetivação já está agendada para essa data!', ['&O k']);
        Result := False;
      End;

      If Result Then
        mskDtaPre.Text := FormatDateTime('DD/MM/YYYY', StrToDate(mskDtaPre.Text));
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
