unit untAltPrecoDigData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  AppEvnts, EditFocus, BitBtnLockedIncrem;

type
  TfrmAltPrecoDigData = class(TfrmPai)
    pnl1: TPanel;
    mskDtaPre: TMaskEditFocus;
    lblTitulo: TLabel;
    rdbDtaPre: TRadioButton;
    rdbTabDin: TRadioButton;
    edtDescri: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbDtaPreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dtaData    :TDateTime;
    blnPorDta  : Boolean;
    blnConfirma: Boolean;
  end;

var
  frmAltPrecoDigData: TfrmAltPrecoDigData;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmAltPrecoDigData.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaPre);

  mskDtaPre.Text := DateToStr(VS_Date);
end;

procedure TfrmAltPrecoDigData.rdbDtaPreClick(Sender: TObject);
begin
  inherited;
  If rdbDtaPre.Checked Then
  Begin
    lblTitulo.Caption := 'Data de Previsão';
    mskDtaPre.Visible := True;
    edtDescri.Visible := False;
    pSetFocus(mskDtaPre);
  End
  Else
  Begin
    lblTitulo.Caption := 'Descrição';
    mskDtaPre.Visible := False;
    edtDescri.Visible := True;
    pSetFocus(edtDescri);
  End;
end;

procedure TfrmAltPrecoDigData.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If rdbDtaPre.Checked Then
  Begin
    If (StrToDate(mskDtaPre.Text) < VS_Date) Then
    Begin
      fMensagem('Atenção', 'Não é permitido datas anteriores à hoje',['&OK']);
      pSetFocus(mskDtaPre);
    End
    Else
    Begin
      blnConfirma := True;
      dtaData     := StrToDate(mskDtaPre.Text);
      blnPorDta   := True;
      Self.Close;
    End;
  End
  Else
  Begin
    If fEmptyStr(edtDescri.Text) Then
    Begin
      fMensagem('Atenção', 'Informe uma Descrição para a Tabela',['&OK']);
      pSetFocus(edtDescri);
    End
    Else
    Begin
      blnPorDta   := False;
      blnConfirma := True;
      Self.Close;
    End;
  End;
end;

procedure TfrmAltPrecoDigData.FormCreate(Sender: TObject);
begin
  inherited;
  If fCfgSis('TABDIN', varBoolean) Then
  Begin
    rdbDtaPre.Visible := True;
    rdbTabDin.Visible := True;
  End
  Else
  Begin
    rdbDtaPre.Visible := False;
    rdbTabDin.Visible := False;
  End;
end;

procedure TfrmAltPrecoDigData.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSairClick(Sender);
end;

procedure TfrmAltPrecoDigData.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.


