unit untDadosXmlInconsistenciaEFD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  MemoFocus, dxGDIPlusClasses;

type
  TfrmDadosXmlInconsistenciaEFD = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtRefNFe: TEditFocus;
    edtInfFisco: TEditFocus;
    edtIdentificacao: TEditFocus;
    mskPeriodo: TMaskEditFocus;
    btnHelp1: TSpeedButton;
    btnHelp2: TSpeedButton;
    btnHelp3: TSpeedButton;
    btnHelp4: TSpeedButton;
    procedure btnHelp1Click(Sender: TObject);
    procedure btnHelp2Click(Sender: TObject);
    procedure btnHelp3Click(Sender: TObject);
    procedure btnHelp4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmDadosXmlInconsistenciaEFD }

procedure TfrmDadosXmlInconsistenciaEFD.btnHelp1Click(Sender: TObject);
begin
  inherited;
  fMensagem('AJUDA', 'Chave de acesso da nota fiscal referenciada', ['Ok'], 1, True);
end;

procedure TfrmDadosXmlInconsistenciaEFD.btnHelp2Click(Sender: TObject);
begin
  inherited;
  fMensagem('AJUDA', 'Informações adicionais de interesse do fisco', ['Ok'], 1, True);
end;

procedure TfrmDadosXmlInconsistenciaEFD.btnHelp3Click(Sender: TObject);
begin
  inherited;
  fMensagem('AJUDA', 'Identificação do campo: deverá constar a expressão "NF0200"', ['Ok'], 1, True);
end;

procedure TfrmDadosXmlInconsistenciaEFD.btnHelp4Click(Sender: TObject);
begin
  inherited;
  fMensagem('AJUDA', 'Conteúdo do campo: deverá constar o período de apuração onde consta escriturada a NF-e de '+
    'saída, cujo item não possui codificação de entrada correspondente, no formato "mês/ano"', ['Ok'], 1, True);
end;

function TfrmDadosXmlInconsistenciaEFD.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtRefNFe Then
    Begin
      If Not fEmptyStr(edtRefNFe.Text) Then
      Begin
        If Not fValidaChaveAcessoNFE(edtRefNFe.Text) Then
        Begin
          pMensagemOk('Chave de acesso inválida!');
          Result := False;
        End;
      End;
    End

    Else If Sender = mskPeriodo Then
    Begin
      If Not fEmptyStr(fRetSomenteNumeros(mskPeriodo.Text)) Then
      Begin
        If StrToDateDef('01/'+ mskPeriodo.Text, 0) = 0 Then
        Begin
          pMensagemOk('Mês/ano inválido!');
          Result := False;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
