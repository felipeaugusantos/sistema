unit untRcxConfCupom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, Grids, DBGridCitel, DBGrids, Menus,
  ComCtrls, Buttons, ExtCtrls, DB, Uni, StrUtils, AppEvnts,
  UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmRcxConfCupom = class(TfrmPaiSimples)
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem2: TMenuItem;
    pnlTitulo: TPanel;
    dbgDocumentos: TDBGridCitel;
    pnlDadosInformativos: TPanel;
    Label21: TLabel;
    edtTotGer: TEditFocus;
    pnlBotoesSelecao: TPanel;
    edtNomVen: TEditFocus;
    Label1: TLabel;
    edtCodVen: TEditFocus;
    btnEmiteCupom: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    btnSairSelecao: TBitBtnLocked;
    btnIniciaBusca: TBitBtnLocked;
    btnLocProxima: TBitBtnLocked;
    btnMarcaImpresso: TBitBtnLocked;
    btnAbreGaveta: TBitBtnLocked;
    btnImprimirCuponsDiasAnteriores: TBitBtnLocked;
    Shape1: TShape;
    Label2: TLabel;
    FlwPnlBotoesSelecao: TFlowPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairSelecaoClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosCellClick(Column: TColumn);
    procedure dbgDocumentosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcaImpressoClick(Sender: TObject);
    procedure btnIniciaBuscaClick(Sender: TObject);
    procedure btnLocProximaClick(Sender: TObject);
    procedure btnEmiteCupomClick(Sender: TObject);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure btnAbreGavetaClick(Sender: TObject);
    procedure btnImprimirCuponsDiasAnterioresClick(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }

    strValorFiltro: String;
    strCampoFiltro: String;

    strNumSer: String;
    strNumCoo: String;
    strNumCcf: String;

    cdsTmpResumoCaixa: TUniClientDataSet;
    cpvTmpResumoCaixa: TUniDataSetProvider;


    procedure pCalculaTotal;
    procedure pMostraInfoRodape;
    procedure pMarcaImpresso( strSeqGer, strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie, strNumSer, strNumCoo, strNumCcf, strNomArq: String );
    procedure pBuscaRegistro(DataSet: TDataSet; Var Accept: Boolean);

  public
    { Public declarations }
    strOpeCai: String;

    strNumDoc: String;
    blnConfirma: Boolean;

    fltValDin: Double;
    fltValCqP: Double;
    fltValCqV: Double;
    blnMosMod: Boolean;

    strCodigoCaixa: String;

    function  fCriaTemporaria: Boolean;

  end;

var
  frmRcxConfCupom: TfrmRcxConfCupom;

Const
  OPERADORES = '999_998_997_';  

implementation

uses  untfuncoesSimples, untRcxConfCupomBusca, untRcxConfCupomModal,
      untFiscal,untFuncoesGenerica, untAtuVarGlobais, untModalidades , untPafGerais, untImpressorCupom,
      untMemo, untTypesSistema;

{$R *.dfm}

function TfrmRcxConfCupom.fCriaTemporaria: Boolean;
  Var
    strSQL,
    strUnion: String;
    qryGen: TUniQuery;
begin
  Try
    Screen.Cursor := crHourGlass;
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   GER_DTAENT, ';
    strSQL := strSQL + '   GER_HORENT, ';
    strSQL := strSQL + '   CONCAT( GER_NUMDOC, "-", GER_ESPDOC ) AS GER_DOCESP, ';
    strSQL := strSQL + '   FORMAT( GER_VLRCON, 2 ) AS GER_VLRCON, ';
    strSQL := strSQL + '           GER_VLRCON      AS GER_VLRFLT, ';
    strSQL := strSQL + '   GER_CODVEN, ';
    strSQL := strSQL + '   GER_NUMDOC, ';
    strSQL := strSQL + '   GER_ESPDOC, ';
    strSQL := strSQL + '   GER_CODCLI, ';
    strSQL := strSQL + '   GER_NOMCON, ';
    strSQL := strSQL + '   GER_ENDCON, ';
    strSQL := strSQL + '   GER_BAICON, ';
    strSQL := strSQL + '   GER_CEPCON, ';
    strSQL := strSQL + '   GER_CIDCON, ';
    strSQL := strSQL + '   GER_CGCCON, ';
    strSQL := strSQL + '   GER_CGCCPF, ';
    strSQL := strSQL + '   GER_IESCON, ';
    strSQL := strSQL + '   GER_R_GCON, ';
    strSQL := strSQL + '   GER_TELCON, ';
    strSQL := strSQL + '   GER_CODEMP, ';
    strSQL := strSQL + '   GER_CONPAG, ';
    strSQL := strSQL + '   GER_CODFPG, ';
    strSQL := strSQL + '   GER_TOTIPI, ';
    strSQL := strSQL + '   GER_SERIE_, ';
    strSQL := strSQL + '   GER_TOTPRO, ';
    strSQL := strSQL + '   GER_DESESP, ';
    strSQL := strSQL + '   GER_TOTICM, ';
    strSQL := strSQL + '   AUX_IMPPAG, ';    
    strSQL := strSQL + '   AUX_FEDIMP, ';
    strSQL := strSQL + '   AUX_ESTIMP, ';
    strSQL := strSQL + '   AUX_MUNIMP, ';
    strSQL := strSQL + '   GER_MEN001, ';
    strSQL := strSQL + '   GER_MEN002, ';

    strSQL := strSQL + '   GER_VPAR01, ';
    strSQL := strSQL + '   GER_VPAR02, ';
    strSQL := strSQL + '   GER_VPAR03, ';
    strSQL := strSQL + '   GER_VPAR04, ';
    strSQL := strSQL + '   GER_VPAR05, ';
    strSQL := strSQL + '   GER_VPAR06, ';
    strSQL := strSQL + '   GER_VPAR07, ';
    strSQL := strSQL + '   GER_VPAR08, ';
    strSQL := strSQL + '   GER_VPAR09, ';
    strSQL := strSQL + '   GER_VPAR10, ';
    strSQL := strSQL + '   GER_VPAR11, ';
    strSQL := strSQL + '   GER_VPAR12, ';

    strSQL := strSQL + '   "MOVGER" AS NOMARQ, ';
    strSQL := strSQL + '   MOVGER.AUTOINCREM AS AUTOINCREM, ';

    strSQL := strSQL + '   ETC_ENDENT AS ENT_ENDENT, ';
    strSQL := strSQL + '   ETC_BAIENT AS ENT_BAIENT, ';
    strSQL := strSQL + '   ETC_CEPENT AS ENT_CEPENT, ';
    strSQL := strSQL + '   ETC_CIDENT AS ENT_CIDENT  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';

    strSQL := strSQL + 'LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'LEFT JOIN ENTCLI ON AUX_ENTGER = ENTCLI.AUTOINCREM ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_IMPRES = 0 AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GER_ESPDOC IN ("IF", "IV") ';

    If (Not fEmptyStr(strNumDoc)) Then
      strSQL := strSQL + ' AND GER_NUMDOC = :NUMDOC ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'AUXMOV', 'AUXNOT'), 'MOVGER', 'NOTGER');

    strUnion := strSQL;

    strSQL := '';
    strSQL := strSQL + ' SELECT        ';
    strSQL := strSQL + '   GER_DTAENT, ';
    strSQL := strSQL + '   GER_HORENT, ';
    strSQL := strSQL + '   GER_DOCESP, ';
    strSQL := strSQL + '   CONCAT( GER_CODCLI, "-", IF( GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON ) ) AS GER_NOMCLI, ';
    strSQL := strSQL + '   GER_VLRCON, ';
    strSQL := strSQL + '   GER_VLRFLT, ';
    strSQL := strSQL + '   GER_CODVEN, ';
    strSQL := strSQL + '   OPE_NOMOPE, ';
    strSQL := strSQL + '   GER_NUMDOC, ';
    strSQL := strSQL + '   GER_ESPDOC, ';
    strSQL := strSQL + '   GER_CODCLI, ';
    strSQL := strSQL + '   GER_NOMCON, ';
    strSQL := strSQL + '   GER_ENDCON, ';
    strSQL := strSQL + '   GER_BAICON, ';
    strSQL := strSQL + '   GER_CEPCON, ';
    strSQL := strSQL + '   GER_CIDCON, ';
    strSQL := strSQL + '   GER_CGCCON, ';
    strSQL := strSQL + '   GER_CGCCPF, ';
    strSQL := strSQL + '   GER_IESCON, ';
    strSQL := strSQL + '   GER_R_GCON, ';
    strSQL := strSQL + '   GER_TELCON, ';
    strSQL := strSQL + '   CLI_NOMCLI, ';
    strSQL := strSQL + '   CLI_ENDERE, ';
    strSQL := strSQL + '   IFNULL(ENT_ENDENT, ETC_ENDENT) AS CLI_ENDENT, ';
    strSQL := strSQL + '   IFNULL(ENT_BAIENT, ETC_BAIENT) AS CLI_BAIENT, ';
    strSQL := strSQL + '   IFNULL(ENT_CEPENT, ETC_CEPENT) AS CLI_CEPENT, ';
    strSQL := strSQL + '   IFNULL(ENT_CIDENT, ETC_CIDENT) AS CLI_CIDENT, ';
    strSQL := strSQL + '   CLI_ENDNUM, ';
    strSQL := strSQL + '   CLI_ENDCOM, ';
    strSQL := strSQL + '   CLI_BAIRRO, ';
    strSQL := strSQL + '   CLI_C_E_P_, ';
    strSQL := strSQL + '   CLI_CODCID, ';
    strSQL := strSQL + '   CLI_C_G_C_, ';
    strSQL := strSQL + '   CLI_I_E_S_, ';
    strSQL := strSQL + '   CLI_NUMR_G, ';
    strSQL := strSQL + '   CLI_FONE01, ';
    strSQL := strSQL + '   CID_NOMCID, ';
    strSQL := strSQL + '   CID_ESTADO, ';
    strSQL := strSQL + '   GER_CODEMP, ';
    strSQL := strSQL + '   GER_CONPAG, ';
    strSQL := strSQL + '   GER_CODFPG, ';
    strSQL := strSQL + '   GER_TOTIPI, ';
    strSQL := strSQL + '   GER_SERIE_, ';
    strSQL := strSQL + '   GER_TOTPRO, ';
    strSQL := strSQL + '   GER_DESESP, ';
    strSQL := strSQL + '   GER_TOTICM, ';
    strSQL := strSQL + '   AUX_IMPPAG, ';    
    strSQL := strSQL + '   AUX_FEDIMP, ';
    strSQL := strSQL + '   AUX_ESTIMP, ';
    strSQL := strSQL + '   AUX_MUNIMP, ';
    strSQL := strSQL + '   GER_MEN001, ';
    strSQL := strSQL + '   GER_MEN002, ';

    strSQL := strSQL + '   GER_VPAR01, ';
    strSQL := strSQL + '   GER_VPAR02, ';
    strSQL := strSQL + '   GER_VPAR03, ';
    strSQL := strSQL + '   GER_VPAR04, ';
    strSQL := strSQL + '   GER_VPAR05, ';
    strSQL := strSQL + '   GER_VPAR06, ';
    strSQL := strSQL + '   GER_VPAR07, ';
    strSQL := strSQL + '   GER_VPAR08, ';
    strSQL := strSQL + '   GER_VPAR09, ';
    strSQL := strSQL + '   GER_VPAR10, ';
    strSQL := strSQL + '   GER_VPAR11, ';
    strSQL := strSQL + '   GER_VPAR12, ';

    strSQL := strSQL + '   NOMARQ,     ';
    strSQL := strSQL + '   TMP.AUTOINCREM ';

    strSQL := strSQL + ' FROM (' + strUnion + ') AS TMP ';

    strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = TMP.GER_CODCLI ';
    strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = TMP.GER_CODVEN ';
    strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = IF(TMP.GER_CIDCON IS NULL, CLI_CODCID, TMP.GER_CIDCON ) ';

    strSQL := strSQL + '  LEFT  JOIN ENTCLI ON ETC_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '                       ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = CLI_CODCLI) ';

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(strNumDoc)) Then
        ParamByName('NUMDOC').AsString := strNumDoc;

      Open;

      pSetaClient(qryGen);

      If Not Assigned(cdsTmpResumoCaixa.FindField('TOT_VLRFLT')) Then
      Begin
        With TAggregateField.Create(Self) Do
        Begin
          Name          := 'TOT_VLRFLT';
          FieldName     := 'TOT_VLRFLT';
          DataSet       := cdsTmpResumoCaixa;
          Expression    := 'SUM(GER_VLRFLT)';
          DisplayFormat := '#,##0.00';
          Active        := True;
        End;
      End;

      cpvTmpResumoCaixa.DataSet := qryGen;
      cdsTmpResumoCaixa.Close;
      cdsTmpResumoCaixa.SetProvider(cpvTmpResumoCaixa);
      cdsTmpResumoCaixa.Open;

      Result := ( cdsTmpResumoCaixa.RecordCount > 0 );

      cdsTmpResumoCaixa.IndexFieldNames := 'GER_DTAENT;GER_HORENT';
    End;

    Screen.Cursor := crDefault;

  Except
    On E: Exception Do
    Begin
      Result := False;
      Screen.Cursor := crDefault;
      pMensagensErro(E.Message,'[fCriaTemporaria - F8Rcx]');
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmRcxConfCupom.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgDocumentos);

  pMostraInfoRodape;
  pCalculaTotal;

  Screen.Cursor := crDefault;

  {*****************************************}
  {* HABILITA O BOTÃO MARCA COMO IMPRESSO  *}
  {* SOMENTE SE FOR OS OPERADORES LISTADOS *}
  {**************************************PZ*}
  btnMarcaImpresso.Visible := (Pos(strLoginUsuarioLogado, OPERADORES) > 0);

end;

procedure TfrmRcxConfCupom.pCalculaTotal;
begin
  edtTotGer.Text := cdsTmpResumoCaixa.AggFields.FieldByName('TOT_VLRFLT').AsString;
end;

procedure TfrmRcxConfCupom.FormCreate(Sender: TObject);
begin
  inherited;

  cpvTmpResumoCaixa := TUniDataSetProvider.Create(Self);
  cdsTmpResumoCaixa := TUniClientDataSet.Create(Self);
  cdsTmpResumoCaixa.AggregatesActive := True;

  Self.dbgDocumentos.DataSource := fCriaDataSource(cdsTmpResumoCaixa);

  strNumDoc    := '';
  cdsTmpResumoCaixa.OnFilterRecord := pBuscaRegistro;

  blnConfirma := False;
  blnMosMod := True;

  strCodigoCaixa := '';
end;

procedure TfrmRcxConfCupom.btnSairSelecaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxConfCupom.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: btnEmiteCupom.Click;
    VK_F5    : btnIniciaBusca.Click;
    VK_F6    : btnLocProxima.Click;
    VK_F7    : btnAbreGaveta.Click;
    VK_F9    : btnMarcaImpresso.Click;
    VK_F12   : btnImprimirCuponsDiasAnteriores.Click;
    VK_Escape: btnSairSelecao.Click;
  End;

end;

procedure TfrmRcxConfCupom.pMostraInfoRodape;
Begin
  edtCodVen.Text := cdsTmpResumoCaixa.FieldByName( 'GER_CODVEN' ).AsString;
  edtNomVen.Text := cdsTmpResumoCaixa.FieldByName( 'OPE_NOMOPE' ).AsString;
End;

procedure TfrmRcxConfCupom.dbgDocumentosCellClick(Column: TColumn);
begin
  inherited;
  pMostraInfoRodape;
end;

procedure TfrmRcxConfCupom.dbgDocumentosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pMostraInfoRodape;
end;

procedure TfrmRcxConfCupom.pMarcaImpresso(strSeqGer, strNumDoc, strEspDoc,  strCodEmp, strCodCli, strSerie, strNumSer, strNumCoo, strNumCcf, strNomArq: String);
  Var
    strSQL   : String;
    strTblGer: String;
    strTblDet: String;
    qryGenGer: TUniQuery;
Begin
  Try
    qryGenGer := fCriaQuery(Self);

    Screen.Cursor := crHourGlass;

    If (strNomArq = 'MOVGER') Then
    Begin
      strTblGer := 'MOVGER';
      strTblDet := 'MOVDET';
    End
    Else
    Begin
      strTblGer := 'NOTGER';
      strTblDet := 'NOTDET';
    End;

    {*****************************************}
    {* MARCA MOVGER COMO JA FATURADO         *}
    {**************************************MA*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + ' ' + strTblGer + ' ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   GER_IMPRES = TRUE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   AUTOINCREM = :AUTOINCREM ';

    With qryGenGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOINCREM').AsString := strSeqGer;
      ExecSql;
      Close;

    End;

    {*****************************************}
    {* MARCA MOVDET COMO JA FATURADO         *}
    {**************************************MA*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + ' ' + strTblDet + ' ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   DET_IMPRES = TRUE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

    With qryGenGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      ExecSql;
      Close;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FGO_NUMCCF = :NUMCCF ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMFAT = :NUMFAT AND ';
    strSQL := strSQL + '  FGO_TIPFAT = :TIPFAT AND ';
    strSQL := strSQL + '  FGO_EMPFAT = :CODEMP ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMCCF').AsString := strNumCcf;

      ParamByName('NUMFAT').AsString := strNumDoc;
      ParamByName('TIPFAT').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADFIS ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FIS_NUMSER = IF(:NUMSER = "", NULL, :NUMSER), ';
    strSQL := strSQL + '  FIS_NUMCOO = IF(:NUMCOO = "", NULL, :NUMCOO) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FIS_FORCLI = :CODCLI AND ';

    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((FIS_SERIE_ IS NULL) OR (FIS_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '  FIS_TIP_FC = "C" ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMSER').AsString := strNumSer;
      ParamByName('NUMCOO').AsString := strNumCoo;

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If (Not fEmptyStr(strSerie)) Then
        ParamByName('SERIE_').AsString := strSerie;

      ExecSQL;
      Close;
    End;

    If (Not cdsTmpResumoCaixa.IsEmpty) Then
    Begin
      {*****************************************}
      {* APAGA CUPOM DA TABELA TEMPORARIA      *}
      {**************************************AF*}
      cdsTmpResumoCaixa.Delete;

      Screen.Cursor := crDefault;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[pMarcaImpresso]');
  End;

  FreeAndNil(qryGenGer);
End;                    

procedure TfrmRcxConfCupom.btnMarcaImpressoClick(Sender: TObject);
begin
  inherited;

  {******************************************}
  {* DESABILITADO DIA 25/04/12 - O OPERADOR *}
  {*     PRECISA IMPRIMIR O CUPOM, SEMPRE.  *}
  {***************************************RN*}

  {*****************************************}
  {  DIREITO DE ACESSO REMOVIDO DO MENU    *}
  {     Name: mnuSenMarcarCupomImpresso    *}
  {  Caption: 'Marcar Cupom como Impresso' *}
  {      Tag: 15000                        *}
  {**************************************RN*}    

  (*
  If Not fVerificaAcessoSistema('mnuSenMarcarCupomImpresso', strOpeCai) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direito de realizar essa operação!', ['&Ok']);
    Exit;
  End; *)

  {******************************************************************}
  {* VERIFICA OS OPERADORES COM PERMISSÃO PARA MARCA COMO IMPRESSO  *}
  {***************************************************************PZ*}
  If (Not btnMarcaImpresso.Visible) Or (Pos(strLoginUsuarioLogado, OPERADORES) <= 0) Then
    Exit;

  If fMensagem('', 'Confirma Operação?', ['&Não', '&Sim' ], 1) = 2 Then
  Begin
    pMarcaImpresso(cdsTmpResumoCaixa.FieldByName( 'AUTOINCREM' ).AsString,
                   cdsTmpResumoCaixa.FieldByName( 'GER_NUMDOC' ).AsString,
                   cdsTmpResumoCaixa.FieldByName( 'GER_ESPDOC' ).AsString,
                   cdsTmpResumoCaixa.FieldByName( 'GER_CODEMP' ).AsString,
                   cdsTmpResumoCaixa.FieldByName( 'GER_CODCLI' ).AsString,
                   cdsTmpResumoCaixa.FieldByName( 'GER_SERIE_' ).AsString,
                   strNumSer,
                   strNumCoo,
                   strNumCcf,
                   cdsTmpResumoCaixa.FieldByName( 'NOMARQ' ).AsString);

    pCalculaTotal;

    If cdsTmpResumoCaixa.RecordCount = 0 Then
    Begin
      fMensagem('', 'Não foi encontrado nenhum documento para emissão de Cupom Fiscal!', ['&Ok']);
      Close;
    End;

  End;
  
end;

procedure TfrmRcxConfCupom.btnImprimirCuponsDiasAnterioresClick(
  Sender: TObject);
  Var
    impressor: TImpressorDeCupons;
    stlProblemas: TStringList;
begin
  inherited;

  {Try (** NÃO ESTÁ FUNCIONANDO NA DARUMA! **)
    If (Assigned(VS_objFiscal)) And (VS_objFiscal.fVerificaCupomAberto) And
       (fMensagem('', 'Existe um cupom fiscal que ainda não foi concluído, deseja cancelar agora?', ['&Sim', '&Não' ], 1) = 1) Then
      VS_objFiscal.fCancelaCupom;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[btnImprimirCuponsDiasAnterioresClick]');
  End;}

  impressor := TImpressorDeCupons.Create;
  Try
    impressor.pImrpimeCupons;
    stlProblemas := impressor.fProblemas;
  Finally
    FreeAndNil(impressor);
  End;

  If stlProblemas.Count > 0 Then
  Begin
    pCriarFormularios(TfrmMemo, frmMemo);

    Try
      stlProblemas.Insert(0, 'Os cupons abaixo não puderam ser impressos. Por favor, imprimir no F8 no Resumo de Caixa.');
      frmMemo.cxMemo.Lines.Assign(stlProblemas);
      frmMemo.ShowModal;
    Finally
      FreeAndNil(frmMemo);
    End;

  End;

  FreeAndNil(stlProblemas);

  fCriaTemporaria;

  If cdsTmpResumoCaixa.RecordCount = 0 Then
  Begin
    fMensagem('', 'Não foi encontrado nenhum documento para emissão de Cupom Fiscal!', ['&Ok']);
    Close;
  End;
end;

procedure TfrmRcxConfCupom.btnIniciaBuscaClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmRcxConfCupomBusca, frmRcxConfCupomBusca);
    frmRcxConfCupomBusca.ShowModal;

    If frmRcxConfCupomBusca.blnConfirma Then
    Begin
      strValorFiltro := frmRcxConfCupomBusca.strValorFiltro;
      strCampoFiltro := frmRcxConfCupomBusca.strCampoFiltro;
      cdsTmpResumoCaixa.FindFirst;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmRcxConfCupom.btnIniciaBuscaClick]');
    End;
  End;
  
  pFreeAndNil(frmRcxConfCupomBusca);

end;

procedure TfrmRcxConfCupom.pBuscaRegistro(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmRcxConfCupom.btnLocProximaClick(Sender: TObject);
begin
  inherited;

  If (cdsTmpResumoCaixa.Active) And (Not fEmptyStr(strCampoFiltro)) Then
    cdsTmpResumoCaixa.FindNext;

end;

procedure TfrmRcxConfCupom.btnEmiteCupomClick(Sender: TObject);
  Var
    strPatIni: String;
    strCodEcf: String;
    strSQL   : String;
    qryGenMod: TUniQuery;
    intCont  : Integer;
    qryCupons: TDataSet;
    strChaveLock: String;
    frmRcxConfCupomModal : TfrmRcxConfCupomModal;
    arrDuplicataCND: TarrDuplicata;

  function fCupomOriginadoF3CheckOut(strNumDoc, strCodEmp: String): Boolean;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  Begin
    Result := False;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   DISTINCT DET_IND_PD AS ORI_PD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '    DET_ESPDOC = "IF" AND ';
    strSQL := strSQL + '    DET_CODEMP = :CODEMP ';

    Try
      qryTmp := fCriaQuery;

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('ORI_PD').AsInteger = -1;
      End;
    Finally
      FreeAndNil(qryTmp);
    End;
  End;
begin
  inherited;
  If dbgDocumentos.DataSource.DataSet.FieldByName('GER_DTAENT').AsDateTime < VS_Date Then
  Begin
    fMensagem('ATENÇÃO!', 'Este cupom foi emitido dia ' + dbgDocumentos.DataSource.DataSet.FieldByName('GER_DTAENT').AsString + '. ' + 
      'Por favor, utilize o botão ' + btnImprimirCuponsDiasAnteriores.Caption, ['&Ok']);
    Exit;
  End;  

  If (VS_strUsaPaf = 'S') And (Not fCfgSis('PAFECF', varBoolean)) Then
  Begin
    If (Not fComparaNumeroSerieGrandeTotal) Then
    Begin
      Exit;
    End;
  End;

  Try
    qryGenMod := fCriaQuery(Self);

    strPatIni := fCfgSis('DIRINI');
    strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

    If fEmptyStr( strCodEcf ) Then
    Begin
      fMensagem('ATENÇÃO!', 'A impressora fiscal que será utilizada não foi setada nas Configurações do Sistema. Verifique!', ['&Ok']);
      Exit;
    End;

    If Not Assigned(VS_objFiscal) Then
    Begin
      If Not pAtuVarGlobais(True) Then
        Exit;
    End;
    
    With qryGenMod Do
    Begin

      strSql := '';
      strSql := strSql + ' SELECT ';
      strSql := strSql + '  * ';
      strSql := strSql + ' FROM ';
      strSql := strSql + '   ECFMOD ';
      strSql := strSql + ' WHERE ';
      strSql := strSql + '   ECF_CODECF = :CODECF ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODECF').AsString := strCodEcf;
      Open;

      If IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há nenhuma modalidade cadastrada para a Impressora Configurada. Verifique!', ['&Ok']);
        Close;
        Exit;
      End;

      Close;

    End;

    qryCupons := dbgDocumentos.DataSource.DataSet;
    strChaveLock := 'IMPRESSAO_IF_' + qryCupons.FieldByName('GER_NUMDOC').AsString + '-' + VS_strCodEmp;

    If fCupomOriginadoF3CheckOut(qryCupons.FieldByName('GER_NUMDOC').AsString,
                                 VS_strCodEmp) Then
    Begin
      If Assigned(VS_objFiscal) Then
        VS_objFiscal.blnApenasItensCheckOutF11 := True;
    End;

    If cdsTmpResumoCaixa.FieldByName('NOMARQ').AsString = 'MOVGER' Then
      pCarregaDuplicatasCND(2, cdsTmpResumoCaixa.FieldByName('AUTOINCREM').AsString, arrDuplicataCND)
    Else
      pCarregaDuplicatasCND(3, cdsTmpResumoCaixa.FieldByName('AUTOINCREM').AsString, arrDuplicataCND);

    If (VS_strUsaTef <> 'S') And (Not VS_blnTelNov)  Then
    Begin

      If fLock_Unlock(strChaveLock, True, False) Then
      Begin
        Try

          pCriarFormularios(TfrmRcxConfCupomModal, frmRcxConfCupomModal);

          {*****************************************}
          {* DADOS DO CUPOM                        *}
          {**************************************MA*}
          With cdsTmpResumoCaixa Do
          Begin

            frmRcxConfCupomModal.strCodOpe   := strOpeCai;
            frmRcxConfCupomModal.fltTotal    := FieldByName( 'GER_VLRFLT' ).AsFloat;
            frmRcxConfCupomModal.fltDinheiro := FieldByName( 'GER_VLRFLT' ).AsFloat;

            frmRcxConfCupomModal.strNumDoc   := FieldByName( 'GER_NUMDOC' ).AsString;
            frmRcxConfCupomModal.strCodCli   := FieldByName( 'GER_CODCLI' ).AsString;

            frmRcxConfCupomModal.dtaDtaEnt   := FieldByName( 'GER_DTAENT' ).AsDateTime;
            frmRcxConfCupomModal.strConPag   := FieldByName( 'GER_CONPAG' ).AsString;
            frmRcxConfCupomModal.strCodFpg   := FieldByName( 'GER_CODFPG' ).AsString;

            frmRcxConfCupomModal.strCodigoCaixa := strCodigoCaixa;


            {*****************************************}
            {* SE FOR CONSUMIDOR, PEGA INFORMACOES   *}
            {* DO MOVGER                             *}
            {**************************************MA*}

            If fClienteConsumidor( FieldByName( 'CLI_NOMCLI' ).AsString, False, True ) Then
            Begin
              frmRcxConfCupomModal.strNomCli   := FieldByName( 'GER_NOMCON' ).AsString;
              frmRcxConfCupomModal.strEndCli   := FieldByName( 'GER_ENDCON' ).AsString;
              frmRcxConfCupomModal.strBaiCli   := FieldByName( 'GER_BAICON' ).AsString;
              frmRcxConfCupomModal.strCepCli   := FieldByName( 'GER_CEPCON' ).AsString;
              frmRcxConfCupomModal.strCidCli   := FieldByName( 'CID_NOMCID' ).AsString;
              frmRcxConfCupomModal.strEstCli   := FieldByName( 'CID_ESTADO' ).AsString;
              frmRcxConfCupomModal.strCGCCPF   := FieldByName( 'GER_CGCCON' ).AsString;
              frmRcxConfCupomModal.strIESCli   := FieldByName( 'GER_IESCON' ).AsString;
              frmRcxConfCupomModal.strRG_Cli   := FieldByName( 'GER_R_GCON' ).AsString;
              frmRcxConfCupomModal.strFone01   := FieldByName( 'GER_TELCON' ).AsString;
              frmRcxConfCupomModal.strEndEnt   := '';
              frmRcxConfCupomModal.strBaiEnt   := '';
              frmRcxConfCupomModal.strCepEnt   := '';
              frmRcxConfCupomModal.strCidEnt   := '';
              frmRcxConfCupomModal.strEstEnt   := '';
            End
            Else
            Begin
              frmRcxConfCupomModal.strNomCli   := FieldByName( 'CLI_NOMCLI' ).AsString;
              frmRcxConfCupomModal.strEndCli   := FieldByName( 'CLI_ENDERE' ).AsString +
                                                  IIF(fEmptyStr(FieldByName('CLI_ENDNUM').AsString), '', ', ' + FieldByName('CLI_ENDNUM').AsString) +
                                                  IIF(fEmptyStr(FieldByName('CLI_ENDCOM').AsString), '', ' ' + FieldByName('CLI_ENDCOM').AsString);
              frmRcxConfCupomModal.strBaiCli   := FieldByName( 'CLI_BAIRRO' ).AsString;
              frmRcxConfCupomModal.strCepCli   := FieldByName( 'CLI_C_E_P_' ).AsString;
              frmRcxConfCupomModal.strCidCli   := FieldByName( 'CID_NOMCID' ).AsString;
              frmRcxConfCupomModal.strEstCli   := FieldByName( 'CID_ESTADO' ).AsString;
              frmRcxConfCupomModal.strCGCCPF   := FieldByName( 'CLI_C_G_C_' ).AsString;
              frmRcxConfCupomModal.strRG_Cli   := FieldByName( 'CLI_NUMR_G' ).AsString;
              frmRcxConfCupomModal.strIESCli   := FieldByName( 'CLI_I_E_S_' ).AsString;
              frmRcxConfCupomModal.strFone01   := FieldByName( 'CLI_FONE01' ).AsString;
              frmRcxConfCupomModal.strEndEnt   := FieldByName( 'CLI_ENDENT' ).AsString;
              frmRcxConfCupomModal.strBaiEnt   := FieldByName( 'CLI_BAIENT' ).AsString;
              frmRcxConfCupomModal.strCepEnt   := FieldByName( 'CLI_CEPENT' ).AsString;
              frmRcxConfCupomModal.strCidEnt   := fRetNomCidade(FieldByName( 'CLI_CIDENT' ).AsString);
              frmRcxConfCupomModal.strEstEnt   := fRetNomCidade(FieldByName( 'CLI_CIDENT' ).AsString, 1);
            End;

            frmRcxConfCupomModal.strCodVen   := FieldByName( 'GER_CODVEN' ).AsString;
            frmRcxConfCupomModal.strNomVen   := FieldByName( 'OPE_NOMOPE' ).AsString;
            frmRcxConfCupomModal.strCodEmp   := FieldByName( 'GER_CODEMP' ).AsString;
            frmRcxConfCupomModal.strSeqGer   := FieldByName( 'AUTOINCREM' ).AsString;
            frmRcxConfCupomModal.strNomArq   := IIF(FieldByName( 'NOMARQ' ).AsString = 'MOVGER', 'MOVDET', 'NOTDET');
            frmRcxConfCupomModal.strTabelaGer := FieldByName( 'NOMARQ' ).AsString;
            frmRcxConfCupomModal.fltTotIcm   := FieldByName( 'GER_TOTICM' ).AsFloat;
            frmRcxConfCupomModal.fltImpPag   := FieldByName( 'AUX_IMPPAG' ).AsFloat;
            frmRcxConfCupomModal.fltFedImp   := FieldByName( 'AUX_FEDIMP' ).AsFloat;
            frmRcxConfCupomModal.fltEstImp   := FieldByName( 'AUX_ESTIMP' ).AsFloat;
            frmRcxConfCupomModal.fltMunImp   := FieldByName( 'AUX_MUNIMP' ).AsFloat;

            If (FieldByName( 'GER_TOTPRO' ).AsFloat - FieldByName( 'GER_DESESP' ).AsFloat) <> 0.00 Then
            Begin
              If Not fUsaImpostoFonteIBPT Then
              Begin
                frmRcxConfCupomModal.fltPeImPg := (FieldByName( 'AUX_IMPPAG' ).AsFloat /
                                                  (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                                   FieldByName( 'GER_DESESP' ).AsFloat)) * 100;
              End
              Else
              Begin
                frmRcxConfCupomModal.fltPeImFd := (FieldByName( 'AUX_FEDIMP' ).AsFloat /
                                                  (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                                   FieldByName( 'GER_DESESP' ).AsFloat)) * 100;

                frmRcxConfCupomModal.fltPeImEs := (FieldByName( 'AUX_ESTIMP' ).AsFloat /
                                                  (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                                   FieldByName( 'GER_DESESP' ).AsFloat)) * 100;

                frmRcxConfCupomModal.fltPeImMn := (FieldByName( 'AUX_MUNIMP' ).AsFloat /
                                                  (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                                   FieldByName( 'GER_DESESP' ).AsFloat)) * 100;
              End;
            End;

            frmRcxConfCupomModal.blnMosMod := blnMosMod;

            frmRcxConfCupomModal.strMen001 := FieldByName( 'GER_MEN001' ).AsString;
            frmRcxConfCupomModal.strMen002 := FieldByName( 'GER_MEN002' ).AsString;
            frmRcxConfCupomModal.strSerie  := FieldByName( 'GER_SERIE_' ).AsString;
            frmRcxConfCupomModal.strEspDoc := FieldByName( 'GER_ESPDOC' ).AsString;

            For intCont := 0 To 23 Do
              frmRcxConfCupomModal.arrDuplicOri[intCont].curValor := FieldByName('GER_VPAR' + fStrZero(intCont + 1, 2)).AsFloat;
            
            If blnMosMod Then
            Begin
              frmRcxConfCupomModal.blnF10Automatico := True;
              frmRcxConfCupomModal.ShowModal;
            End
            Else
            Begin
              {*****************************************}
              {* CASO SEJA DINHEIRO, CHEQUE A VISTA,   *}
              {* CHEQUE PRE OU COMBINAÇÃO DAS MESMAS,  *}
              {* IMPRIME O CUPOM DIRETO.               *}
              {**************************************MV*}
              If (fltValDin > 0.0) Then
              Begin
                frmRcxConfCupomModal.pSetaModalidade('1', fltValDin);
              End;

              If (fltValCqP > 0.0) Then
              Begin
                frmRcxConfCupomModal.pSetaModalidade('2', fltValCqP);
              End;

              If (fltValCqV > 0.0) Then
              Begin
                frmRcxConfCupomModal.pSetaModalidade('4', fltValCqV);
              End;

              frmRcxConfCupomModal.btnConfirma.Click;
            End;

          End;

          blnConfirma := frmRcxConfCupomModal.blnConfirma;
          If frmRcxConfCupomModal.blnConfirma Then
          Begin
            With cdsTmpResumoCaixa Do
              pCalculaTotal;
          End;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[btnEmiteCupomClick]');
          End;
        End;

        fLock_Unlock(strChaveLock, False);
        pFreeAndNil(frmRcxConfCupomModal);
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Este cupom já está em processo de impressão pela estação ' + fGetHostLock(strChaveLock) + '.',
          ['&Ok']);      
      End;

      If fEmptyStr(strNumDoc) Then
        pSetFocus(dbgDocumentos);

    End
    Else 
    Begin

      If fLock_Unlock(strChaveLock, True, False) Then
      Begin
        Try

          pCriarFormularios(TfrmModalidades, frmModalidades);

          {*****************************************}
          {* DADOS DO CUPOM                        *}
          {**************************************AF*}
          With cdsTmpResumoCaixa Do
          Begin

            frmModalidades.fltTotal := FieldByName('GER_VLRFLT').AsFloat;
            VS_objFiscal.strNumDoc  := FieldByName('GER_NUMDOC').AsString;
            VS_objFiscal.strCodCli  := FieldByName('GER_CODCLI').AsString;
            VS_objFiscal.strNomVen  := FieldByName('GER_CODVEN').AsString + '-' + FieldByName('OPE_NOMOPE').AsString;

            {*****************************************}
            {* SE FOR CONSUMIDOR, PEGA INFORMACOES   *}
            {* DO MOVGER                             *}
            {**************************************AF*}
            If fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True) Then
            Begin
              VS_objFiscal.strNomCli := FieldByName('GER_NOMCON').AsString;
              VS_objFiscal.strEndCli := FieldByName('GER_ENDCON').AsString;
              VS_objFiscal.strBaiCli := FieldByName('GER_BAICON').AsString;
              VS_objFiscal.strCepCli := FieldByName('GER_CEPCON').AsString;
              VS_objFiscal.strCidCli := FieldByName('CID_NOMCID').AsString;
              VS_objFiscal.strEstCli := FieldByName('CID_ESTADO').AsString;
              VS_objFiscal.strCgcCpf := FieldByName('GER_CGCCON').AsString;
              VS_objFiscal.strIesCli := FieldByName('GER_IESCON').AsString;
              VS_objFiscal.strRG_Cli := FieldByName('GER_R_GCON').AsString;
              VS_objFiscal.strTelCli := FieldByName('GER_TELCON').AsString;
              VS_objFiscal.strEndEntCli := '';
              VS_objFiscal.strBaiEntCli := '';
              VS_objFiscal.strCepEntCli := '';
              VS_objFiscal.strCidEntCli := '';
              VS_objFiscal.strEstEntCli := '';
            End
            Else
            Begin
              VS_objFiscal.strNomCli := FieldByName('CLI_NOMCLI').AsString;
              VS_objFiscal.strEndCli := FieldByName('CLI_ENDERE').AsString +
                                        IIF(fEmptyStr(FieldByName('CLI_ENDNUM').AsString), '', ', ' + FieldByName('CLI_ENDNUM').AsString) +
                                        IIF(fEmptyStr(FieldByName('CLI_ENDCOM').AsString), '', ' ' + FieldByName('CLI_ENDCOM').AsString);
              VS_objFiscal.strBaiCli := FieldByName('CLI_BAIRRO').AsString;
              VS_objFiscal.strCepCli := FieldByName('CLI_C_E_P_').AsString;
              VS_objFiscal.strCidCli := FieldByName('CID_NOMCID').AsString;
              VS_objFiscal.strEstCli := FieldByName('CID_ESTADO').AsString;
              VS_objFiscal.strCgcCpf := FieldByName('CLI_C_G_C_').AsString;
              VS_objFiscal.strRG_Cli := FieldByName('CLI_NUMR_G').AsString;
              VS_objFiscal.strIesCli := FieldByName('CLI_I_E_S_').AsString;
              VS_objFiscal.strTelCli := FieldByName('CLI_FONE01').AsString;
              VS_objFiscal.strEndEntCli := FieldByName('CLI_ENDENT').AsString;
              VS_objFiscal.strBaiEntCli := FieldByName('CLI_BAIENT').AsString;
              VS_objFiscal.strCepEntCli := FieldByName('CLI_CEPENT').AsString;
              VS_objFiscal.strCidEntCli := fRetNomCidade(FieldByName('CLI_CIDENT').AsString);
              VS_objFiscal.strEstEntCli := fRetNomCidade(FieldByName('CLI_CIDENT').AsString, 1);
            End;

            VS_objFiscal.fltIcmDev   := FieldByName( 'GER_TOTICM' ).AsFloat;
            VS_objFiscal.fltImpPag   := FieldByName( 'AUX_IMPPAG' ).AsFloat;
            VS_objFiscal.fltFedImp   := FieldByName( 'AUX_FEDIMP' ).AsFloat;
            VS_objFiscal.fltEstImp   := FieldByName( 'AUX_ESTIMP' ).AsFloat;
            VS_objFiscal.fltMunImp   := FieldByName( 'AUX_MUNIMP' ).AsFloat;

            If (FieldByName( 'GER_TOTPRO' ).AsFloat - FieldByName( 'GER_DESESP' ).AsFloat) <> 0.00 Then
            Begin
              If Not fUsaImpostoFonteIBPT Then
              Begin
                VS_objFiscal.fltPeImPg := (FieldByName( 'AUX_IMPPAG' ).AsFloat /
                                          (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                           FieldByName( 'GER_DESESP' ).AsFloat)) * 100;
              End
              Else
              Begin
                VS_objFiscal.fltPeImFd := (FieldByName( 'AUX_FEDIMP' ).AsFloat /
                                          (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                           FieldByName( 'GER_DESESP' ).AsFloat)) * 100;

                VS_objFiscal.fltPeImEs := (FieldByName( 'AUX_ESTIMP' ).AsFloat /
                                          (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                           FieldByName( 'GER_DESESP' ).AsFloat)) * 100;

                VS_objFiscal.fltPeImMn := (FieldByName( 'AUX_MUNIMP' ).AsFloat /
                                          (FieldByName( 'GER_TOTPRO' ).AsFloat -
                                           FieldByName( 'GER_DESESP' ).AsFloat)) * 100;
              End;
            End;

            If FieldByName('GER_CGCCPF').AsString = '1' Then
            Begin
              frmModalidades.mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
              frmModalidades.lblCpf.Caption := 'CGC:';
            End
            Else
            Begin
              frmModalidades.mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
              frmModalidades.lblCpf.Caption := 'CPF:';
            End;

            frmModalidades.mskCgcCpf.Text := VS_objFiscal.strCgcCpf;
            frmModalidades.strSeqGer := FieldByName('AUTOINCREM').AsString;
            frmModalidades.strNomArq := IIF(FieldByName('NOMARQ').AsString = 'MOVGER', 'MOVDET', 'NOTDET');
            frmModalidades.strTabelaGer := FieldByName( 'NOMARQ' ).AsString;
            frmModalidades.strConPag := FieldByName('GER_CONPAG').AsString;
            frmModalidades.dtaDtaEnt := FieldByName('GER_DTAENT').AsDateTime;

            frmModalidades.strNumDoc := FieldByName('GER_NUMDOC').AsString;
            frmModalidades.strEspDoc := FieldByName('GER_ESPDOC').AsString;
            frmModalidades.strCodEmp := FieldByName('GER_CODEMP').AsString;
            frmModalidades.strCodCli := FieldByName('GER_CODCLI').AsString;
            frmModalidades.strSerie  := FieldByName('GER_SERIE_').AsString;            

            For intCont := 0 To 23 Do
              frmModalidades.arrDuplicOri[intCont].curValor := FieldByName('GER_VPAR' + fStrZero(intCont + 1, 2)).AsFloat;

            If blnMosMod Then
              frmModalidades.ShowModal
            Else
            Begin
              {*****************************************}
              {* CASO SEJA DINHEIRO, CHEQUE A VISTA,   *}
              {* CHEQUE PRE OU COMBINAÇÃO DAS MESMAS,  *}
              {* IMPRIME O CUPOM DIRETO.               *}
              {**************************************MV*}
              frmModalidades.blnF10Automatico := False;
              If (fltValDin > 0.0) Then
              Begin
                If frmModalidades.fSetaModalidade('1') Then
                Begin
                  frmModalidades.edtValor.Value := fltValDin;
                  frmModalidades.edtValorExit(frmModalidades.edtValor);
                End;
              End;

              If (fltValCqP > 0.0) Then
              Begin
                If frmModalidades.fSetaModalidade('2') Then
                Begin
                  frmModalidades.edtValor.Value := fltValCqP;
                  frmModalidades.edtValorExit(frmModalidades.edtValor);
                End;
              End;

              If (fltValCqV > 0.0) Then
              Begin
                If frmModalidades.fSetaModalidade('4') Then
                Begin
                  frmModalidades.edtValor.Value := fltValCqV;
                  frmModalidades.edtValorExit(frmModalidades.edtValor);
                End;
              End;

              frmModalidades.pFechaCupom;

            End;
          
          End;

          blnConfirma := (frmModalidades.ModalResult = mrOk) Or (Not blnMosMod);
          If blnConfirma Then
          Begin
            With cdsTmpResumoCaixa Do
              pCalculaTotal;
          End;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[btnEmiteCupomClick_1]');
          End;
        End;

        fLock_Unlock(strChaveLock, False);
        pFreeAndNil(frmModalidades);
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Este cupom já está em processo de impressão pela estação ' + fGetHostLock(strChaveLock) + '.',
          ['&Ok']);
      End;

      If (dbgDocumentos.CanFocus) And (fEmptyStr(strNumDoc)) Then
        pSetFocus(frmRcxConfCupom.dbgDocumentos);

    End;

    If Assigned(VS_objFiscal) Then
      VS_objFiscal.blnApenasItensCheckOutF11 := False;

    fCriaTemporaria;
        
    If (cdsTmpResumoCaixa.RecordCount = 0) And (fEmptyStr(strNumDoc)) Then
    Begin
      fMensagem('', 'Não foi encontrado nenhum documento para emissão de Cupom Fiscal!', ['&Ok']);
      Close;
    End;

    FreeAndNil(qryGenMod);

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      FreeAndNil(qryGenMod);
      pMensagensErro(E.Message,'[F10 - untRcxConfCupom]');
    End;
  End;

end;

procedure TfrmRcxConfCupom.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  btnEmiteCupom.Click;
end;

procedure TfrmRcxConfCupom.dbgDocumentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If dbgDocumentos.DataSource.DataSet.FieldByName('GER_DTAENT').AsDateTime < VS_Date Then
  Begin
    dbgDocumentos.Canvas.Brush.Color := clMoneyGreen;
    dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmRcxConfCupom.btnAbreGavetaClick(Sender: TObject);
  Var
    strPatIni: String;
    strCodEcf: String;
    strModEcf: String;
    strPorta : String;
    strCodErr: String;
    ecfFiscal: TUntFiscal;
begin
  inherited;
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
  strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

  ecfFiscal := TUntFiscal.Create;

  If Not ecfFiscal.pSetModEcf( strModEcf ) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não foi possivel setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
  End
  Else If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
  Begin
    fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
  End
  Else If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
  Begin
    fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
  End
  {*******************************************}
  {* ABRE GAVETA                             *}
  {****************************************MV*}
  Else If (Not ecfFiscal.fAbreGaveta(strCodErr)) Then
  Begin
    fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
  End;

  ecfFiscal.fFinalizaEcf( strCodErr );
  ecfFiscal.Free;
end;

end.


