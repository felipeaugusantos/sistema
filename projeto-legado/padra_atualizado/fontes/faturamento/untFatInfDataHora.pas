unit untFatInfDataHora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, EditFocus, Uni, AppEvnts, UniClientDataSet, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatInfDataHora = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    mskDtaSai: TMaskEditFocus;
    Label1: TLabel;
    mskHorSai: TMaskEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    dtaDataSaida: TDate;
    tmeHoraSaida: TTime;
    blnEhComplementoNF: Boolean;
    dtaDtaDocReferenciado: TDate;
    { Public declarations }
  end;

var
  frmFatInfDataHora: TfrmFatInfDataHora;

implementation

uses  untfuncoesSimples, DB;

{$R *.dfm}

procedure TfrmFatInfDataHora.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaSai.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskHorSai.Text := FormatDateTime('hh:mm:ss', fTime());
  dtaDtaDocReferenciado := VS_Date;
  blnEhComplementoNF := False;
end;

function TfrmFatInfDataHora.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (blnEhComplementoNF) Then
    Begin
      If (Sender = mskDtaSai) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaSai.Text)) Then
        Begin
          fMensagem('ATENÇÃO','A data informada deve ser preenchida!',['&OK']);
          Result := False;
        End
        Else If (StrToDateDef(mskDtaSai.Text,0) < dtaDtaDocReferenciado) Then
        Begin
          fMensagem('ATENÇÃO','A data informada não pode ser menor que a data do documento referenciado!',['&OK']);
          Result := False;
        End
        Else If ((VS_Date - fCfgSis('DRNFCC', varInteger)) > (StrToDateDef(mskDtaSai.Text,0))) Then
        Begin
          fMensagem('ATENÇÃO','A data informada não pode ser menor que a tolerância permitida "'+DateToStr(VS_Date - fCfgSis('DRNFCC', varInteger))+'" !',['&OK']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      If (Sender = mskDtaSai) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaSai.Text)) Then
        Begin
          fMensagem('ATENÇÃO','A Data de Saída deve ser preenchida!',['&OK']);
          Result := False;
        End
        Else
        Begin
          If Not fValidaPeriodo(DateToStr(VS_Date),mskDtaSai.Text) Then
          Begin
            fMensagem('ATENÇÃO','A Data de Saída deve ser maior ou igual a data atual!',['&OK']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = mskHorSai) Then
      Begin
        If StrToDateTimeDef(mskHorSai.Text, 0) = 0 Then
        Begin
          fMensagem('ATENÇÃO','Informe uma hora válida',['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatInfDataHora.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    dtaDataSaida := StrToDate(mskDtaSai.Text);
    tmeHoraSaida := StrToTime(mskHorSai.Text);
    ModalResult := mrOk;
  End;

end;

end.

