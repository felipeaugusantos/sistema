unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, QColorLabel, Mask, 
  FilenameEditFocus, ExtCtrls, EditFocus, Uni, DB,
  TConverte, Buttons, MaskEditFocus,
  IWSystem, BitBtnLockedIncrem, Vcl.Clipbrd;

type
  TfrmPrincipal = class(TForm)
    pnlFundo: TPanel;
    pnlBotoes: TPanel;
    pgbStatus: TProgressBar;
    edtHost: TEditFocus;
    Label1: TLabel;
    edtBanco: TEditFocus;
    Label2: TLabel;
    edtUser: TEditFocus;
    lblUser: TLabel;
    edtSenha: TEditFocus;
    lblSenha: TLabel;
    btnConvert: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    stbLog: TStatusBar;
    Label3: TLabel;
    edtNumPor: TEditFocus;
    chbLibUti: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chbLibUtiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtHostKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtHostKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objConverte: TConvert;

    function fValidaCampos: Boolean;

    procedure pCarregaGrid;

  public
    { Public declarations }
    strRelArquivParam : String;
    strCaminhoArquivParam : String;
    strRelPadParam : String;
    strCodcli : String;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{ TfrmPrincipal }

Uses
  System.UITypes,
  untGridRelatorios;

function TfrmPrincipal.fValidaCampos: Boolean;
begin

  Try

    Result := True;

    objConverte.strNum_Ip := edtHost.Text;
    objConverte.strNomBan := edtBanco.Text;

    If edtUser.Enabled Then
    Begin
      objConverte.strUsuari := edtUser.Text;
      objConverte.strPassWd := edtSenha.Text;
    End;  

    objConverte.intNumPor := StrToIntDef(edtNumPor.Text, 0);

  Except

    On E: Exception Do
    Begin
      Result := False;
      MessageDlg(E.Message,mtError,[mbOK],0);
    End;

  End;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  erros : String;
begin

  objConverte := TConvert.Create(Self);
  chbLibUti.Enabled := objConverte.fUsarSenhaDLL;

  erros := '';

  if not FileExists(gsAppPath + 'libUtil.dll') then
  begin
    erros := erros + '-libUtil.dll' + #13#10;
  end;

  if not FileExists(gsAppPath + 'opcoes.ini') then
  begin
    erros := erros + '-opcoes.ini' + #13#10;
  end;

  if erros <> '' then
  begin
    ShowMessage('Estão faltando os arquivos: ' + #13#10 + erros);
  end;

end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.chbLibUtiClick(Sender: TObject);
begin
  lblUser.Enabled  := not chbLibUti.Checked;
  edtUser.Enabled  := not chbLibUti.Checked;
  lblSenha.Enabled := not chbLibUti.Checked;
  edtSenha.Enabled := not chbLibUti.Checked;
end;

procedure TfrmPrincipal.edtHostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  aux : TStrings;
begin
  if ((Shift = [ssCtrl]) and (Key = 86)) then
  begin
    try
      Key := 0;

      aux := TStringList.Create;
      aux.Text := ClipBoard.AsText;

      edtHost.Text := StringReplace(aux[1], 'NUMIP=', '', [rfReplaceAll, rfIgnoreCase]);
      edtBanco.Text := StringReplace(aux[2], 'NOMBAN=', '', [rfReplaceAll, rfIgnoreCase]);
      edtNumPor.Text := StringReplace(aux[3], 'PORTA=', '', [rfReplaceAll, rfIgnoreCase]);

      chbLibUti.Checked := True;

    except
       edtHost.Text := ClipBoard.AsText;

    end;
  end;
end;

procedure TfrmPrincipal.edtHostKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #22) then
    Key := #0;
end;

procedure TfrmPrincipal.btnConvertClick(Sender: TObject);
begin

  If fValidaCampos Then
  Begin

    btnConvert.Enabled := False;
    btnSair.Enabled := False;

    objConverte.strRelArquiv := strRelArquivParam;
    objConverte.strCaminhoArquiv := strCaminhoArquivParam;
    objConverte.strRelPad := strRelPadParam;
    objConverte.strCodcli := strCodcli;


    If objConverte.fConverte(pgbStatus,stbLog, chbLibUti.Checked) Then
      pCarregaGrid;

    btnConvert.Enabled := True;
    btnSair.Enabled := True;
  End;
end;

procedure TfrmPrincipal.pCarregaGrid;
Begin
  Application.CreateForm(TfrmGridRelatorios, frmGridRelatorios);
  frmGridRelatorios.objConverte := objConverte;
  frmGridRelatorios.Caption := 'Grid Relatórios - ' + strCodcli;

  frmGridRelatorios.dtsConsulta.DataSet := objConverte.cdsCadRel;
  frmGridRelatorios.dtsCadTem.DataSet := objConverte.cdsCadTem;
  frmGridRelatorios.dtsCadMod.DataSet := objConverte.cdsCadMod;

  if Trim(objConverte.strCaminhoArquiv) <> '' then
    frmGridRelatorios.cmbExporta.ItemIndex := 2;

  if Trim(objConverte.strRelArquiv) <> '' then
  begin
    objConverte.pAddMarcaDesmarcaTodosLista(True);

    if objConverte.strRelPad = 'E' then
    begin
      frmGridRelatorios.chkRelPadrao.Checked := False;
    end;

    frmGridRelatorios.cmbExporta.ItemIndex := 2;
    frmGridRelatorios.chkModoExporta.Checked := True;

    frmGridRelatorios.btnGerarClick(Self);
    frmGridRelatorios.Close;
  end
  else
  begin
    frmGridRelatorios.ShowModal;
  end;

  FreeAndNil(frmGridRelatorios);
End;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_Return Then
    SelectNext(ActiveControl,True,True);

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  numip, nomban, porta, codcli: string;
begin

  strCodcli := '';

  try
    numip  := ParamStr(1);
    nomban := ParamStr(2);
    porta  := ParamStr(3);
    codcli := ParamStr(4);
    strRelArquivParam := ParamStr(5);
    strRelArquivParam := StringReplace(strRelArquivParam, '"', '', [rfReplaceAll]);
    strCaminhoArquivParam := ParamStr(6);
    strCaminhoArquivParam := StringReplace(strCaminhoArquivParam, '"', '', [rfReplaceAll]);

    strRelPadParam := ParamStr(7);

    if(numip <> '') and (nomban <> '') and (porta <> '') then
    begin
      edtHost.Text := numip;
      edtBanco.Text := nomban;
      edtNumPor.Text := porta;

      lblUser.Enabled  := not chbLibUti.Checked;
      edtUser.Enabled  := not chbLibUti.Checked;
      lblSenha.Enabled := not chbLibUti.Checked;
      edtSenha.Enabled := not chbLibUti.Checked;

      chbLibUti.Checked := True;

      if strRelPadParam = '' then
      begin
        strRelPadParam := 'S';
      end;

      if (strRelArquivParam = '') and (strCaminhoArquivParam = '') then
      begin
        ShowMessage('Conectando em: ' + codcli);

        strCodcli := codcli;
      end;

      btnConvert.Click;
    end;

  finally

  end;

end;

end.
