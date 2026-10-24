unit untFatManutencaoManifestoEletronico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, untPaiOrdena, DB, 
  UniDataSetProvider, AppEvnts,
  Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids,
  DBGridCitel, DBGrids, Buttons, BitBtnLockedIncrem, ExtCtrls, StrUtils, UniClientDataSet,
    Uni, MemDS, DBAccess, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, untLibNfe, cxGroupBox,
  cxRadioGroup, untFuncoesConsulta, untTypesSistema;

type
  TfrmFatManutencaoManifestoEletronico = class(TfrmPaiOrdena)
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lblCodEmp: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    mskDtaIniMan: TMaskEditFocus;
    mskDtaFinMan: TMaskEditFocus;
    lblNroDocumento: TLabel;
    edtNumNfe: TEditFocus;
    Label6: TLabel;
    edtEspDoc: TEditFocus;
    Label7: TLabel;
    edtNumMan: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    Label8: TLabel;
    edtPercurso: TEditFocus;
    btnAtuPercurso: TBitBtnLocked;
    lblObs: TLabel;
    pnlInclusao: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    edtChaveAcesso: TEditFocus;
    btnIncluir: TBitBtnLocked;
    Label12: TLabel;
    lblMensCarPos: TLabel;
    chkCarPos: TcxCheckBox;
    rdgTipoDocumento: TcxRadioGroup;
    lblObs2: TLabel;
    procedure edtNumManChange(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnAtuPercursoClick(Sender: TObject);
    procedure edtChaveAcessoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkCarPosClick(Sender: TObject);
    procedure rdgTipoDocumentoClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strForCli: String;
    strTip_FC: String;
    strSerie_: String;
    blnTemCarPos : Boolean;
    strCaptionBtnGravar: string;
    blnCarPos: Boolean;
    arrEmpresa : TConsultasArray;

    procedure pRemoverDoManifesto;
    procedure pLimparTela;
    function fVerificaFiltros: Boolean;
    procedure pEfetuarCargaPosterior;
    function fAtualizarDocumentosManifesto: Boolean;
    function fGetSqlNFe: string;
    function fGetSqlCTe: string;
    procedure pRemoveDocumentoDoManifesto(AAutInc, ANumMan, AEmpMan: String);
    procedure pSelecionarDocumentosSemMDFe;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fGetOrderBy: String; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untClassPanelCx, untConsultas;

{ TfrmFatManutencaoManifestoEletronico }

procedure TfrmFatManutencaoManifestoEletronico.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fVerificaFiltros) Then
  Begin
    pLimpaPesquisa;
    fAbreConsulta(True);
    If cdsConsulta.IsEmpty Then
    Begin
      if chkCarPos.Checked then
        pMensagemOk('Não há notas para confirmação de carregamento neste manifesto eletrônico ou já estão confirmadas.')
      else
      pMensagemOk('Não há notas para manutenção de manifesto eletrônico neste período ou já estão autorizados.');
      pnlInclusao.Visible := False;
    End
    Else
    Begin
      If cdsConsulta.FieldByName('ENCERR').AsString = '1' Then
      Begin
        pMensagemOk('O manifesto informado está encerrado.');
        pLimparTela;
        Exit;
      End;

      pSelecionarDocumentosSemMDFe;

      pSetFocus(dbgConsulta);
      edtPercurso.Text  := cdsConsulta.FieldByName('FIS_PERCUR').AsString;

      pnlInclusao.Visible := (Not fEmptyStr(edtNumMan.Text));

      blnCarPos := ((cdsConsulta.FieldByName('CARPOS').AsString = 'S') Or
                    (cdsConsulta.FieldByName('CARPOS').AsString = 'C')) ;

      lblMensCarPos.Visible := blnCarPos;

      lblObs2.Visible := blnTemCarPos and chkCarPos.Checked;
    End;
  End;
end;

function TfrmFatManutencaoManifestoEletronico.fVerificaFiltros: Boolean;
begin
  Result := True;
  If Not mskDtaIni.ReadOnly Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
       (fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text))) Then
    Begin
      pMensagemOk('É necessário informar pelo menos um período ou um número de nota ou manifesto.');
      pSetFocus(mskDtaIni);
      Result := False;
    End;
  End;
end;

procedure TfrmFatManutencaoManifestoEletronico.btnAtuPercursoClick(
  Sender: TObject);
  Var
    qryUpd: TUniQuery;
begin
  inherited;
  If Not fValidaUFsPercurso(edtPercurso.Text) Then
  Begin
    Exit;
  End;

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE CADFIS SET ');
  qryUpd.SQL.Add('  FIS_PERCUR = :PERCUR ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
  qryUpd.SQL.Add('  FIS_CODEMP = :CODEMP ');

  qryUpd.ParamByName('PERCUR').AsString := edtPercurso.Text;
  qryUpd.ParamByName('NUMMAN').AsString := cdsConsulta.FieldByName('NUMMAN').AsString;
  qryUpd.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('FIS_CODEMP').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);

  pLimpaPesquisa;
  fAbreConsulta(True);
end;

procedure TfrmFatManutencaoManifestoEletronico.btnGravarClick(Sender: TObject);
begin
  inherited;
  If stlListSelecao.Count <= 0 Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos 1 documento para ' +
                IIF(chkCarPos.Checked, 'confirmar o Carregamento do Documento', 'a remoção do manifesto.'));
    Exit;
  End;

  If fMensagem('', 'Confirma ' + IIF(chkCarPos.Checked, 'o Carregamento', 'a exclusão') + ' dos documentos selecionados?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  chkCarPos.Enabled := False;
  fStartTransaction();
  Try
    if not chkCarPos.Checked then
    begin
      pRemoverDoManifesto;
    end
    else
    begin
      pEfetuarCargaPosterior;
    end;

    fCommit();

    if not chkCarPos.Checked then
    begin
      pMensagemOk('Operação concluída com sucesso.');
    end
    else
    begin
      pMensagemOk('Informações enviadas com sucesso. Aguarde a autorização no PainelNFe.');
      chkCarPos.Enabled := True;
    end;

    pLimparTela;
  Except
    On E: Exception Do
    Begin
      fRollBack();
      if chkCarPos.Checked then
      begin
        pMensagemOk('Manifesto não gerado. Por favor verifique o erro no PainelNFe.');
        chkCarPos.Enabled := True;
      end;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmFatManutencaoManifestoEletronico.btnIncluirClick(Sender: TObject);
  Var
    strSQL: String;
    qryAux: TUniQuery;
    qryCadFis: TUniQuery;
    qryFisMot: TUniQuery;
begin
  inherited;

  If Not cdsConsulta.Active Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  If fEmptyStr(edtChaveAcesso.Text) Then
  Begin
    pMensagemOk('É necessário informar a chave de acesso da Nota.');
    pSetFocus(edtChaveAcesso);
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'UPDATE CADFIS SET ';
  strSQL := strSQL + '  FIS_NUMMAN = :NUMMAN, ';
  strSQL := strSQL + '  FIS_EMPMAN = :EMPMAN, ';
  strSQL := strSQL + '  FIS_DTAMAN = :DTAMAN, ';

  if blnTemCarPos then
    strSQL := strSQL + '  FIS_CARPOS = :CARPOS, ';

  strSQL := strSQL + '  FIS_MOTMAN = :CODMOT, ';
  strSQL := strSQL + '  FIS_PLAMAN = :PLAVEI, ';
  strSQL := strSQL + '  FIS_PLAMA2 = :PLAVE2, ';
  strSQL := strSQL + '  FIS_PERCUR = :PERCUR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FIS_ACESSO = :ACESSO AND ';
  strSQL := strSQL + '  FIS_FORCLI = :FORCLI AND ';
  strSQL := strSQL + '  FIS_TIP_FC = :TIP_FC AND ';
  strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';
  strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FIS_CODEMP = :CODEMP ';

  qryAux := fCriaQuery(Self);
  qryCadFis := fCriaQuery(Self);
  qryFisMot := fCriaQuery(Self);
  try
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMMAN').AsString   := cdsConsulta.FieldByName('NUMMAN').AsString;
    qryAux.ParamByName('EMPMAN').AsString   := cdsConsulta.FieldByName('EMPMAN').AsString;
    qryAux.ParamByName('DTAMAN').AsDateTime := cdsConsulta.FieldByName('DTAMAN').AsDateTime;

    if blnTemCarPos then
      qryAux.ParamByName('CARPOS').AsString   := IIF(blnCarPos, 'S', 'N');

    qryAux.ParamByName('CODMOT').AsString   := cdsConsulta.FieldByName('FIS_MOTMAN').AsString;
    qryAux.ParamByName('PLAVEI').AsString   := cdsConsulta.FieldByName('FIS_PLAMAN').AsString;;
    qryAux.ParamByName('PLAVE2').AsString   := cdsConsulta.FieldByName('FIS_PLAMA2').AsString;;
    qryAux.ParamByName('PERCUR').AsString   := cdsConsulta.FieldByName('FIS_PERCUR').AsString;;
    qryAux.ParamByName('ACESSO').AsString   := edtChaveAcesso.Text;
    qryAux.ParamByName('FORCLI').AsString   := strForCli;
    qryAux.ParamByName('TIP_FC').AsString   := strTip_FC;
    qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryAux.ParamByName('SERIE_').AsString   := strSerie_;
    qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryAux.ParamByName('CODEMP').AsString   := strCodEmp;

    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM FROM CADFIS ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_ACESSO = :ACESSO AND ';
    strSQL := strSQL + '  FIS_FORCLI = :FORCLI AND ';
    strSQL := strSQL + '  FIS_TIP_FC = :TIP_FC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP ';

    qryCadFis.SQL.Add(strSQL);
    qryCadFis.ParamByName('ACESSO').AsString := edtChaveAcesso.Text;
    qryCadFis.ParamByName('FORCLI').AsString := strForCli;
    qryCadFis.ParamByName('TIP_FC').AsString := strTip_FC;
    qryCadFis.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCadFis.ParamByName('SERIE_').AsString := strSerie_;
    qryCadFis.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCadFis.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFis.Open;

    strSQL := '';
    strSQL := strSQL + 'SELECT FMO_CODMOT ';
    strSQL := strSQL + 'FROM FISMOT ';
    strSQL := strSQL + 'WHERE FMO_SEQGER = :SEQGER ';

    qryFisMot.SQL.Add(strSQL);
    qryFisMot.ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryFisMot.Open;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO FISMOT(AUTOINCREM, FMO_SEQGER, FMO_CODMOT) ';
    strSQL := strSQL + 'VALUES(:AUTOINCREM, :SEQGER, :CODMOT); ';

    fStartTransaction;
    Try
      qryAux.ExecSQL;

      qryAux.SQL.Text := strSQL;
      while not qryCadFis.Eof do
      begin
        while not qryFisMot.Eof do
        begin
          qryAux.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FISMOT', IIF(blnCarPos, cdsConsulta.FieldByName('EMPMAN').AsString, VS_strCodEmp));
          qryAux.ParamByName('SEQGER').AsString := qryCadFis.FieldByName('AUTOINCREM').AsString;
          qryAux.ParamByName('CODMOT').AsString := qryFisMot.FieldByName('FMO_CODMOT').AsString;
          qryAux.ExecSQL;

          qryFisMot.Next;
        end;

        qryCadFis.Next;
      end;

      fCommit;
      edtChaveAcesso.Clear;
      pDesmarcaTodos;
      qryConsulta.Close;
      cdsConsulta.Close;
      btnAdicionar.Click;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnIncluirClick]');
      End;
    End;
  finally
    FreeAndNil(qryAux);
    FreeAndNil(qryCadFis);
    FreeAndNil(qryFisMot);
  end;
end;

procedure TfrmFatManutencaoManifestoEletronico.cdsConsultaAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  edtPercurso.Clear;
  If (DataSet.Active) And (Not DataSet.IsEmpty) Then
  Begin
    edtPercurso.Text := DataSet.FieldByName('FIS_PERCUR').AsString;
  End;
end;

procedure TfrmFatManutencaoManifestoEletronico.chkCarPosClick(Sender: TObject);
begin
  inherited;
  edtCodEmp.NormalColor := $00FFDFB8;
  edtCodEmp.ReadOnly    := True;
  edtCodEmp.TabStop     := False;

  If chkCarPos.Checked Then
  Begin
    edtCodEmp.NormalColor := clWindow;
    edtCodEmp.ReadOnly    := False;
    edtCodEmp.TabStop     := True;
  End;

  pnlTail.Visible := not chkCarPos.Checked;
  if pnlTail.Visible then
  begin
    btnGravar.Caption := strCaptionBtnGravar;
    btnGravar.Width := 225;
  end
  else
  begin
    pnlInclusao.Visible := pnlTail.Visible;

    btnGravar.Caption := '[ F10 ] Confirma';
    btnGravar.Width := 118;
  end;
  if not cdsConsulta.IsEmpty then
    pLimparTela;
end;

procedure TfrmFatManutencaoManifestoEletronico.dbgConsultaDblClick(
  Sender: TObject);
begin
  If Assigned(cdsConsulta) And (cdsConsulta.RecordCount > 0) And (blnTemCarPos) and (chkCarPos.Checked) then
  Begin
    If not fEmptyStr(cdsConsulta.FieldByName('ACEMAN').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse documento já está no manifesto!', ['&O k']);
      Exit;
    End;
  End;

  inherited;

end;

procedure TfrmFatManutencaoManifestoEletronico.edtChaveAcessoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    strSQL      : String;
    strSQLUnion : String;
    strWhere    : String;
    strWhereUni : String;
    qryConsulta: TUniQuery;
    arrSel: TConsultasArray;
    arrTitCol  : TColunasArray;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
begin
  If fEntraCons(Key) Then
  Begin
    Try
      Key := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  F.FIS_NUMDOC, ';                                                               pAddNomeColuna('Documento 1');
      strSQL := strSQL + '  F.FIS_NUMDO2, ';                                                               pAddNomeColuna('Documento 2');
      strSQL := strSQL + '  F.FIS_CLFSC1, ';                                                               pAddNomeColuna('CFOP');
      strSQL := strSQL + '  F.FIS_ESPDOC, ';                                                               pAddNomeColuna('Espécie');
      strSQL := strSQL + '  F.FIS_CODEMP, ';                                                               pAddNomeColuna('Emp.');
      strSQL := strSQL + '  F.FIS_SERIE_, ';                                                               pAddNomeColuna('Série');
      strSQL := strSQL + '    FIS_VALOR_, ';                                                               pAddNomeColuna('Valor');
      strSQL := strSQL + '  F.FIS_ACESSO, ';                                                               pAddNomeColuna('Chave de Acesso');
      strSQL := strSQL + '  F.FIS_ENTSAI, ';                                                               pAddNomeColuna('E/S');
      strSQL := strSQL + '  F.FIS_TIP_FC, ';                                                               pAddNomeColuna('C/F');
      strSQL := strSQL + '  F.FIS_FORCLI, ';                                                               pAddNomeColuna('Cliente/Forn.');
      strSQL := strSQL + '  FIS_NOMDES,   ';                                                               pAddNomeColuna('Nome');
      strSQL := strSQL + '  F.FIS_DTAENT, ';                                                               pAddNomeColuna('Dt. Entrada');
      strSQL := strSQL + '  F.FIS_DTADOC, ';                                                               pAddNomeColuna('Dt. Documento');
      strSQL := strSQL + '  F.FIS_HISTOR, ';                                                               pAddNomeColuna('Histórico');
      strSQL := strSQL + '  F.FIS_NUMCOO, ';                                                               pAddNomeColuna('Número CCO');
      strSQL := strSQL + '  F.AUTOINCREM  ';                                                               pAddNomeColuna('AUTOINCREM');
      strSQL := strSQL + 'FROM            ';
      strSQL := strSQL + '  CADFIS F      ';
      strSQL := strSQL + '  LEFT JOIN CADFOR FR  ON FR.FOR_CODFOR  = F.FIS_FORCLI ';
      strSQL := strSQL + '                      AND F.FIS_TIP_FC   = "F"          ';
      strSQL := strSQL + '  LEFT JOIN CADCLI CLI ON CLI.CLI_CODCLI = F.FIS_FORCLI ';
      strSQL := strSQL + '                      AND F.FIS_TIP_FC   = "C"          ';
      strSQL := strSQL + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
      strSQL := strSQL + '                 GER_ESPDOC = FIS_ESPDOC AND ';
      strSQL := strSQL + '                 GER_CODEMP = FIS_CODEMP AND ';
      strSQL := strSQL + '                 GER_TIP_FC = FIS_TIP_FC AND ';
      strSQL := strSQL + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI AND ';
      strSQL := strSQL + '                 IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';

      strWhere := ' WHERE IFNULL(FIS_ACESSO,"") <> "" AND ';
      strWhere := strWhere + '  FIS_ESPDOC IN ("NF", "EL") AND ';
      strWhere := strWhere + '  FIS_CLFSC1 > "5000" AND ';
      strWhere := strWhere + '  FIS_ORIDOC = "V" AND ';
      strWhere := strWhere + '  FIS_NUMMAN IS NULL ';

      if (blnTemCarPos) and (chkCarPos.Checked) then
      begin
        strWhere := strWhere + ' AND FIS_ESTADO = '+QuotedStr(fRetUFEmpresa(edtCodEmp.Text));
      end;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('FIS_NOMDES', 'IF(F.FIS_TIP_FC = "F", FR.FOR_NOMFOR, CLI.CLI_NOMCLI)');
      objConsulta.pIncluiSubConsulta('FIS_VALOR_', '(IFNULL(F.FIS_VLCON1, 0) + IFNULL(F.FIS_VLCON2, 0) + ' +
                                                   ' IFNULL(F.FIS_VLCON3, 0) + IFNULL(F.FIS_VLCON4, 0) + ' +
                                                   ' IFNULL(F.FIS_VLCON5, 0))');

      strSQLUnion := 'UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
      strWhereUni := strWhere;

      qryConsulta := fCriaQuery(Nil);
      Try
        If fConsulta([strSQL, strWhere, '', strSQLUnion, strWhereUni, ''],
                     arrTitCol,
                     ['FIS_NUMDOC','FIS_NUMDO2','FIS_CLFSC1','FIS_ESPDOC','FIS_FORCLI'],
                     '',
                     'CADFIS',
                     Self.Name,
                     'Consulta de Livros Fiscais',
                     qryConsulta,
                     Nil,
                     True,
                     arrSel,
                     'FIS_NUMDOC',
                     objConsulta) Then
        Begin
          edtChaveAcesso.Text := qryConsulta.FieldByName('FIS_ACESSO').AsString;
          strNumDoc := qryConsulta.FieldByName('FIS_NUMDOC').AsString;
          strEspDoc := qryConsulta.FieldByName('FIS_ESPDOC').AsString;
          strCodEmp := qryConsulta.FieldByName('FIS_CODEMP').AsString;
          strForCli := qryConsulta.FieldByName('FIS_FORCLI').AsString;
          strTip_FC := qryConsulta.FieldByName('FIS_TIP_FC').AsString;
          strSerie_ := qryConsulta.FieldByName('FIS_SERIE_').AsString;
          SelectNext(ActiveControl, True, True);
        End;

        FreeAndNil(objConsulta);
      Finally
        FreeAndNil(qryConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

procedure TfrmFatManutencaoManifestoEletronico.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, False) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManutencaoManifestoEletronico.edtNumManChange(Sender: TObject);
begin
  inherited;
  mskDtaIni.ReadOnly    := (Not fEmptyStr(edtNumMan.Text)) Or (Not fEmptyStr(edtNumNfe.Text));
  mskDtaFin.ReadOnly    := mskDtaIni.ReadOnly;
  mskDtaIniMan.ReadOnly := mskDtaIni.ReadOnly;
  mskDtaFinMan.ReadOnly := mskDtaIni.ReadOnly;

  If mskDtaIni.ReadOnly Then
  Begin
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    mskDtaIniMan.Clear;
    mskDtaFinMan.Clear;
  End;
end;

function TfrmFatManutencaoManifestoEletronico.fAtualizarDocumentosManifesto: Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  try
    try
      qryAux.SQL.Add('UPDATE CADFIS SET FIS_CARPOS = :CARPOS');
      qryAux.SQL.Add('WHERE AUTOINCREM IN (' + stlListSelecao.CommaText + ') ');
      qryAux.ParamByName('CARPOS').AsString := 'C';
      qryAux.ExecSQL;
      Result := True;
    except
      On E: Exception Do
      begin
        Result := False;
        Raise;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmFatManutencaoManifestoEletronico.fGetOrderBy: String;
begin
  Result := '';
end;

function TfrmFatManutencaoManifestoEletronico.fGetSql(blnLike: Boolean): String;
begin
  if (rdgTipoDocumento.ItemIndex = 0) then
    Result := fGetSqlNFe
  else
    Result := fGetSqlCTe;
end;

function TfrmFatManutencaoManifestoEletronico.fGetSqlCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_NUMMAN AS NUMMAN, ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_EMPMAN AS EMPMAN, ';
  Result := Result + '  FIS_ACEMAN AS ACEMAN, ';
  Result := Result + '  FIS_ENCERR AS ENCERR, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  CID_NOMCID AS NOMCID, ';
  Result := Result + '  FIS_ESTADO AS ESTADO, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_CGCCON, CLI_C_G_C_) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, CLI_NOMCLI) AS NOMDES, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM, ';
  Result := Result + '  IF(IFNULL(FIS_MOTMAN, "") = "", ';
  Result := Result + '    CAST((SELECT GROUP_CONCAT(CONCAT(FMO_CODMOT, "-", MOT_NOMMOT) SEPARATOR ", ") ';
  Result := Result + '      FROM FISMOT ';
  Result := Result + '      JOIN CADMOT ON FMO_CODMOT = MOT_CODMOT ';
  Result := Result + '      WHERE FMO_SEQGER = CADFIS.AUTOINCREM) AS CHAR(200)), ';
  Result := Result + '    CONCAT(FIS_MOTMAN,"-",MOT_NOMMOT)) AS NOMMOT, ';
  Result := Result + '  FIS_MOTMAN, ';
  Result := Result + '  FIS_CODEMP, ';
  Result := Result + '  FIS_PLAMAN, ';
  Result := Result + '  FIS_PLAMA2, ';

  if (blnTemCarPos) then
    Result := Result + '  IFNULL(FIS_CARPOS, "N") AS CARPOS, '
  else
    Result := Result + '  "N" AS CARPOS, ';

  Result := Result + '  FIS_PERCUR ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ';
  Result := Result + '             AND FIS_CODEMP =  CTE_CODEMP ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
  Result := Result + '                  AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';
  Result := Result + '  LEFT JOIN CADCID CD ON CD.CID_CODCID = IFNULL(ETC_CIDENT, CLI_CODCID) ';
  Result := Result + '  LEFT JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';
  Result := Result + 'WHERE ';
  if (blnTemCarPos) and (chkCarPos.Checked) then
  begin
    Result := Result + '  ((FIS_CARPOS = "S") OR (FIS_CARPOS = "C")) AND ';
    Result := Result + '  FIS_ESTADO = '+QuotedStr(fRetUFEmpresa(edtCodEmp.Text))+' AND ';
  end
  else
  begin
    Result := Result + '  FIS_CARPOS = "N" AND ';
    Result := Result + '  IFNULL(FIS_ACEMAN, "") = "" AND ';
  end;

  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  Result := Result + '  FIS_ENTSAI = "S" AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN IS NOT NULL ';

  If Not fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_NUMMAN = :NUMMAN ';

  If Not fEmptyStr(edtNumNfe.Text) Then
    Result := Result + '  AND FIS_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    Result := Result + '  AND FIS_ESPDOC = :ESPDOC ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Result := Result + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
    Result := Result + '  AND FIS_DTAMAN BETWEEN :DTAINI_MAN AND :DTAFIN_MAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'MOVCTE', 'NOTCTE'), 'AUXMOV', 'AUXNOT');
end;

function TfrmFatManutencaoManifestoEletronico.fGetSqlNFe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_NUMMAN AS NUMMAN, ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_EMPMAN AS EMPMAN, ';
  Result := Result + '  FIS_ACEMAN AS ACEMAN, ';
  Result := Result + '  FIS_ENCERR AS ENCERR, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  CID_NOMCID AS NOMCID, ';
  Result := Result + '  FIS_ESTADO AS ESTADO, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_CGCCON, IFNULL(CLI_C_G_C_, FOR_C_G_C_)) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, IFNULL(CLI_NOMCLI, FOR_NOMFOR)) AS NOMDES, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM, ';
  Result := Result + '  IF(IFNULL(FIS_MOTMAN, "") = "", ';
  Result := Result + '    CAST((SELECT GROUP_CONCAT(CONCAT(FMO_CODMOT, "-", MOT_NOMMOT) SEPARATOR ", ") ';
  Result := Result + '      FROM FISMOT ';
  Result := Result + '      JOIN CADMOT ON FMO_CODMOT = MOT_CODMOT ';
  Result := Result + '      WHERE FMO_SEQGER = CADFIS.AUTOINCREM) AS CHAR(200)), ';
  Result := Result + '    CONCAT(FIS_MOTMAN,"-",MOT_NOMMOT)) AS NOMMOT, ';
  Result := Result + '  FIS_MOTMAN, ';
  Result := Result + '  FIS_CODEMP, ';
  Result := Result + '  FIS_PLAMAN, ';
  Result := Result + '  FIS_PLAMA2, ';

  if (blnTemCarPos) then
    Result := Result + '  IFNULL(FIS_CARPOS, "N") AS CARPOS, '
  else
    Result := Result + '  "N" AS CARPOS, ';

  Result := Result + '  FIS_PERCUR ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
  Result := Result + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
  Result := Result + '                 GER_ESPDOC = FIS_ESPDOC AND ';
  Result := Result + '                 GER_CODEMP = FIS_CODEMP AND ';
  Result := Result + '                 GER_TIP_FC = FIS_TIP_FC AND ';
  Result := Result + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI AND ';
  Result := Result + '                 IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
  Result := Result + '                  AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';
  Result := Result + '  LEFT JOIN CADCID CD ON CD.CID_CODCID = IFNULL(ETC_CIDENT, IFNULL(CLI_CODCID, FOR_CODCID)) ';
  Result := Result + '  LEFT JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';
  Result := Result + 'WHERE ';
  if (blnTemCarPos) and (chkCarPos.Checked) then
  begin
    Result := Result + '  ((FIS_CARPOS = "S") OR (FIS_CARPOS = "C")) AND ';
    Result := Result + '  FIS_ESTADO = '+QuotedStr(fRetUFEmpresa(edtCodEmp.Text))+' AND ';
  end
  else
  begin
    Result := Result + '  FIS_CARPOS = "N" AND ';
    Result := Result + '  IFNULL(FIS_ACEMAN, "") = "" AND ';
  end;

  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
  Result := Result + ' '+fSqlManifestoDocumentosPermitidos+' AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN IS NOT NULL ';

  If Not fEmptyStr(edtNumMan.Text) Then
    Result := Result + '  AND FIS_NUMMAN = :NUMMAN ';

  If Not fEmptyStr(edtNumNfe.Text) Then
    Result := Result + '  AND FIS_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    Result := Result + '  AND FIS_ESPDOC = :ESPDOC ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Result := Result + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
    Result := Result + '  AND FIS_DTAMAN BETWEEN :DTAINI_MAN AND :DTAFIN_MAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER','NOTGER'), 'AUXMOV', 'AUXNOT');
end;

procedure TfrmFatManutencaoManifestoEletronico.FormCreate(Sender: TObject);
begin
  inherited;

  edtNumNfe.MaxLength := fTamDocCadRec;
  edtNumNfe.TamCampo  := fTamDocCadRec;
end;

procedure TfrmFatManutencaoManifestoEletronico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (((Key In [VK_UP,VK_DOWN]) And (ssShift In Shift)) Or
      ((Key = VK_RETURN) And blnSelecionaComEnter) Or
      ((Key = VK_SPACE) And blnSelecionaComEspaco)) And
      (dbgConsulta.Focused) Then
  Begin
    If Assigned(cdsConsulta) And (cdsConsulta.RecordCount > 0) And (blnTemCarPos) and (chkCarPos.Checked) then
    Begin
      If not fEmptyStr(cdsConsulta.FieldByName('ACEMAN').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse documento já está no manifesto!', ['&O k']);
        Exit;
      End;
    End;
  End;

  If Key = VK_DELETE Then
  Begin
    If Assigned(cdsConsulta) And (cdsConsulta.RecordCount > 0) And (blnTemCarPos) and (chkCarPos.Checked) then
    Begin
      If not fEmptyStr(cdsConsulta.FieldByName('ACEMAN').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse documento já está no manifesto!', ['&O k']);
        Exit;
      End;

      If fMensagem('', 'Deseja remover esse documento?', ['&Sim', '&Não'], 1) = 1 Then
      Begin
        pRemoveDocumentoDoManifesto(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                    cdsConsulta.FieldByName('NUMMAN').AsString,
                                    cdsConsulta.FieldByName('EMPMAN').AsString);
        pLimpaPesquisa;
        fAbreConsulta(True);
      End;
    End;
  end;

  If Key = VK_ESCAPE Then
  Begin
    If dbgConsulta.Focused Then
    Begin
      If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        pLimparTela;
      End;
    End
    Else
      inherited;
  End
  Else If Key = VK_F10 Then
  Begin
    btnGravar.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatManutencaoManifestoEletronico.FormShow(Sender: TObject);
begin
  inherited;
  blnTemCarPos := fCampoExiste('CADFIS', 'FIS_CARPOS', True);
  chkCarPos.Visible := (fCfgSis('VERMDF') = '3.00a') and (blnTemCarPos);
  rdgTipoDocumento.Enabled := fCfgSis('EMICTE', varBoolean);
  rdgTipoDocumento.ItemIndex := IIF(rdgTipoDocumento.Enabled, 1, 0);
  lblObs2.Visible := False;
  blnCarPos := False;
  blnSempreRelerBanco := False;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  strCaptionBtnGravar := btnGravar.Caption;
  pSetFocus(edtNumMan);
end;

function TfrmFatManutencaoManifestoEletronico.fSetParametros: Boolean;
begin
  qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  If Not fEmptyStr(edtNumMan.Text) Then
    qryConsulta.ParamByName('NUMMAN').AsString := edtNumMan.Text;

  If Not fEmptyStr(edtNumNfe.Text) Then
    qryConsulta.ParamByName('NUMDOC').AsString := edtNumNfe.Text;

  If Not fEmptyStr(edtEspDoc.Text) Then
    qryConsulta.ParamByName('ESPDOC').AsString := edtEspDoc.Text;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    qryConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryConsulta.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)) Then
  Begin
    qryConsulta.ParamByName('DTAINI_MAN').AsDateTime := StrToDate(mskDtaIniMan.Text);
    qryConsulta.ParamByName('DTAFIN_MAN').AsDateTime := StrToDate(mskDtaFinMan.Text);
  End;

  Result := True;
end;

function TfrmFatManutencaoManifestoEletronico.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaFin)                                 And
       (Not mskDtaFin.ReadOnly)                             And
       (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final da emissão da NFe deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final da emissão da NFe deve ser maior ou igual a Data Inicial  da emissão da NFe !', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFinMan)                                  And
            (Not mskDtaFinMan.ReadOnly)                              And
            (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniMan.Text)))  Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinMan.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final  do manifesto deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIniMan.Text, mskDtaFinMan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final  do manifesto deve ser maior ou igual a Data Inicial  do manifesto !', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumMan) and (chkCarPos.Visible) and (chkCarPos.Checked) then
    Begin
      if fEmptyStr(edtNumMan.Text) then
      begin
        fMensagem('ATENÇÃO!', 'É obrigatório preencher o Número do Manisfesto!', ['&O k']);
        Result := False;
      end;
    End

    Else If (Sender = edtCodEmp) And (not edtCodEmp.ReadOnly) Then
    Begin
      edtNomEmp.Clear;

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a empresa do manifesto!', ['&Ok']);
        Result := False;
        pSetFocus(edtCodEmp);
        Exit;
      End;

      edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
        pSetFocus(edtCodEmp);
        Exit;
      End;
    End;
  End;
end;

procedure TfrmFatManutencaoManifestoEletronico.pRemoverDoManifesto;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE CADFIS SET ';
  strSQL := strSQL + '  FIS_NUMMAN = NULL, ';
  strSQL := strSQL + '  FIS_DTAMAN = NULL, ';
  strSQL := strSQL + '  FIS_MOTMAN = NULL, ';
  strSQL := strSQL + '  FIS_PLAMAN = NULL, ';
  strSQL := strSQL + '  FIS_PLAMA2 = NULL, ';
  strSQL := strSQL + '  FIS_ACEMAN = NULL, ';
  strSQL := strSQL + '  FIS_PERCUR = NULL, ';
  strSQL := strSQL + '  FIS_ESTMAN = NULL, ';
  strSQL := strSQL + '  FIS_EMPMAN = NULL, ';

  if blnTemCarPos then
    strSQL := strSQL + '  FIS_CARPOS = "N", ';

  strSQL := strSQL + '  FIS_ENCERR = NULL  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM IN (' + stlListSelecao.CommaText + '); ';

  strSQL := strSQL + 'DELETE FROM FISMOT WHERE FMO_SEQGER IN (' + stlListSelecao.CommaText + '); ';

  qryAux := fCriaQuery(Self);
  try
    qryAux.SQL.Add(strSQL);
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmFatManutencaoManifestoEletronico.rdgTipoDocumentoClick(
  Sender: TObject);
begin
  inherited;
  edtEspDoc.Enabled := (rdgTipoDocumento.ItemIndex = 0);
  chkCarPos.Enabled := edtEspDoc.Enabled;

  if edtEspDoc.Enabled then
    lblNroDocumento.Caption := 'Número da Nota:'
  else
  begin
    lblNroDocumento.Caption := 'Número do CTe:';
    edtEspDoc.Clear;
    chkCarPos.Checked := False;
  end;
end;

procedure TfrmFatManutencaoManifestoEletronico.pEfetuarCargaPosterior;
begin
  if fAtualizarDocumentosManifesto then
    fEnviarDocsCarregados(cdsConsulta.FieldByName('NUMMAN').AsString, stlListSelecao.CommaText, cdsConsulta.FieldByName('EMPMAN').AsString);
end;

procedure TfrmFatManutencaoManifestoEletronico.pLimparTela;
begin
  pDesmarcaTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  edtNumMan.Clear;
  edtNumNfe.Clear;
  edtEspDoc.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaIniMan.Clear;
  mskDtaFinMan.Clear;
  lblMensCarPos.Visible := False;
  pnlInclusao.Visible := False;
  pSetFocus(edtNumMan);
end;

procedure TfrmFatManutencaoManifestoEletronico.pRemoveDocumentoDoManifesto(AAutInc, ANumMan, AEmpMan: String);
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  Try
    fStartTransaction();

    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE CADFIS SET ');
      qryAux.SQL.Add('  FIS_NUMMAN = NULL, ');
      qryAux.SQL.Add('  FIS_DTAMAN = NULL, ');
      qryAux.SQL.Add('  FIS_MOTMAN = NULL, ');
      qryAux.SQL.Add('  FIS_PLAMAN = NULL, ');
      qryAux.SQL.Add('  FIS_PLAMA2 = NULL, ');
      qryAux.SQL.Add('  FIS_ACEMAN = NULL, ');
      qryAux.SQL.Add('  FIS_PERCUR = NULL, ');
      qryAux.SQL.Add('  FIS_ESTMAN = NULL, ');
      qryAux.SQL.Add('  FIS_EMPMAN = NULL, ');
      qryAux.SQL.Add('  FIS_ENCERR = NULL  ');
      qryAux.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
      qryAux.SQL.Add('  AND FIS_NUMMAN = :NUMMAN ');
      qryAux.SQL.Add('  AND FIS_EMPMAN = :EMPMAN ');

      qryAux.ParamByName('AUTINC').AsString := AAutInc;
      qryAux.ParamByName('NUMMAN').AsString := ANumMan;
      qryAux.ParamByName('EMPMAN').AsString := AEmpMan;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM FISMOT ');
      qryAux.SQL.Add('WHERE FMO_SEQGER = :AUTINC');
      qryAux.ParamByName('AUTINC').AsString := AAutInc;
      qryAux.ExecSQL;

    Finally
      FreeAndNil(qryAux);
    End;

    fCommit();

  Except
    On E: Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, '[pRemoveDocumentoDoManifesto]');
    End;
  End;

end;

Procedure TfrmFatManutencaoManifestoEletronico.pSelecionarDocumentosSemMDFe;
Begin
  If Not Assigned(cdsConsulta) Then
    Exit;

  If Not cdsConsulta.Active Then
    Exit;

  If Not blnTemCarPos Then
    Exit;

  If Not chkCarPos.Checked Then
    Exit;

  stlListSelecao.Clear;

  cdsConsulta.DisableControls;
  cdsConsulta.First;

  Try
    While Not cdsConsulta.Eof Do
    Begin
      If fEmptyStr(cdsConsulta.FieldByName('ACEMAN').AsString) Then
        pAddListaQuery;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
    dbgConsulta.Repaint;
  End;

End;

end.
