unit untDigDataMsk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus;

type
  TfrmDigDataMsk = class(TfrmPai)
    btnConfirmar: TBitBtnLocked;
    lblData: TLabel;
    edtData: TMaskEditFocus;
    procedure btnConfirmarClick(Sender: TObject);

  private
    { Private declarations }
  protected
     function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    public dtaDataMin: TDate;
    public dtaDataMax: TDate;

    class function fDigDataMsk(Var dtaData: TDateTime; strCaption, strCaptionLabel: String; dtaDtaMin: TDateTime = 0; dtaDtaMax: TDateTime = 0): Boolean;
    class function fDigDataMskVal(Var dtaData: TDateTime; strCaption, strCaptionLabel: String; dtaDtaMin: TDateTime = 0; dtaDtaMax: TDateTime = 0): Boolean;

    { Public declarations }
  end;

var
  frmDigDataMsk: TfrmDigDataMsk;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigDataMsk.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

class function TfrmDigDataMsk.fDigDataMsk(var dtaData: TDateTime; strCaption, strCaptionLabel: String; dtaDtaMin, dtaDtaMax: TDateTime): Boolean;
Begin

  If dtaData = 0 Then
    dtaData := VS_Date;

  Try
    pCriarFormularios(TfrmDigDataMsk, frmDigDataMsk);
    frmDigDataMsk.dtaDataMin      := dtaDtaMin;
    frmDigDataMsk.dtaDataMax      := dtaDtaMax;
    frmDigDataMsk.Caption         := strCaption;
    frmDigDataMsk.lblData.Caption := strCaptionLabel;

    if DateToStr(dtaData) <> '30/12/1899' then
      frmDigDataMsk.edtData.Text := FormatDateTime('dd/mm/yyyy', dtaData)
    else
      frmDigDataMsk.edtData.Text := FormatDateTime('dd/mm/yyyy', VS_Date);


    Result := (frmDigDataMsk.ShowModal = mrOk);

    If (Result) Then
      dtaData := StrToDate(frmDigDataMsk.edtData.Text);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmData]');
    End;
  End;

  pFreeAndNil(frmDigDataMsk);
end;

class function TfrmDigDataMsk.fDigDataMskVal(var dtaData: TDateTime; strCaption,
  strCaptionLabel: String; dtaDtaMin, dtaDtaMax: TDateTime): Boolean;
begin
  If dtaData = 0 Then
    dtaData := VS_Date;

  Try
    pCriarFormularios(TfrmDigDataMsk, frmDigDataMsk);
    frmDigDataMsk.dtaDataMin      := dtaDtaMin;
    frmDigDataMsk.dtaDataMax      := dtaDtaMax;
    frmDigDataMsk.Caption         := strCaption;
    frmDigDataMsk.lblData.Caption := strCaptionLabel;
    frmDigDataMsk.edtData.Tag := 99;

    if DateToStr(dtaData) <> '30/12/1899' then
      frmDigDataMsk.edtData.Text := FormatDateTime('dd/mm/yyyy', dtaData)
    else
      frmDigDataMsk.edtData.Text := FormatDateTime('dd/mm/yyyy', VS_Date);


    Result := (frmDigDataMsk.ShowModal = mrOk);

    If (Result) Then
      dtaData := StrToDate(frmDigDataMsk.edtData.Text);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmData]');
    End;
  End;

  pFreeAndNil(frmDigDataMsk);

end;


function TfrmDigDataMsk.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin
  Result := True;

  If Sender = edtData Then
  Begin
    If StrToDateDef(edtData.Text, 0) = 0 Then
      strMsg := 'Data inválida'

    Else If StrToDate(edtData.Text) < dtaDataMin Then
      strMsg := 'Data deve ser maior ou igual a '+ FormatDateTime('dd/mm/yyyy', dtaDataMin)

    Else If (dtaDataMax > 0) And (StrToDate(edtData.Text) > dtaDataMax) Then
      strMsg := 'Data deve ser menor ou igual a '+ FormatDateTime('dd/mm/yyyy', dtaDataMax);
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    fMensagem('', strMsg, ['&O k']);
    Result := False;
    pSetFocus(edtData);
  End;
end;

end.
