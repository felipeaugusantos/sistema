unit untDigParcelasReneg;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, StrUtils, Menus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untfuncoesSimples, untTypesSistema;

type
  TfrmDigParcelasReneg = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    lblQtdPar: TLabel;
    lblParc01: TLabel;
    mskParc01: TMaskEditFocus;
    lblParc02: TLabel;
    mskParc02: TMaskEditFocus;
    lblParc03: TLabel;
    mskParc03: TMaskEditFocus;
    lblParc04: TLabel;
    mskParc04: TMaskEditFocus;
    lblParc05: TLabel;
    mskParc05: TMaskEditFocus;
    lblParc06: TLabel;
    mskParc06: TMaskEditFocus;
    lblParc07: TLabel;
    mskParc07: TMaskEditFocus;
    lblParc08: TLabel;
    mskParc08: TMaskEditFocus;
    lblParc09: TLabel;
    mskParc09: TMaskEditFocus;
    lblParc10: TLabel;
    mskParc10: TMaskEditFocus;
    lblParc11: TLabel;
    mskParc11: TMaskEditFocus;
    lblParc12: TLabel;
    mskParc12: TMaskEditFocus;
    Label1: TLabel;
    pnlBotoesBaixa: TPanel;
    btnSairDig: TBitBtnLocked;
    btnSalvar: TBitBtnLocked;
    lblParc13: TLabel;
    mskParc13: TMaskEditFocus;
    lblParc14: TLabel;
    lblParc15: TLabel;
    lblParc16: TLabel;
    lblParc17: TLabel;
    lblParc18: TLabel;
    lblParc19: TLabel;
    lblParc20: TLabel;
    lblParc21: TLabel;
    lblParc22: TLabel;
    lblParc23: TLabel;
    lblParc24: TLabel;
    mskParc14: TMaskEditFocus;
    mskParc15: TMaskEditFocus;
    mskParc16: TMaskEditFocus;
    mskParc17: TMaskEditFocus;
    mskParc18: TMaskEditFocus;
    mskParc19: TMaskEditFocus;
    mskParc20: TMaskEditFocus;
    mskParc21: TMaskEditFocus;
    mskParc22: TMaskEditFocus;
    mskParc23: TMaskEditFocus;
    mskParc24: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intQtdPar: Integer;
    strCndPag: String;
    dtaDtaBas: TDateTime;
    blnConfirma: Boolean;
  end;

var
  frmDigParcelasReneg: TfrmDigParcelasReneg;

implementation


{$R *.dfm}

procedure TfrmDigParcelasReneg.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSalvar);
end;

procedure TfrmDigParcelasReneg.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    mskTemp: TMaskEdit;
begin
  inherited;

  blnConfirma := False;

  If (intQtdPar <= 0) Then
  Begin
    fMensagem('', 'Escolha uma ou mais parcelas!', ['&O k']);
    Close;
  End
  Else
  Begin

    lblQtdPar.Caption := fStrZero(IntToStr(intQtdPar), 2);
    pSetFocus(mskParc01);

    For intContador := intQtdPar+1 To 24 Do
    Begin
      mskTemp := (fComponentByName(pnlDados, 'mskParc' + fStrZero(IntToStr(intContador), 2)) As TMaskEdit);
      mskTemp.Enabled := False;
    End;

  End;

end;

procedure TfrmDigParcelasReneg.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigParcelasReneg.btnSalvarClick(Sender: TObject);
  Var
    mskTemp    : TMaskEdit;
    intContador: Integer;
    arrDatas   : TDateArray;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  SetLength(arrDatas, intQtdPar);

  For intContador := 1 To intQtdPar Do
  Begin
    mskTemp := (fComponentByName(pnlDados, 'mskParc' + fStrZero(IntToStr(intContador), 2)) As TMaskEdit);
    arrDatas[intContador-1] := StrToDate(mskTemp.Text);
  End;

  strCndPag   := fRetornaCndPag(arrDatas, dtaDtaBas);

  blnConfirma := True;
  Close;
end;

function TfrmDigParcelasReneg.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    mskTemp: TMaskEdit;
    mskAtual: TMaskEdit;
    dtaDtaAnt: TDateTime;
    dtaDtaAtu: TDateTime;
    dtaDtaIni: TDateTime;
    strEditAnt: String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskParc01) Then
    Begin
      dtaDtaIni := dtaDtaBas;
      If dtaDtaIni = 0 Then
        dtaDtaIni := VS_Date;

      If fEmptyStr(fTiraCaracEspeciais(mskParc01.Text)) Then
      Begin
        fMensagem('ATEN플O!', 'Todas as datas devem ser preenchidas!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(mskParc01.Text) < dtaDtaIni) Then
      Begin
        fMensagem('ATEN플O!', 'A primeira data deve ser maior ou igual a '+
               FormatDateTime('DD/MM/YYYY', dtaDtaIni) + '!', ['&O k']);
        Result := False;
      End;

    End
    Else If Sender.Enabled Then
    Begin

      mskAtual   := (Sender As TMaskEdit);

      strEditAnt := fStrZero(IntToStr(StrToInt(RightStr(mskAtual.Name, 2)) - 1), 2);
      mskTemp    := (fComponentByName(pnlDados, 'mskParc' + strEditAnt) As TMaskEdit);

      If fEmptyStr(fTiraCaracEspeciais(mskTemp.Text)) Then
      Begin
        fMensagem('ATEN플O!', 'Todas as datas devem ser preenchidas!', ['&O k']);
        Result := False;
        Sender := mskTemp;
      End
      Else If fEmptyStr(fTiraCaracEspeciais(mskAtual.Text)) Then
      Begin
        fMensagem('ATEN플O!', 'Todas as datas devem ser preenchidas!', ['&O k']);
        Result := False;
      End;

      If Result Then
      Begin

        dtaDtaAnt := StrToDate(mskTemp.Text);
        dtaDtaAtu := StrToDate(mskAtual.Text);

        If (dtaDtaAnt >= dtaDtaAtu) Then
        Begin
          Result := False;
        End;

      End;
      

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.

