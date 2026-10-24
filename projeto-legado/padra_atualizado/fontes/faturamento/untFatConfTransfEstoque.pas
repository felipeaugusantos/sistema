{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}

unit untFatConfTransfEstoque;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus,
  Grids, DBGridCitel, DBGrids, Menus, ComCtrls, Buttons, ExtCtrls, DB, {Qt,} untFuncFat,
  StrUtils, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, cxProgressBar,
  frxExportCSVTestabilidade;

type
  TfrmFatConfTransfEstoque = class(TfrmPaiSimples)
    pnlAux2: TPanel;
    dbgDocumentos: TDBGridCitel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    btnItensDoc: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    edtQtdDoc: TEditFocus;
    edtTotLiq: TEditFocus;
    edtQtdDocSel: TEditFocus;
    edtTotLiqSel: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label5: TLabel;
    btnMarca: TBitBtnLocked;
    btnPopMenuMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnPopMenuDesMarca: TBitBtnLocked;
    popMarca: TPopupMenu;
    popEnt: TMenuItem;
    popRet: TMenuItem;
    procedure btnSairConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensDocClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnPopMenuMarcaClick(Sender: TObject);
    procedure btnPopMenuDesMarcaClick(Sender: TObject);
    procedure popEntClick(Sender: TObject);
    procedure popRetClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    const
      PREFIXO_TRAVA : String = 'CONF_TE_';
      TAMANHO_SUFIXO_TRAVA : Integer = 25;
  private
    { Private declarations }
    qryConCli: TUniQuery;
    blnFecharForm: Boolean;

    intItensDocs: Integer;
    blnAlgumaEmpresaUsaRegimeEspecialPorEmpresa : Boolean;

    strSelecaoEntRet : String;
    strSelecaoRegEsp2 : String;
    stlConnectionsID : TStringList;

    procedure pCriaTemporaria(const pgbProgresso: TcxProgressBar);
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pCarregaCliente;

    procedure pCarregaItensDocumento;
    procedure pMarcarTodosDocumentos(blnMarcar: Boolean; strEntRet: String; const pgbProgresso: TcxProgressBar);
    procedure pMarcaDocumento(const blnMarcar: Boolean; const blnCalculaTotais : Boolean);
    procedure pCalculaTotais;

    procedure pDeletaDocDesmarcados;
    procedure pGeraStringDocsConfirmados;

    Function fRetKeyLck: String;
    Function fDocumentoConfirmado: Boolean;
    Function fPodeFechar: Boolean;
    procedure pMarcarDesmarcarTudo(strOpc, strEntRet: String; const pgbProgresso: TcxProgressBar);
    function  fExisteRegistro: Boolean;

    function fVerificaConfirmacaoRegEsp2(strRegEsp2: String): Boolean;
    function fVerificaUltimaNotaEntradaFornecedorRegEsp2: Boolean;

    procedure pRetJurosDescontoSujerido(strNumDoc,
                                        strEspDoc,
                                        strCodEmp,
                                        strCodCli: String;
                                    Var fltJurSuj,
                                        fltDesSuj,
                                        fltValAbe: Double);

    function fGetValorDuplicatasRecebidas(strNumDup,
                                          strEspDoc,
                                          strCodEmp: String;
                                          fltVlrCon,
                                          fltDupRecAnt: Double;
                                      Var fltJurSuj,
                                          fltDesSuj,
                                          fltValAbe: Double ): Double;

    function fLancouTravaLCKEmLote : Boolean;
    procedure pDeletarTravaLCKEmLote;
    procedure pFlegarStatusTemporaria(const strMarDes : String);
    procedure pPublicarTravas;
    procedure pPublicarTravasLck;
    procedure pPublicarPrefixoLck;
    procedure pRemoverPublicacaoTravasLck;
    function fExtrairTravaLck(const strMensagemErro : String): String;
    procedure pMarcarTodos;
    procedure pDesmarcarTodos;
    procedure pAddConnectionID(const strConnectionID : String);
    function fGetConnectionsIDAsSQL: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    fatVenda: TFatVenda;
  end;

var
  frmFatConfTransfEstoque: TfrmFatConfTransfEstoque;

implementation

uses  untfuncoesSimples, untPesqAux,
      untFatMostraProdConfirmacao, untPai, untFuncoes, untGravando;

{$R *.dfm}

procedure TfrmFatConfTransfEstoque.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatConfTransfEstoque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If (fEmptyStr(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False; 
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If (fEmptyStr(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else If (fValidaCampos(mskDtaIni, True)) Then
      Begin

        If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data final deve ser menor ou igual a data final!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          fExecutarModal(
            function(pgbProgresso: TcxProgressBar): Boolean
            begin
              pCriaTemporaria(pgbProgresso);
              Result := True;
            end,
            'Carregando Documentos...',
            ''
          );
          pAtualizaTemporaria;

          If (fatVenda.qryTemporariaConfirmacao.IsEmpty) Then
          Begin

            fMensagem('ATENÇÃO!', 'Não há documentos para confirmar nesse período!', ['&Ok']);
            Result := False;

          End
          Else
          Begin
            blnMudarFoco := False;
            pSetFocus(dbgDocumentos);
          End;
        End;

      End;

    End;


  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatConfTransfEstoque.fVerificaConfirmacaoRegEsp2(
  strRegEsp2: String): Boolean;
Var
  strSQL   : String;
  qryGenDes: TUniQuery;
begin
  Result := True;

  If (Not blnAlgumaEmpresaUsaRegimeEspecialPorEmpresa) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT TMP_REGES2 FROM ' + fatVenda.strTabelaConfMi + ' ';
  strSQL := strSQL + 'WHERE TMP_MARDES = "M" ';

  qryGenDes := fCriaQuery(Self);
  Try
    qryGenDes.Close;
    qryGenDes.SQL.Text := strSQL;
    qryGenDes.Open;

    If qryGenDes.IsEmpty Then
      Exit;

    If qryGenDes.FieldByName('TMP_REGES2').AsString <> strRegEsp2 Then
    Begin
      pMensagemOk('Não é possível selecionar documentos gerados pela rotina de Regime Especial, junto com documentos gerados manualmente!');
      Result := False;
    End;
  Finally
    FreeAndNil(qryGenDes);
  End;
end;

function TfrmFatConfTransfEstoque.fVerificaUltimaNotaEntradaFornecedorRegEsp2: Boolean;
  Var
    strEmpCliFil, strForFil: String;
begin
  Result := True;

  If (Not blnAlgumaEmpresaUsaRegimeEspecialPorEmpresa) Then
    Exit;

  If fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REGES2').AsString <> 'S' Then
    Exit;

  If Not fClienteFilial(edtCodCli.Text, strEmpCliFil) Then
    Exit;

  strForFil := fGetFornecedorFilial(strEmpCliFil);

  If fEmptyStr(strForFil) Then
  Begin
    pMensagemOk('Fornecedor filial não preenchido no cadastro da empresa "'+ strEmpCliFil +'".'+ sLineBreak +
                'Por favor, corrija o cadastro e tente novamente.');
    Result := False;
  End

  Else If fEmptyStr(fGetUltimaChaveAcessoFornecedor(strForFil, VS_strCodEmp)) Then
  Begin
    pMensagemOk('Não foi encontrada última nota de entrada do fornecedor flial '+ strForFil +'!');
    Result := False;
  End;
end;

function TfrmFatConfTransfEstoque.fPodeFechar: Boolean;
  Var
    strSQL   : String;
    qryGen: TUniQuery;
begin
  Result := True;

  If (Not blnConfirma) And fTabelaExiste(fatVenda.strTabelaConfMi) Then
  Begin
    qryGen := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '  TMP_MARDES ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fatVenda.strTabelaConfMi;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '  TMP_MARDES = "M" ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If Not IsEmpty Then
          If fMensagem('', 'Abandona?', ['&Sim', '&Não']) = 2 Then
            Result := False
          Else
            pDeletaTemporaria;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TfrmFatConfTransfEstoque.pRemoverPublicacaoTravasLck;
  Var
    intCnt : Integer;
begin
  fatVenda.objLock.pRemoverPublicacaoTravas(PREFIXO_TRAVA);
  For intCnt := 0 To Pred(stlConnectionsID.Count) Do
    fatVenda.objLock.pRemoverPublicacaoPrefixo(stlConnectionsID.Strings[intCnt]);
end;

procedure TfrmFatConfTransfEstoque.pPublicarTravas;
begin
  pPublicarTravasLck;
  pPublicarPrefixoLck;
end;

procedure TfrmFatConfTransfEstoque.pPublicarPrefixoLck;
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Pred(stlConnectionsID.Count) Do
    fatVenda.objLock.pPublicarPrefixo(PREFIXO_TRAVA, stlConnectionsID.Strings[intCnt]);
end;

procedure TfrmFatConfTransfEstoque.pPublicarTravasLck;
  Var
    qryLckAtc : TUniQuery;
begin
  qryLckAtc := fCriaQuery(Self);
  Try
    qryLckAtc.SQL.Add(' SELECT DISTINCT RIGHT(TMP_CHVLCK, ' + IntToStr( TAMANHO_SUFIXO_TRAVA + Length(PREFIXO_TRAVA) ) + ') AS TMP_CHVLCK ');
    qryLckAtc.SQL.Add('   FROM ' + fatVenda.strTabelaConfMi);
    qryLckAtc.SQL.Add('   JOIN LCKATC ON LCK_CHAACE = TMP_CHVLCK ');
    qryLckAtc.SQL.Add('  WHERE TMP_MARDES = "D" ');
    qryLckAtc.SQL.Add('    AND LCK_CON_ID IN (' + fGetConnectionsIDAsSQL + ') ');
    qryLckAtc.Open;
    qryLckAtc.First;
    While Not qryLckAtc.Eof Do
    Begin
      fatVenda.objLock.pPublicarTravas(qryLckAtc.FieldByName('TMP_CHVLCK').AsString);
      qryLckAtc.Next;
    End;
  Finally
    FreeAndNil(qryLckAtc);
  End;
end;

procedure TfrmFatConfTransfEstoque.pFlegarStatusTemporaria(const strMarDes : String);
  Var
    strSQL : String;
    qryLckAtc : TUniQuery;
begin
  strSQL := EmptyStr;
  strSQL := strSQL + ' UPDATE ' + fatVenda.strTabelaConfMi;
  If (strMarDes = 'M') Then
    strSQL := strSQL + '  INNER JOIN LCKATC ON LCK_CHAACE = TMP_CHVLCK '
  Else
    strSQL := strSQL + '  LEFT JOIN LCKATC ON LCK_CHAACE = TMP_CHVLCK ';
  strSQL := strSQL + '    SET TMP_MARDES = ' + QuotedStr(strMarDes);
  strSQL := strSQL + '  WHERE TMP_MARDES = ' + QuotedStr(IfThen(strMarDes = 'M', 'D', 'M'));

  If (strMarDes = 'M') Then
    strSQL := strSQL + '  AND LCK_CON_ID IN (' + fGetConnectionsIDAsSQL + ') '
  Else
    strSQL := strSQL + '  AND LCK_CHAACE IS NULL ';

  qryLckAtc := fCriaQuery(Self);
  Try
    qryLckAtc.SQL.Text := strSQL;
    qryLckAtc.ExecSQL;
  Finally
    FreeAndNil(qryLckAtc);
  End;
end;

procedure TfrmFatConfTransfEstoque.pDeletarTravaLCKEmLote;
  Var
    strSQL : String;
    qryLckAtc : TUniQuery;
begin
  strSQL := EmptyStr;
  strSQL := strSQL + ' DELETE ';
  strSQL := strSQL + '   FROM LCKATC ';
  strSQL := strSQL + '  WHERE LCK_CHAACE IN ( SELECT TMP_CHVLCK ';
  strSQL := strSQL + '                          FROM ' + fatVenda.strTabelaConfMi;
  strSQL := strSQL + '                         WHERE TMP_MARDES = "M" ';
  strSQL := strSQL + '                       )';
  strSQL := strSQL + '    AND LCK_CON_ID IN (' + fGetConnectionsIDAsSQL + ') ';
  qryLckAtc := fCriaQuery(Self);
  Try
    qryLckAtc.SQL.Text := strSQL;
    qryLckAtc.ExecSQL;
  Finally
    FreeAndNil(qryLckAtc);
  End;
end;

function TfrmFatConfTransfEstoque.fExtrairTravaLck(const strMensagemErro : String): String;
  Var
    strMensagem : String;
    strTrava : String;
begin
  strMensagem := strMensagemErro;
  Result := EmptyStr;
  While (Pos(PREFIXO_TRAVA, strMensagem) > 0) Do
  Begin
    If (Not fEmptyStr(Result)) Then
      Result := Result + ', ';

    strTrava := Copy(strMensagem, Pos(PREFIXO_TRAVA, strMensagem), TAMANHO_SUFIXO_TRAVA + Length(PREFIXO_TRAVA));
    strMensagem := AnsiReplaceStr(strMensagem, strTrava, '');

    strTrava := AnsiReplaceStr(strTrava, PREFIXO_TRAVA, '');
    Insert('-', strTrava, 13);
    Insert('-', strTrava, 16);
    Insert('-', strTrava, 20);

    Result := Result + strTrava;
  End;
end;

function TfrmFatConfTransfEstoque.fLancouTravaLCKEmLote: Boolean;
  Var
    strSQL : String;
    qryLckAtc : TUniQuery;
    strCoonectionID : String;
begin
  strCoonectionID := fGetConnectionID;
  pAddConnectionID(strCoonectionID);
  strSQL := EmptyStr;
  strSQL := strSQL + ' INSERT INTO LCKATC (LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_DTALCK, LCK_HRALCK, ';
  strSQL := strSQL + '                     LCK_TENTAT, LCK_ORIGEM, LCK_QTDTRA, LCK_MACADD, LCK_NOMMAQ, LCK_NOMUSU) ';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL +      QuotedStr(VS_IPAddressAsString) + ', ';
  strSQL := strSQL +      QuotedStr(strCoonectionID) + ', ';
  strSQL := strSQL +      'TMP_CHVLCK, ';
  strSQL := strSQL +      QuotedStr(strLoginUsuarioLogado) + ', ';
  strSQL := strSQL +      ' CURRENT_DATE, ';
  strSQL := strSQL +      ' CURRENT_TIME, ';
  strSQL := strSQL +      ' 0, ';
  strSQL := strSQL +      ' "", ';
  strSQL := strSQL +      ' 1, ';
  strSQL := strSQL +      QuotedStr(VS_MacAddress) + ', ';
  strSQL := strSQL +      QuotedStr(VS_ComputerNetName) + ', ';
  strSQL := strSQL +      QuotedStr(VS_UserFromWindows);
  strSQL := strSQL + '   FROM ' + fatVenda.strTabelaConfMi;
  strSQL := strSQL + '   JOIN MOVGER G ON G.GER_NUMDOC = TMP_NUMDOC ';
  strSQL := strSQL + '                AND G.GER_ESPDOC = TMP_ESPDOC ';
  strSQL := strSQL + '                AND G.GER_CODEMP = TMP_CODEMP ';
  strSQL := strSQL + '                AND G.GER_CODCLI = ' + QuotedStr(edtCodCli.Text);
  strSQL := strSQL + '                AND G.GER_TIP_FC = "C" ';
  strSQL := strSQL + '  WHERE TMP_MARDES = "D" ';
  strSQL := strSQL + '    AND IFNULL(GER_NUMFAT,"") = "" ';

  If (Not fEmptyStr(strSelecaoRegEsp2)) And (blnAlgumaEmpresaUsaRegimeEspecialPorEmpresa) Then
    strSQL := strSQL + '  AND TMP_REGES2 = ' + QuotedStr(strSelecaoRegEsp2);

  If (Not fEmptyStr(strSelecaoEntRet)) And (fCfgSis('COENRE', varString) = 'S') Then
    strSQL := strSQL + '  AND TMP_ENTRET = ' + QuotedStr(strSelecaoEntRet);

  Result := True;
  qryLckAtc := fCriaQuery(Self);
  Try
    Try
      qryLckAtc.SQL.Text := strSQL;
      qryLckAtc.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Alguns documentos não puderam ser marcados pois estão sendo utilizados por outra estação' + sLineBreak +
                              fExtrairTravaLck(E.Message), ['&OK']);
      End;
    End;
  Finally
    FreeAndNil(qryLckAtc);
  End;
end;

procedure TfrmFatConfTransfEstoque.pAddConnectionID(
  const strConnectionID: String);
begin
  If stlConnectionsID.IndexOf(strConnectionID) >= 0 Then
    Exit;
  stlConnectionsID.Add(strConnectionID);
end;

procedure TfrmFatConfTransfEstoque.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

procedure TfrmFatConfTransfEstoque.pCriaTemporaria;
  Var
    strSQL: String;
    strNumDoc: String;
    intQtdIte: Integer;
    strDocAnt: String;
    strEspAnt: String;
    qryGenDet: TUniQuery;
    qryGenGer: TUniQuery;

    fltTotIte,
    fltTotFre,
    fltVlrCon,
    fltJurSuj,
    fltDesSuj,
    fltValAbe: Double;

begin
  qryGenDet := fCriaQuery(Self);
  qryGenGer := fCriaQuery(Self);

  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_JAFATU, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  GER_VLRCON, ';
  strSQL := strSQL + '  GER_ENTFAT, ';
  strSQL := strSQL + '  GER_CODS01, ';
  strSQL := strSQL + '  GER_CODS02, ';
  strSQL := strSQL + '  GER_CODS03, ';
  strSQL := strSQL + '  GER_CODS04, ';
  strSQL := strSQL + '  GER_CODS05, ';
  strSQL := strSQL + '  GER_CODS06, ';
  strSQL := strSQL + '  GER_CODS07, ';
  strSQL := strSQL + '  GER_CODS08, ';
  strSQL := strSQL + '  GER_CODS09, ';
  strSQL := strSQL + '  GER_CODS10, ';
  strSQL := strSQL + '  GER_CODS11, ';
  strSQL := strSQL + '  GER_CODS12, ';
  strSQL := strSQL + '  GER_CODS13, ';
  strSQL := strSQL + '  GER_CODS14, ';
  strSQL := strSQL + '  GER_CODS15, ';
  strSQL := strSQL + '  GER_CODS16, ';
  strSQL := strSQL + '  GER_CODS17, ';
  strSQL := strSQL + '  GER_CODS18, ';
  strSQL := strSQL + '  GER_CODS19, ';
  strSQL := strSQL + '  GER_CODS20, ';
  strSQL := strSQL + '  GER_CODS21, ';
  strSQL := strSQL + '  GER_CODS22, ';
  strSQL := strSQL + '  GER_CODS23, ';
  strSQL := strSQL + '  GER_CODS24, ';
  strSQL := strSQL + '  GER_CODS25, ';
  strSQL := strSQL + '  GER_CODS26, ';
  strSQL := strSQL + '  GER_CODS27, ';
  strSQL := strSQL + '  GER_CODS28, ';
  strSQL := strSQL + '  GER_CODS29, ';
  strSQL := strSQL + '  GER_CODS30, ';

  strSQL := strSQL + '  GER_DESS01, ';
  strSQL := strSQL + '  GER_DESS02, ';
  strSQL := strSQL + '  GER_DESS03, ';
  strSQL := strSQL + '  GER_DESS04, ';
  strSQL := strSQL + '  GER_DESS05, ';
  strSQL := strSQL + '  GER_DESS06, ';
  strSQL := strSQL + '  GER_DESS07, ';
  strSQL := strSQL + '  GER_DESS08, ';
  strSQL := strSQL + '  GER_DESS09, ';
  strSQL := strSQL + '  GER_DESS10, ';
  strSQL := strSQL + '  GER_DESS11, ';
  strSQL := strSQL + '  GER_DESS12, ';
  strSQL := strSQL + '  GER_DESS13, ';
  strSQL := strSQL + '  GER_DESS14, ';
  strSQL := strSQL + '  GER_DESS15, ';
  strSQL := strSQL + '  GER_DESS16, ';
  strSQL := strSQL + '  GER_DESS17, ';
  strSQL := strSQL + '  GER_DESS18, ';
  strSQL := strSQL + '  GER_DESS19, ';
  strSQL := strSQL + '  GER_DESS20, ';
  strSQL := strSQL + '  GER_DESS21, ';
  strSQL := strSQL + '  GER_DESS22, ';
  strSQL := strSQL + '  GER_DESS23, ';
  strSQL := strSQL + '  GER_DESS24, ';
  strSQL := strSQL + '  GER_DESS25, ';
  strSQL := strSQL + '  GER_DESS26, ';
  strSQL := strSQL + '  GER_DESS27, ';
  strSQL := strSQL + '  GER_DESS28, ';
  strSQL := strSQL + '  GER_DESS29, ';
  strSQL := strSQL + '  GER_DESS30, ';

  strSQL := strSQL + '  GER_VALS01, ';
  strSQL := strSQL + '  GER_VALS02, ';
  strSQL := strSQL + '  GER_VALS03, ';
  strSQL := strSQL + '  GER_VALS04, ';
  strSQL := strSQL + '  GER_VALS05, ';
  strSQL := strSQL + '  GER_VALS06, ';
  strSQL := strSQL + '  GER_VALS07, ';
  strSQL := strSQL + '  GER_VALS08, ';
  strSQL := strSQL + '  GER_VALS09, ';
  strSQL := strSQL + '  GER_VALS10, ';
  strSQL := strSQL + '  GER_VALS11, ';
  strSQL := strSQL + '  GER_VALS12, ';
  strSQL := strSQL + '  GER_VALS13, ';
  strSQL := strSQL + '  GER_VALS14, ';
  strSQL := strSQL + '  GER_VALS15, ';
  strSQL := strSQL + '  GER_VALS16, ';
  strSQL := strSQL + '  GER_VALS17, ';
  strSQL := strSQL + '  GER_VALS18, ';
  strSQL := strSQL + '  GER_VALS19, ';
  strSQL := strSQL + '  GER_VALS20, ';
  strSQL := strSQL + '  GER_VALS21, ';
  strSQL := strSQL + '  GER_VALS22, ';
  strSQL := strSQL + '  GER_VALS23, ';
  strSQL := strSQL + '  GER_VALS24, ';
  strSQL := strSQL + '  GER_VALS25, ';
  strSQL := strSQL + '  GER_VALS26, ';
  strSQL := strSQL + '  GER_VALS27, ';
  strSQL := strSQL + '  GER_VALS28, ';
  strSQL := strSQL + '  GER_VALS29, ';
  strSQL := strSQL + '  GER_VALS30, ';
  strSQL := strSQL + '  AUX_DUPREC, ';
  strSQL := strSQL + '  "MOVGER" AS GER_TABELA, ';
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS GER_AUTINC, ';
  strSQL := strSQL + '  AUX_FASOBR AS GER_FASOBR,  ';
  strSQL := strSQL + '  AUX_DOCRE2  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN SERMOV ON GER_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (GER_NUMFAT IS NULL OR GER_TIPFAT = "") AND  ';
  strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  GER_ESPDOC = "TE" AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  GER_NUMDOC, GER_ESPDOC ';

  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString   := edtCodCli.Text;
    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODCLI, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_CLAFIS  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  //strSQL := strSQL + '  (DET_NUMFAT IS NULL OR DET_TIPFAT = "") AND ';
  strSQL := strSQL + '  DET_JAFATU = FALSE AND ';
  strSQL := strSQL + '  DET_ESPDOC = "TE" AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  DET_NUMDOC, DET_ESPDOC ';

  {*****************************************}
  {* MOVDET                                *}
  {**************************************MV*}
  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString   := edtCodCli.Text;
    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    Open;
  End;

  strSelecaoEntRet := EmptyStr;
  strSelecaoRegEsp2 := EmptyStr;

  pAtualizaTemporaria;

  pgbProgresso.Properties.Max := qryGenGer.RecordCount;
  fatVenda.qryTemporariaConfirmacao.DisableControls;
  Try
    With qryGenGer Do
    Begin

      {*****************************************}
      {* PROCESSA MOVGER                       *}
      {**************************************MV*}
      While Not Eof Do
      Begin
        pgbProgresso.Position := qryGenGer.RecNo;
        pProcessMessages();

        intQtdIte := 0;
        strDocAnt := qryGenDet.FieldByName('DET_NUMDOC').AsString;
        strEspAnt := qryGenDet.FieldByName('DET_ESPDOC').AsString;
        fltVlrCon := 0.0;

        {*****************************************}
        {* CALCULA QUANTIDADE DE ITENS NO DOC.   *}
        {**************************************MV*}
        While (Not qryGenDet.Eof)                                        And
              (qryGenDet.FieldByName('DET_NUMDOC').AsString = strDocAnt) And
              (qryGenDet.FieldByName('DET_ESPDOC').AsString = strEspAnt) Do
        Begin

          {*******************************************}
          {* VALIDAR AQUI PRODUTO EMBALAGEM (PROEMB) *}
          {****************************************MV*}
          //If proemb Then
          //  Continue;

          fltTotIte := (qryGenDet.FieldByName('DET_TOTITE').AsFloat - qryGenDet.FieldByName('DET_DESESP').AsFloat);
          fltTotFre := qryGenDet.FieldByName('DET_TOTFRE').AsFloat;

          If (qryGenDet.FieldByName('DET_CLAFIS').AsString < '5000') Then
          Begin
            fltTotIte := -fltTotIte;
            fltTotFre := -fltTotFre;
          End;

          fltVlrCon := fltVlrCon + (fltTotIte + fltTotFre);


          Inc(intQtdIte);
          qryGenDet.Next;
        End;

        {*****************************************}
        {* INSERE REGISTRO NA TEMPORARIA         *}
        {**************************************MV*}
        fatVenda.qryTemporariaConfirmacao.Append;
        strNumDoc := FieldByName('GER_NUMDOC').AsString;

        If FieldByName('GER_JAFATU').DataType = ftInteger Then
          strNumDoc := strNumDoc + IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'q', '')
        Else
          strNumDoc := strNumDoc + IIF(FieldByName('GER_JAFATU').AsBoolean = True, 'q', '');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FASOBR').AsString   := FieldByName('GER_FASOBR').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DTAENT').AsDateTime := FieldByName('GER_DTAENT').AsDateTime;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString   := strNumDoc;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString   := FieldByName('GER_ESPDOC').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString   := VS_strCodEmp;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString   := FieldByName('GER_CODVEN').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat    := FieldByName('GER_VLRCON').AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESESP').AsFloat    := FieldByName('GER_DESESP').AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ITEDOC').AsInteger  := intQtdIte;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ENTRET').AsString   := IfThen(FieldByName('GER_ENTFAT').AsString = 'S', 'E', 'R');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString   := FieldByName('GER_TABELA').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString   := FieldByName('GER_AUTINC').AsString;

        If FieldByName('GER_JAFATU').DataType = ftInteger Then
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString := IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'S', 'N')
        else
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString := IIF(FieldByName('GER_JAFATU').AsBoolean = True, 'S', 'N');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString   := 'D';

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REGES2').AsString   := IfThen(fEmptyStr(FieldByName('AUX_DOCRE2').AsString), 'N', 'S');

        If (qryGenGer.FieldByName('GER_ESPDOC').AsString = 'TE') Then
        Begin
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPREC').AsFloat := fGetValorDuplicatasRecebidas(qryGenGer.FieldByName('GER_NUMDOC').AsString,
                                                                                                              qryGenGer.FieldByName('GER_ESPDOC').AsString,
                                                                                                              qryGenGer.FieldByName('GER_CODEMP').AsString,
                                                                                                              fltVlrCon,
                                                                                                              qryGenGer.FieldByName('AUX_DUPREC').AsFloat,
                                                                                                              fltJurSuj,
                                                                                                              fltDesSuj,
                                                                                                              fltValAbe);
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_JURSUJ').AsFloat := fltJurSuj;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESSUJ').AsFloat := fltDesSuj;
        End;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CHVLCK').AsString := fGetDatabaseName + '.' + fRetKeyLck;
        fatVenda.qryTemporariaConfirmacao.Post;

        If fEmptyStr(strSelecaoRegEsp2) Then
          strSelecaoRegEsp2 := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REGES2').AsString;

        If fEmptyStr(strSelecaoEntRet) Then
          strSelecaoEntRet := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ENTRET').AsString;

        Next;

      End;
      fatVenda.qryTemporariaConfirmacao.First;

    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.EnableControls;
  End;

  qryGenGer.Close;

  pCalculaTotais;

  FreeAndNil(qryGenDet);
  FreeAndNil(qryGenGer);

  If fCfgSis('COENRE', varBoolean) Then
  Begin
    btnPopMenuMarca.Enabled    := fTemItensEntregaRetira(fatVenda.strTabelaConfMi);
    btnPopMenuDesMarca.Enabled := btnPopMenuMarca.Enabled;
  End;

end;

procedure TfrmFatConfTransfEstoque.pDeletaTemporaria;
begin

  If (Not fTabelaExiste(fatVenda.strTabelaConfMi)) Then
    Exit;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ' + fatVenda.strTabelaConfMi);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatConfTransfEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not fPodeFechar Then
    Action := caNone
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmFatConfTransfEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma   := False;
  blnFecharForm := False;
  qryConCli     := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  blnAlgumaEmpresaUsaRegimeEspecialPorEmpresa := fAlgumaEmpresaUsaRegimeEspecialPorEmpresa;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  stlConnectionsID := TStringList.Create;
end;

procedure TfrmFatConfTransfEstoque.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlConnectionsID);
  inherited;
end;

procedure TfrmFatConfTransfEstoque.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmFatConfTransfEstoque.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    Close;
  End
  Else If (Key = VK_Return) Then
  Begin
    If (fExisteRegistro) Then
      pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M', True);
  End
  Else If (Key = VK_F5) Then
  Begin
    btnItensDoc.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnMarca.Click
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarca.Click
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

Function TfrmFatConfTransfEstoque.fDocumentoConfirmado: Boolean;
  Var
    qryMovGer: TUniQuery;
    strSQL: String;
Begin
  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    qryMovGer := fCriaQuery(Self);

    strSQL := strSQL + '  SELECT IFNULL(GER_NUMFAT, "") AS NUMFAT  ';
    strSQL := strSQL + '  FROM                       ';
    strSQL := strSQL + '    MOVGER                  ';
    strSQL := strSQL + '  WHERE                      ';
    strSQL := strSQL + '    GER_ESPDOC = "TE"    AND ';
    strSQL := strSQL + '    GER_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '    GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '    GER_NUMDOC = :NUMDOC     ';

    qryMovGer.SQL.Text := strSQL;

    qryMovGer.ParamByName('NUMDOC').AsString := FieldByName('TMP_NUMDOC').AsString;
    qryMovGer.ParamByName('CODCLI').AsString := edtCodCli.Text;
    qryMovGer.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryMovGer.Open;

    Result := Not fEmptyStr(qryMovGer.FieldByName('NUMFAT').AsString);

    qryMovGer.Close;

    FreeAndNil(qryMovGer);
  End;
End;

function TfrmFatConfTransfEstoque.fExisteRegistro: Boolean;
begin

  Result := (Assigned(fatVenda.qryTemporariaConfirmacao)) And
            (fatVenda.qryTemporariaConfirmacao.active)    And
            (fatVenda.qryTemporariaConfirmacao.recordcount > 0);

end;

procedure TfrmFatConfTransfEstoque.pMarcaDocumento(const blnMarcar: Boolean; const blnCalculaTotais : Boolean);
begin

  If blnMarcar Then
  Begin
    If (fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString = 'TE') Then
    Begin

      If Not fatVenda.objLock.fLock_Unlock(fRetKeyLck, True, False) Then
      Begin

        fMensagem('ATENÇÃO!', 'Documento marcado em outra estação: ' + fGetHostLock(fRetKeyLck + '%'), ['&Ok']);

      End

      Else If fDocumentoConfirmado Then
      Begin

        fatVenda.objLock.fLock_Unlock(fRetKeyLck, False, False);
        fMensagem('ATENÇÃO!', 'Documento já confirmado em outra estação!', ['&Ok']);

      End

      Else If Not fPodeMarcarEntregaRetira(fatVenda.qryTemporariaConfirmacao, fatVenda.strTabelaConfMi) Then
      Begin
        fatVenda.objLock.fLock_Unlock(fRetKeyLck, False, False);
      End

      Else If Not fVerificaConfirmacaoRegEsp2(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REGES2').AsString) Then
      Begin
        fatVenda.objLock.fLock_Unlock(fRetKeyLck, False, False);
      End

      Else If Not fVerificaUltimaNotaEntradaFornecedorRegEsp2 Then
      Begin
        fatVenda.objLock.fLock_Unlock(fRetKeyLck, False, False);
      End

      Else
      Begin
        fatVenda.qryTemporariaConfirmacao.Edit;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString := 'M';
        fatVenda.qryTemporariaConfirmacao.Post;
      End;

    End
    Else
    Begin
      fMensagem('', 'Só é permitido selecionar documentos de mesma espécie!', ['&Ok']);
    End;
  End
  Else
  Begin
    fatVenda.qryTemporariaConfirmacao.Edit;
    fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString := 'D';
    fatVenda.qryTemporariaConfirmacao.Post;

    fatVenda.objLock.fLock_Unlock(fRetKeyLck, False, False);
  End;

  If (blnCalculaTotais) Then
    pCalculaTotais;
end;

procedure TfrmFatConfTransfEstoque.pMarcarDesmarcarTudo(strOpc,
  strEntRet: String; const pgbProgresso: TcxProgressBar);
begin
  If (strOpc = 'M') Then
  Begin
    pMarcarTodosDocumentos(True, strEntRet, pgbProgresso);
  End
  Else
  Begin
    pMarcarTodosDocumentos(False, strEntRet, pgbProgresso);
  End;

  pCalculaTotais;
end;

procedure TfrmFatConfTransfEstoque.pMarcarTodosDocumentos(blnMarcar: Boolean;
  strEntRet: String; const pgbProgresso: TcxProgressBar);
begin
  inherited;

  If (Not Assigned(fatVenda.qryTemporariaConfirmacao)) Or
     (Not fatVenda.qryTemporariaConfirmacao.Active) Or
     (fatVenda.qryTemporariaConfirmacao.RecordCount = 0) Then
  Begin
    If blnMarcar Then
      fMensagem('ATENÇÃO!', 'Não há documentos para marcar!', ['&OK']);
    Exit;
  End;

  If (blnMarcar) And (Not fEmptyStr(strEntRet)) And (Not fPodeMarcarEntregaRetira(fatVenda.qryTemporariaConfirmacao, fatVenda.strTabelaConfMi, strEntRet)) Then
  Begin
    Exit;
  End;

  fatVenda.qryTemporariaConfirmacao.DisableControls;
  Try
    pgbProgresso.Properties.Max := fatVenda.qryTemporariaConfirmacao.RecordCount;
    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      First;
      While Not Eof Do
      Begin
        pgbProgresso.Position := fatVenda.qryTemporariaConfirmacao.RecNo;
        pProcessMessages();

        If (blnMarcar) Then
        Begin
          If (FieldByName('TMP_MARDES').AsString <> 'M') And
             (fEmptyStr(strEntRet) Or ((Not fEmptyStr(strEntRet)) And (FieldByName('TMP_ENTRET').AsString = strEntRet))) Then
          Begin
            pMarcaDocumento(True, False);
          End;
        End
        Else
        Begin
          If (FieldByName('TMP_MARDES').AsString = 'M') And
             (fEmptyStr(strEntRet) Or ((Not fEmptyStr(strEntRet)) And (FieldByName('TMP_ENTRET').AsString = strEntRet))) Then
            pMarcaDocumento(False, False);
        End;

        Next;
      End;
      First;
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.EnableControls;
  End;

end;

procedure TfrmFatConfTransfEstoque.popEntClick(Sender: TObject);
  Var
    strTextoAcao : String;
    strAcao : String;
begin
  inherited;

  If (popMarca.Tag = 0) Then
  Begin
    strAcao := 'M';
    strTextoAcao := 'Marcando todos os documento de entrega...';
  End
  Else
  Begin
    strAcao := 'D';
    strTextoAcao := 'Desmarcando todos os documentos de entrega...';
  End;

  fExecutarModal(
    function(pgbProgresso: TcxProgressBar): Boolean
    begin
      pMarcarDesmarcarTudo(strAcao, 'E', pgbProgresso);
      Result := True;
    end,
    strTextoAcao,
    ''
  );
end;

procedure TfrmFatConfTransfEstoque.popRetClick(Sender: TObject);
  Var
    strTextoAcao : String;
    strAcao : String;
begin
  inherited;

  If (popMarca.Tag = 0) Then
  Begin
    strAcao := 'M';
    strTextoAcao := 'Marcando todos os documentos de retira...';
  End
  Else
  Begin
    strAcao := 'D';
    strTextoAcao := 'Desmarcando todos os documentos de retira...';
  End;

  fExecutarModal(
    function(pgbProgresso: TcxProgressBar): Boolean
    begin
      pMarcarDesmarcarTudo(strAcao, 'R', pgbProgresso);
      Result := True;
    end,
    strTextoAcao,
    ''
  );
end;

procedure TfrmFatConfTransfEstoque.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('TMP_MARDES').AsString = 'M' Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;
    End
    Else If FieldByName('TMP_VLRCON').AsFloat = FieldByName('TMP_DUPREC').AsFloat Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clRed;
    End;

  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  
end;

procedure TfrmFatConfTransfEstoque.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  If (fExisteRegistro) Then
    pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M', True);
end;

procedure TfrmFatConfTransfEstoque.FormShow(Sender: TObject);
begin
  inherited;

  pDeletaTemporaria;
  fatVenda.qryTemporariaConfirmacao.Close;

  dbgDocumentos.DataSource := fatVenda.dtsTemporariaConfirmacao;
  edtCodCli.Text           := fatVenda.strCodCli;
  pCarregaCliente;
  fatVenda.objLock.pDestravarTodos;
  pAddConnectionID(fGetConnectionID);
  pSetFocus(mskDtaIni);
end;

procedure TfrmFatConfTransfEstoque.pCalculaTotais;
  Var
    strSQL   : String;
    qryGenFmi: TUniQuery;

begin
  Try

    qryGenFmi := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi;

    With qryGenFmi Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      edtQtdDoc.Text := FieldByName('TOTDOC').AsString;
      edtTotLiq.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_ITEDOC) AS ITEDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TMP_MARDES = "M" ';

    With qryGenFmi Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      intItensDocs      := FieldByName('ITEDOC').AsInteger;
      edtQtdDocSel.Text := FieldByName('TOTDOC').AsString;
      edtTotLiqSel.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

      Close;
    End;

  Finally
    FreeAndNil(qryGenFmi);
  End;

end;

procedure TfrmFatConfTransfEstoque.pCarregaItensDocumento;
  Var
    strSQL: String;
    fltTotGer: Double;
    fltDesEsp: Double;
    qryGenDet: TUniQuery;
    dtsGenDet: TDataSource;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;
begin

  If (Not fExisteRegistro) Then
  Begin
    pMensagemOk('Nenhum documento encontrado!');
    Exit;
  End;

  qryGenDet := fCriaQuery(Self);
  dtsGenDet := fCriaDataSource(qryGenDet);

  fltTotGer := 0.0;
  fltDesEsp := 0.0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_CODITE AS ITE_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI AS ITE_DESITE, ';
  strSQL := strSQL + '  DET_UNIDAD AS ITE_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE AS ITE_QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS ITE_UNITAR, ';
  strSQL := strSQL + '  DET_TOTITE AS ITE_TOTITE, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_CLAFIS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  //strSQL := strSQL + '  (DET_NUMFAT IS NULL OR DET_TIPFAT = "") AND ';
  strSQL := strSQL + '  DET_JAFATU = FALSE AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_CODITE <> :ITESER AND ';
  strSQL := strSQL + '  DET_CODITE <> :SERTER ';

  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('ITESER').AsString := fCfgSis('ITESER');
    ParamByName('SERTER').AsString := fCfgSis('SERTER');
    Open;

    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

    While Not Eof Do
    Begin
      fltTotGer := fltTotGer + FieldByName('ITE_TOTITE').AsFloat;
      fltDesEsp := fltDesEsp + FieldByName('DET_DESESP').AsFloat;
      Next;
    End;

    First;

    Try
      pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
      frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
      frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', 0.0);
      frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
      frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', fltDesEsp);
      frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fltTotGer - fltDesEsp);
      frmFatMostraProdConfirmacao.Caption             := frmFatMostraProdConfirmacao.Caption + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + ' - ' +
                                                                                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
      frmFatMostraProdConfirmacao.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatConfTransfEstoque.pCarregaItensDocumento]');
      End;
    End;

    pFreeAndNil(frmFatMostraProdConfirmacao);

  End;

  FreeAndNil(dtsGenDet);
  FreeAndNil(qryGenDet);

end;

procedure TfrmFatConfTransfEstoque.pDesmarcarTodos;
begin
  pDeletarTravaLCKEmLote;
  pFlegarStatusTemporaria('D');
  pRemoverPublicacaoTravasLck;
  pAtualizaTemporaria;
  pCalculaTotais;
end;

procedure TfrmFatConfTransfEstoque.btnDesmarcaClick(Sender: TObject);
begin
  inherited;

  If btnPopMenuDesMarca.Enabled Then
  Begin
    btnPopMenuDesMarca.Click;
    Exit;
  End;

  pDesmarcarTodos;
end;

procedure TfrmFatConfTransfEstoque.btnItensDocClick(Sender: TObject);
begin
  inherited;

  pCarregaItensDocumento;
  pSetFocus(dbgDocumentos);

end;

procedure TfrmFatConfTransfEstoque.pMarcarTodos;
begin
  fLancouTravaLCKEmLote;
  pPublicarTravas;
  pFlegarStatusTemporaria('M');
  pAtualizaTemporaria;
  pCalculaTotais;
end;

procedure TfrmFatConfTransfEstoque.btnMarcaClick(Sender: TObject);
begin
  inherited;

  If btnPopMenuMarca.Enabled Then
  Begin
    btnPopMenuMarca.Click;
    Exit;
  End;

  pMarcarTodos;
end;

procedure TfrmFatConfTransfEstoque.btnPopMenuDesMarcaClick(Sender: TObject);
begin
  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
  Begin
     popMarca.Tag := 1; //DESMARCA
     popMarca.Popup(X, Y);
  End;
end;

procedure TfrmFatConfTransfEstoque.btnPopMenuMarcaClick(Sender: TObject);
begin
  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
  Begin
     popMarca.Tag := 0; //MARCA
     popMarca.Popup(X, Y);
  End;
end;

procedure TfrmFatConfTransfEstoque.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If StrToIntDef(edtQtdDocSel.Text, 0) <= 0 Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If (fStrToFloat(edtTotLiqSel.Text) < 0.0) Then
  Begin
    fMensagem('', 'Não é possivel confirmar um valor negativo!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If fBloqueiaConfirmacaoOndeTodosDocumentosEstaoQuitados(fStrToFloat(edtTotLiqSel.Text)) Then
  Begin
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If fMensagem('', 'Confirma documentos?', ['&Sim', '&Não']) = 1 Then
  Begin

    pDeletaDocDesmarcados;
    pAtualizaTemporaria;
    pGeraStringDocsConfirmados;
    blnConfirma := True;
    Close;

  End;

end;

{*****************************************}
{* APAGA DOCUMENTOS QUE NAO ESTÃO SELE-  *}
{* CIONADOS                              *}
{**************************************MV*}
procedure TfrmFatConfTransfEstoque.pDeletaDocDesmarcados;
  Var
    strSQL   : String;
    qryGenDes: TUniQuery;

begin
  Try

    qryGenDes := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE TMP_MARDES <> "M" ';

    With qryGenDes Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenDes);
  End;

end;

procedure TfrmFatConfTransfEstoque.FormActivate(Sender: TObject);
begin
  inherited;

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If blnFecharForm Then
  Begin
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;

end;

procedure TfrmFatConfTransfEstoque.pGeraStringDocsConfirmados;
begin
  fatVenda.qryTemporariaConfirmacao.DisableControls;
  try
    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      First;

      fatVenda.strDocsConfTE := '';

      While (Not Eof) Do
      Begin
        If FieldByName('TMP_MARDES').AsString = 'M' Then
        Begin
          fatVenda.strDocsConfTE := fatVenda.strDocsConfTE + FieldByName('TMP_NUMDOC').AsString + '-' +
                                                             FieldByName('TMP_ESPDOC').AsString + '-' +
                                                             FieldByName('TMP_CODEMP').AsString + ',';

        End;

        Next;
      End;
      First;
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.EnableControls;
  End;

  If Not fEMptyStr(fatVenda.strDocsConfTE) Then
  Begin
    fatVenda.strDocsConfTE := LeftStr(fatVenda.strDocsConfTE, Length(fatVenda.strDocsConfTE)-1);
  End;
end;

Function TfrmFatConfTransfEstoque.fRetKeyLck: String;
Begin
  With fatVenda.qryTemporariaConfirmacao Do
  Result := PREFIXO_TRAVA + FieldByName('TMP_NUMDOC').AsString +
                         FieldByName('TMP_ESPDOC').AsString +
                         FieldByName('TMP_CODEMP').AsString +
                         edtCodCli.Text;
End;

procedure TfrmFatConfTransfEstoque.pRetJurosDescontoSujerido(strNumDoc,
                                                             strEspDoc,
                                                             strCodEmp,
                                                             strCodCli: String;
                                                         Var fltJurSuj,
                                                             fltDesSuj,
                                                             fltValAbe: Double);
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE          ';
  strSQL := strSQL + '  SUM(CTR_VALDUP) AS VALDUP, ';
  strSQL := strSQL + '  SUM(CTR_JURSUJ) AS JURSUJ, ';
  strSQL := strSQL + '  SUM(CTR_DESSUJ) AS DESSUJ  ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CADREC                     ';
  strSQL := strSQL + 'WHERE                        ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND   ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND   ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND   ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND   ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL         ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    SQL.Text := strSQL;

    ParamByName('NUMDUP').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    fltJurSuj := FieldByName('JURSUJ').AsFloat;
    fltDesSuj := FieldByName('DESSUJ').AsFloat;
    fltValAbe := FieldByName('VALDUP').AsFloat;

    Close;
  End;
  FreeAndNil(qryGen);
End;

function TfrmFatConfTransfEstoque.fGetConnectionsIDAsSQL: String;
  Var
    intCnt : Integer;
begin
  Result := EmptyStr;
  For intCnt := 0 To Pred(stlConnectionsID.Count) Do
  Begin
    If fEmptyStr(Result) Then
      Result := QuotedStr(stlConnectionsID.Strings[intCnt])
    Else
      Result := Result + ', ' + QuotedStr(stlConnectionsID.Strings[intCnt]);
  End;
  If fEmptyStr(Result) Then
    Result := QuotedStr('');
end;

function TfrmFatConfTransfEstoque.fGetValorDuplicatasRecebidas(strNumDup,
                                                               strEspDoc,
                                                               strCodEmp: String;
                                                               fltVlrCon,
                                                               fltDupRecAnt: Double;
                                                           Var fltJurSuj,
                                                               fltDesSuj,
                                                               fltValAbe: Double): Double;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;
    fltDupRec: Double;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(TOTPAG) AS TOTPAG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '( ';

  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '    SUM(IF('+fRetSQLCadRecFFComBol(' AND (CTR_DTAREC IS NULL) ')+',IFNULL(CTR_VALDUP,0), IFNULL(CTR_VALREC,0)) - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0)) AS TOTPAG ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    CADREC ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '    CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    ((CTR_DTAREC IS NOT NULL) OR '+fRetSQLCadRecFFComBol+') ';

  strSQL := strSQL + '  UNION ALL ';

  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '    SUM(IFNULL(CTR_VALDUP, 0) - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_DESSUJ, 0) - IFNULL(CTR_JURSUJ, 0)) AS TOTPAG ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    DUPAGR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '    CTR_CODEMP = :CODEMP ';

  strSQL := strSQL + ') AS TBL ';

  qryGenRec := fCriaQuery;

  qryGenRec.Close;
  qryGenRec.SQL.Clear;
  qryGenRec.SQL.Add(strSQL);
  qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
  qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
  qryGenRec.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
  qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
  qryGenRec.Open;

  fltDupRec := qryGenRec.FieldByName('TOTPAG').AsFloat;

  fltDupRec := fltDupRec + fltDupRecAnt;

  pRetJurosDescontoSujerido(strNumDup,
                            strEspDoc,
                            strCodEmp,
                            fatVenda.strCodCli,
                            fltJurSuj, fltDesSuj, fltValAbe);

  Result := fltDupRec;

  qryGenRec.Close;

  FreeAndNil(qryGenRec);
end;

end.

