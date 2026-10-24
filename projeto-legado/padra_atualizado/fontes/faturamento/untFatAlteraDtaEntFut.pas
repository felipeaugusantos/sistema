{*********************************************************}
{* ALTERAÇÃO DE DATA DE ENTREGA FUTURA                   *}
{*                                                       *}
{* DATA......: 27/06/2009                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI                  *}
{*                                                       *}
{******************************************************AF*}
unit untFatAlteraDtaEntFut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, Math, untControleEntregaRomaneio,
  BitBtnLockedIncrem, StrUtils, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untCadLote, untTLock,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxGridCitel;

type
  TfrmFatAlteraDtaEntFut = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label2: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    btnFaltaProd: TBitBtnLocked;
    pnlLegenda: TPanel;
    lblLegenda: TLabel;
    btnAlteracaoLote: TBitBtnLocked;
    edtNomeCliente: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtEndereco: TEditFocus;
    edtBairro: TEditFocus;
    edtCidade: TEditFocus;
    btnAlteraLocFis: TBitBtnLocked;
    btnCopiarLocFis: TBitBtnLocked;
    cxConsulta: TcxGridCitel;
    cxConsultaDBTableView1: TcxGridDBTableView;
    cxConsultaDBTableView1DET_CODITE: TcxGridDBColumn;
    cxConsultaDBTableView1DET_DESCRI: TcxGridDBColumn;
    cxConsultaDBTableView1DET_REFERE: TcxGridDBColumn;
    cxConsultaDBTableView1UNI_SIGUNI: TcxGridDBColumn;
    cxConsultaDBTableView1DET_MOTFUT: TcxGridDBColumn;
    cxConsultaDBTableView1ITE_SALDOS: TcxGridDBColumn;
    cxConsultaDBTableView1DET_QTDAEN: TcxGridDBColumn;
    cxConsultaDBTableView1DET_DTAFUT: TcxGridDBColumn;
    cxConsultaDBTableView1DET_CLIBUS: TcxGridDBColumn;
    cxConsultaLevel1: TcxGridLevel;
    cxConsultaDBTableView1DET_LOCFIS: TcxGridDBColumn;
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFaltaProdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtEspDocExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAlteracaoLoteClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlteraLocFisClick(Sender: TObject);
    procedure btnCopiarLocFisClick(Sender: TObject);
    procedure cxConsultaDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    objCadLot : TCadLot;
    objLock: TLock;
    intQtdDec: Integer;
    strTabela,
    strTabTri,
    strTabGer,
    strTabAux: String;

    strChaveLockDocumento : String;
    function fLockDocumento : Boolean;

    function fDocumentoBaixado: Boolean;
    function fDocumentoExiste: Boolean;

    function fAtualizaRegistro(objConEnt: TControleEntregaRomaneio;
                               fltQtdFut: Double;
                               dtaDtaRes,
                               dtaDtaFut: TDateTime;
                               strMotAtu: String = '';
                               blnAlteraMotivo: Boolean = False;
                               strCliBus: String = 'N';
                               blnTodosItens: Boolean = False): Boolean;

    Function fParticionaRegistro(objConEnt: TControleEntregaRomaneio;
                                 fltQtdPar: Double;
                                 dtaDtaRes,
                                 dtaEntFut: TDate;
                                 strMotivo,
                                 strAutInc: String;
                                 strCliBus: String = 'N'): Boolean;


    procedure pCarregaEmpresa;
    procedure pTrazerDadosCliente;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoesSimples, untFuncFat, untConsultas, untFatDigDtaEntFut, untMovIte,
  untFatAltLoteEntFut, untTypesSistema, untTFatReprocessarSaldoItem,
  untFatAlteraLocFisEntFut, untReformaTributariaCalculo;

{$R *.dfm}

procedure TfrmFatAlteraDtaEntFut.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := ''
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmFatAlteraDtaEntFut.edtCodEmpresaKeyPress(Sender: TObject;
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
    If fValidaCampos(edtCodEmpresa) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAlteraDtaEntFut.edtEspDocExit(Sender: TObject);
begin
  inherited;
  strTabela := 'MOVDET';
  strTabTri := 'MOVTRI';
  strTabGer := 'MOVGER';
  strTabAux := 'AUXMOV';
end;

procedure TfrmFatAlteraDtaEntFut.pCarregaEmpresa;
Begin

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text)
  Else
    edtDesEmpresa.Text := '';

End;

procedure TfrmFatAlteraDtaEntFut.pTrazerDadosCliente;
begin
  edtNomeCliente.Text := cdsConsulta.FieldByName('DET_CODCLI').AsString + '-' + cdsConsulta.FieldByName('NOMECLIENTE').AsString;
  edtEndereco.Text := cdsConsulta.FieldByName('ENDERECO').AsString;
  edtBairro.Text := cdsConsulta.FieldByName('BAIRRO').AsString;
  edtCidade.Text := cdsConsulta.FieldByName('CIDADE').AsString;
end;

function TfrmFatAlteraDtaEntFut.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('', 'O número do documento deve ser preenchido!', ['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','A espécie do documento deve ser preenchida!', ['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('','O código da empresa deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('','A empresa não foi encontrada!', ['&OK']);
          Result := False;
        End

        Else If Not fDocumentoExiste Then
        Begin
          fMensagem('', 'O documento não existe!', ['&Ok']);
          Result := False;
        End

        Else If fDocumentoBaixado Then
        Begin
          fMensagem('', 'O documento está baixado!', ['&Ok']);
          Result := False;
        End

        Else fAbreConsulta(True);

      End

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

{*****************************************}
{* VERIFICA SE DOCUMENTO FOI BAIXADO     *}
{**************************************AF*}
function TfrmFatAlteraDtaEntFut.fDocumentoBaixado: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS VALOR ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + ' ' + strTabela + ' D ';
    strSQL := strSQL + ' LEFT JOIN ' + strTabTri + ' T ON D.AUTOINCREM = T.DET_SEQGER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   DET_ENTFUT = "S"     AND ';

    If fCfgSis('EFTEST') = '2' Then
    Begin
      strSQL := strSQL + '   (DET_PROEMB <> "S" OR DET_BXSBIT = "S") AND ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
      strSQL := strSQL + '   (DET_FILKAR = 0) AND ';//Para nao exibir o item principal (que vai estar com filkar = 1)
    End
    Else
      strSQL := strSQL + '   DET_PROEMB <> "S" AND ';

    strSQL := strSQL + '   ROUND(DET_QTDITE - IFNULL(DET_QTDENT,0),4) > 0 ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      Open;

      Result := (FieldByName('VALOR').AsFloat <= 0);

      Close;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatAlteraDtaEntFut.fDocumentoBaixado]');
    End;
  End;

  FreeAndNil(qryGen);
End;

{*****************************************}
{* VERIFICA SE DOCUMENTO EXISTE          *}
{**************************************AF*}
function TfrmFatAlteraDtaEntFut.fDocumentoExiste: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL +   strTabGer + ' ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   GER_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      Open;

      Result := (FieldByName('VALOR').AsFloat > 0);

      Close;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatAlteraDtaEntFut.fDocumentoExiste]');
    End;
  End;

  FreeAndNil(qryGen);
End;

function TfrmFatAlteraDtaEntFut.fAbreConsulta(blnLike: Boolean): Boolean;
begin

  Result := inherited fAbreConsulta(blnLike);

  If Result Then
  Begin

    pTrazerDadosCliente;

    If Not fLockDocumento Then
      Exit;

    TFloatField(cdsConsulta.FieldByName('DET_QTDAEN')).DisplayFormat := '#,##0.' + fStrZero('0', intQtdDec);
    TFloatField(cdsConsulta.FieldByName('DET_QTDAEN')).EditFormat    := '#,##0.' + fStrZero('0', intQtdDec);

    TFloatField(cdsConsulta.FieldByName('DET_QTDEFT')).DisplayFormat := '#,##0.' + fStrZero('0', intQtdDec);
    TFloatField(cdsConsulta.FieldByName('DET_QTDEFT')).EditFormat    := '#,##0.' + fStrZero('0', intQtdDec);

    TFloatField(cdsConsulta.FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.' + fStrZero('0', intQtdDec);
    TFloatField(cdsConsulta.FieldByName('ITE_SALDOS')).EditFormat    := '#,##0.' + fStrZero('0', intQtdDec);

    TDateTimeField(cdsConsulta.FieldByName('DET_DTAFUT')).EditMask := '99/99/9999';
    TDateTimeField(cdsConsulta.FieldByName('DET_DTAEFT')).EditMask := '99/99/9999';

    If cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'F' Then
      cdsConsulta.FieldByName('DET_DTAEFT').FocusControl
    Else
      cdsConsulta.FieldByName('DET_QTDEFT').FocusControl;

    pSetFocus(cxConsulta);
  End;

end;

function TfrmFatAlteraDtaEntFut.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODCLI, ';
  strSQL := strSQL + '  DET_SERIE_, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_CODVEN, ';
  strSQL := strSQL + '  DET_CODDIG, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  ITE_SALDOS, ';
  strSQL := strSQL + '  DET_MOTFUT, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  ROUND(DET_QTDITE - IFNULL(DET_QTDENT,0),4) AS DET_QTDAEN, ';
  strSQL := strSQL + '  DET_DTAFUT, ';
  strSQL := strSQL + '  DET_QTDEFT, ';
  strSQL := strSQL + '  DET_DTAEFT, ';
  strSQL := strSQL + '  ITE_DIAFOR, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_CLIBUS, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  UNI_CODUNI, ';
  strSQL := strSQL + '  D.DET_SEQGER, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_NOMCON', 'CLI_NOMCLI') + ' AS NOMECLIENTE, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_ENDCON', 'IFNULL(ETC_ENDENT, ' +
                     '            CONCAT(CLI_ENDERE, ' +
                     '            IF(IFNULL(CLI_ENDNUM, "") = "", " ", CONCAT(", ", CLI_ENDNUM)), ' +
                     '            IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT(" ", CLI_ENDCOM)))) ');
  strSQL := strSQL + '  AS ENDERECO, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_BAICON',' IF(IFNULL(AUX_ENTGER, "") = "", CLI_BAIRRO, ETC_BAIENT)') + ' AS BAIRRO, ';
  strSQL := strSQL + '  CONCAT(CID_NOMCID, " - ", CID_ESTADO) AS CIDADE, ';
  strSQL := strSQL + '  DET_LOCFIS, ';
  strSQL := strSQL + '  ' + strTabGer + '.AUTOINCREM AS GER_AUTINC ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL +   strTabela + ' AS D ';
  strSQL := strSQL + '  LEFT JOIN ' + strTabTri + ' T ON D.AUTOINCREM = T.DET_SEQGER ';
  strSQL := strSQL + '       JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '       JOIN CADITE I ON I.ITE_CODITE = DET_CODITE                               ';
  strSQL := strSQL + '  LEFT JOIN CADUNI U ON U.UNI_CODUNI = DET_UNIDAD                               ';
  strSQL := strSQL + '       JOIN ' + strTabGer + ' ON ' + strTabGer + '.AUTOINCREM = D.DET_SEQGER ';
  strSQL := strSQL + '       JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQL := strSQL + '       JOIN ' + strTabAux + ' ON ' + strTabGer + '.AUTOINCREM = AUX_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI ON AUX_ENTGER = ENTCLI.AUTOINCREM ';
  strSQL := strSQL + '       JOIN CADCID ON CID_CODCID = ' + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CIDCON', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODCID, ETC_CIDENT) ');
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_NUMDOC = ' + QuotedStr(edtNumDoc.Text);
  strSQL := strSQL + '  AND DET_ESPDOC = ' + QuotedStr(edtEspDoc.Text);
  strSQL := strSQL + '  AND DET_CODEMP = ' + QuotedStr(edtCodEmpresa.Text);
  strSQL := strSQL + '  AND DET_ENTFUT = "S" ';

  If fCfgSis('EFTEST') = '2' Then
  Begin
    strSQL := strSQL + '   AND (DET_PROEMB <> "S" OR DET_BXSBIT = "S") ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
    strSQL := strSQL + '   AND (DET_FILKAR = 0) ';//Para nao exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    strSQL := strSQL + '   AND DET_PROEMB <> "S" ';

  strSQL := strSQL + '  AND ROUND(DET_QTDITE - IFNULL(DET_QTDENT,0),4) > 0 ';
  strSQL := strSQL + fFiltraSQL(blnlike);

  Result := strSQL;
end;

function TfrmFatAlteraDtaEntFut.fLockDocumento: Boolean;
  var
    strChaveLocal : String;
begin

  Result := True;

  strChaveLocal := strTabGer + edtNumDoc.Text + edtEspDoc.Text + edtCodEmpresa.Text;

  If (objLock.fLocalizaTrava(strChaveLocal)) Then
    Exit;

  If (Not strChaveLockDocumento.IsEmpty) And (strChaveLockDocumento <> strChaveLocal) Then
    objLock.pDestravarTodos;

  If (cdsConsulta.IsEmpty) Then
  Begin
    objLock.pDestravarTodos;
    Exit;
  End;

  If (Not objLock.fLock_Unlock(strChaveLocal, True, False)) Then
  Begin
    cdsConsulta.Close;
    pMensagemOk('Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaveLocal));
    pSetFocus(edtNumDoc);
    Exit(False);
  End;

  strChaveLockDocumento := strChaveLocal;

end;

procedure TfrmFatAlteraDtaEntFut.FormCreate(Sender: TObject);
begin
  inherited;
  objCadLot := TCadLot.Create(Self);
  objLock := TLock.Create;

  blnTemSelecao        := False;
  blnSempreRelerBanco  := False;
  blnSelecionaComEnter := False;
  blnTemPesquisa       := False;

  intQtdDec := fCfgSis('DECQTD', varInteger);

  If (fCfgSis('CTLEST') = '1') Then
    btnAlteracaoLote.Caption := '[F7] Alteração de Lote'
  Else
    btnAlteracaoLote.Caption := '[F7] Alteração de Armazém';

  btnAlteraLocFis.Visible := fCfgSis('LFADEF', varBoolean);
  btnCopiarLocFis.Visible := fCfgSis('LFADEF', varBoolean);
  cxConsultaDBTableView1DET_LOCFIS.Visible := fCfgSis('LFADEF', varBoolean);

  strChaveLockDocumento := '';

  btnAlteracaoLote.Enabled := (not fCfgSis('UTIWMS', varBoolean));
end;

procedure TfrmFatAlteraDtaEntFut.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin

    If (ActiveControl) = cxConsulta Then
    Begin
      fAbreConsulta(True);
      btnAlteracaoLote.Enabled := False;
      pSetFocus(edtNumDoc);
      Key := 0;
      Exit;
    End;

    Inherited;
  End
  Else
    Inherited;
end;

function TfrmFatAlteraDtaEntFut.fAtualizaRegistro(objConEnt: TControleEntregaRomaneio;
                                                  fltQtdFut: Double;
                                                  dtaDtaRes,
                                                  dtaDtaFut: TDateTime;
                                                  strMotAtu: String = '';
                                                  blnAlteraMotivo: Boolean = False;
                                                  strCliBus: String = 'N';
                                                  blnTodosItens: Boolean = False): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
    strMotAnt: String;
    strDtaAnt: String;
    intPosicao: integer;
Begin

  Try
    strMotAnt := cdsConsulta.FieldByName('DET_MOTFUT').AsString;
    strDtaAnt := cdsConsulta.FieldByName('DET_DTAFUT').AsString;
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL +     strTabela + ' ';
    strSQL := strSQL + ' SET ';

    If blnAlteraMotivo Then
    Begin
      strSQL := strSQL + '  DET_MOTFUT = :MOTFUT, ';
      strSQL := strSQL + '  DET_DTAFUT = :DTAFUT  ';
    End Else
    Begin
      If cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'F' Then
      Begin
        strMotAtu := 'P';

        strSQL := strSQL + '  DET_MOTFUT = "P", ';
        strSQL := strSQL + '  DET_DTAFUT = :DTAFUT  ';
      End
      Else
      Begin
        strMotAtu := strMotAnt;

        strSQL := strSQL + '  DET_QTDEFT = :QTDFUT, ';
        strSQL := strSQL + '  DET_DTAEFT = :DTAFUT  ';
      End;
    End;

    strSQL := strSQL + 'WHERE ';

    if blnTodosItens then
    begin
      strSQL := strSQL + '  DET_SEQGER = :AUTINC ';
    end
    else
    begin
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';
    end;

    fStartTransaction;

    If Assigned(objConEnt) Then
    Begin
      objConEnt.fSetNumDoc(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                           cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                           cdsConsulta.FieldByName('DET_CODEMP').AsString,
                           cdsConsulta.FieldByName('DET_CODCLI').AsString);
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If blnAlteraMotivo Then
      Begin
        ParamByName('DTAFUT').AsDateTime := dtaDtaFut;
        ParamByName('MOTFUT').AsString   := strMotAtu;
      End Else
      Begin

        If cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'F' Then
        Begin

          ParamByName('DTAFUT').AsDateTime := dtaDtaFut;

        End
        Else
        Begin
          If dtaDtaFut = 0 Then
          Begin
            ParamByName('DTAFUT').Value := Null;
            ParamByName('QTDFUT').Value := Null;
          End
          Else
          Begin
            ParamByName('DTAFUT').AsDateTime := dtaDtaFut;
            ParamByName('QTDFUT').AsFloat    := fltQtdFut;
          End;
        End;

      End;

      if blnTodosItens then
      begin
        ParamByName('AUTINC').AsString   := cdsConsulta.FieldByName('DET_SEQGER').AsString;
      end
      else
      begin
        ParamByName('AUTINC').AsString   := cdsConsulta.FieldByName('AUTOINCREM').AsString;
      end;

      ExecSQL;

      SQL.Clear;
      SQL.Add('UPDATE ' + strTabTri);
      SQL.Add('SET   DET_CLIBUS = :CLIBUS ');
      SQL.Add('WHERE DET_SEQGER = :AUTINC ');

      if blnTodosItens then
      begin
        intPosicao := cdsConsulta.RecNo;
        cdsConsulta.First;

        while not cdsConsulta.Eof do
        begin
          ParamByName('AUTINC').AsString   := cdsConsulta.FieldByName('AUTOINCREM').AsString;
          ParamByName('CLIBUS').AsString   := strCliBus;

          ExecSQL;

          cdsConsulta.Next;
        end;

        cdsConsulta.RecNo := intPosicao;
      end
      else
      begin
        ParamByName('AUTINC').AsString   := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        ParamByName('CLIBUS').AsString   := strCliBus;

        ExecSQL;
      end;

      pGravarLogFut(Self.Name,
                    cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                    cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                    cdsConsulta.FieldByName('DET_CODEMP').AsString,
                    cdsConsulta.FieldByName('DET_CODCLI').AsString,
                    cdsConsulta.FieldByName('DET_SERIE_').AsString,
                    cdsConsulta.FieldByName('DET_CODITE').AsString,
                    strLoginUsuarioLogado,
                    VS_Date,
                    fTime(),
                    strMotAnt,
                    strMotAtu,
                    strDtaAnt,
                    DateToStr(dtaDtaFut));

      if blnTodosItens then
      begin
        intPosicao := cdsConsulta.RecNo;
        cdsConsulta.First;

        while not cdsConsulta.Eof do
        begin
          ReprocessarItem(cdsConsulta.FieldByName('DET_CODITE').AsString, '');
          cdsConsulta.Next;
        end;

        cdsConsulta.RecNo := intPosicao;
      end
      else
      begin
        ReprocessarItem(cdsConsulta.FieldByName('DET_CODITE').AsString, '');
      end;
    End;

    If Assigned(objConEnt) Then
    Begin
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaEnt);

      objConEnt.fProcessaArrayDatasControleEntregaRomaneio;
    End;

    If (blnTodosItens) Then
    Begin
      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
           TItensReprocessarDoDocumento.New
             .Documento(cdsConsulta.FieldByName('DET_NUMDOC').AsString)
             .Especie(cdsConsulta.FieldByName('DET_ESPDOC').AsString)
             .Empresa(cdsConsulta.FieldByName('DET_CODEMP').AsString)
           ).ReprocessarSaldoPedidos(Nil)
            .ReprocessarSaldoEntregaFutura(Nil);
    End
    Else
    Begin
      TReprocessarSaldoItem.New
        .AddItem(
           TItemReprocessarSaldo.New
             .Codigo(cdsConsulta.FieldByName('DET_CODITE').AsString)
             .Empresa(cdsConsulta.FieldByName('DET_CODEMP').AsString)
           ).ReprocessarSaldoPedidos(Nil)
            .ReprocessarSaldoEntregaFutura(Nil);
    End;

    fCommit;
    
    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatAlteraDtaEntFut.fAtualizaRegistro]');
    End;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmFatAlteraDtaEntFut.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmFatAlteraDtaEntFut.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(objCadLot) Then
    FreeAndNil(objCadLot);

  If Assigned(objLock) Then
    FreeAndNil(objLock);

  inherited;

  If cdsConsulta.State = dsEdit Then
    cdsConsulta.Post;
end;

procedure TfrmFatAlteraDtaEntFut.btnCopiarLocFisClick(Sender: TObject);
var
  qryUpdate: TUniQuery;
begin
  inherited;
  If Not (cdsConsulta.Active And (cdsConsulta.RecordCount > 0)) Then
    Exit;

  If (not btnCopiarLocFis.Visible) Or (not btnCopiarLocFis.Enabled) Then
    Exit;

  If fMensagem('', 'Deseja realmente copiar a Loc.Física do produto atual' +
    ' para todos os produtos do documento?  (produtos com motivo "Falta Produto" não serão afetados)', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  qryUpdate := fCriaQuery;
  try
    qryUpdate.SQL.Add('UPDATE ' + strTabTri + ' AS T');
    qryUpdate.SQL.Add('  LEFT JOIN ' + strTabela + ' D ON D.AUTOINCREM = T.DET_SEQGER');
    qryUpdate.SQL.Add('       JOIN ' + strTabGer + ' ON ' + strTabGer + '.AUTOINCREM = D.DET_SEQGER ');
    qryUpdate.SQL.Add(' SET T.DET_LOCFIS = :LOCFIS');
    qryUpdate.SQL.Add('WHERE ' + strTabGer + '.AUTOINCREM = :AUTINC');
    qryUpdate.SQL.Add('  AND DET_MOTFUT <> "F" ');

    qryUpdate.ParamByName('LOCFIS').AsString := cdsConsulta.FieldByName('DET_LOCFIS').AsString;
    qryUpdate.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('GER_AUTINC').AsString;
    qryUpdate.ExecSql;

    fMensagem('AVISO', 'Cópia da Loc. Física da Entrega Futura realizada com sucesso!', ['&OK']);
    fAbreConsulta(True);

  finally
    FreeAndNil(qryUpdate);
  end;
end;

procedure TfrmFatAlteraDtaEntFut.btnAlteracaoLoteClick(Sender: TObject);
begin
  inherited;

  If Not (cdsConsulta.Active And (cdsConsulta.RecordCount > 0)) Then
    Exit;

  If (btnAlteracaoLote.Visible) And (btnAlteracaoLote.Enabled) Then
  Begin
    Try
      pCriarFormularios(TfrmFatAltLoteEntFut, frmFatAltLoteEntFut);
      frmFatAltLoteEntFut.pSetProduto(cdsConsulta.FieldByName('DET_CODITE').AsString + ' - ' + cdsConsulta.FieldByName('DET_DESCRI').AsString);
      frmFatAltLoteEntFut.pSetReferencia(cdsConsulta.FieldByName('DET_REFERE').AsString);
      frmFatAltLoteEntFut.pSetUnidade(cdsConsulta.FieldByName('UNI_SIGUNI').AsString);
      frmFatAltLoteEntFut.pSetQuantidade(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat);
      frmFatAltLoteEntFut.pSetSituacao(fMotivoSiglaToEntFut(cdsConsulta.FieldByName('DET_MOTFUT').AsString));
      frmFatAltLoteEntFut.pSetDtaPrevisao(DateToStr(cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime));
      frmFatAltLoteEntFut.pSetLoteAtual(cdsConsulta.FieldByName('DET_NUMLOT').AsString);
      frmFatAltLoteEntFut.pSetEmpresa(cdsConsulta.FieldByName('DET_CODEMP').AsString);
      frmFatAltLoteEntFut.pSetTabela(strTabela);
      frmFatAltLoteEntFut.pSetAutInc(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      frmFatAltLoteEntFut.pSetMotFut(cdsConsulta.FieldByName('DET_MOTFUT').AsString);
      If (frmFatAltLoteEntFut.ShowModal = mrOk) Then
      Begin
        If (frmFatAltLoteEntFut.fGravar) Then
        Begin
          fMensagem('AVISO','Alteração do ' + frmFatAltLoteEntFut.fGetTitulo + ' realizada com sucesso!', ['&OK']);
          fAbreConsulta(True);
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatAlteraDtaEntFut.btnAlteracaoLoteClick]');
    End;
    FreeAndNil(frmFatAltLoteEntFut);
  End;
end;

procedure TfrmFatAlteraDtaEntFut.btnAlteraLocFisClick(Sender: TObject);
var
  frmAlteraLocFisEntFut: TfrmAlteraLocFisEntFut;
begin
  inherited;

  If Not (cdsConsulta.Active And (cdsConsulta.RecordCount > 0)) Then
    Exit;

  If (not btnAlteraLocFis.Visible) Or (not btnAlteraLocFis.Enabled) Then
    Exit;

  If (cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'F') Then
  Begin
    fMensagem('AVISO','Localização física com motivo "Falta Produto" não pode ser alterado.', ['&OK']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmAlteraLocFisEntFut, frmAlteraLocFisEntFut);
    try
      frmAlteraLocFisEntFut.edtProduto.Text := cdsConsulta.FieldByName('DET_CODITE').AsString + ' - ' + cdsConsulta.FieldByName('DET_DESCRI').AsString;
      frmAlteraLocFisEntFut.edtRefere.Text := cdsConsulta.FieldByName('DET_REFERE').AsString;
      frmAlteraLocFisEntFut.edtUnidad.Text := cdsConsulta.FieldByName('UNI_SIGUNI').AsString;
      frmAlteraLocFisEntFut.edtLocFis.Text := cdsConsulta.FieldByName('DET_LOCFIS').AsString;
      frmAlteraLocFisEntFut.pSetAutInc(cdsConsulta.FieldByName('AUTOINCREM').AsString);

      If (frmAlteraLocFisEntFut.ShowModal = mrOk) Then
      Begin
        frmAlteraLocFisEntFut.fAtualiza;
        fMensagem('AVISO', 'Alteração da Loc. Física da Entrega Futura realizada com sucesso!', ['&OK']);
        fAbreConsulta(True);
      End;
    finally
      pFreeAndNil(frmAlteraLocFisEntFut);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatAlteraDtaEntFut.btnAlteraLocFisClick]');
  End;
end;

procedure TfrmFatAlteraDtaEntFut.btnFaltaProdClick(Sender: TObject);
  Var
    objConEnt: TControleEntregaRomaneio;
    blnSucesso: Boolean;
begin
  inherited;

  If Not (cdsConsulta.Active And (cdsConsulta.RecordCount > 0)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatDigDtaEntFut, frmFatDigDtaEntFut);

    If fCfgSis('DIAENT', varBoolean) Then
    Begin
      objConEnt := TControleEntregaRomaneio.Create;
      objConEnt.fSetNumDoc(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                           cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                           cdsConsulta.FieldByName('DET_CODEMP').AsString,
                           cdsConsulta.FieldByName('DET_CODCLI').AsString);
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
    End
    Else
      objConEnt := Nil;

    frmFatDigDtaEntFut.objConEnt              := objConEnt;
    frmFatDigDtaEntFut.intDiaFor              := cdsConsulta.FieldByName('ITE_DIAFOR').AsInteger;
    frmFatDigDtaEntFut.cmbMotEntFut.ItemIndex := fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTFUT').AsString);
    frmFatDigDtaEntFut.mskDtaEntFut.Text      := DateToStr(cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime);
    frmFatDigDtaEntFut.cmbCliBus.ItemIndex    := IIF(cdsConsulta.FieldByName('DET_CLIBUS').AsString = 'S', 1, 0);
    frmFatDigDtaEntFut.fltQtdEnt              := cdsConsulta.FieldByName('DET_QTDAEN').AsFloat;
    frmFatDigDtaEntFut.strNumDoc              := edtNumDoc.Text;
    frmFatDigDtaEntFut.strEspDoc              := edtEspDoc.Text;
    frmFatDigDtaEntFut.strCodEmp              := edtCodEmpresa.Text;
    frmFatDigDtaEntFut.strCodUni              := cdsConsulta.FieldByName('UNI_CODUNI').AsString;
    frmFatDigDtaEntFut.strCodIte              := cdsConsulta.FieldByName('DET_CODITE').AsString;
    frmFatDigDtaEntFut.strAutInc              := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    frmFatDigDtaEntFut.strCodCli              := cdsConsulta.FieldByName('DET_CODCLI').AsString;
    frmFatDigDtaEntFut.strCodVen              := cdsConsulta.FieldByName('DET_CODVEN').AsString;

    blnSucesso := False;

    If (frmFatDigDtaEntFut.ShowModal = mrOk) And
       (frmFatDigDtaEntFut.blnAltera) Then
    Begin
      If frmFatDigDtaEntFut.fltQtdPar > 0 Then
      Begin
        blnSucesso := fParticionaRegistro(objConEnt, frmFatDigDtaEntFut.fltQtdPar,
                                          frmFatDigDtaEntFut.dtaDtaRes,
                                          StrToDate(frmFatDigDtaEntFut.mskDtaEntFut.Text),
                                          fMotivoEntFutToSigla(frmFatDigDtaEntFut.cmbMotEntFut.ItemIndex),
                                          cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                          LeftStr(frmFatDigDtaEntFut.cmbCliBus.Text,1));
      End
      Else
      Begin
        blnSucesso := fAtualizaRegistro(objConEnt, 0,
                                        frmFatDigDtaEntFut.dtaDtaRes,
                                        StrToDate(frmFatDigDtaEntFut.mskDtaEntFut.Text),
                                        fMotivoEntFutToSigla(frmFatDigDtaEntFut.cmbMotEntFut.ItemIndex),
                                        True,
                                        LeftStr(frmFatDigDtaEntFut.cmbCliBus.Text,1),
                                        IIF(frmFatDigDtaEntFut.rdgQtdItens.ItemIndex = 0, FALSE, TRUE));
      End;
    End;

    If Assigned(objConEnt) Then
      FreeAndNil(objConEnt);

    If blnSucesso Then
    Begin
      pMensagemOk('Alteração realizada com sucesso!');
      fAbreConsulta(True);
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'btnFaltaProdClick');
    End;

  End;

  FreeAndNil(frmFatDigDtaEntFut);

end;

procedure TfrmFatAlteraDtaEntFut.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  Begin
    btnAlteracaoLote.Enabled := ((Not fEmptyStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString)) Or
                                (fEmptyStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString) And (objCadLot.fExisteLote(cdsConsulta.FieldByName('DET_CODITE').AsString, VS_strCodEmp)))) And
                                (not fCfgSis('UTIWMS', varBoolean));
    btnCopiarLocFis.Enabled := not fEmptyStr(cdsConsulta.FieldByName('DET_LOCFIS').AsString);
  End;
end;

procedure TfrmFatAlteraDtaEntFut.cxConsultaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  Case Key Of
    VK_F6: btnFaltaProd.Click;
    VK_F7: btnAlteracaoLote.Click;
    VK_F8: btnAlteraLocFis.Click;
    VK_F9: btnCopiarLocFis.Click;
  End;

end;

procedure TfrmFatAlteraDtaEntFut.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  If fCfgSis('CLBUEF',varBoolean) Then
  Begin
    cxConsultaDBTableView1DET_CLIBUS.Visible := True;
    cxConsultaDBTableView1DET_DESCRI.Width   := 243;
  End
  Else
  Begin
    cxConsultaDBTableView1DET_CLIBUS.Visible := False;
    cxConsultaDBTableView1DET_DESCRI.Width   := 298;
  End;

  pSetFocus(edtNumDoc);
end;

Function TfrmFatAlteraDtaEntFut.fParticionaRegistro(objConEnt: TControleEntregaRomaneio;
                                                    fltQtdPar: Double;
                                                    dtaDtaRes,
                                                    dtaEntFut: TDate;
                                                    strMotivo,
                                                    strAutInc: String;
                                                    strCliBus: String = 'N'): Boolean;
  Var
    qryGenAlt,
    qryGenInc: TUniQuery;
    intIndice: Integer;
    strAutIncNov: String;
    fltQtdOri: Double;

    Procedure pAtualizaTotais(qryGen: TUniQuery; fltQtdPar: Double; strTab: String);
    Begin
      With qryGen, SQL Do
      Begin
        If (LeftStr(strTab,6) = 'MOVDET') Then
        Begin
          FieldByName('DET_TOTITE').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTITE').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VLRCON').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VLRCON').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTFRE').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTFRE').AsFloat / fltQtdOri, -2);
          FieldByName('DET_DESESP').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_DESESP').AsFloat / fltQtdOri, -2);
          FieldByName('DET_DESACE').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_DESACE').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTCOM').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTCOM').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VALIPI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VALIPI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BASIPI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BASIPI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VALICM').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VALICM').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BASICM').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BASICM').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VALRET').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VALRET').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BASRET').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BASRET').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTPES').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTPES').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VALFAT').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VALFAT').AsFloat / fltQtdOri, -2);
          FieldByName('DET_QTDEMB').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_QTDEMB').AsFloat / fltQtdOri, -2);
          FieldByName('DET_DESCFF').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_DESCFF').AsFloat / fltQtdOri, -2);
          FieldByName('DET_PORCAT').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_PORCAT').AsFloat / fltQtdOri, -2);
          FieldByName('DET_QTDPON').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_QTDPON').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BAIEMP').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BAIEMP').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BAEIPI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BAEIPI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VAEIPI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VAEIPI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTCUS').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTCUS').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTCU2').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTCU2').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTMED').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTMED').AsFloat / fltQtdOri, -2);
        end
        Else If (LeftStr(strTab,6) = 'MOVICD') Then
        Begin
          FieldByName('ICD_BCUFDE').AsFloat    := RoundTo(fltQtdPar * FieldByName('ICD_BCUFDE').AsFloat / fltQtdOri, -2);
          FieldByName('ICD_BASFCP').AsFloat    := RoundTo(fltQtdPar * FieldByName('ICD_BASFCP').AsFloat / fltQtdOri, -2);
          FieldByName('ICD_VALFCP').AsFloat    := RoundTo(fltQtdPar * FieldByName('ICD_VALFCP').AsFloat / fltQtdOri, -2);
          FieldByName('ICD_VALDES').AsFloat    := RoundTo(fltQtdPar * FieldByName('ICD_VALDES').AsFloat / fltQtdOri, -2);
          FieldByName('ICD_VALORI').AsFloat    := RoundTo(fltQtdPar * FieldByName('ICD_VALORI').AsFloat / fltQtdOri, -2);
        End
        Else
        Begin
          FieldByName('DET_VAEIPI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VAEIPI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BAEIPI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BAEIPI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_TOTULT').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_TOTULT').AsFloat / fltQtdOri, -2);
          FieldByName('DET_IMPULT').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_IMPULT').AsFloat / fltQtdOri, -2);
          FieldByName('DET_QTDEXP').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_QTDEXP').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BASPIS').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BASPIS').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VALPIS').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VALPIS').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BASCOF').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BASCOF').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VALCOF').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VALCOF').AsFloat / fltQtdOri, -2);
          FieldByName('DET_CONFRE').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_CONFRE').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BASANT').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BASANT').AsFloat / fltQtdOri, -2);
          FieldByName('DET_ICMANT').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_ICMANT').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VENDOR').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VENDOR').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VLGNRE').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VLGNRE').AsFloat / fltQtdOri, -2);
          FieldByName('DET_COMLIQ').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_COMLIQ').AsFloat / fltQtdOri, -2);
          FieldByName('DET_OUTDES').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_OUTDES').AsFloat / fltQtdOri, -2);
          FieldByName('DET_OUTICM').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_OUTICM').AsFloat / fltQtdOri, -2);
          FieldByName('DET_ISEICM').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_ISEICM').AsFloat / fltQtdOri, -2);
          FieldByName('DET_FRESUG').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_FRESUG').AsFloat / fltQtdOri, -2);
          FieldByName('DET_OUTVAL').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_OUTVAL').AsFloat / fltQtdOri, -2);
          FieldByName('DET_ICMSAI').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_ICMSAI').AsFloat / fltQtdOri, -2);
          FieldByName('DET_IMPFED').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_IMPFED').AsFloat / fltQtdOri, -2);
          FieldByName('DET_DESOPE').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_DESOPE').AsFloat / fltQtdOri, -2);
          FieldByName('DET_DEDVCF').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_DEDVCF').AsFloat / fltQtdOri, -2);
          FieldByName('DET_BAERET').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_BAERET').AsFloat / fltQtdOri, -2);
          FieldByName('DET_VAERET').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_VAERET').AsFloat / fltQtdOri, -2);
          FieldByName('DET_COMPRO').AsFloat    := RoundTo(fltQtdPar * FieldByName('DET_COMPRO').AsFloat / fltQtdOri, -2);
        End;
      End;
    End;

   procedure pAtualizaSepFut(fltQtdIte: Double);
     Var
       qryAux: TUniQuery;
   begin
     qryAux := fCriaQuery;
     Try
       qryAux.SQL.Text := 'UPDATE SEPFUT SET SEP_QTDITE = :QTDITE WHERE SEP_SEQGER = :AUTINC';
       qryAux.ParamByName('AUTINC').AsString := strAutInc;
       qryAux.ParamByName('QTDITE').AsFloat  := fltQtdIte;
       qryAux.ExecSQL;
     Finally
       FreeAndNil(qryAux);
     End;
   end;

   procedure pParticionaIcd;
     Var
       qryIcdOri,
       qryIcdNov: TUniQuery;
       intIndice : Integer;
   begin
     // O INSERT do MOVICD novo dispara a T_MOVICD_AI_MOVREF, que aplica FCP/DIFAL na REF do pedaco novo
     qryIcdOri := fCriaQuery(Self);
     qryIcdNov := fCriaQuery(Self);
     Try
       qryIcdOri.SQL.Text := 'SELECT * FROM MOVICD WHERE ICD_SEQGER = ' + QuotedStr(strAutInc);
       qryIcdOri.Open;

       qryIcdNov.SQL.Text := 'SELECT * FROM MOVICD WHERE FALSE';
       qryIcdNov.Open;

       While Not qryIcdOri.Eof Do
       Begin
         qryIcdNov.Insert;

         For intIndice := 0 To qryIcdOri.Fields.Count - 1 Do
           If Not SameText(qryIcdOri.Fields[intIndice].FieldName, 'AUTOINCREM') Then
             qryIcdNov.Fields[intIndice].Value := qryIcdOri.Fields[intIndice].Value;

         pAtualizaTotais(qryIcdNov, fltQtdPar, 'MOVICD');
         qryIcdNov.FieldByName('ICD_SEQGER').AsString := strAutIncNov;
         qryIcdNov.Post;

         qryIcdOri.Edit;
         pAtualizaTotais(qryIcdOri, fltQtdOri - fltQtdPar, 'MOVICD');
         qryIcdOri.Post;

         qryIcdOri.Next;
       End;
     Finally
       FreeAndNil(qryIcdOri);
       FreeAndNil(qryIcdNov);
     End;
   end;

   procedure pParticionaReforma;
     Const
       CAMPOS_VALOR: Array[0..16] Of String = ('REF_VALOPE', 'REF_BASCAL', 'REF_VALIBS', 'REF_CBSVLD', 'REF_CBSVLT',
                                               'REF_CBSVAL', 'REF_IBSUVD', 'REF_IBSUFT', 'REF_IBSUFV', 'REF_IBSMVD',
                                               'REF_IBSMNT', 'REF_IBSMNV', 'REF_SELBAS', 'REF_SELVAL', 'REF_TIUREG',
                                               'REF_TIMREG', 'REF_TCBREG');
     Var
       qryRefOri,
       qryRefNov: TUniQuery;
       intCampo: Integer;
       strCampo: String;
   begin
     qryRefOri := fCriaQuery(Self);
     qryRefNov := fCriaQuery(Self);
     Try
       // Pedaco novo: a REF ja foi gravada pela trigger no INSERT do MOVTRI/MOVICD. O original so
       // teve UPDATE, que nao dispara a trigger: recalcula com a mesma regra sobre os valores reduzidos
       qryRefNov.SQL.Text := 'SELECT REF_SEQGER FROM MOVREF WHERE REF_SEQGER = ' + QuotedStr(strAutIncNov);
       qryRefNov.Open;

       If Not qryRefNov.IsEmpty Then
       Begin
         TRefTribCalculo.fRecalcularRefDoItemGravado(strAutInc, '');
         Exit;
       End;

       qryRefNov.Close;

       // Documento fora do alcance da trigger (REF gravada pelo Delphi): rateia a REF da original
       qryRefOri.SQL.Text := 'SELECT * FROM MOVREF WHERE REF_SEQGER = ' + QuotedStr(strAutInc);
       qryRefOri.Open;

       If qryRefOri.IsEmpty Then
         Exit;

       qryRefNov.SQL.Text := 'DELETE FROM MOVREF WHERE REF_SEQGER = ' + QuotedStr(strAutIncNov);
       qryRefNov.ExecSQL;

       qryRefNov.SQL.Text := 'SELECT * FROM MOVREF WHERE FALSE';
       qryRefNov.Open;
       qryRefNov.Insert;

       For intCampo := 0 To qryRefOri.Fields.Count - 1 Do
         qryRefNov.Fields[intCampo].Value := qryRefOri.Fields[intCampo].Value;

       qryRefNov.FieldByName('REF_SEQGER').AsString := strAutIncNov;

       For strCampo In CAMPOS_VALOR Do
         If Assigned(qryRefNov.FindField(strCampo)) Then
           qryRefNov.FieldByName(strCampo).AsFloat := RoundTo(fltQtdPar * qryRefOri.FieldByName(strCampo).AsFloat / fltQtdOri, -2);

       qryRefNov.Post;

       qryRefOri.Edit;

       For strCampo In CAMPOS_VALOR Do
         If Assigned(qryRefOri.FindField(strCampo)) Then
           qryRefOri.FieldByName(strCampo).AsFloat := RoundTo((fltQtdOri - fltQtdPar) * qryRefOri.FieldByName(strCampo).AsFloat / fltQtdOri, -2);

       qryRefOri.Post;
     Finally
       FreeAndNil(qryRefOri);
       FreeAndNil(qryRefNov);
     End;
   end;

Begin

  Try
    qryGenAlt := fCriaQuery(Self);
    qryGenInc := fCriaQuery(Self);

    {*******************}
    {* ALTERA MOVDET/X *}
    {*******************}
    With qryGenAlt, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ');
      Add(strTabela);
      Add('WHERE');
      Add('  AUTOINCREM = ' + QuotedStr(strAutInc));
      Open;

      fltQtdOri := FieldByName('DET_QTDITE').AsFloat; 
    End;

    With qryGenInc, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ');
      Add(strTabela);
      Add('WHERE');
      Add('  FALSE');
      Open;

      qryGenInc.Insert;

      For intIndice := 0 To qryGenAlt.Fields.Count - 1 Do
        Fields[intIndice].Value := qryGenAlt.Fields[intIndice].Value;

      fStartTransaction;

      If Assigned(objConEnt) Then
      Begin
        objConEnt.fSetNumDoc(qryGenInc.FieldByName('DET_NUMDOC').AsString,
                             qryGenInc.FieldByName('DET_ESPDOC').AsString,
                             qryGenInc.FieldByName('DET_CODEMP').AsString,
                             qryGenInc.FieldByName('DET_CODCLI').AsString);
        objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
      End;  

      pGravarLogFut(Self.Name,
                    FieldByName('DET_NUMDOC').AsString,
                    FieldByName('DET_ESPDOC').AsString,
                    FieldByName('DET_CODEMP').AsString,
                    FieldByName('DET_CODCLI').AsString,
                    FieldByName('DET_SERIE_').AsString,
                    FieldByName('DET_CODITE').AsString,
                    strLoginUsuarioLogado,
                    VS_Date,
                    fTime(),
                    FieldByName('DET_MOTFUT').AsString,
                    strMotivo,
                    FieldByName('DET_DTAFUT').AsString,
                    FormatDateTime('DD/MM/YYYY', dtaEntFut));

      pAtualizaTotais(qryGenInc, fltQtdPar, strTabela);

      strAutIncNov := fRetAutoIncrem(strTabela, VS_strCodEmp);

      FieldByName('AUTOINCREM').AsString   := strAutIncNov;
      FieldByName('DET_MOTFUT').AsString   := strMotivo;
      FieldByName('DET_DTAFUT').AsDateTime := dtaEntFut;
      FieldByName('DET_QTDITE').AsFloat    := fltQtdPar;
      FieldByName('DET_QTDENT').AsFloat    := 0;
      FieldByName('DET_QTDROM').AsFloat    := 0;

      If Assigned(FindField('DET_EFBAIX')) Then
        FieldByName('DET_EFBAIX').AsString   := 'N';

      Post;

    End;

    With qryGenAlt Do
    Begin
      Edit;

      pAtualizaTotais(qryGenAlt, FieldByName('DET_QTDITE').AsFloat - fltQtdPar, strTabela);

      FieldByName('DET_QTDITE').AsFloat := FieldByName('DET_QTDITE').AsFloat - fltQtdPar;

      If Assigned(FindField('DET_EFBAIX')) Then
        FieldByName('DET_EFBAIX').AsString   := 'N';

      Post;

      pAtualizaSepFut(FieldByName('DET_QTDITE').AsFloat);
    End;

    {****************************************************}
    {* VALIDA SE A QUANTIDADE TOTAL BATE COM A ORIGINAL *}
    {*REQ.226299**************************************RP*}
    If Not SameValue(fFormataFloat(cdsConsulta.FieldByName('DET_QTDITE').AsFloat, intQtdDec),
                     fFormataFloat(qryGenAlt.FieldByName('DET_QTDITE').AsFloat + fltQtdPar, intQtdDec)) Then
    Begin
      fRollBack;
      Result := False;
      pMensagemOk('Houve uma inconsistência na gravação. A quantidade original do item ' +
                  cdsConsulta.FieldByName('DET_CODITE').AsString + ' (' +
                  FormatFloat(fMskDigitos(intQtdDec), cdsConsulta.FieldByName('DET_QTDITE').AsFloat) +
                  ') é diferente da quantidade alterada (' +
                  FormatFloat(fMskDigitos(intQtdDec), qryGenAlt.FieldByName('DET_QTDITE').AsFloat + fltQtdPar) +
                  ').' + sLineBreak + 'Por favor, recarregue a tela e refaça a operação.');
      Exit;
    End;

    If Assigned(objConEnt) Then
    Begin
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaEnt);

      objConEnt.fProcessaArrayDatasControleEntregaRomaneio;                                   
    End;

    {*******************}
    {* ALTERA MOVTRI/X *}
    {*******************}
    With qryGenAlt, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ');
      Add(strTabTri);
      Add('WHERE');
      Add('  DET_SEQGER = ' + QuotedStr(strAutInc));
      Open;
    End;

    With qryGenInc, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ');
      Add(strTabTri);
      Add('WHERE');
      Add('  FALSE');
      Open;

      qryGenInc.Insert;

      For intIndice := 0 To qryGenAlt.Fields.Count - 1 Do
        Fields[intIndice].Value := qryGenAlt.Fields[intIndice].Value;

      pAtualizaTotais(qryGenInc, fltQtdPar, strTabTri);

      FieldByName('DET_SEQGER').AsString := strAutIncNov;
      FieldByName('DET_CLIBUS').AsString := strCliBus;

      Post;
    End;

    With qryGenAlt Do
    Begin
      Edit;
      pAtualizaTotais(qryGenAlt, fltQtdOri - fltQtdPar, strTabTri);
      Post;
    End;    

    {*******************}
    {* ALTERA MOVICD   *}
    {*******************}
    pParticionaIcd;

    pParticionaReforma;

    TMovIte.pParticionaMovIteEntregaFutura(strAutInc, strAutIncNov, fltQtdPar);

    With qryGenAlt, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ');
      Add(strTabela);
      Add('WHERE');
      Add('  AUTOINCREM = ' + QuotedStr(strAutInc));
      Open;

      ReprocessarItem(FieldByName('DET_CODITE').AsString, '');

      TReprocessarSaldoItem.New
        .AddItem(
           TItemReprocessarSaldo.New
             .Codigo(FieldByName('DET_CODITE').AsString)
             .Empresa(FieldByName('DET_CODEMP').AsString)
           ).ReprocessarSaldoPedidos(Nil)
            .ReprocessarSaldoEntregaFutura(Nil);
    End;      

    fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatAlteraDtaEntFut.fParticionaRegistro]');
    End;
  End;

  FreeAndNil(qryGenAlt);
  FreeAndNil(qryGenInc);

End;

end.
