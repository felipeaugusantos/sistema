unit untFatDadosFiscaisNFVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Uni, StrUtils, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatDadosFiscaisNFVenda = class(TfrmPai)
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    Label18: TLabel;
    edtNumDoc: TEditFocus;
    Label19: TLabel;
    edtEspDoc: TEditFocus;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function fBuscaDocumento(strNumero, strEspDoc, strEmpresa: String): Boolean;
  public
    { Public declarations }
    strNumDoc: String;
    strNomCli: String;
    strCGCCli: String;
    strIE_Cli: String;
    strCodEmp: String;
    strDtaEmi: String;
    fltValDoc: Double;
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

var
  frmFatDadosFiscaisNFVenda: TfrmFatDadosFiscaisNFVenda;

implementation

uses DB, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatDadosFiscaisNFVenda.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosFiscaisNFVenda.pEscapePressed;
begin

  If (ActiveControl = edtNumDoc) Or (ActiveControl = edtCodEmp) Then
  Begin
    strNumDoc := '';
    strNomCli := '';
    strCGCCli := '';
    strIE_Cli := '';
    strCodEmp := '';
    strDtaEmi := '';
    fltValDoc := 0;
    blnConfirma := False;
  End;

  inherited;

end;

procedure TfrmFatDadosFiscaisNFVenda.btnSairClick(Sender: TObject);
begin
  inherited;
  strNumDoc := '';
  strNomCli := '';
  strCGCCli := '';
  strIE_Cli := '';
  strCodEmp := '';
  strDtaEmi := '';
  fltValDoc := 0;
  blnConfirma := False;
end;

procedure TfrmFatDadosFiscaisNFVenda.btnConfirmaDadosClick(
  Sender: TObject);
begin
  inherited;
  If (fValidaCampos(edtCodEmp, False)) Then
  Begin
    blnConfirma := True;
    Close;
  End
  Else
    Exit;
end;

function TfrmFatDadosFiscaisNFVenda.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('','Digite o número do documento!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique!',['&O K']);
          Result := False;
        End
        Else If Not fBuscaDocumento(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('','Documento digitado não foi encontrado, verifique!',['&O K']);
          Result := False;
          blnMudarFoco := False;
          pSetFocus(edtNumDoc);
        End;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If (fEmptyStr(edtEspDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A espécie do documento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtEspDoc.Text, 'NF_EL_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie do documento deve ser NF ou EL!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatDadosFiscaisNFVenda.fBuscaDocumento(strNumero, strEspDoc, strEmpresa: String): Boolean;
  Var
    qryGen : TUniQuery;
    strSql : String;
    strSQLMovGer : String;
    strSQLNotGer : String;
begin

  strSQLMovGer := '';
  strSQLMovGer := strSQLMovGer + '  SELECT SQL_NO_CACHE                           ';
  strSQLMovGer := strSQLMovGer + '    CLI_NOMCLI AS NOMCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    CLI_C_G_C_ AS CGCCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    CLI_I_E_S_ AS IESCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_DTAENT AS DTAENT,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_VLRCON AS VALDOC                        ';
  strSQLMovGer := strSQLMovGer + '  FROM                                          ';
  strSQLMovGer := strSQLMovGer + '    MOVGER                                      ';
  strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQLMovGer := strSQLMovGer + '  WHERE                                         ';
  strSQLMovGer := strSQLMovGer + '    GER_NUMDOC =:NUMDOC AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_ESPDOC =:ESPDOC AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_CODEMP =:CODEMP AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_TIP_FC = "C"                            ';

  strSQLNotGer := AnsiReplaceStr(strSQLMovGer, 'MOVGER', 'NOTGER');

  strSql := strSQLMovGer + ' UNION ALL ' + strSQLNotGer;

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumero;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strEmpresa;
    Open;

    If IsEmpty Then
      Result := False
    Else
    Begin
      Result := True;
      strNumDoc := strNumero;
      strNomCli := fieldbyname('NOMCLI').AsString;
      strCGCCli := fieldbyname('CGCCLI').AsString;
      strIE_Cli := fieldbyname('IESCLI').AsString;
      strCodEmp := strEmpresa;
      strDtaEmi := FormatDateTime('dd/mm/yyyy',fieldbyname('DTAENT').AsDateTime);
      fltValDoc := fieldbyname('VALDOC').AsFloat;
    End;
  End;

  FreeAndNil(qryGen);

end;

procedure TfrmFatDadosFiscaisNFVenda.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;
end;

procedure TfrmFatDadosFiscaisNFVenda.FormShow(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmp.Text) Then
  Begin
    strNumDoc := '';
    strNomCli := '';
    strCGCCli := '';
    strIE_Cli := '';
    strCodEmp := '';
    strDtaEmi := '';
    fltValDoc := 0;
  End
  Else
  Begin
    edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
    pSetFocus(edtNumDoc);
  End;

  blnConfirma := False;
  pSetFocus(edtNumDoc);
end;

end.
