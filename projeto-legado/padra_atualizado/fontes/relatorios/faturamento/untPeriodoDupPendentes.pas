unit untPeriodoDupPendentes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus;

type
  TfrmPeriodoDupPendentes = class(TfrmPai)
    Label1: TLabel;
    mskDtaCad_Ini: TMaskEditFocus;
    mskDtaCad_Fin: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaVen_Fin: TMaskEditFocus;
    mskDtaVen_Ini: TMaskEditFocus;
    Label4: TLabel;
    pnDtaCadastro: TPanel;
    pnDtaVencimento: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    btnImprimir: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnClickImprimir: Boolean;
  end;

implementation

{$R *.dfm}

Uses untFuncoesSimples;

procedure TfrmPeriodoDupPendentes.btnImprimirClick(Sender: TObject);
begin
  inherited;
  blnClickImprimir := True;
  Close;
end;

procedure TfrmPeriodoDupPendentes.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaCad_Ini);
  blnClickImprimir := False;
end;

function TfrmPeriodoDupPendentes.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

    If (Sender = mskDtaCad_Ini) Or (Sender = mskDtaCad_Fin) Then
    Begin
      If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaCad_Ini.Text))) and Not(fEmptyStr(fTiraCaracEspeciais(mskDtaCad_Fin.Text))) Then
      Begin
        If StrToDate(mskDtaCad_Ini.Text) > StrToDate(mskDtaCad_Fin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End;
    End;


    If (Sender = mskDtaVen_Ini) Or (Sender = mskDtaVen_Fin) Then
    Begin
      If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaVen_Ini.Text))) and Not(fEmptyStr(fTiraCaracEspeciais(mskDtaVen_Fin.Text)))Then
      Begin
        If StrToDate(mskDtaVen_Ini.Text) > StrToDate(mskDtaVen_Fin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End;
    End;

  If Not Result Then
  pSetFocus(Sender);

End;

end.
