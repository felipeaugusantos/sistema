{***************************}
{* qryConEcf -> CADECF     *}
{************************JB*}
{***************************}
{* qryCadEcf -> CADECF     *}
{************************RV*}
unit untCfgCupomFiscal;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, ComboBoxFocus, DBCtrls, QColorLabel, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCfgCupomFiscal = class(TfrmPai)
    pnlCentral: TPanel;
    Label2: TLabel;
    edtCodEcf: TEditFocus;
    edtNomEcf: TEditFocus;
    Label3: TLabel;
    cmbModEcf: TComboBoxFocus;
    Label4: TLabel;
    cmbPorta: TComboBoxFocus;
    Label8: TLabel;
    ColorLabel2: TColorLabel;
    edtUsaTef: TEditFocus;
    Label1: TLabel;
    edtUsaPaf: TEditFocus;
    ColorLabel1: TColorLabel;
    btnGravar: TBitBtnLocked;
    Label5: TLabel;
    ColorLabel3: TColorLabel;
    edtCmtF11: TEditFocus;
    chkMP4200: TCheckBox;
    edtQtdCol: TEditFocus;
    Label6: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEcfKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConEcf: TUniQuery;
    qryCadEcf: TUniQuery;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pCarregaEcf(strCodEcf: String; edtLabel: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgCupomFiscal: TfrmCfgCupomFiscal;

implementation

uses SysUtils, untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema, untFiscal;

{$R *.dfm}

procedure TfrmCfgCupomFiscal.btnGravarClick(Sender: TObject);
  Var
    chrSystem32: Array [0..MAX_PATH] Of Char;
    strSystem32: String;
    txtRegistra: TextFile;
    strDirIni: String;
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;

    GetSystemDirectory(chrSystem32, MAX_PATH);
    strSystem32 := StrPas(chrSystem32);
    strSystem32 := strSystem32 + '\';
    strDirIni   := fCfgSis('DIRINI') + '\';

    {***********************************************}
    {* COPIA REGISTROS DA BEMATECH PARA O SYSTEM32 *}
    {********************************************AF*}
    If Not FileExists(strDirIni + 'BemaFI32.dll') Then
      CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'BemaFI32.dll'),
               PChar(strDirIni + 'BemaFI32.dll'), False);

    If FileExists(ExtractFilePath(Application.ExeName) + 'BemaFI32.ini') Then
      CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'BemaFI32.ini'),
               PChar(strSystem32 + 'BemaFI32.ini'), False);

    If Not FileExists(strDirIni + 'BemaMFD.dll') Then
      CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'BemaMFD.dll'),
               PChar(strDirIni + 'BemaMFD.dll'), False);

    If Not FileExists(strDirIni + 'BemaMFD2.dll') Then
      CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'BemaMFD2.dll'),
               PChar(strDirIni + 'BemaMFD2.dll'), False);

    If Not FileExists(strDirIni + 'BemaMFD3.dll') Then
      CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'BemaMFD3.dll'),
               PChar(strDirIni + 'BemaMFD3.dll'), False);

    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'DAO350.dll'),
             PChar(strSystem32 + 'DAO350.dll'), False);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'MSJET35.dll'),
             PChar(strSystem32 + 'MSJET35.dll'), False);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'AX6R32.DLL'),
             PChar(strSystem32 + 'AX6R32.DLL'), False);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'DAO2535.tlb'),
             PChar(strSystem32 + 'DAO2535.tlb'), False);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'libeay32.dll'),
             PChar(strSystem32 + 'libeay32.dll'), False);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'sign_bema.dll'),
             PChar(strSystem32 + 'sign_bema.dll'), False);

    If Not fDllRegistrada(strSystem32 + 'DAO350.dll') Then
    Begin
      If Not DirectoryExists('c:\registro') Then
        CreateDir('c:\registro');

      AssignFile(txtRegistra, 'c:\registro\registra.bat');
      Rewrite(txtRegistra);
      WriteLn(txtRegistra, 'regsvr32 /s DAO350.DLL');
      WriteLn(txtRegistra, 'regsvr32 /s MSJET35.DLL');
      CloseFile(txtRegistra);

      WinExec(PAnsiChar('c:\registro\registra.bat'), SW_HIDE);
      DeleteFile('c:\registro\registra.bat');
      RemoveDir('c:\registro');
    End;

    If fDefiniuPathDllsECF Then
    Begin
      pMensagemOk('Foram feitas configurações necessárias ao funcionamento do sistema.'+#13+
                  'Reinicie o Computador para as configurações funcionarem!');
    End;
  End;
end;

function TfrmCfgCupomFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (fEmptyStr(fCfgSis('DIRINI'))) Then
  Begin
    fMensagem('ATENÇÃO', 'O Diretório não pode estar vazio!', ['&Ok']);
    Result := False;
  End

  Else If (Sender = edtCodEcf) Then
  Begin
    If (fEmptyStr(edtCodEcf.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'O Código da Impressora Fiscal deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaEcf(edtCodEcf.Text, edtNomEcf);
      If qryConEcf.FieldByName('ECF_CODECF').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa impressora não está cadastrada!', ['&Ok']);
        Result := False;
      End;

    End;
  End

  Else If (Sender = cmbModEcf) Then
  Begin

    If (fEmptyStr(cmbModEcf.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'O Modelo da Impressora não pode estar vazio!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtQtdCol) Then
  Begin

    If (fEmptyStr(edtQtdCol.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'A Quantidade de Colunas da Impressora não pode estar vazia!', ['&Ok']);
      Result := False;
    End
    else
    if (StrToIntDef(edtQtdCol.Text, 0) < 40) then
    begin
      fMensagem('ATENÇÃO', 'A Quantidade de Colunas da Impressora tem que ser no mínimo 40!', ['&Ok']);
      Result := False;
    end;

  End

  Else If (Sender = edtUsaTef) Then
  Begin

    If Pos(edtUsaTef.Text, 'SN') <= 0 Then
    Begin
      fMensagem('','O campo usa tef deve ser S ou N.', ['&OK']);
      Result := False;
    End;

  End
  Else If (Sender = edtUsaPaf) Then
  Begin

    If Pos(edtUsaPaf.Text, 'SN') <= 0 Then
    Begin
      fMensagem('','O campo usa paf deve ser S ou N.', ['&OK']);
      Result := False;
    End;

  End
  Else If (Sender = edtCmtF11) Then
  Begin
    If Pos(edtCmtF11.Text, 'SN') <= 0 Then
    Begin
      fMensagem('','O campo impressão concomitante deve ser S ou N.', ['&OK']);
      Result := False;
    End;
  End;
end;

procedure TfrmCfgCupomFiscal.pCarregaArqIni;
  Var
    strModeloAnt : String;
begin
  edtCodEcf.Text    := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

  {*************************************************************}
  {* FORAM ACRESCENTADOS OUTROS MODELOS A LISTA DE IMPRESSORAS *}
  {**********************************************************LA*}
  strModeloAnt      := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  If SameText(strModeloAnt,'BEMATECH-MP2100THFI') Then
    strModeloAnt := 'BEMATECH-MP2100THFI / MP40';

  If (SameText(strModeloAnt, BEMATECH_MP20)) Or (SameText(strModeloAnt, BEMATECH25_SU)) Then
  Begin
    strModeloAnt := BEMATECH20_40;
  End;

  cmbModEcf.Text    := strModeloAnt;

  cmbPorta.Text     := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  edtQtdCol.Text    := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'QTDCOL'       , '40', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  edtUsaTef.Text    := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'USATEF'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  edtUsaPaf.Text    := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'USAPAF'       , 'N', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  edtCmtF11.Text    := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'CMTF11'       , 'N', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  chkMP4200.Checked := (fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MP4200'      , 'N', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' ) = 'S');
end;

procedure TfrmCfgCupomFiscal.pGravaArqIni;
begin
  If Not DirectoryExists(fCfgSis('DIRINI')) Then
    CreateDir(fCfgSis('DIRINI'));

  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'IMPRESSORA'    , edtCodEcf.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'MODELO'        , cmbModEcf.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'PORTA'         , cmbPorta.Text , fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'USATEF'        , edtUsaTef.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'USAPAF'        , edtUsaPaf.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'CMTF11'        , edtCmtF11.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'MP4200'        , IIF(chkMP4200.Checked, 'S', 'N'), fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
  fArqIniLocal(1, 'IMPRESSORA_FISCAL', 'QTDCOL'        , edtQtdCol.Text, fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
end;

procedure TfrmCfgCupomFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadEcf);
end;

procedure TfrmCfgCupomFiscal.FormShow(Sender: TObject);
begin
  inherited;
  qryCadEcf := fCriaQuery(Self);
  qryConEcf := qryCadEcf;

  pCarregaArqIni;
  pCarregaEcf(edtCodEcf.Text, edtNomEcf);

  pSetFocus(edtCodEcf);
end;

procedure TfrmCfgCupomFiscal.pCarregaEcf(strCodEcf: String; edtLabel: TEdit);
begin
  pPesquisaCadEcf(qryCadEcf, qryConEcf, strCodEcf);
  With qryConEcf Do
  Begin
    edtLabel.Text := FieldByName('ECF_MODELO').AsString;
  End;
end;

procedure TfrmCfgCupomFiscal.edtCodEcfKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrECF : TConsultasArray;
begin
  inherited;
  {************************}
  {* NOVA CONSULTA DE ECF *}
  {*********************DP*}
  If fPesqECF(Self, edtCodECF, edtNomEcf, Nil, Key, arrECF) Then
  Begin
    If fValidaCampos(edtCodECF, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

initialization
  RegisterClass(TfrmCfgCupomFiscal);
finalization
  UnRegisterClass(TfrmCfgCupomFiscal);

end.

