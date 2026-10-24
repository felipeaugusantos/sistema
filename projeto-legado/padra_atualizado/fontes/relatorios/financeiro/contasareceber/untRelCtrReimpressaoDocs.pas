unit untRelCtrReimpressaoDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, Menus,
  Buttons, ExtCtrls, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmRelCtrReimpressaoDocs = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    lblEmpresa: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    edtEspDoc: TEditFocus;
    edtSequenciaBaixa: TEditFocus;
    Label3: TLabel;
    btnImprimir: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    chkLancCred: TCheckBox;
    procedure edtEspDocChange(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtSequenciaBaixaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function fGetSQLCadRec: String;
    function fGetSQLAdtCli: String;
    function fGetSQlLancLC: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    blnCaixaCC: Boolean;
    { Public declarations }
  end;


implementation

uses untfuncoesSimples, DB, untConsultas,
    untRelCtrReimpressaoDocsList, untTypesSistema;

{$R *.dfm}

function TfrmRelCtrReimpressaoDocs.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('AVISO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End
    {*******************************}
    {* VALIDA DATA INICIAL E FINAL *}
    {****************************JU*}
    Else If ((Sender = mskDtaIni) And Not blnCaixaCC) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('AVISO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If ((Sender = mskDtaFin) And Not blnCaixaCC) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('AVISO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('AVISO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmRelCtrReimpressaoDocs.edtEspDocChange(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
  Begin
    mskDtaIni.Enabled      := False;
    mskDtaFin.Enabled      := False;
    edtCodCliente.Enabled  := False;
    edtCodEmpresa.Enabled  := False;
  End
  Else
  Begin
    mskDtaIni.Enabled      := True;
    mskDtaFin.Enabled      := True;
    edtCodCliente.Enabled  := True;
    edtCodEmpresa.Enabled  := True;
  End;

end;

procedure TfrmRelCtrReimpressaoDocs.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmRelCtrReimpressaoDocs.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrReimpressaoDocs.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCliente.Text) Then
    edtDesCliente.Text := 'TODOS'
  Else
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text))  Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodCliente.Clear;
    pSetFocus(edtCodCliente);
  End;

end;

procedure TfrmRelCtrReimpressaoDocs.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrReimpressaoDocs.FormCreate(Sender: TObject);
begin
  inherited;
  blnCaixaCC := False;
end;

procedure TfrmRelCtrReimpressaoDocs.FormShow(Sender: TObject);
begin
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  inherited;
end;

(****************************)
(* LANÇAMENTOS DE CREDITOS  *)
(*************************JC*)
function TfrmRelCtrReimpressaoDocs.fGetSQlLancLC: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE         ';
  strSQL := strSQL + '  RCX_NUMDOC AS NUMDOC,      ';
  strSQL := strSQL + '  RCX_ESPDOC AS ESPDOC,      ';
  strSQL := strSQL + '  RCX_PARCEL AS PARCEL,      ';
  strSQL := strSQL + '  RCX_CODEMP AS CODEMP,      ';
  strSQL := strSQL + '  RCX_DESCRI AS HIST01,      ';
  strSQL := strSQL + '  NULL AS HIST02,            ';
  strSQL := strSQL + '  RCX_DTACAD AS DTACAD,      ';
  strSQL := strSQL + '  RCX_DTACAD AS DTAVEN,      ';
  strSQL := strSQL + '  RCX_DTACAD AS DTAREC,      ';
  strSQL := strSQL + '  CURRENT_TIME AS HORREC,    ';
  strSQL := strSQL + '  RCX_DESCRI AS DESCRI,      ';
  strSQL := strSQL + '  NULL AS CODCTA,            ';
  strSQL := strSQL + '  NULL AS DESCTA,            ';
  strSQL := strSQL + '  (                          ';
  strSQL := strSQL + '    IFNULL(RCX_VALDOC, 0)    ';
  strSQL := strSQL + '  ) AS VALDOC,               ';
  strSQL := strSQL + '  RCX_VALDOC AS VALORI,      ';
  strSQL := strSQL + '  RCX_VALDOC AS VALREC,      ';
  strSQL := strSQL + '  0.00 AS VALDES,            ';
  strSQL := strSQL + '  0.00 AS VALJUR,            ';
  strSQL := strSQL + '  0.00 AS VALCOB,            ';
  strSQL := strSQL + '  0.00 AS DESCOB,            ';
  strSQL := strSQL + '  NULL AS CODCLI,            ';
  strSQL := strSQL + '  NULL AS NOSNUM,            ';
  strSQL := strSQL + '  RCX_SEQCON AS SEQCON,      ';
  strSQL := strSQL + '  RCX_CODOPE AS CODVEN,      ';
  strSQL := strSQL + '  NULL AS NOMCLI,            ';
  strSQL := strSQL + '  NULL AS ENDERE,            ';
  strSQL := strSQL + '  NULL AS BAIRRO,            ';
  strSQL := strSQL + '  NULL AS CIDADE,            ';
  strSQL := strSQL + '  NULL AS ESTADO,            ';
  strSQL := strSQL + '  NULL AS C_E_P_,            ';
  strSQL := strSQL + '  NULL AS C_G_C_,            ';
  strSQL := strSQL + '  NULL AS FONE01,            ';
  strSQL := strSQL + '  NULL AS F_A_X_,            ';
  strSQL := strSQL + '  NULL AS ENDNUM,            ';
  strSQL := strSQL + '  1 AS RESCAI,               ';
  strSQL := strSQL + '  0.00 AS VALRES,            ';
  strSQL := strSQL + '  RCX_VALDOC AS GRVORI,      ';
  strSQL := strSQL + '  RCX_SEQCON AS CTR_SEQBAI,  ';
  strSQL := strSQL + '  RCX_CODEMP AS CTR_EMPBAI,  ';
  strSQL := strSQL + '  RCX_NUMDOC AS CTR_NUMDUP,  ';
  strSQL := strSQL + '  RCX_DESCRI AS CTR_HIST01,  ';
  strSQL := strSQL + '  NULL AS CTR_HIST02,        ';
  strSQL := strSQL + '  RCX_PARCEL AS CTR_PARCEL,  ';
  strSQL := strSQL + '  RCX_DTACAD AS CTR_DTAVEN,  ';
  strSQL := strSQL + '  RCX_VALDOC AS CTR_VALDUP,  ';
  strSQL := strSQL + '  RCX_DTACAD AS CTR_DTACAD,  ';
  strSQL := strSQL + '  RCX_ESPDOC AS CTR_ESPDOC,  ';
  strSQL := strSQL + '  RCX_CODEMP AS CTR_CODEMP,  ';
  strSQL := strSQL + '  RCX_VALDOC AS CTR_VALREC,  ';
  strSQL := strSQL + '  0.00 AS CTR_VALDES,        ';
  strSQL := strSQL + '  0.00 AS CTR_VALJUR,        ';
  strSQL := strSQL + '  NULL AS CTR_CODCLI,        ';
  strSQL := strSQL + '  NULL AS CTR_NOSNUM,        ';
  strSQL := strSQL + '  NULL AS CLI_NOMCLI,        ';
  strSQL := strSQL + '  NULL AS CLI_FONE01,        ';
  strSQL := strSQL + '  NULL AS CLI_F_A_X_,        ';
  strSQL := strSQL + '  RCX_SEQCON AS CTR_SEQCON,  ';
  strSQL := strSQL + '  RCX_DINREC AS CTR_DINHEI,  ';
  strSQL := strSQL + '  RCX_CHQAVI AS CTR_CHQAVI,  ';
  strSQL := strSQL + '  RCX_CHQPRE AS CTR_CHQPRE,  ';
  strSQL := strSQL + '  RCX_CARREC AS CTR_CARTAO,  ';
  strSQL := strSQL + '  RCX_ORDREC AS CTR_ORDPAG,  ';
  strSQL := strSQL + '  RCX_VALCRE AS CTR_CREDITO, ';
  strSQL := strSQL + '  "D" AS CTR_MARDES,         ';
  strSQL := strSQL + '  0.00 AS CTR_JURSUJ,        ';
  strSQL := strSQL + '  0.00 AS CTR_DESSUJ,        ';
  strSQL := strSQL + '  RCX_CODOPE AS OPEBAI,      ';
  strSQL := strSQL + '  NULL AS CTR_PORBAI,        ';
  strSQL := strSQL + '  NULL AS RCX_CAIXA,         ';
  strSQL := strSQL + '  RCX_RECPIX AS RECPIX,      ';
  strSQL := strSQL + '  RCX_DTACAD AS CTR_DTABAI,  ';
  strSQL := strSQL + '  0.00 AS COBANT,            ';
  strSQL := strSQL + '  RCX_VALDOC AS VALOR2       ';
  strSQL := strSQL + 'FROM CADRCXX ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '  RCX_ESPDOC = "LC" ';

  If (Not fEmptyStr(edtSequenciaBaixa.Text)) Then
  Begin

    strSQL := strSQL + ' AND RCX_SEQCON = :SEQBAIXA AND ';
    strSQL := strSQL + '     RCX_CODEMP = :SEQEMP ';

  End
  Else
  Begin
    If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) And (edtEspDoc.Text = 'LC') Then
    Begin

      strSQL := strSQL + ' AND RCX_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '     RCX_ESPDOC = "LC" ';

    End
    Else
    Begin

      strSQL := strSQL + ' AND RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtNumDoc.Text) Then
        strSQL := strSQL + 'AND RCX_NUMDOC = :NUMDOC ';

      If Not fEmptyStr(edtEspDoc.Text) Then
        strSQL := strSQL + 'AND RCX_ESPDOC = "LC" ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
         strSQL := strSQL + 'AND RCX_CODEMP = :CODEMP ';

    End
  End;

  Result := strSQL;
End;

(****************************)
(* ADIANTAMENTOS DE CLIENTE *)
(*************************JC*)
function TfrmRelCtrReimpressaoDocs.fGetSQLAdtCli: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  (***********************************************************************)
  (* CAMPOS PARA A FUNÇÃO frmQckReciboCtaReceber.pImprimeRecibo - INICIO *)
  (********************************************************************LA*)
  strSQL := strSQL + '  ADT_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  ADT_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  "A"        AS PARCEL, ';
  strSQL := strSQL + '  ADT_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  FGO_MEN001 AS HIST01, ';
  strSQL := strSQL + '  FGO_MEN002 AS HIST02, ';
  strSQL := strSQL + '  FGO_DTAENT AS DTACAD, ';
  strSQL := strSQL + '  FGO_DTAENT AS DTAVEN, ';
  strSQL := strSQL + '  ADT_DTALAN AS DTAREC, ';
  strSQL := strSQL + '  ADT_HORLAN AS HORREC, ';
  strSQL := strSQL + '  ADT_DESCRI AS DESCRI, ';
  strSQL := strSQL + '  NULL       AS CODCTA, ';
  strSQL := strSQL + '  NULL       AS DESCTA, ';
  strSQL := strSQL + '  ADT_VALLAN AS VALDOC, ';
  strSQL := strSQL + '  ADT_VALLAN AS VALORI, ';
  strSQL := strSQL + '  ADT_VALLAN AS VALREC, ';
  strSQL := strSQL + '  0.00       AS VALDES, ';
  strSQL := strSQL + '  0.00       AS VALJUR, ';
  strSQL := strSQL + '  0.00       AS VALCOB, ';
  strSQL := strSQL + '  0.00       AS DESCOB, ';
  strSQL := strSQL + '  ADT_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  NULL       AS NOSNUM, ';
  strSQL := strSQL + '  ADT_SEQCON AS SEQCON, ';
  strSQL := strSQL + '  FGO_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_NOMCON, CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_ENDCON, CLI_ENDERE) AS ENDERE, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_BAICON, CLI_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_CIDCON, CID_NOMCID) AS CIDADE, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_ESTCON, CID_ESTADO) AS ESTADO, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_CEPCON, CLI_C_E_P_) AS C_E_P_, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_CGCCON, CLI_C_G_C_) AS C_G_C_, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_TELCON, CLI_FONE01) AS FONE01, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", ""        , CLI_F_A_X_) AS F_A_X_, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", ""        , CLI_ENDNUM) AS ENDNUM, ';
  strSQL := strSQL + '  0 AS RESCAI, ';
  strSQL := strSQL + '  0 AS VALRES, ';
  strSQL := strSQL + '  ADT_VALLAN AS GRVORI, ';
  (***********************************************************************)
  (* CAMPOS PARA A FUNÇÃO frmQckReciboCtaReceber.pImprimeRecibo - FIM    *)
  (********************************************************************LA*)

  strSQL := strSQL + '  0          AS CTR_SEQBAI, ';
  strSQL := strSQL + '  ADT_EMPLAN AS CTR_EMPBAI, ';
  strSQL := strSQL + '  ADT_NUMDOC AS CTR_NUMDUP, ';
  strSQL := strSQL + '  FGO_MEN001 AS CTR_HIST01, ';
  strSQL := strSQL + '  FGO_MEN002 AS CTR_HIST02, ';
  strSQL := strSQL + '  "A"        AS CTR_PARCEL, ';
  strSQL := strSQL + '  FGO_DTAENT AS CTR_DTAVEN, ';
  strSQL := strSQL + '  ADT_VALLAN AS CTR_VALDUP, '; //RENOMEADO PARA VALDUP POIS NA BAIXA SO USA O VALDUP
  strSQL := strSQL + '  FGO_DTAENT AS CTR_DTACAD, ';
  strSQL := strSQL + '  ADT_ESPDOC AS CTR_ESPDOC, ';
  strSQL := strSQL + '  ADT_CODEMP AS CTR_CODEMP, ';
  strSQL := strSQL + '  ADT_VALLAN AS CTR_VALREC, ';
  strSQL := strSQL + '  0.00       AS CTR_VALDES, ';
  strSQL := strSQL + '  0.00       AS CTR_VALJUR, ';
  strSQL := strSQL + '  ADT_CODCLI AS CTR_CODCLI, ';
  strSQL := strSQL + '  NULL       AS CTR_NOSNUM, ';
  strSQL := strSQL + '  CLI_NOMCLI AS CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_FONE01 AS CLI_FONE01, ';
  strSQL := strSQL + '  CLI_F_A_X_ AS CLI_F_A_X_, ';
  strSQL := strSQL + '  ADT_SEQCON AS CTR_SEQCON, ';
  strSQL := strSQL + '  ADT_VALDIN + ADT_VALCRE AS CTR_DINHEI, ';
  strSQL := strSQL + '  ADT_VALCHV AS CTR_CHQAVI, ';
  strSQL := strSQL + '  ADT_VALCHP AS CTR_CHQPRE, ';
  strSQL := strSQL + '  ADT_VALCAR AS CTR_CARTAO, ';
  strSQL := strSQL + '  ADT_VALORD AS CTR_ORDPAG, ';
  strSQL := strSQL + '  ADT_VALCRE AS CTR_CREDITO, ';
  strSQL := strSQL + '  "D"        AS CTR_MARDES, ';
  strSQL := strSQL + '  0.00       AS CTR_JURSUJ, ';
  strSQL := strSQL + '  0.00       AS CTR_DESSUJ, ';
  strSQL := strSQL + '  NULL       AS OPEBAI,     ';
  strSQL := strSQL + '  NULL       AS CTR_PORBAI, ';
  strSQL := strSQL + '  IF(ADT_ORIGEM <> "RCX", "", (SELECT RCX_CODCAX FROM CADRCXX ';
  strSQL := strSQL + '                               WHERE RCX_SEQCON=ADT_SEQCON AND RCX_CODEMP=ADT_EMPLAN LIMIT 1)) AS RCX_CAIXA, ';
  strSQL := strSQL + '  ADT_RECPIX AS RECPIX,  ';
  strSQL := strSQL + '  ADT_DTALAN AS CTR_DTABAI, ';
  strSQL := strSQL + '  0.00       AS COBANT,     ';
  strSQL := strSQL + '  ADT_VALLAN AS VALOR2      ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ADTCLI  ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON ADT_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN FATGOR ON FGO_NUMDOC = ADT_NUMDOC ';
  strSQL := strSQL + '                  AND FGO_ESPDOC = ADT_ESPDOC ';
  strSQL := strSQL + '                  AND FGO_CODCLI = ADT_CODCLI ';
  strSQL := strSQL + '                  AND FGO_CODEMP = ADT_CODEMP ';
  strSQL := strSQL + 'WHERE ';

  If (Not fEmptyStr(edtSequenciaBaixa.Text)) Then
  Begin

    strSQL := strSQL + ' ADT_SEQCON = :SEQBAIXA AND ';
    strSQL := strSQL + ' ADT_EMPLAN = :SEQEMP ';

  End
  Else
  Begin
    If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
    Begin

      strSQL := strSQL + '  ADT_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  ADT_ESPDOC = :ESPDOC ';

    End
    Else
    Begin

      strSQL := strSQL + '  ADT_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtNumDoc.Text) Then
        strSQL := strSQL + 'AND ADT_NUMDOC = :NUMDOC ';

      If Not fEmptyStr(edtEspDoc.Text) Then
        strSQL := strSQL + 'AND ADT_ESPDOC = :ESPDOC ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + 'AND ADT_EMPLAN = :CODEMP '
      Else
        strSQL := strSQL + 'AND LOCATE(ADT_EMPLAN,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If Not fEmptyStr(edtCodCliente.Text) Then
        strSQL := strSQL + 'AND ADT_CODCLI = :CODCLI ';

    End
  End;

  Result := strSQL;
end;

function TfrmRelCtrReimpressaoDocs.fGetSQLCadRec: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  (***********************************************************************)
  (* CAMPOS PARA A FUNÇÃO frmQckReciboCtaReceber.pImprimeRecibo - INICIO *)
  (********************************************************************LA*)
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '  CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + '  CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CTR_HIST01 AS HIST01, ';
  strSQL := strSQL + '  CTR_HIST02 AS HIST02, ';
  strSQL := strSQL + '  CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  CTR_DTAREC AS DTAREC, ';
  strSQL := strSQL + '  CURRENT_TIME AS HORREC, ';
  strSQL := strSQL + '  CTR_HISBAI AS DESCRI, ';
  strSQL := strSQL + '  CTR_CTABAI AS CODCTA, ';
  strSQL := strSQL + '  CTA_DESCTA AS DESCTA, ';
  strSQL := strSQL + '  SUM((CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0))) AS VALDOC, ';
  strSQL := strSQL + '  SUM(CTR_VALORI) AS VALORI, ';
  strSQL := strSQL + '  SUM(CTR_VALREC) AS VALREC, ';
  strSQL := strSQL + '  SUM(CTR_VALDES) AS VALDES, ';
  strSQL := strSQL + '  SUM(CTR_VALJUR) AS VALJUR, ';
  strSQL := strSQL + '  SUM(CTR_VALCOB) AS VALCOB, ';
  strSQL := strSQL + '  SUM(CTR_DESCOB) AS DESCOB, ';
  strSQL := strSQL + '  CTR_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CTR_NOSNUM AS NOSNUM, ';
  strSQL := strSQL + '  CTR_SEQCON AS SEQCON, ';
  strSQL := strSQL + '  CTR_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_NOMCON, CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_ENDCON, CLI_ENDERE) AS ENDERE, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_BAICON, CLI_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_CIDCON, CID_NOMCID) AS CIDADE, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_ESTCON, CID_ESTADO) AS ESTADO, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_CEPCON, CLI_C_E_P_) AS C_E_P_, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_CGCCON, CLI_C_G_C_) AS C_G_C_, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", GER_TELCON, CLI_FONE01) AS FONE01, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", ""        , CLI_F_A_X_) AS F_A_X_, ';
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", ""        , CLI_ENDNUM) AS ENDNUM, ';
  strSQL := strSQL + '  CTR_RESCAI AS RESCAI, ';
  strSQL := strSQL + '  SUM(IF(CTR_RESCAI <> 1, (CTR_VALANT + IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALDES, 0) - IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_VALREC, 0) ),(IF(CTR_VALCOR > 0, CTR_VALCOR, CTR_VALORI) - CTR_VALREC))) AS VALRES, ';
  strSQL := strSQL + '  CTR_GRVORI AS GRVORI, ';
  (***********************************************************************)
  (* CAMPOS PARA A FUNÇÃO frmQckReciboCtaReceber.pImprimeRecibo - FIM    *)
  (********************************************************************LA*)

  strSQL := strSQL + '  CTR_SEQBAI AS CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_EMPBAI AS CTR_EMPBAI, ';
  strSQL := strSQL + '  CTR_NUMDUP AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_HIST01 AS CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02 AS CTR_HIST02, ';
  strSQL := strSQL + '  CTR_PARCEL AS CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_DTAVEN AS CTR_DTAVEN, ';
  strSQL := strSQL + '  SUM(CTR_VALORI) AS CTR_VALDUP, '; //RENOMEADO PARA VALDUP POIS NA BAIXA SO USA O VALDUP
  strSQL := strSQL + '  CTR_DTACAD AS CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_ESPDOC AS CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODEMP AS CTR_CODEMP, ';
  strSQL := strSQL + '  SUM(IF(CTR_ESPDOC = "CC" AND CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALREC)) AS CTR_VALREC, ';
  strSQL := strSQL + '  SUM(CTR_VALDES) AS CTR_VALDES, ';
  strSQL := strSQL + '  SUM(CTR_VALJUR) AS CTR_VALJUR, ';
  strSQL := strSQL + '  CTR_CODCLI AS CTR_CODCLI, ';
  strSQL := strSQL + '  CTR_NOSNUM AS CTR_NOSNUM, ';
  strSQL := strSQL + '  CLI_NOMCLI AS CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_FONE01 AS CLI_FONE01, ';
  strSQL := strSQL + '  CLI_F_A_X_ AS CLI_F_A_X_, ';
  strSQL := strSQL + '  CTR_SEQCON AS CTR_SEQCON, ';
  strSQL := strSQL + '  SUM(CTR_DINHEI) AS CTR_DINHEI, ';
  strSQL := strSQL + '  SUM(CTR_CHQAVI) AS CTR_CHQAVI, ';
  strSQL := strSQL + '  SUM(CTR_CHQPRE) AS CTR_CHQPRE, ';
  strSQL := strSQL + '  SUM(CTR_CARTAO) AS CTR_CARTAO, ';
  strSQL := strSQL + '  SUM(CTR_ORDPAG) AS CTR_ORDPAG, ';
  strSQL := strSQL + '  SUM(IF(CTR_DTAREC IS NOT NULL AND CTR_VALREC < 0, CTR_VALREC, 0)) AS CTR_CREDITO, ';
  strSQL := strSQL + '  "D"        AS CTR_MARDES, ';
  strSQL := strSQL + '  SUM(CTR_JURSUJ) AS CTR_JURSUJ, ';
  strSQL := strSQL + '  SUM(CTR_DESSUJ) AS CTR_DESSUJ, ';
  strSQL := strSQL + '  CTR_OPEBAI AS OPEBAI,     ';
  strSQL := strSQL + '  CTR_PORBAI AS CTR_PORBAI, ';
  strSQL := strSQL + '  IF(CTR_RESCAI <> 1, "", (SELECT RCX_CODCAX FROM CADRCXX ';
  strSQL := strSQL + '                           WHERE RCX_SEQCON=CTR_SEQCON AND RCX_CODEMP=CTR_EMPBAI LIMIT 1)) AS RCX_CAIXA, ';
  strSQL := strSQL + '  CTR_RECPIX AS RECPIX,  ';
  strSQL := strSQL + '  CTR_DTABAI,  ';
  strSQL := strSQL + '  CTR_COBANT AS COBANT,  ';
  strSQL := strSQL + '  CTR_GRVORI AS VALOR2   ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC  ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCTA ON CTA_CODCTA = CTR_CTABAI ';
  strSQL := strSQL + '  LEFT JOIN MOVGER ON GER_NUMDOC = CTR_NUMDUP ';
  strSQL := strSQL + '                  AND GER_ESPDOC = CTR_ESPDOC ';
  strSQL := strSQL + '                  AND GER_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + '                  AND GER_CODEMP = CTR_CODEMP ';
  strSQL := strSQL + 'WHERE ';
  If Not blnCaixaCC Then
    strSQL := strSQL + '  ((CTR_DTAREC IS NOT NULL) OR (CTR_ESPDOC = "CC" AND CTR_DTAREC IS NULL)) '
  Else
    strSQL := strSQL + '  (CTR_ESPDOC = "CC" AND CTR_DTAREC IS NULL) ';

  If (Not fEmptyStr(edtSequenciaBaixa.Text)) Then
  Begin
    strSQL := strSQL + ' AND CTR_SEQCON = :SEQBAIXA AND ';
    strSQL := strSQL + '     CTR_EMPBAI = :SEQEMP ';

  End
  Else
  Begin
    If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
    Begin

      strSQL := strSQL + '  AND CTR_NUMDUP = :NUMDOC AND ';
      strSQL := strSQL + '      CTR_ESPDOC = :ESPDOC ';

    End
    Else
    Begin
      //Colocada essa verificação pois é chamada essa tela pelo caixa, para reimprimir CC
      If Not blnCaixaCC Then
        strSQL := strSQL + '  AND IF(CTR_ESPDOC = "CC" AND CTR_DTAREC IS NULL, CTR_DTACAD, CTR_DTAREC) BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtNumDoc.Text) Then
        strSQL := strSQL + 'AND CTR_NUMDUP = :NUMDOC ';

      If Not fEmptyStr(edtEspDoc.Text) Then
        strSQL := strSQL + 'AND CTR_ESPDOC = :ESPDOC ';

      If Not blnCaixaCC Then
      Begin
        If Not fEmptyStr(edtCodEmpresa.Text) Then
          strSQL := strSQL + 'AND CTR_EMPBAI = :CODEMP '
        Else
          strSQL := strSQL + 'AND CTR_EMPBAI IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';
      End
      Else
        strSQL := strSQL + 'AND CTR_CODEMP = :CODEMP ';

      If Not fEmptyStr(edtCodCliente.Text) Then
        strSQL := strSQL + 'AND CTR_CODCLI = :CODCLI ';

    End
  End;

  strSQL := strSQL + 'GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI ';

  Result := strSQL;
end;

procedure TfrmRelCtrReimpressaoDocs.btnImprimirClick(Sender: TObject);
  Var
    strSQL    : String;
    qryGenCtr : TUniQuery;
    frmRelCtrReimpressaoDocsList: TfrmRelCtrReimpressaoDocsList;

    LUltimaDataBaixa: TDateTime;
begin
  If Not fVerificaCampos Then
    Exit;

  inherited;

  Try

    qryGenCtr := fCriaQuery(Self);

    btnImprimir.Enabled := False;

    strSQL := fGetSQLCadRec + IIF(blnCaixaCC, '',
                                  ' UNION ALL ' + fGetSQLAdtCli +
                                  IIF(chkLancCred.checked, ' UNION ALL ' + fGetSQlLancLC, '') );

    With qryGenCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not fEmptyStr(edtSequenciaBaixa.Text))  Then
      Begin
        SQL.Add(' ORDER BY CTR_SEQCON DESC, CTR_DTABAI DESC, CTR_EMPBAI');

        ParamByName('SEQBAIXA').AsString := edtSequenciaBaixa.Text;
        ParamByName('SEQEMP').AsString := VS_strCodEmp;

      End
      Else
      Begin
        SQL.Add(' ORDER BY CTR_SEQCON DESC, CTR_EMPBAI');

        If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
        Begin

          ParamByName('NUMDOC').AsString := edtNumDoc.Text;
          ParamByName('ESPDOC').AsString := edtEspDoc.Text;

        End
        Else
        Begin
          //Colocada essa verificação pois é chamada essa tela pelo caixa, para reimprimir CC
          If Not blnCaixaCC Then
          Begin
            ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
          End;

          If Not fEmptyStr(edtNumDoc.Text) Then
            ParamByName('NUMDOC').AsString := edtNumDoc.Text;

          If Not fEmptyStr(edtEspDoc.Text) Then
            ParamByName('ESPDOC').AsString := edtEspDoc.Text;

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

          If Not fEmptyStr(edtCodCliente.Text) Then
            ParamByName('CODCLI').AsString := edtCodCliente.Text;

        End
      End;

      Open;

      (FieldByName('CTR_VALREC') As TFloatField).DisplayFormat := '#,##0.00';
    End;

    If Not qryGenCtr.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmRelCtrReimpressaoDocsList,frmRelCtrReimpressaoDocsList);
        frmRelCtrReimpressaoDocsList.qryGenCtr := qryGenCtr;

        If fEmptyStr(edtSequenciaBaixa.Text) Then
          frmRelCtrReimpressaoDocsList.ShowModal
        Else
        Begin
          qryGenCtr.First;

          frmRelCtrReimpressaoDocsList.cdsGenCtr := fCriaClientDatset(qryGenCtr);

          frmRelCtrReimpressaoDocsList.cdsGenCtr.First;

          LUltimaDataBaixa := frmRelCtrReimpressaoDocsList.cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime;
          While Not frmRelCtrReimpressaoDocsList.cdsGenCtr.Eof do
          Begin
            If LUltimaDataBaixa <> frmRelCtrReimpressaoDocsList.cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime Then
            Begin
              frmRelCtrReimpressaoDocsList.cdsGenCtr.Delete;

              Continue;
            End;

            frmRelCtrReimpressaoDocsList.cdsGenCtr.Edit;
            frmRelCtrReimpressaoDocsList.cdsGenCtr.FieldByName('CTR_MARDES').AsString := 'M';

            If frmRelCtrReimpressaoDocsList.cdsGenCtr.FieldByName('CTR_CREDITO').Value > 0 Then
              frmRelCtrReimpressaoDocsList.cdsGenCtr.FieldByName('CTR_CREDITO').Value := 0;

            frmRelCtrReimpressaoDocsList.cdsGenCtr.Post;

            frmRelCtrReimpressaoDocsList.cdsGenCtr.Next;
          End;

          frmRelCtrReimpressaoDocsList.dtsGenCtr := fCriaDataSource(frmRelCtrReimpressaoDocsList.cdsGenCtr);
          frmRelCtrReimpressaoDocsList.fImprimirDocumento(True);
          FreeAndNil(frmRelCtrReimpressaoDocsList.cdsGenCtr);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmRelCtrReimpressaoDocs.btnImprimirClick]');
        End;
      End;

      pFreeAndNil(frmRelCtrReimpressaoDocsList);

    End
    Else
    Begin
      fMensagem('','Não há dados para gerar reimpressão!!!',['&O K']);

      If (Sender = edtNumDoc) Then
      Begin
        edtNumDoc.Clear;
      End;

    End;

  Finally
    btnImprimir.Enabled := True;
    FreeAndNil(qryGenCtr);
  End;

end;

procedure TfrmRelCtrReimpressaoDocs.edtSequenciaBaixaExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtSequenciaBaixa.Text)) Then
  Begin
    edtNumDoc.Enabled := False;
    edtEspDoc.Enabled := False;
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;
    edtCodEmpresa.Enabled := False;
    edtCodCliente.Enabled := False;
    pSetFocus(btnImprimir);
  End
  Else
  Begin
    edtNumDoc.Enabled := True;
    edtEspDoc.Enabled := True;
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
    edtCodEmpresa.Enabled := True;
    edtCodCliente.Enabled := True;
    //pSetFocus(edtNumDoc);
  End;

end;

end.

