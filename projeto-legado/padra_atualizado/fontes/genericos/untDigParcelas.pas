unit untDigParcelas;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, ExtCtrls, DateUtils,
  Mask, MaskEditFocus, StrUtils, Menus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Vcl.Buttons, untTypesSistema;

type
  TfrmDigParcelas = class(TfrmPaiSimples)
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    mskParc13: TMaskEditFocus;
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
    FstrCodCli: String;

    procedure pCarregaDatas;
    function fDataExiste(strData: String): Boolean;
    function fValidaVencimentoParcela(dtaVenc: TDateTime; strDiaMes,
      strDiaFix: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  published
    property strCodCli: String read FstrCodCli write FstrCodCli;
  public
    { Public declarations }
    intQtdPar: Integer;
    strCndPag: String;
    dtaDtaBas: TDateTime;
    blnConfirma: Boolean;
  end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmDigParcelas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSalvar);
end;

function TfrmDigParcelas.fDataExiste(strData: String): Boolean;
  Var
    intContador : Integer;
begin
  Result := False;

  For intContador := 0 to Pred(intQtdPar) Do
    If TMaskEditFocus(FindComponent('mskParc' + fStrZero(Succ(intContador), 2))).Text = strData Then
    Begin
      Result := True;
      Exit;
    End;
End;

function TfrmDigParcelas.fValidaVencimentoParcela(dtaVenc: TDateTime; strDiaMes: String; strDiaFix: String): Boolean;
  Var
    intDiaSem : Integer;
    strDiaAtu : String;
begin
  If strDiaMes <> '' Then
  Begin
    strDiaAtu := IntToStr(DayOf(dtaVenc));
    Result := fDiaAtualEstaEmDiasCadastrados(strDiaMes, strDiaAtu);

    If (DayOf(dtaVenc) = DaysInMonth(dtaVenc)) and (Pos('31', strDiaMes) > 0) Then
      Result := True;
  End
  Else
  Begin
    intDiaSem := DayOfWeek(dtaVenc);
    Result := (intDiaSem In [2..6]) And (strDiaFix[intDiaSem -1] = 'S');
  End;

  If fDataExiste(DateToStr(dtaVenc)) Then
    Result := False;

  If dtaVenc = Date Then
    Result := False;
end;

procedure TfrmDigParcelas.pCarregaDatas;
  Var
    strDiaFix: String;
    strDiaMes: String;
    intParc: Integer;
    dtaVenc: TDateTime;
begin
  If fEmptyStr(strCodCli) Then
    Exit;

  strDiaFix := fCampoTabela('CLI_DIAFIX', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  strDiaFix := fPadR(strDiaFix, 5, 'N');

  If strDiaFix = 'NNNNN' Then
  Begin
    strDiaMes := fCampoTabela('CLI_DIAMES', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
    strDiaMes := fTransform(strDiaMes, 2);

    If fEmptyStr(strDiaMes) Then
      Exit;
  End;

  If (dtaDtaBas >= VS_Date) Then
    dtaVenc := dtaDtaBas
  Else
    dtaVenc := VS_Date;

  For intParc := 0 To Pred(intQtdPar) Do
  Begin
    While Not fValidaVencimentoParcela(dtaVenc, strDiaMes, strDiaFix) Do
      dtaVenc := IncDay(dtaVenc);

    If Not fCfgSis('FSDUDP', varBoolean) Then
    Begin
      While (fDiaDeFolga(dtaVenc, True)) Do
        dtaVenc := IncDay(dtaVenc);
    End;

    TMaskEditFocus(FindComponent('mskParc' + fStrZero(Succ(intParc), 2))).Text := DateToStr(dtaVenc);
  End;
end;


procedure TfrmDigParcelas.FormShow(Sender: TObject);
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

    If mskParc01.CanFocus Then
      pSetFocus(mskParc01);

    For intContador := intQtdPar+1 To 24 Do
    Begin
      mskTemp := (fComponentByName(pnlDados, 'mskParc' + fStrZero(IntToStr(intContador), 2)) As TMaskEdit);
      mskTemp.Enabled := False;
    End;

  End;

  pCarregaDatas;
end;

procedure TfrmDigParcelas.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigParcelas.btnSalvarClick(Sender: TObject);
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

  strCndPag := fRetornaCndPag(arrDatas, dtaDtaBas);
  blnConfirma := True;
  Close;
end;

function TfrmDigParcelas.fValidaCampos(Sender: TWinControl;
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

