unit untCalculaComissaoProfissionais;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, StdCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, MaskEditFocus, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, UniClientDataSet,
  Mask, AppEvnts, BitBtnLockedIncrem, frxClass, untFuncoes, untFuncoesGenerica,
  frxExportCSVTestabilidade, Datasnap.DBClient, untBaixaReceber, untBaixaCtaPagar,
  untTypesSistema,untFuncoesConsulta,untConsultas,untPesqAux;

type
  TfrmCalculaComissaoProfissionais = class(TfrmPaiSimples)
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    dtsComPro: TDataSource;
    pnlFundoGeral: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    pnlGrid: TPanel;
    pnlTotais: TPanel;
    dbgComissoes: TDBGridCitel;
    pnlTotal: TPanel;
    Label23: TLabel;
    lblNumReg: TLabel;
    edtTotNroCom: TEditFocus;
    edtTotValTot: TEditFocus;
    pnlMenuBtn: TPanel;
    pnlInformativos: TPanel;
    pnlSelecionados: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtSelNroCom: TEditFocus;
    edtSelValTot: TEditFocus;
    Label6: TLabel;
    edtProfissional: TEditFocus;
    Bevel1: TBevel;
    Label5: TLabel;
    edtCodCom: TEditFocus;
    edtDtaCad: TEditFocus;
    Label1: TLabel;
    edtCreDeb: TEditFocus;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    Label7: TLabel;
    lblValComiss: TLabel;
    Label10: TLabel;
    edtValVen: TEditFocus;
    edtValCom: TEditFocus;
    edtCli: TEditFocus;
    Label11: TLabel;
    Label12: TLabel;
    edtEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    Label13: TLabel;
    lblTotComiss: TLabel;
    edtSelTotCom: TEditFocus;
    cdsRecibo: TUniClientDataSet;
    cdsReciboNOMREC: TStringField;
    cdsReciboVALREC: TFloatField;
    cdsReciboVALEXT: TStringField;
    cdsReciboHISREC: TStringField;
    cdsReciboNOMASS: TStringField;
    cdsReciboNROVIA: TIntegerField;
    cdsReciboDTAREC: TStringField;
    cdsReciboVALTOT: TFloatField;
    cdsReciboVALIMP: TFloatField;
    cdsReciboNOMLIB: TStringField;
    cdsReciboNROREC: TStringField;
    cdsReciboNUMPIS: TStringField;
    cdsReciboMARCA_: TStringField;
    BitBtn1: TBitBtnLocked;
    button: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    Button23: TBitBtnLocked;
    btnSaida: TBitBtnLocked;
    btnMarTds: TBitBtnLocked;
    btnDesTds: TBitBtnLocked;
    btnLocPro: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    cdsReciboHISREC_02: TStringField;
    btnCarrDocumentos: TBitBtnLocked;
    Label9: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label20: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    cdsReciboHISREC_03: TStringField;
    procedure FormShow(Sender: TObject);
    procedure dbgComissoesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgComissoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgComissoesDblClick(Sender: TObject);
    procedure btnMarTdsClick(Sender: TObject);
    procedure btnDesTdsClick(Sender: TObject);
    procedure btnLocProClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnSaidaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarrDocumentosClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPais: TPais;
    strValorFiltro: String;
    strCampoFiltro: String;
    strNomImp: String;
    strTipImp: String;
    frxRecibo: TfrxReport;
    fltTotComSel: Double;

    stlLisSel: TStringList;
    intRecAtu: Integer;

    cdsComPro: TUniClientDataSet;
    blnMarcando: Boolean;
    arrEmp     : TConsultasArray;
    arrCli     : TConsultasArray;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;

    FCdsComissaoAbatidas : TUniClientDataSet;
    FValorTotalComissao : Double;

    function fBaixaComissao: Boolean;
    function fComissaoJaBaixada: Boolean;

    procedure pLoadDados(blnLimit : Boolean = False);
    procedure pSelecionaDocumento;
    procedure pSetMarDesAll(blnMarcar: Boolean);
    procedure pAtualizaTotais;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pImprimeRecibo;
    procedure InsereRegistroBaixaComissao;
    procedure CriaTemporariaComissaoRecebida;
    function fBaixaCtp(pStrNomeTabela, pStrAutoIncrem, pStrTelaFuncaoDeOrigem, pStrCodPorFix: String;
                       pDteDtaPagFix: TDateTime; pFltValLanLoc: Double): Boolean;
    function fBaixaCtr(pStrCodCliFix, pStrCodEmpFix: String): Boolean;
    function  fLoadReport : Boolean;
    function GetValorComissao: Double;
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
  public
    { Public declarations }
    strCodPro,
    strCodFor,
    strCodEmp: String;

    VS_strTCoProInterna: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

var
  frmCalculaComissaoProfissionais: TfrmCalculaComissaoProfissionais;

implementation

uses SysUtils, Graphics, strUtils, DateUtils, UniDataSetProvider,
  untfuncoesSimples, untBuscaComissao, untPai, untBaixaProfiss, untCadPag,
  untModuloCalculaComissaoProfissionais, untCfgRel, untValorPorExtenso,
  untDigInformacoesRPA, untLogCom, untModulo;

{$R *.dfm}

procedure TfrmCalculaComissaoProfissionais.pCarregaCliente;
begin
  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
    With qryConCli Do
    Begin
      edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
    End;
  End
  Else
    edtNomCli.Clear;
end;

function TfrmCalculaComissaoProfissionais.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {***********************}
  {* VALIDA DATA INICIAL *}
  {********************JB*}
  If (Sender = mskDtaIni) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    If (fEmptyStr(edtCodEmp.Text)) Then
    Begin
      edtNomEmp.Clear;
    End
    Else
    Begin
      If Not SameText(edtCodEmp.Text, '000') Then
      Begin
        SetLength(arrEmp, 0);

        pCarregaEmpresa;
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End

  Else If (Sender = edtCodCli) Then
  Begin
    If Not fEmptyStr(edtCodCli.Text) Then
    Begin
      pDesmarcaLista(edtCodCli, arrCli, 'TMP_CLIENTE');

      If edtCodCli.Text <> '00000000' Then
      Begin
        pCarregaCliente;
      End;
    End
    Else
    Begin
      edtNomCli.Text := 'TODOS';
      Result := True;
    End;
  End

  {*********************}
  {* VALIDA DATA FINAL *}
  {******************JB*}
  Else If (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
      Result := False;
    End

    Else If Not (fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
      Result := False;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCalculaComissaoProfissionais.GetValorComissao: Double;
  Var
    LQryComPro: TUniQuery;
    LSql: String;
    LCont: Integer;
begin
  Result := fltTotComSel;

  Try
    LQryComPro := fCriaQuery(Nil);

    LSql := '';
    LSql := LSql + 'SELECT                 ';
    LSql := LSql + '  SUM(                 ';
    LSql := LSql + 'IF(                    ';
    LSql := LSql + '  COM_CREDEB = "C",    ';
    LSql := LSql + '  COM_VRCOMI,          ';
    LSql := LSql + '  COM_VRCOMI * - 1     ';
    LSql := LSql + ')                      ';
    LSql := LSql + '  ) AS COMISSAO        ';
    LSql := LSql + 'FROM                   ';
    LSql := LSql + '  COMPRO               ';
    LSql := LSql + 'WHERE                  ';
    LSql := LSql + '  AUTOINCREM IN       (';

    For LCont := 0 To stlLisSel.Count -1 Do
    Begin
      LSql := LSql + QuotedStr(stlLisSel[LCont]);
      If LCont + 1 < stlLisSel.Count Then
         LSql := LSql + ',';
    End;

    LSql := LSql + ')';

    Try
      LQryComPro.Close;
      LQryComPro.Sql.Clear;
      LQryComPro.Sql.Add(LSql);
      LQryComPro.Open;

      If Not LQryComPro.IsEmpty Then
        Result := LQryComPro.FieldByName('COMISSAO').AsFloat;

    Except
      On E: Exception Do
      Begin
        Result := fltTotComSel;
      End;
    End;

  Finally
    FreeAndNil(LQryComPro);
  End;
end;

procedure TfrmCalculaComissaoProfissionais.InsereRegistroBaixaComissao;
var
  LQryComissoes : TUniQuery;
  LSQL : String;
begin
  FValorTotalComissao := 0.0;

  LSQL := EmptyStr;
  LSQL := LSQL + '  SELECT ' ;
  LSQL := LSQL + '    REC.CTR_NUMDUP, ' ;
  LSQL := LSQL + '    REC.CTR_ESPDOC, ' ;
  LSQL := LSQL + '    REC.CTR_CODCLI, ' ;
  LSQL := LSQL + '    COM.COM_SEQCTR, ' ;
  LSQL := LSQL + '    COM.COM_VALCTR AS CTR_VALORI, ' ;
  LSQL := LSQL + '    COM.COM_VALCOM AS CTR_VALREC ' ;
  LSQL := LSQL + '  FROM ACECOM_LOG COM ' ;
  LSQL := LSQL + '  INNER JOIN CADREC REC ON REC.CTR_CODEMP = COM.COM_EMPBAI ' ;
  LSQL := LSQL + '                AND REC.CTR_SEQCON = COM.COM_SEQCTR ' ;
  LSQL := LSQL + ' WHERE COM.COM_CODDIV = :CODPRO ' ;
  LSQL := LSQL + '   AND COM.COM_SEQCTR > 0 ' ;

  If Not fEmptyStr(edtCodEmp.Text) Then
    LSQL := LSQL + '  AND COM.COM_EMPBAI = :CODEMP ' ;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then

    LSQL := LSQL + '  AND COM.COM_DTABAI BETWEEN :DTAINI AND :DTAFIN ' ;

  LQryComissoes := fCriaQuery(nil);
  try
    LQryComissoes.Close;
    LQryComissoes.SQL.Text := LSQL;

    LQryComissoes.ParamByName('CODPRO').AsString := strCodPro;

    If Not fEmptyStr(edtCodEmp.Text) Then
      LQryComissoes.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      LQryComissoes.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      LQryComissoes.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    LQryComissoes.Open;

    LQryComissoes.First;
    while not LQryComissoes.Eof do
    begin

      FCdsComissaoAbatidas.Append;
      FCdsComissaoAbatidas.FieldByName('DUPLICATA').AsString := LQryComissoes.FieldByName('CTR_NUMDUP').AsString;
      FCdsComissaoAbatidas.FieldByName('ESPECIE').AsString   := LQryComissoes.FieldByName('CTR_ESPDOC').AsString;
      FCdsComissaoAbatidas.FieldByName('CLIENTE').AsString   := LQryComissoes.FieldByName('CTR_CODCLI').AsString;
      FCdsComissaoAbatidas.FieldByName('VALOR_ORIGINAL').AsFloat := fFormataFloat(LQryComissoes.FieldByName('CTR_VALORI').AsFloat, 2);
      FCdsComissaoAbatidas.FieldByName('VALOR_ABATIDO').AsFloat  := fFormataFloat(LQryComissoes.FieldByName('CTR_VALREC').AsFloat, 2);
      FCdsComissaoAbatidas.Post;

      FValorTotalComissao := FValorTotalComissao + fFormataFloat(LQryComissoes.FieldByName('CTR_VALREC').AsFloat, 2);
      LQryComissoes.Next;
    end;
  finally
    FreeAndNil(LQryComissoes);
  end;
end;

{***********************************}
{* CARREGA OS DADOS PARA DBGRID    *}
{********************************JB*}
procedure TfrmCalculaComissaoProfissionais.pLoadDados(blnLimit : Boolean);
  Var
    strSQL: String;
    qryComPro: TUniQuery;
    pvdComPro: TUniDataSetProvider;
    strEmp: String;
    strCli: String;
begin
  strEmp:= '';
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COM_CODCOM AS "Código",       ';
  strSQL := strSQL + '  COM_DTACAD AS "Dta Cadastro", ';
  strSQL := strSQL + '  COM_CREDEB AS "C_D",          ';
  strSQL := strSQL + '  COM_NUMDOC AS "Documento",    ';
  strSQL := strSQL + '  COM_ESPDOC AS "Espécie",      ';
  strSQL := strSQL + '  COM_CODEMP AS "Empresa",      ';
  strSQL := strSQL + '  COM_VRVEND AS "Vr Venda",     ';

  If VS_strTCoProInterna = '3' Then
    strSQL := strSQL + '  COM_VRCOMI AS "Qtd Pontos",   '
  Else
    strSQL := strSQL + '  COM_VRCOMI AS "Vr Comissão",   ';

  strSQL := strSQL + '  CLI_NOMCLI AS "Nome Cliente", ';
  strSQL := strSQL + '  COMPRO.AUTOINCREM AS "AUTOINCREM", ';
  strSQL := strSQL + '  "N" AS MARDES  ';
  strSQL := strSQL + 'FROM      ';
  strSQL := strSQL + '  COMPRO  ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON (CLI_CODCLI = COM_CODCLI) ';
  strSQL := strSQL + '  LEFT JOIN CADDIV ON (DIV_CODDIV = COM_CODPRO) ';
  strSQL := strSQL + 'WHERE     ';

  strSQL := strSQL  + ' IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(VS_strTCoProInterna) +
                                       ', COM_TCOPRO) = ' + QuotedStr(VS_strTCoProInterna) + ' AND ';

  strSQL := strSQL + '  COM_DTABAI IS NULL AND  ';
  strSQL := strSQL + '  COM_CODPRO = :CODPRO  ';

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'COM_CODEMP', 'CODEMP');

  If (Not fEmptyStr(edtCodCli.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'COM_CODCLI', 'CODCLI');

  If Not blnLimit Then
    strSQL := strSQL + '  AND COM_DTACAD BETWEEN :DTAINI AND :DTAFIN '
  Else
    strSQL := strSQL + '  LIMIT 0 ';

  qryComPro := fCriaQuery(Self);
  pvdComPro := TUniDataSetProvider.Create(Self);
  pvdComPro.DataSet := qryComPro;

  With qryComPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;

    If Not blnLimit Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryComPro);

    If (Not fEmptyStr(edtCodCli.Text)) Then
      pSetaParam(edtCodCli.Text, arrCli, strCli, 'CODCLI', qryComPro);

    Open;

    pSetaClient(qryComPro);

    If Assigned(cdsComPro) Then
      FreeAndNil(cdsComPro);

    cdsComPro := TUniClientDataSet.Create(Self);
    cdsComPro.SetProvider(pvdComPro);
    cdsComPro.Open;
    pSetaClient(cdsComPro);

    dtsComPro.DataSet := cdsComPro;
    cdsComPro.AfterPost := pAfterPost;
    cdsComPro.AfterScroll := pAtualizaDados;
    cdsComPro.OnFilterRecord := pFilterRecord;
  End;

  FreeAndNil(pvdComPro);
  FreeAndNil(qryComPro);

  (cdsComPro.FieldByName('Dta Cadastro') As TDateField).EditMask      := '99/99/9999';
  (cdsComPro.FieldByName('Vr Venda') As TFloatField).DisplayFormat    := '#,##0.00';
  (cdsComPro.FieldByName('Vr Venda') As TFloatField).EditFormat       := '#,##0.00';
  (cdsComPro.FieldByName('Vr Venda') As TFloatField).Alignment        := taRightJustify;

  If VS_strTCoProInterna = '3' Then
  Begin
    (cdsComPro.FieldByName('Qtd Pontos') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsComPro.FieldByName('Qtd Pontos') As TFloatField).EditFormat    := '#,##0.00';
    (cdsComPro.FieldByName('Qtd Pontos') As TFloatField).Alignment     := taRightJustify;
  End
  Else
  Begin
    (cdsComPro.FieldByName('Vr Comissão') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsComPro.FieldByName('Vr Comissão') As TFloatField).EditFormat    := '#,##0.00';
    (cdsComPro.FieldByName('Vr Comissão') As TFloatField).Alignment     := taRightJustify;
  End;

  dbgComissoes.Columns[02].Title.Caption := 'C/D';

  dbgComissoes.Columns[06].Title.Alignment := taRightJustify;
  dbgComissoes.Columns[07].Title.Alignment := taRightJustify;

  dbgComissoes.Columns[09].Visible := False;
  dbgComissoes.Columns[10].Visible := False;

  pAtualizaTotais;
end;


procedure TfrmCalculaComissaoProfissionais.FormShow(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  If VS_strTCoProInterna = '3' Then
  Begin
    lblValComiss.Caption := 'Pontuação:';
    lblTotComiss.Caption := 'Total pontos:';
  End;

  mskDtaIni.Text := FormatDateTime('dd/MM/yyyy', VS_Date);
  mskDtaFin.Text := mskDtaIni.Text;
  edtCodEmp.text := strCodEmp;
  pSetFocus(edtCodEmp);

  If Not fEmptyStr(edtCodEmp.Text) Then
    fValidaCampos(edtCodEmp);

  pLoadDados(False);

end;

procedure TfrmCalculaComissaoProfissionais.dbgComissoesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {**************************************************}
  {* ALTERA A COR PARA AS LINHAS MARCADAS NA DBGRID *}
  {***********************************************JB*}
  If cdsComPro.FieldByName('MARDES').AsString = 'S' Then
    If (intRecAtu = cdsComPro.RecNo) Then
      dbgComissoes.Canvas.Font.Color := clLime
    Else
      dbgComissoes.Canvas.Font.Color := clBlue;

  dbgComissoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

{************************************}
{* SELECIONA COMISSOES DA DBGRID    *}
{*********************************JB*}
procedure TfrmCalculaComissaoProfissionais.pSelecionaDocumento;
  Var
    BookMark : TBookmark;
    strValOld: String;
    intIndex : Integer;
begin
  If (Not cdsComPro.IsEmpty) Then
  Begin
    BookMark := cdsComPro.GetBookmark;
    cdsComPro.DisableControls;
    Try
      strValOld := cdsComPro.FieldByName('MARDES').AsString;
      cdsComPro.Edit;
      If (strValOld = 'N') Then
      Begin
        cdsComPro.FieldByName('MARDES').AsString := 'S';
        If Not stlLisSel.Find(cdsComPro.FieldByName('AUTOINCREM').AsString,intIndex) Then
          stlLisSel.Add(cdsComPro.FieldByName('AUTOINCREM').AsString);
      End Else
      Begin
        cdsComPro.FieldByName('MARDES').AsString := 'N';
        If stlLisSel.Find(cdsComPro.FieldByName('AUTOINCREM').AsString,intIndex) Then
          stlLisSel.Delete(intIndex);
      End;
      cdsComPro.Post;
    Finally
      cdsComPro.GotoBookmark(BookMark);
      cdsComPro.FreeBookmark(BookMark);
      cdsComPro.EnableControls;
    End;
  End;
end;

procedure TfrmCalculaComissaoProfissionais.dbgComissoesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = Vk_Return) Then
    pSelecionaDocumento
  Else If Key = VK_Escape Then
  Begin
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    edtCodEmp.Clear;
    edtNomEmp.Clear;
    edtNomCli.Clear;

    pLoadDados(True);

    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
    edtCodEmp.Enabled := True;
    edtCodCli.Enabled := True;

    pSetFocus(edtCodEmp);

  End;


end;

procedure TfrmCalculaComissaoProfissionais.edtCodCliExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCli, nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmCalculaComissaoProfissionais.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqCliente(conCliAgrupDup, Self, edtCodCli, edtNomCli, Nil, Key, arrCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalculaComissaoProfissionais.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmCalculaComissaoProfissionais.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalculaComissaoProfissionais.dbgComissoesDblClick(
  Sender: TObject);
begin
  inherited;

  pSelecionaDocumento;

end;

procedure TfrmCalculaComissaoProfissionais.btnMarTdsClick(Sender: TObject);
begin
  inherited;

  pSetMarDesAll(True);

end;

{*******************************************}
{* MARCA E DESMAR TODOS OS ITENS DA DBGRID *}
{****************************************JB*}
procedure TfrmCalculaComissaoProfissionais.pSetMarDesAll(blnMarcar: Boolean);
begin
  If cdsComPro.IsEmpty Then
  Begin
    fMensagem('', 'É necessário ter registros para a consulta!', ['&Ok']);
    Exit;
  End;


  With cdsComPro Do
  Begin

    stlLisSel.Clear;
    blnMarcando := True;
    Try

      cdsComPro.DisableControls;

      First;

      While Not Eof DO
      Begin
        Edit;
        FieldByName('MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
        Post;

        If blnMarcar Then
          stlLisSel.Add(FieldByName('AUTOINCREM').AsString);

        Next
      End;

    Finally
      First;
      cdsComPro.EnableControls;
      blnMarcando := False;
      pAtualizaTotais;
    End;

  End;

end;


procedure TfrmCalculaComissaoProfissionais.btnDesTdsClick(Sender: TObject);
begin
  inherited;

  pSetMarDesAll(False);

end;

{*****************************************}
{* MOSTRA OS TOTAIS (SELECIONADAS\TODOS) *}
{**************************************JB*}
procedure TfrmCalculaComissaoProfissionais.pAfterPost(DataSet: TDataSet);
begin
  If not blnMarcando Then
    pAtualizaTotais;
end;

procedure TfrmCalculaComissaoProfissionais.pAtualizaDados(DataSet: TDataSet);
begin
  If blnMarcando Then
    Exit;
    
  {***********************************}
  {* CARREGA OS DADOS NAS EDITS      *}
  {********************************JB*}
  With cdsComPro Do
  Begin
    edtCodCom.Text := FieldByName('Código').AsString;
    edtDtaCad.Text := FormatDateTime('dd/MM/yyyy', FieldByName('Dta Cadastro').AsDateTime);
    edtCreDeb.Text := FieldByName('C_D').AsString;
    edtNumDoc.Text := FieldByName('Documento').AsString;
    edtEspDoc.Text := FieldByName('Espécie').AsString;
    edtEmp.Text    := FieldByName('Empresa').AsString;
    edtValVen.Text := FloatToStrF(FieldByName('Vr Venda').AsFloat, ffFixed, 15, 2);
    If VS_strTCoProInterna =  '3' Then
      edtValCom.Text := FloatToStrF(FieldByName('Qtd Pontos').AsFloat, ffFixed, 15, 2)
    Else
      edtValCom.Text := FloatToStrF(FieldByName('Vr Comissão').AsFloat, ffFixed, 15, 2);
    edtCli.Text    := FieldByName('Nome Cliente').AsString;

    intRecAtu := RecNo;

  End;

end;

procedure TfrmCalculaComissaoProfissionais.pAtualizaTotais;
  Var
    fltValCom: Double;
    intQtdCom: Integer;

    BookMark : TBookmark;

    fltValComSel: Double;
    intQtdComSel: Integer;

begin
  intQtdCom := 0;
  fltValCom := 0;
  intQtdComSel := 0;
  fltValComSel := 0;
  fltTotComSel := 0;

  BookMark := cdsComPro.GetBookmark;

  With cdsComPro Do
  Begin
    DisableControls;
    First;
    While (Not Eof) Do
    Begin
      If FieldByName('C_D').AsString = 'C' Then
        fltValCom := fltValCom + FieldByName('Vr Venda').AsFloat
      Else
        fltValCom := fltValCom - FieldByName('Vr Venda').AsFloat;

      Inc(intQtdCom);

      If FieldByName('MARDES').AsString = 'S' Then
      Begin
        If FieldByName('C_D').AsString = 'C' Then
        Begin
          fltValComSel := fltValComSel + FieldByName('Vr Venda').AsFloat;
          If VS_strTCoProInterna = '3' Then
            fltTotComSel := fltTotComSel + FieldByName('Qtd Pontos').AsFloat
          Else
            fltTotComSel := fltTotComSel + FieldByName('Vr Comissão').AsFloat;
        End Else
        Begin
          fltValComSel := fltValComSel - FieldByName('Vr Venda').AsFloat;
          If VS_strTCoProInterna = '3' Then
            fltTotComSel := fltTotComSel - FieldByName('Qtd Pontos').AsFloat
          Else
            fltTotComSel := fltTotComSel - FieldByName('Vr Comissão').AsFloat;
        End;
        Inc(intQtdComSel);
      End;

      Next;
    End;

    EnableControls;

  End;

  cdsComPro.GotoBookmark(BookMark);
  cdsComPro.FreeBookmark(BookMark);

  edtTotNroCom.Text := FloatToStrF(intQtdCom, ffFixed, 15, 2);
  edtTotValTot.Text := FloatToStrF(fltValCom, ffFixed, 15, 2);

  edtSelNroCom.Text := FloatToStrF(intQtdComSel, ffFixed, 15, 2);
  edtSelValTot.Text := FloatToStrF(fltValComSel, ffFixed, 15, 2);

  edtSelTotCom.Text := FloatToStrF(fltTotComSel, ffFixed, 15, 2);

end;

procedure TfrmCalculaComissaoProfissionais.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmCalculaComissaoProfissionais.btnLocProClick(Sender: TObject);
begin
  inherited;

  If cdsComPro.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If (cdsComPro.Active) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsComPro.FindNext Then
      fMensagem('ATENÇÃO!', 'Nenhum registro encontrado!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmCalculaComissaoProfissionais.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;


procedure TfrmCalculaComissaoProfissionais.pImprimeRecibo;
  Var
    qryRecibo: TUniQuery;
    strSQL   : String;
    fltValTot: Double;
    fltTotGer: Double;
    intCont  : Integer;
    
Begin
  Try
    pnlInfo.Caption := 'Gerando Recibo(s)...';
    pnlInfo.Repaint;

    qryRecibo := fCriaQuery;
    cdsRecibo.CreateDataSet;

    CriaTemporariaComissaoRecebida;

    fltValTot := 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  COM_CODEMP, ';
    strSQL := strSQL + '  CONCAT(COM_NUMDOC, "-", COM_ESPDOC, "-", COM_CODEMP) AS COM_NUMDOC,';
    {************************************************************}
    {*** O VR COM SOMANDO, MESMO QUANDO ERA DO TIPO DE DEBITO ***}
    {** REQ.29919 ********************************************BB*}
    strSQL := strSQL + '  IF(COM_CREDEB = "D", (COM_VRCOMI *(-1)), COM_VRCOMI) AS COM_VRCOMI,';
    strSQL := strSQL + '  COM_DTABAI, ';
    strSQL := strSQL + '  COM_DTABAI, ';
    strSQL := strSQL + '  COM_DTACAD, ';
    strSQL := strSQL + '  COM_OBSERV, ';
    strSQL := strSQL + '  COM_VRVEND, ';
    strSQL := strSQL + '  DIV_NOMDIV, ';
    strSQL := strSQL + '  DIV_NUMPIS, ';
    strSQL := strSQL + '  CLI_NOMCLI  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  COMPRO B    ';
    strSQL := strSQL + '  JOIN CADDIV P ON P.DIV_CODDIV = B.COM_CODPRO ';
    strSQL := strSQL + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = B.COM_CODCLI ';
    strSQL := strSQL + 'WHERE         ';
    //strSQL := strSQL + '  B.AUTOINCREM IN (' + stlLisSel.CommaText + ')';
    strSQL := strSQL + '  B.AUTOINCREM IN (';

    For intCont := 0 To stlLisSel.Count -1 Do
    Begin
      strSQL := strSQL + QuotedStr(stlLisSel[intCont]);

      If intCont + 1 < stlLisSel.Count Then
        strSQL := strSQL + ',';
    End;

    strSQL := strSQL + ')';

    With qryRecibo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := strSQL;
      Open;
      If (fCfgSis('MODRPA') = '1') Then
      Begin
        While Not Eof Do
        Begin
          cdsRecibo.Append;
          cdsReciboNOMREC.AsString  := fRetNomeEmpresaSelec(FieldByName('COM_CODEMP').AsString);
          If VS_strTCoProInterna <> '3' Then
          Begin
            cdsReciboVALREC.AsFloat   := fFormataFloat(IIF(fCfgSis('PESGSO', varDouble) > 0, FieldByName('COM_VRCOMI').AsFloat - (fCfgSis('PESGSO', varDouble) * FieldByName('COM_VRCOMI').AsFloat / 100), FieldByName('COM_VRCOMI').AsFloat), 2);
            cdsReciboVALEXT.AsString  := UpperCase(fRetExtensoNumero(cdsReciboVALREC.AsString));
            cdsReciboHISREC.AsString  := 'COMISSAO REF. FATURAMENTO ' + FieldByName('COM_NUMDOC').AsString + '  ' + FieldByName('COM_DTACAD').AsString + ' - ' + 'R$ ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + FieldByName('CLI_NOMCLI').AsString) +
                                         IIF(fCfgSis('PESGSO', varDouble) > 0, ' DEDUZIDO ' + FormatFloat(',0.00%', fCfgSis('PESGSO', varDouble)) + ' A TITULO DE SEGURIDADE SOCIAL.', '');
            cdsReciboHISREC_02.AsString  := 'COMISSAO REF. FATURAMENTO ' + FieldByName('COM_NUMDOC').AsString + '  ' + FieldByName('COM_DTACAD').AsString + ' - ' + 'R$ ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + FieldByName('CLI_NOMCLI').AsString);
          End
          Else
          Begin
            cdsReciboVALREC.AsFloat   := fFormataFloat(FieldByName('COM_VRCOMI').AsFloat, 2);
            cdsReciboVALEXT.AsString  := '';
            cdsReciboHISREC.AsString  := 'COMISSAO REF. FATURAMENTO ' + FieldByName('COM_NUMDOC').AsString + '  ' + FieldByName('COM_DTACAD').AsString + ' - ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + FieldByName('CLI_NOMCLI').AsString);
          End;
          cdsReciboHISREC_03.AsString := 'COMISSAO ' + FieldByName('COM_OBSERV').AsString + ' '  + FieldByName('COM_NUMDOC').AsString + '  ' + FieldByName('COM_DTACAD').AsString + ' - ' + 'R$ ' + FormatFloat('#,##0.00', FieldByName('COM_VRVEND').AsFloat) + ' - ' +
            'R$ ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + FieldByName('CLI_NOMCLI').AsString);
          cdsReciboDTAREC.AsString  := fRetDataExtenso(FieldByName('COM_DTABAI').AsDateTime, True);
          cdsReciboNOMASS.AsString  := FieldByName('DIV_NOMDIV').AsString;
          cdsReciboNROVIA.AsInteger := 1;
          cdsReciboMARCA_.AsString  := '-';
          fltValTot := fltValTot + cdsReciboVALREC.AsFloat;
          cdsRecibo.Post;
          Next;
        End;

        InsereRegistroBaixaComissao;
      End
      Else
      Begin
        pCriarFormularios(TfrmDigInformacoesRPA, frmDigInformacoesRPA);
        If frmDigInformacoesRPA.ShowModal = mrOK Then
        Begin
          cdsRecibo.Append;
          cdsReciboNROREC.AsString  := fRetSequencial('SEQRPA') + '/' + Copy(IntToStr(YearOf(Date)), 3, 2);
          cdsReciboNOMREC.AsString  := fRetNomeEmpresaSelec(FieldByName('COM_CODEMP').AsString);
          cdsReciboHISREC.AsString  := frmDigInformacoesRPA.mmoHisRec.Lines.Text;
          cdsReciboDTAREC.AsString  := fRetDataExtenso(FieldByName('COM_DTABAI').AsDateTime, True);
          cdsReciboNOMASS.AsString  := FieldByName('DIV_NOMDIV').AsString;
          cdsReciboNROVIA.AsInteger := 1;
          cdsReciboNOMLIB.AsString  := frmDigInformacoesRPA.edtNomOpe.Text;

          If VS_strTCoProInterna <> '3' Then
            cdsReciboNUMPIS.AsString  := FieldByName('DIV_NUMPIS').AsString
          Else
            cdsReciboNUMPIS.AsString  := '';

          cdsRecibo.Post;
          cdsRecibo.First;
          fltTotGer := 0;
          While Not Eof Do
          Begin
            cdsRecibo.Edit;
            cdsReciboVALTOT.AsFloat  := cdsReciboVALTOT.AsFloat + fFormataFloat(FieldByName('COM_VRCOMI').AsFloat, 2);

            fltTotGer := fltTotGer + FieldByName('COM_VRCOMI').AsFloat;

            cdsRecibo.Post;
            Next;
          End;
          {**********************************}
          {* ALTERADA A ROTINA POIS HOUVE   *}
          {* DIFERENÇA DE R$ 0,03 NO VALOR  *}
          {* DO IMPOSTO VISTO NA FIGUEIREDO *}
          {*******************************JU*}
          cdsRecibo.Edit;
          If VS_strTCoProInterna <> '3' Then
          Begin
            cdsReciboVALIMP.AsFloat := fFormataFloat(IIF(fCfgSis('PESGSO', varDouble) > 0, fltTotGer * (fCfgSis('PESGSO', varDouble) / 100), 0), 2);
            cdsReciboVALREC.AsFloat := cdsReciboVALTOT.AsFloat - cdsReciboVALIMP.AsFloat;
            cdsReciboVALEXT.AsString := UpperCase(fRetExtensoNumero(cdsReciboVALREC.AsString));
          End
          Else
          Begin
            cdsReciboVALIMP.AsFloat := fFormataFloat(0, 2);
            cdsReciboVALREC.AsFloat := cdsReciboVALTOT.AsFloat - cdsReciboVALIMP.AsFloat;
            cdsReciboVALEXT.AsString := '';
          End;
          cdsRecibo.Post;
        End;
      End;
      cdsRecibo.First;
      If Not cdsRecibo.IsEmpty Then
      Begin

        pCarregaConfImpr(qryCfgRel, 'frmRelFatReciboAvulso');
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
        strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
        fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

        pCriarFormularios(TfrmModuloCalculaComissaoProfissionais,frmModuloCalculaComissaoProfissionais);
        With frmModuloCalculaComissaoProfissionais Do
        Begin
          frxRelatorio.DataSet := cdsRecibo;
          frxReportsBaixas.DataSet := FCdsComissaoAbatidas;

          If Not Assigned(frxRecibo) Then
             frxRecibo := TfrxReport.Create(Self);
          If (fCfgSis('MODRPA') = '1') Then
          Begin
            If Not fLoadReport Then
            Begin
              If (strTipImp = 'M') Then
                frxRecibo := frxReciboM
              Else
                frxRecibo := frxReciboJ;
            End;

            frxRecibo.Script.Variables['VALREC'] := FormatFloat('#,##0.00', fltValTot);
            frxRecibo.Script.Variables['ValorTotalComissao'] := FormatFloat('#,##0.00', FValorTotalComissao);
            If VS_strTCoProInterna <> '3' Then
            Begin
              frxRecibo.Script.Variables['VALEXT'] := UpperCase(fRetExtensoNumero(FormatFloat('#,##0.00', fltValTot)));
              frxRecibo.Script.Variables['MOEDA']  := 'R$';
              frxRecibo.Script.Variables['PONTO']  := '';
              frxRecibo.Script.Variables['(']      := '(';
              frxRecibo.Script.Variables[')']      := ')';
              frxRecibo.Script.Variables['ValorTotalComissaoExtenso'] := UpperCase(fRetExtensoNumero(FormatFloat('#,##0.00', FValorTotalComissao)));
            End
            Else
            Begin
              frxRecibo.Script.Variables['VALEXT'] := '';
              frxRecibo.Script.Variables['MOEDA']  := '';
              frxRecibo.Script.Variables['PONTO']  := 'Ptos.';
              frxRecibo.Script.Variables['(']      := '';
              frxRecibo.Script.Variables[')']      := '';
              frxRecibo.Script.Variables['ValorTotalComissaoExtenso'] := '';
            End;
          End
          Else
          Begin
            If Not fLoadReport Then
            Begin
              If (strTipImp = 'M') Then
                frxRecibo := frxRPAM
              Else
                frxRecibo := frxRPAJ;
            End;
          End;

          frxRecibo.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
          frxRecibo.Script.Variables['ENDEMP'] := fCampoTabela('EMP_ENDERE', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) + ', '  +
                                                  fCampoTabela('EMP_ENDNUM', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) + ' - ' +
                                                  fCampoTabela('EMP_BAIRRO', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) + ' - ' +
                                                  fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 0) + '/' +
                                                  fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 1);
          frxRecibo.Script.Variables['CGCEMP'] := fFormataCpfCgc(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]), FPais);
          frxRecibo.Script.Variables['IESEMP'] := fCampoTabela('EMP_I_E_S_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]);

          frxRecibo.Script.Variables['DTAINI'] := mskDtaIni.Text;
          frxRecibo.Script.Variables['DTAFIN'] := mskDtaFin.Text;

          frxRecibo.Script.Variables['CIDEMP'] := fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 0) + '/' +
                                                  fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 1);
          frxRecibo.Script.Variables['OPELIB'] := fRetNomeOperador(strLoginUsuarioLogado);

          If VS_strTCoProInterna <> '3' Then
          Begin
            frxRecibo.Script.Variables['PERIMP'] := fCfgSis('PESGSO');
            frxRecibo.Script.Variables['INSINSS']:= 'Nº INSCRIÇÃO NO INSS';
            frxRecibo.Script.Variables['RETINSS']:= 'RETENÇÃO DE INSS';
            frxRecibo.Script.Variables['MOEDA']  := 'R$';
            frxRecibo.Script.Variables['PONTO']  := '';
            frxRecibo.Script.Variables['(']      := '(';
            frxRecibo.Script.Variables[')']      := ')';
            frxRecibo.Script.Variables['%']      := '%';

            If strTipImp = 'M' Then
            Begin
              frxRecibo.Script.Variables['..']   := '..';
              frxRecibo.Script.Variables['-']    := '-';
            End;

          End
          Else
          Begin
            frxRecibo.Script.Variables['PERIMP'] := '';
            frxRecibo.Script.Variables['INSINSS']:= '';
            frxRecibo.Script.Variables['RETINSS']:= '';
            frxRecibo.Script.Variables['MOEDA']  := '';
            frxRecibo.Script.Variables['PONTO']  := 'Ptos.';
            frxRecibo.Script.Variables['(']      := '';
            frxRecibo.Script.Variables[')']      := '';
            frxRecibo.Script.Variables['%']      := '';

            If strTipImp = 'M' Then
            Begin
              frxRecibo.Script.Variables['..']   := '';
              frxRecibo.Script.Variables['-']    := '';
            End;
          End;

          frxRecibo.PrintOptions.ShowDialog := fEmptyStr(strNomImp);
          frxRecibo.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\', '');

          pPreviewReport('frmRelFatReciboAvulso', Self.Caption + ' (Recibo)', frxRecibo);
        End;

      End;
    End;
    pnlInfo.Caption := '';
    pnlInfo.Repaint;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmModuloCalculaComissaoProfissionais);
  FreeAndNil(qryRecibo);
end;

procedure TfrmCalculaComissaoProfissionais.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmCalculaComissaoProfissionais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsComPro) Then
    FreeAndNil(cdsComPro);

  FreeAndNil(qryConEmp);
  FreeAndNil(qryConCli);
end;

procedure TfrmCalculaComissaoProfissionais.FormCreate(Sender: TObject);
begin
  inherited;
  stlLisSel := TStringList.Create;
  stlLisSel.Sorted := True;
  FPais := fSetaPais;
  VS_strTCoProInterna := fCfgSis('TCOPRO');
end;

procedure TfrmCalculaComissaoProfissionais.btnIniBusClick(Sender: TObject);
  Var
    frmBuscaComissao : TfrmBuscaComissao;
begin
  inherited;

  If (Not cdsComPro.Active) Or
     (cdsComPro.IsEmpty)    Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    btnLocPro.Enabled := False;
    Exit;

  End;

  Try
    pCriarFormularios(TfrmBuscaComissao, frmBuscaComissao);
    frmBuscaComissao.ShowModal;

    If (Not fEmptyStr(frmBuscaComissao.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBuscaComissao.strValorFiltro;
      strCampoFiltro := frmBuscaComissao.strCampoFiltro;
      If Not cdsComPro.FindFirst Then
      Begin
        fMensagem('ATENÇÃO!', 'Nenhum registro encontrado!', ['&O k']);
      End;

      btnLocPro.Enabled := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCalculaComissaoProfissionais.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaComissao);

end;

procedure TfrmCalculaComissaoProfissionais.btnSaidaClick(Sender: TObject);
begin
  inherited;

  Close;

end;

procedure TfrmCalculaComissaoProfissionais.CriaTemporariaComissaoRecebida;
begin
  if Assigned(FCdsComissaoAbatidas) then
    FreeAndNil(FCdsComissaoAbatidas);

  FCdsComissaoAbatidas := TUniClientDataSet.Create(Owner);
  FCdsComissaoAbatidas.AggregatesActive := True;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef do
  begin
    Name := 'DUPLICATA';
    DataType := ftString;
    Size := 012;
  end;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPECIE';
    DataType := ftString;
    Size := 006;
    Required := False;
  End;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLIENTE';
    DataType := ftString;
    Size := 012;
    Required := False;
  End;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR_ORIGINAL';
    DataType := ftFloat;
    Required := False;
  End;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR_ABATIDO';
    DataType := ftFloat;
    Required := False;
  End;

  if Not FCdsComissaoAbatidas.Active then
    FCdsComissaoAbatidas.CreateDataSet;

  FCdsComissaoAbatidas.EmptyDataSet;
end;

procedure TfrmCalculaComissaoProfissionais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6    : btnIniBus.Click;
    VK_F7    : btnLocPro.Click;
    VK_F8    : btnDesTds.Click;
    VK_F9    : btnMarTds.Click;
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: Begin
                 If mskDtaIni.Enabled Then
                   btnSaida.Click;
               End;
  End;

end;

function TfrmCalculaComissaoProfissionais.fBaixaComissao: Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
    blnCommit : Boolean;
Begin

  blnCommit := False;

  If fComissaoJaBaixada Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem comissões selecionadas que já sofreram baixa! '+#13#10+
                          'Realize a pesquisa novamente.', ['&O k']);
    Result := False;
    Exit;
  End;

  Try

    {*************************************************}
    {*  CASO NAO ESTEJA EM TRANSACAO INICIA UMA NOVA *}
    {**********************************************WS*}
    blnCommit := (Not frmModulo.GetCurrentConnection.InTransaction);

    If blnCommit Then
       fStartTransaction;

    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      Clear;
      Add('UPDATE COMPRO');
      Add('SET');
      Add('  COM_DTABAI = :DTABAI,');
      Add('  COM_HORBAI = :HORBAI,');
      Add('  COM_OPEBAI = :OPEBAI ');
      Add('WHERE');
      Add('  AUTOINCREM IN (');

      For intCont := 0 To stlLisSel.Count -1 Do
      Begin
        Add(QuotedStr(stlLisSel[intCont]));

        If intCont + 1 < stlLisSel.Count Then
          Add(',');
      End;

      Add(')');

      ParamByName('DTABAI').AsDate   := VS_Date;
      ParamByName('HORBAI').AsTime   := fTime();
      ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;

      ExecSQL;
    End;

    // Grava log
    Result := fGravalogComLst( stlLisSel, 'BAIXA', self.name );

    If Result Then
    Begin

       If blnCommit Then
          fCommit;

       Result := True;

    End
    Else
    Begin

       If blnCommit Then
          fRollBack;

       Result := False;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;

      If blnCommit Then
         fRollBack;

      pMensagensErro(E.Message, '[TfrmCalculaComissaoProfissionais.fBaixaComissao]');
    End;
  End;
  FreeAndNil(qryGen);
End;

function TfrmCalculaComissaoProfissionais.fLoadReport: Boolean;
 Var
   mmsLoad: TStream;
   FLayImp: TUniQuery;
Begin
  Result := False;
  FLayImp:= fCriaQuery(nil);
  Try
    With FLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'MDRPA'+IntToStr(fCfgSis('MODRPA', varInteger));

      If(strTipImp = 'M') Then
        ParamByName('TIPLAY').AsString := 'M'
      Else
        ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
        frxRecibo.LoadFromStream(mmsLoad);
        frxRecibo.Variables.Clear;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;
  pFreeAndNil(mmsLoad);
  pFreeAndNil(FLayImp);
End;

procedure TfrmCalculaComissaoProfissionais.btnCarrDocumentosClick(Sender: TObject);
begin
  If Not fValidaCampos(edtCodEmp) Then
    Exit;

  If Not fValidaCampos(edtCodCli) Then
    Exit;

  If Not fValidaCampos(mskDtaIni) Then
    Exit;

  If Not fValidaCampos(mskDtaFin) Then
    Exit;

  pLoadDados;

  If (cdsComPro.IsEmpty) Then
  Begin
    fMensagem('', 'Nenhum registro foi encontrado!', ['&Ok']);
    pSetFocus(mskDtaIni);
  End
  Else
  Begin
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;
    edtCodEmp.Enabled := False;
    edtCodCli.Enabled := False;
    pSetFocus(dbgComissoes);
  End;
end;

procedure TfrmCalculaComissaoProfissionais.btnConfirmaClick(
  Sender: TObject);
  Var
    strNumDup: String;
    strAutInc: String;
    frmBaixaProfiss: TfrmBaixaProfiss;
    LCont : Integer;

    blnBxContasPagar   : Boolean;
    blnBxContasReceber : Boolean;
    LValorCom: Double;
begin
  inherited;

  strAutInc := '';
  blnBxContasPagar   := False;
  blnBxContasReceber := False;

  Try

    If stlLisSel.Count > 0 Then
    Begin
      If VS_strTCoProInterna = '3' Then
      Begin
        If fBaixaComissao Then
        Begin
          If (fMensagem('', 'Deseja imprimir o Recibo?', ['', '']) = 1) Then
            pImprimeRecibo;
          fMensagem('','Documentos baixados com sucesso !', ['&O k']);
        End;
        Self.Close;
      End
      Else
      Begin
        pCriarFormularios(TfrmBaixaProfiss, frmBaixaProfiss);
        frmBaixaProfiss.edtCodFor.Text    := strCodFor;
        frmBaixaProfiss.strCodFor         := strCodFor;
        frmBaixaProfiss.edtNomFor.Text    := fRetNomFornecedor(strCodFor);
        frmBaixaProfiss.cbxLanCTP.Enabled := fltTotComSel <> 0;
        frmBaixaProfiss.cbxLanCTP.Checked := frmBaixaProfiss.cbxLanCTP.Enabled;

        If frmBaixaProfiss.ShowModal = mrOK Then
        Begin
          With frmBaixaProfiss Do
          Begin
            Try
              {*REQ*145940**********RP*}
              If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
              Begin
                fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
                Exit;
              End;

              If (fCfgSis('PBXCOM') = 'S') And (cbxLanCTP.Checked) Then
              Begin

                 If (fMensagem('', 'Deseja realizar a baixa do contas a pagar?', ['&Sim', '&Não'], 2) = 1) Then
                     blnBxContasPagar := True;

              End;

              // RECEBER
              if fCfgSis('PBXCOM') = 'S' then
              begin

                 If fEmptyStr(fRetCliProfissional(strCodPro)) Then
                 Begin
                    fMensagem('', 'Atenção, não existe cliente cadastrado para o : ' + strCodPro +
                              sLineBreak + 'Por isso o contas a receber não será aberto.', ['&O k']);

                    // este if esta verificando se o usuario ja escolheu q vai ter baixa pagar ai não sai do processo;
                    if Not blnBxContasPagar then
                       Exit;
                 End
                 Else
                 Begin
                    If (fMensagem('', 'Deseja realizar a baixa do contas a receber?', ['&Sim', '&Não'], 2) = 1) Then
                        blnBxContasReceber := True;
                 End;

              end;


              fStartTransaction;

              If cbxLanCTP.Checked Then
              Begin
                strNumDup := fRetSequencialCadPag;
                strAutInc := fRetAutoIncrem('CADPAG', VS_strCodEmp);
                LValorCom := GetValorComissao;

                if fGravaCadPag('frmCalculaComissaoProfissionais',              // Nome Form LOGCTP
                             'INCLUSAO - COMISSAO DE PROFISSIONAIS',         // Descrição LOGCTP
                             edtCodFor.Text,                                 // Fornecedor
                             strNumDup,                                      // Num. Duplicata
                             'A',                                            // Parcela
                             VS_strCodEmp,                                   // Empresa
                             fraPlanoDeContas.MskCodCta.Text,                // Centro de Custo
                             '',                                             // Serie do Documento
                             0,                                              // Sequencial de Baixa
                             VS_Date,                                        // Data do lançamento
                             VS_Date,                                        // Data de Vencimento
                             LValorCom,                                      // Valor da Duplicata
                             LValorCom,                                      // Valor Original
                             'N',                                            // Previsão?
                             'N',                                            // Veio Boleto
                             'N',                                            // Deposito
                             edtHisBai.Text,                                 // Histórico 1
                             '',                                             // Histórico 2
                             '',                                             // Histórico da Baixa
                             '',                                             // Portador da Baixa
                             '',                                             // Centro de Custo da Baixa
                             '',                                             // Documento da Baixa
                             '',                                             // Operador da Baixa
                             0,                                              // Data do Pagamento
                             0,                                              // Valor Pago
                             0,                                              // Valor de Juros
                             0,                                              // Valor Desconto
                             '',                                             // Empresa
                             edtCodEve.Text,                                 // Codigo do Evento
                             'N',                                            // Usa Cheque
                             edtCodPor.Text,                                 // Codigo do Portador
                             '',
                             0,
                             0,
                             0,
                             False,
                             0,
                             '',
                             0,
                             'N',
                             '',
                             '',
                             '',
                             strAutInc,
                             '',
                             '',
                             '',
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '0',
                             '',
                             '',
                             '',
                             '', 
                             'N')then
                begin

                  For LCont := 0 To stlLisSel.Count -1 Do
                  Begin
                    GravarCTPCOM(strNumDup,'A','',edtCodFor.Text,VS_strCodEmp,stlLisSel[LCont]);
                  End;


                end;

              End;

              If fBaixaComissao Then
              Begin
                fCommit;

                // ABRE CONTAS A PAGAR PARA BAIXA DESSA DUPLICATA ESPECIFICA
                If (fCfgSis('PBXCOM') = 'S') And (blnBxContasPagar) then  // se esta habilitado a cfg e se escolheu a opção sim na pergunta;
                Begin

                    If Not fLock_Unlock('CADPAG' + strAutInc, True, False) Then
                    Begin
                       fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);
                       Exit;
                    End;
                   fBaixaCtp('CADPAG', strAutInc, '[frmCalculaComissaoProfissionais.btnConfirmaClick]', edtCodPor.Text, VS_Date, fltTotComSel);

                End;

                // ABRE CONTAS A RECEBER PARA BAIXA DO CLIENTE CADASTRADO PELO CADDIV (Diversos)
                If (fCfgSis('PBXCOM') = 'S') And (blnBxContasReceber) Then
                Begin
                   fBaixaCtr( fRetCliProfissional(strCodPro), strCodEmp );
                End;

                If (fMensagem('', 'Deseja imprimir o Recibo de Comissão?', ['', '']) = 1) Then
                  pImprimeRecibo;
                fMensagem('', 'Documentos baixados com sucesso!', ['&O k']);

              End
              Else
                 fRollback;

              Self.Close;

            Except

              On E: Exception Do
              Begin
                fRollBack;
                pMensagensErro(E.Message, '[Baixa Comissão Profissionais]');
              End;

            End;

          End;

        End;

      End;
    End
    Else
      fMensagem('','Selecione ao menos um documento !', ['&O k']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCalculaComissaoProfissionais.btnConfirmaClick]');
    End;
  End;

  pFreeAndNil(frmBaixaProfiss);

end;

procedure TfrmCalculaComissaoProfissionais.FormDestroy(Sender: TObject);
begin
  fLock_Unlock('COMPRO'+strCodPro, False);
  if Assigned(FCdsComissaoAbatidas) then
    FreeAndNil(FCdsComissaoAbatidas);
  inherited;
  FreeAndNil(stlLisSel);
end;

function TfrmCalculaComissaoProfissionais.fBaixaCtp(pStrNomeTabela, pStrAutoIncrem, pStrTelaFuncaoDeOrigem, pStrCodPorFix: String;
  pDteDtaPagFix: TDateTime; pFltValLanLoc: Double): Boolean;
var
  frmBaixaCtaPagar: TfrmBaixaCtaPagar;
begin
  fLock_Unlock(pStrNomeTabela + pStrAutoIncrem, False);

  pCriarFormularios(TfrmBaixaCtaPagar, frmBaixaCtaPagar);
  Try
    Try
      frmBaixaCtaPagar.strChamada := pStrTelaFuncaoDeOrigem;

      frmBaixaCtaPagar.pnlCabecalho.Enabled := False;
      frmBaixaCtaPagar.pnlCabecalho.Visible := False;
      frmBaixaCtaPagar.strAutIncManCtp := pStrAutoincrem;
      frmBaixaCtaPagar.btnIniBus.Enabled         := False;
      frmBaixaCtaPagar.btnLocProx.Enabled        := False;
      frmBaixaCtaPagar.btnMarcarTodas.Enabled    := False;
      frmBaixaCtaPagar.btnDesmarcarTodas.Enabled := False;
      frmBaixaCtaPagar.btnSelecionadas.Enabled   := False;

      if pDteDtaPagFix <> 0 then
        frmBaixaCtaPagar.dteDtaPagFix   := pDteDtaPagFix;
      if pStrCodPorFix  <> '' then
        frmBaixaCtaPagar.strCodPorFix   := pStrCodPorFix;
      if pFltValLanLoc <> 0 then
        frmBaixaCtaPagar.fltValorBaixa  := pFltValLanLoc;

      Sleep(1000); //NÃO RETIRAR
      frmBaixaCtaPagar.btnConsultar.Click;
      frmBaixaCtaPagar.ShowModal;

      Result := True;

      {***************************************************************************************************************}
      {* SE A DUPLICATA FOR BAIXADA, E, ANTES DA TELA DE BAIXA FOR FECHADA OUTRA ESTAÇÃO CARREGAR A MESMA DUPLICATA, *}
      {* O SISTEMA DEVE FICAR VERIFICANDO QUANDO A DUPLICATA ESTIVER SIDO LIBERADA PARA ASSIM SEGUIR. ****************}
      {* POR ISSO O PARÂMENTRO blnLoopTravamento ESTÁ TRUE ***********************************************************}
      {***************************************************************************************************************}
      If Not fLock_Unlock(pStrNomeTabela + pStrAutoIncrem, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(pStrNomeTabela + pStrAutoIncrem), ['&Ok']);
        Exit;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, pStrTelaFuncaoDeOrigem);
      End;
    End;

  finally
    pFreeAndNil(frmBaixaCtaPagar);
  end;
End;

function TfrmCalculaComissaoProfissionais.fBaixaCtr(pStrCodCliFix, pStrCodEmpFix: String): Boolean;
var
  frmBaixaReceber: TfrmBaixaReceber;
begin
  pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);
  Try
    Try
      frmBaixaReceber.edtCodCli.Enabled  := False;
      frmBaixaReceber.edtCodCli.Text     := pStrCodCliFix;
      frmBaixaReceber.edtCodEmp.Text     := pStrCodEmpFix;
      frmBaixaReceber.chkLimFil.Checked  := False;
      Sleep(1000); //NÃO RETIRAR
      frmBaixaReceber.btnCarrTitulos.Click;
      If not frmBaixaReceber.dbgDuplicatasDBTableView1.DataController.DataSource.DataSet.IsEmpty Then
        frmBaixaReceber.ShowModal;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCalculaComissaoProfissionais.fBaixaCtr]');
      End;
    End;

  finally
    pFreeAndNil(frmBaixaReceber);
  end;
End;

function TfrmCalculaComissaoProfissionais.fComissaoJaBaixada: Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      Clear;
      Add('SELECT                             ');
      Add('  COM_DTABAI                       ');
      Add('FROM                               ');
      Add('  COMPRO                           ');
      Add('WHERE COM_DTABAI IS NOT NULL       ');
      Add(' AND AUTOINCREM IN ('               );

      For intCont := 0 To stlLisSel.Count -1 Do
      Begin
        Add(QuotedStr(stlLisSel[intCont]));

        If intCont + 1 < stlLisSel.Count Then
          Add(',');
      End;

      Add(')');

      Open;
    End;
    Result := Not fEmptyStr(qryGen.FieldByName('COM_DTABAI').AsString);
  Except
    Result := False;
  End;
  FreeAndNil(qryGen);
End;

end.
