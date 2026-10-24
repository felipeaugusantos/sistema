unit untPedePeriodoConEnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, ComCtrls, EditFocus, untControleEntregaRomaneio,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPedePeriodoConEnt = class(TfrmPaiConfirma)
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl2: TLabel;
    mskDtaFin: TMaskEditFocus;
    edtQtdPe1: TEditFocus;
    Label1: TLabel;
    prgProgesso: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objConEnt: TControleEntregaRomaneio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmPedePeriodoConEnt: TfrmPedePeriodoConEnt;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmPedePeriodoConEnt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fVerificaCampos Then
    Begin

      If (StrToDateDef(mskDtaIni.Text, 0) <= objConEnt.fUltimaData) And
         (Not fPergunta('Já existem registros nesse período. O controle será refeito, Confirma?')) Then
      Begin
        Action := caNone;
        Exit;
      End;

      Self.Enabled := False;
      If objConEnt.fIncluiPeriodo(StrToDateDef(mskDtaIni.Text, 0),
                                  StrToDateDef(mskDtaFin.Text, 0),
                                  StrToIntDef(edtQtdPe1.Text, 0),
                                  prgProgesso) Then
        pMensagemOk('Período incluido com sucesso!')
      Else
        Action := caNone;

      Self.Enabled := True;

    End

    Else Action := caNone;

  End;

end;

procedure TfrmPedePeriodoConEnt.FormShow(Sender: TObject);
  var
    dtaIniEnt: TDate;
begin
  inherited;

  dtaIniEnt := objConEnt.fUltimaData;
  If (dtaIniEnt < VS_Date) Then
    dtaIniEnt := VS_Date
  Else
    dtaIniEnt := dtaIniEnt + 1;
    
  mskDtaIni.Text := FormatDateTime('DD/MM/YYYY', dtaIniEnt);
  pSetFocus(mskDtaIni);
end;

function TfrmPedePeriodoConEnt.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('','Data Inicial deve ser preenchida!',['&O K']);
        Result := False;
      End

      Else If StrToDateDef(mskDtaIni.Text, 0) = 0 Then
      Begin
        fMensagem('','Data Inicial inválida!',['&O K']);
        Result := False;
      End

      Else If StrToDateDef(mskDtaIni.Text, 0) < VS_Date Then
      Begin
        fMensagem('','Data Inicial deve ser maior ou igual a data atual!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('','Data Final deve ser preenchida!',['&O K']);
        Result := False;
      End

      Else If StrToDateDef(mskDtaFin.Text, 0) = 0 Then
      Begin
        fMensagem('','Data Final inválida!',['&O K']);
        Result := False;
      End

      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('','Data Final deve ser maior ou igual que a Data Inicial!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtQtdPe1) Then
    Begin
      If fEmptyStr(edtQtdPe1.Text) Then
        edtQtdPe1.Text := '0';

      If StrToIntDef(edtQtdPe1.Text, -1) < 0 Then
      Begin
        fMensagem('','A quantidade de entregas deve ser maior ou igual a zero!',['&O K']);
        Result := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
