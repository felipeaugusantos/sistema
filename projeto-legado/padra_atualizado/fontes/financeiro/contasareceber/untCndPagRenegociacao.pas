unit untCndPagRenegociacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, MaskEditFocus, frxClass, frxExportCSVTestabilidade, untFuncoesSimples, StrUtils;

type
  TfrmCndPagRenegociacao = class(TfrmPai)
    pnlFunto: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    lblCndPag: TLabel;
    mskCndPag: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function fValidaCndPagReneg(strCndPag: String; Var strCndRet: String;  dtaDtaBas: TDateTime; blnPerRep: Boolean = False): Boolean;
    function fDigCndPagamentoReneg(Var strCndPag: String; dtaDtaBas: TDateTime): Boolean;
  private
    { Private declarations }
    strCndPag : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;


implementation

uses untDigParcelasReneg, untConstantes;

{$R *.dfm}

{ TfrmCndPagRenegociacao }

procedure TfrmCndPagRenegociacao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmCndPagRenegociacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskCndPag);
end;

procedure TfrmCndPagRenegociacao.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  mskCndPag.EditMask := MASK_CONPAG;
end;

function TfrmCndPagRenegociacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = mskCndPag) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
    Begin
      pMensagemOk('A condição de pagamento deve ser preenchida!');
      Result := False;
    End

    Else
    Begin

      If Not fValidaCndPagReneg(mskCndPag.Text, strCndPag, VS_Date) Then
      Begin
        pMensagemOk('Essa condição de pagamento não é valida!');
        Result := False;
      End
      Else
      Begin

        If fEmptyStr(strCndPag) Then
          Result := False
        Else
          mskCndPag.Text := strCndPag;

      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;


function TfrmCndPagRenegociacao.fValidaCndPagReneg(strCndPag: String; Var strCndRet: String;
  dtaDtaBas: TDateTime; blnPerRep: Boolean = False): Boolean;
begin

  strCndRet := strCndPag;

  If StrToIntDef(Trim(Copy(strCndRet, 1, 2)), 0) > 24 then
  begin
    Result := False;
    Exit;
  end;

  If (Length(Trim(fTiraCaracEspeciais(strCndRet))) = 2) And (StrToIntDef(Trim(fTiraCaracEspeciais(strCndRet)), 0) > 0) Then
  Begin

    If Not fDigCndPagamentoReneg(strCndRet, dtaDtaBas) Then
    Begin
      strCndRet := '';
      Result    := True;
      Exit;
    End;

  End;

  Result := fValidaCndPag(strCndRet, blnPerRep);

end;

function TfrmCndPagRenegociacao.fDigCndPagamentoReneg(Var strCndPag: String; dtaDtaBas: TDateTime): Boolean;
  Var
    strCndTmp: String;
    intQtdPar: Integer;
begin

  strCndTmp := Trim(fTiraCaracEspeciais(strCndPag));
  intQtdPar := 0;

  If Not fEmptyStr(Trim(LeftStr(strCndTmp, 2))) Then
    intQtdPar := StrToIntDef(Trim(LeftStr(strCndTmp, 2)), 0);

  Try

    pCriarFormularios(TfrmDigParcelasReneg, frmDigParcelasReneg);
    frmDigParcelasReneg.intQtdPar      := intQtdPar;
    frmDigParcelasReneg.mskParc01.Text := DateToStr(dtaDtaBas);
    frmDigParcelasReneg.dtaDtaBas      := dtaDtaBas;
    frmDigParcelasReneg.showModal;

    Result := frmDigParcelasReneg.blnConfirma;

    If Result Then
      strCndPag := frmDigParcelasReneg.strCndPag;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmDigParcelasReneg]');
    End;
  End;

  pFreeAndNil(frmDigParcelasReneg);

end;

end.
