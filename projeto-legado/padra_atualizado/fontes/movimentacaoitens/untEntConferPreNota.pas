unit untEntConferPreNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils, untTypesSistema, TypesRel, untFuncoesRel2,
  Math, ShlObj, untFuncoesRel, BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxExportCSVTestabilidade, untEntConfPreNotaFuncoes, untFuncoesEtiquetas,
  Datasnap.DBClient, Vcl.DBCtrls, DBMemoFocus, untTProcessaEtiqueta;

type
  TFuncUpItem = Function (strAutInc: String; Var fltQtdIte: Double): Boolean Of Object;

  TfrmEntConferPreNota = class(TfrmPaiOrdena)
    Label2: TLabel;
    edtCodIte: TEditFocus;
    Label3: TLabel;
    edtQtdIte: TEditFocus;
    cdsCriticas: TUniClientDataSet;
    cdsCriticasCODITE: TStringField;
    cdsCriticasQTDITE: TFloatField;
    cdsCriticasQTDCON: TFloatField;
    cdsCriticasDESITE: TStringField;
    cdsCriticasSIGUNI: TStringField;
    Label1: TLabel;
    edtQtdEti: TEditFocus;
    cdsCriticasCODFAB: TStringField;
    cdsCriticasLOCFIS: TStringField;
    cdsCriticasSALDOS: TFloatField;
    rdbCodFab: TRadioButton;
    rdbCodBar: TRadioButton;
    lblNotEle: TLabel;
    edtNotEle: TEditFocus;
    chkImprimeEtiqueta: TCheckBox;
    edtCodFor: TEditFocus;
    Label5: TLabel;
    Panel1: TPanel;
    spbEtiqueta: TSpeedButton;
    lblEtiqueta: TLabel;
    btnExcluir: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnExcluirItensIncons: TBitBtnLocked;
    btnNotEle: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    btnCriticas: TBitBtnLocked;
    btnQtdEti: TBitBtnLocked;
    btnCadSem: TBitBtnLocked;
    btnDigCodBarLocFis: TBitBtnLocked;
    btnEtiPro: TBitBtnLocked;
    btnImpColetor: TBitBtnLocked;
    chkMosEmb: TCheckBox;
    cdsCriticasQTDXML: TFloatField;
    pnlImgPro: TPanel;
    imgPro: TImage;
    lblErrImg: TLabel;
    pnlFicIns: TPanel;
    Panel9: TPanel;
    dbeFicIns: TDBMemoFocus;
    Splitter1: TSplitter;
    btnBalanca: TBitBtnLocked;
    lblCodCfr: TLabel;
    edtCodCfr: TEditFocus;
    edtNomCfr: TEditFocus;
    btnArquivosAnexos: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    lblAgeRec: TLabel;
    btnLimparConferencia: TBitBtnLocked;
    pnlLegendaConferencia: TPanel;
    lblLegNaoLocalizado: TLabel;
    shpRed: TShape;
    lblConfOK: TLabel;
    shpConfOK: TShape;
    btnLiberarEnderecamento: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsConsultaAfterClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCriticasClick(Sender: TObject);
    procedure btnQtdEtiClick(Sender: TObject);
    procedure btnCadSemClick(Sender: TObject);
    procedure rdbCodBarClick(Sender: TObject);
    procedure btnDigCodBarLocFisClick(Sender: TObject);
    procedure btnNotEleClick(Sender: TObject);
    procedure btnNotEleEnter(Sender: TObject);
    procedure btnExcluirItensInconsClick(Sender: TObject);
    procedure spbEtiquetaClick(Sender: TObject);
    procedure chkImprimeEtiquetaClick(Sender: TObject);
    procedure btnEtiProClick(Sender: TObject);
    procedure btnImpColetorClick(Sender: TObject);
    procedure chkMosEmbClick(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);

    procedure btnBalancaClick(Sender: TObject);
    procedure imgProDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnArquivosAnexosClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure btnLimparConferenciaClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnLiberarEnderecamentoClick(Sender: TObject);
  private
    { Private declarations }
    blnCOFEND : Boolean;
    qryNotEle: TUniQuery;

    blnAbrindoConsulta,
    blnImgPro: Boolean;

    stlIncNfe: TStringList;

    strIdeDig: String;
    strArcCod: String;

    blnPrePro: Boolean;
    intTabPre: Integer;
    strCodCnd: String;
    strCndPag: String;
    strNumPar: String;
    strDesEti: String;

    blnBarCen : Boolean;
    blnFcQtEt : Boolean;

    blnRefEnt: Boolean;
    blnFluxoCompras: Boolean;

    objConfPreNota: TConferePreNota;

    qryConOpe : TUniQuery;
    strCodCfr : String;
    blnSenCfp : Boolean;
    blnDocumentoEspecifico : boolean;
    blnITECNF: Boolean;

    function fRegistraItem: Boolean;
    Function fDocumentoLiberado: Boolean;

    procedure pCancela(blnPerguntar: Boolean = True);
    procedure pAtivaCampos;
    function fEscolheTipoEtiqueta: Boolean;
    procedure pCdsConsultaBeforeDelete(Sender: TDataset);
    function fItensSemPeso: Boolean;
    function fValidaItensEcommerce: Boolean;
    procedure pVerificaSolicitaSenSep;
    procedure pAtulizaPlanoDeRecebimento(strIdeDig, strArcCod:String);
    procedure RestauraItens;
    procedure AdicionarColunaQtdNfe;
  public
    class procedure pCarregaConferencia(strIdeDigP : String);
  protected
    objEtiqueta: TProcessaEtiqueta;
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
    procedure pCarregaConferente;
    procedure pAcaoAbort; override;

  end;

Const
  MSG_ETIQUETA = 'Etiqueta não selecionada';

implementation

uses untPai, untFatSelecProduto, untRelacSemelhanca, untCadProFoto,
     untCfgRel, untRelEntConferencia, untFuncFat,untConstantes,
     untEntSelecionaNotaElet,untFuncoesSimples, untFuncoesEtiqItens, untDllOpeProdFuncoes,
     untPesqAux, untQckLiberacaoArmazenamento, untImpEtiquetas, untEntImportaColetor,
     untEntEtiquetas, untBalanca, untImagens, untGravaArquivoPasta, untEntMercadoriasEfetivaMovFiscal,
     untDllOpeProd, untManECommerce,
     untOpcPoupupRadio, untTDistribuicaoConferencia,
     untTEnderecamentoConferenciaParciAL;

{$R *.dfm}

function TfrmEntConferPreNota.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCfr) And (edtCodCfr.Visible) Then
    Begin
      If fEmptyStr(edtCodCfr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Conferente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaConferente;
        If qryConOpe.FieldbyName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Conferente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

      If Not Result Then
      Begin
        edtCodCfr.Text := '';
        edtNomCfr.Text := '';
      End;

      If Result Then
      Begin
        pAtivaCampos;
        objConfPreNota.pAtualizaOpeCfr(strCodCfr,stlIncNfe);
      End;

    End

    Else If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If (fEmptyStr(edtQtdIte.Text)) Then
      Begin
        pMensagemSonora('A quantidade deve ser preenchida!');
        Result := False;
      End
      Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
      Begin
        pMensagemSonora('A quantidade deve ser maior que zero!');
        Result := False;
      End

      Else
      Begin
        if blnBuscaPorChave Then
        Begin
          If blnFcQtEt Then
          Begin
            edtQtdIte.Enabled := False;
            edtQtdEti.Enabled := True;
            chkImprimeEtiqueta.Checked := True;
            pSetFocus(edtQtdEti);
          End
          Else
          Begin
            pSetFocus(edtCodIte);

            edtQtdIte.Enabled := False;
            edtQtdEti.Enabled := False;
          End;
        End;  
        blnMudarFoco := False;
      End;

    End

    Else If (Sender = edtQtdEti) Then
    Begin

      If (StrToIntDef(edtQtdEti.Text, -1) < 0) Then
      Begin
        pMensagemSonora('A quantidade deve ser maior ou igual a zero!');
        Result := False;
      End
      Else
      Begin
        edtQtdIte.Enabled := False;
        edtQtdEti.Enabled := False;
        blnMudarFoco := False;

        If blnBuscaPorChave Then
        Begin
          pSetFocus(edtCodIte);
        End;    


      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmEntConferPreNota.fValidaItensEcommerce: Boolean;

procedure pCriarFormManEcommerce(strCodIte: String);
  var
    frmManEcom: TfrmManECommerce;
  begin
    pCriarFormularios(TfrmManECommerce, frmManEcom);
    Try
      frmManEcom.edtCodIte.Text := strCodIte;
      frmManEcom.edtCodIteExit(nil);
      frmManEcom.ShowModal;
    Finally
      FreeAndNil(frmManEcom);
    End;
  end;

var
  strCodIte: String;
  blnIteSem: Boolean;
begin

  Result := True;	
  
  If Not fCfgSis('CONVMP', varBoolean) Then
    Exit(True);

  cdsConsulta.First;

  While not cdsConsulta.Eof Do
  Begin
    strCodIte := cdsConsulta.FieldByName('ITE_CODITE').AsString;

    blnIteSem := objConfPreNota.fItemSemDadosEcommerce(strCodIte);

    If blnIteSem Then
    Begin
      If (fVerificaAcessoSistema('frmManECommerce')) Then
      Begin
        If (fMensagem('', 'Produto ' + strCodIte + ' sem informações de eCommerce, deseja preencher?', ['&Sim','&Não']) = 1) Then
        Begin
          Try
            pCriarFormManEcommerce(strCodIte);
          Finally
            If objConfPreNota.fItemSemDadosEcommerce(strCodIte) Then
              Result := False;
          End;
        End
        Else
          Exit(False);
      End;
    End;

    cdsConsulta.Next;
  End;

end;

procedure TfrmEntConferPreNota.imgProDblClick(Sender: TObject);
begin
  inherited;
  if (not cdsConsulta.IsEmpty) then
    TfrmImagens.pAbrirImagens(tiProduto, cdsConsulta.FieldByName('ITE_CODITE').AsString, True);
end;

Function TfrmEntConferPreNota.fGetSql(blnLike: Boolean): String;
Begin
  Result := objConfPreNota.fGetSqlPrincipal(blnLike);
End;

procedure TfrmEntConferPreNota.pCancela(blnPerguntar: Boolean = True);
Begin
  If btnNotEle.Focused Or cdsConsulta.IsEmpty Then
    Close

  Else If (Not blnPerguntar) Or
          (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
  Begin
    If blnDocumentoEspecifico Then
    Begin
      Close;
      Exit;
    End;

    lblAgeRec.Visible := False;
    btnNotEle.Enabled := True;
    edtCodCfr.Enabled := True;
    pSetFocus(btnNotEle);
  End;
End;

class procedure TfrmEntConferPreNota.pCarregaConferencia(strIdeDigP: String);
  Var
    qryGerEle : TUniQuery;
    frmEntConferPreNota: TfrmEntConferPreNota;
begin
  Try
    pCriarFormularios( TfrmEntConferPreNota, frmEntConferPreNota);

    qryGerEle := fCriaQuery;
    With qryGerEle, SQL Do
    Begin
      frmEntConferPreNota.blnDocumentoEspecifico := True;
      frmEntConferPreNota.strIdeDig := strIdeDigP;
      frmEntConferPreNota.objConfPreNota.strIdeDig := strIdeDigP;
      frmEntConferPreNota.edtCodFor.Clear;
      frmEntConferPreNota.edtNotEle.Clear;

      Close;
      Clear;
      Add('SELECT NE.*,');
      Add('       (SELECT FIS_DTAENT FROM CADFIS ');
      Add('         WHERE FIS_NUMDOC = NE.GER_DOCENT AND ');
      Add('               FIS_ESPDOC = NE.GER_ESPENT AND ');
      Add('               FIS_CODEMP = NE.GER_CODEMP AND ');
      Add('               FIS_SERIE_ = NE.B07_SERIE  AND ');
      Add('               FIS_FORCLI = NE.GER_CODFOR) AS FIS_DTAENT, ');
      Add('        EXTGOR.FGO_SEQFGO AS SEQFGO');
      Add('  FROM GERELE NE ');
      Add(' LEFT JOIN EXTGOR ON FGO_DOCEND = ');
      Add(' CONCAT( ');
      Add(' B08_NNF, ');
      Add(' GER_ESPENT, ');
      Add(' LEFT(CONCAT(B07_SERIE,REPEAT('' '',3)),3), ');
      Add(' GER_CODEMP, ');
      Add(' GER_CODFOR, ');
      Add(' "F" ');
      Add(' ) ');



      Add('  WHERE NE.GER_IDEDIG = :IDEDIG ');
      ParamByName('IDEDIG').AsString := strIdeDigP;
      Open;
      frmEntConferPreNota.objConfPreNota.dtaFisDtaEnt :=  FieldByName('FIS_DTAENT').AsDateTime;
      frmEntConferPreNota.objConfPreNota.strSeqFgo := FieldByName('SEQFGO').AsString;

      While Not Eof Do
      Begin

        frmEntConferPreNota.stlIncNfe.Add(FieldByName('AUTOINCREM').AsString);
        frmEntConferPreNota.edtCodFor.Text := FieldByName('GER_CODFOR').AsString + '-' + fRetNomFornecedor(FieldByName('GER_CODFOR').AsString);
        frmEntConferPreNota.objConfPreNota.strCodfor := frmEntConferPreNota.edtCodFor.Text;
        If fConferenciaDepoisDaEntrada Then
          frmEntConferPreNota.edtNotEle.Text := frmEntConferPreNota.edtNotEle.Text + FieldByName('GER_DOCENT').AsString + '-' + FieldByName('GER_ESPENT').AsString + ' ' + FieldByName('B07_SERIE').AsString
        Else
          frmEntConferPreNota.edtNotEle.Text := frmEntConferPreNota.edtNotEle.Text + FieldByName('B08_NNF').AsString + '-' + 'NF' + ' ' + FieldByName('B07_SERIE').AsString;

        Next;

        if not Eof Then
          frmEntConferPreNota.edtNotEle.Text := frmEntConferPreNota.edtNotEle.Text + ', ';

      End;


      If frmEntConferPreNota.fDocumentoLiberado Then
      Begin
        If fUtilizaDistribuicaoConferenciaPreNota Then
          frmEntConferPreNota.objConfPreNota.ObjDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorGerEle(frmEntConferPreNota.stlIncNfe);
        If frmEntConferPreNota.fAbreConsulta(TRUE) Then
        Begin
          frmEntConferPreNota.pnlTail.Enabled := TRUE;
          frmEntConferPreNota.btnNotEle.Enabled := False;
          frmEntConferPreNota.pVerificaSolicitaSenSep;
          frmEntConferPreNota.blnFluxoCompras := True;
          frmEntConferPreNota.objConfPreNota.ObjDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorGerEle(frmEntConferPreNota.stlIncNfe);
          If TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorreta(FieldByName('SEQFGO').AsString) Then
            pMensagemOk('Esta conferência foi iniciada em outra vesão do Autcom, por motivos de compatibilidade não será possível prosseguir com esta versão!')
          Else
            frmEntConferPreNota.ShowModal;
        End;
      End;
    End;


  Finally
    FreeAndNil(qryGerEle);
    FreeAndNil(frmEntConferPreNota);
  End;

end;

procedure TfrmEntConferPreNota.pCarregaConferente;
begin
  strCodCfr := '';
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodCfr.Text, True);
  With qryConOpe Do
  Begin
    strCodCfr      := FieldByName('OPE_CODOPE').AsString;
    edtNomCfr.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmEntConferPreNota.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_RETURN: If edtCodIte.Focused Then
               begin
                 If fEmptyStr(edtCodIte.Text) Then
                   Exit;

                 If Not fValidaCampos(edtQtdIte, False) Then
                   Exit;

                 If Not fValidaCampos(edtQtdEti, False) Then
                   Exit;

                 fRegistraItem;
               end
               Else
                 inherited;
    VK_F1: spbEtiqueta.Click;
    VK_F2: btnAtualizar.Click;
    VK_F4: If btnBalanca.Visible Then
             btnBalanca.Click;
    VK_F6: btnQuantidade.Click;
    VK_F7: btnQtdEti.Click;

    VK_F9: If ssAlt In Shift Then
             btnImpColetor.Click
           Else
             btnCriticas.Click;

    VK_F8: btnEtiPro.Click;
    VK_F11: btnCadSem.Click;
    VK_F12: btnDigCodBarLocFis.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_ESCAPE:  If pnlPesquisa.Visible Then
                  inherited
                Else
                Begin
                  Key := 0;
                  pCancela;
                End;

    VK_DELETE: If dbgConsulta.Focused Then
                 btnExcluir.Click;

    Else inherited;
  End;

end;

procedure TfrmEntConferPreNota.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('EXIAPL', varBoolean) Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := dtsConsulta;
  End;

  If fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
    edtCodIte.Enabled := False;

  blnAbrindoConsulta  := False;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;
  btnBalanca.Visible  := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := getColumByFieldName('ITE_CODITE').FieldName;
  lflLastField.strNomCol := getColumByFieldName('ITE_CODITE').Title.Caption;
  lflLastField.ftyTipCam := ftString;

  edtQtdEti.Text := fCfgSis('ETICEM');

  pSetFocus(btnNotEle);

  btnCriticas.Enabled := fVerificaAcessoSistema('RELCPN');

  edtQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTPC', varInteger)), 1);

  If fCfgSis('CPESOB', varBoolean) Then
  Begin
    btnBalanca.Visible := True ;
    getColumByFieldName('ITE_PESBRU').Visible := True;
    getColumByFieldName('ITE_PESLIQ').Visible := True;
    getColumByFieldName('ITE_CPESOB').Visible := True;
  End;

  If blnSenCfp Then
  Begin
    lblCodCfr.Visible := True;
    edtCodCfr.Visible := True;
    edtNomCfr.Visible := True;
  End
  Else
  Begin
    lblCodCfr.Visible := False;
    edtCodCfr.Visible := False;
    edtNomCfr.Visible := False;
  End;

  blnRefEnt := fCfgSis('REFENT', varBoolean);
  btnLiberarEnderecamento.Visible := (blnCOFEND) And (objConfPreNota.dtaFisDtaEnt > 0);
  btnLimparConferencia.Visible := fCfgSis('TPLREC') = 'N';
end;

procedure TfrmEntConferPreNota.btnQuantidadeClick(Sender: TObject);
begin
  inherited;
  If {(Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Or }(Not btnQuantidade.Enabled) Then
    Exit;

  If (rdbCodBar.Checked) And (Not fVerificaAcessoSistema('QTDEXP', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Operador não tem direitos para executar essa operação!', ['&OK']);
    Exit;
  End;

  edtQtdIte.Enabled := True;
//  edtQtdEti.Enabled := True;
  pSetFocus(edtQtdIte);

end;

procedure TfrmEntConferPreNota.btnEtiProClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
  Begin
    pMensagemOk('Nenhum item conferido!');
    Exit;
  End;

  TfrmEntEtiquetas.pImpEtiPreNota(objConfPreNota.strIdeDig);

end;

procedure TfrmEntConferPreNota.btnExcluirClick(Sender: TObject);
var
  fltQtdLiberada: Double;
begin
  inherited;
  if not btnExcluir.Enabled then
    exit;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;
  If blnCofEnd Then
  Begin
    fltQtdLiberada := objConfPreNota.ObjDistribuicaoConferencia.GetQuantidadeLiberadaEnderecamento(cdsConsulta.FieldByName('ITE_CODITE').AsString);
    If fltQtdLiberada > 0 Then
    begin
      If fPergunta('O item ' + cdsConsulta.FieldByName('ITE_CODITE').AsString + ' ' +
                   'já foi liberado para endereçamento. Deseja excluir a confêrencia realizada ainda não liberada para endereçar?', False) Then

        objConfPreNota.fAjustaItem(cdsConsulta, fltQtdLiberada, stlIncNfe);
      pSetFocus(edtCodIte);
      Exit;
    End;
  End;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  With cdsConsulta Do
    If fMensagem('', 'Deseja excluir o item ' + FieldByName('ITE_CODITE').AsString + ' ?', ['&Sim', '&Não']) = 1 Then
    begin
      If fUtilizaDistribuicaoConferenciaPreNota Then
       objConfPreNota.ObjDistribuicaoConferencia.DesfazerConferenciaItem(cdsConsulta.FieldByName('ITE_CODITE').AsString);
      Delete;
    End;

  pSetFocus(edtCodIte);
end;

procedure TfrmEntConferPreNota.btnExcluirItensInconsClick(Sender: TObject);
begin
  inherited;

  if not btnExcluirItensIncons.Enabled then
    exit;

  If objConfPreNota.fExisteConferenciaParcial Then
  Begin
    fMensagem('', 'A conferência foi liberada para endereçamento então não pode ser excluída!', ['&OK']);
    exit;
  End;

  pLimpaPesquisa;

  If Not objConfPreNota.fPosssuiInconsistencias(cdsConsulta, cdsCriticas, qryNotEle) Then
    fMensagem('', 'Não há inconsistências no Documento!', ['&Ok'])

  Else If fMensagem('','Confirma exclusão dos itens com inconsistências?', ['','']) = 1 Then
  Begin
    objConfPreNota.pExcluirItensIncons(cdsConsulta, cdsCriticas);
  End;

end;

procedure TfrmEntConferPreNota.btnImpColetorClick(Sender: TObject);
begin
  inherited;
  if not btnImpColetor.Enabled then
    exit;

  TEntImportaColetor.fImportaColetor(cdsConsulta, edtCodIte, edtQtdIte, fRegistraItem);
end;

procedure TfrmEntConferPreNota.btnLimparConferenciaClick(Sender: TObject);
var
  I : Integer;
  intOpcao: integer;
begin
  inherited;
  intOpcao := -1;

  If Not objConfPreNota.fLiberacaoParaLimparConferencia(edtNotEle) Then
  Begin
    pMensagemOk('Usuário sem permissão para limpar conferência!');
    Exit;
  End;


  If fUtilizaDistribuicaoConferenciaPreNota Then
  Begin
    If objConfPreNota.ObjDistribuicaoConferencia.TemQuantidadeLiberadaEnderecamento then
    begin
      intOpcao := TfrmOpcPoupupRadio.fRetOpcPopup(['&Toda Conferência', 'Conferência Não &Liberada', '&Cancelar'],
                                                  2,
                                                  'A Conferência tem itens liberados para endereçamento. Limpar?');
      case intOpcao of
        0: begin
             If objConfPreNota.objDistribuicaoConferencia.fJateveEnderecamento then
             begin
               pMensagemOk('Este processo não pode ser realizado pois Endereçamento parcial já foi realizado');
               Exit;
             End;
           End;
        1: Begin
             RestauraItens;
             Exit;
           End;
        2,
       -1: Exit;
      End;
    End;
  End;

  If (intOpcao = -1) Then
    If fMensagem('ATENÇÃO', 'Confirma o reinício da conferência?', ['&Sim', '&Não']) = 2 Then
      Exit;

  With objConfPreNota Do
  Begin
    fStartTransaction;
    Try
      For I := 0 to stlIncNfe.Count - 1 Do
      Begin
        pLimpaSeqConf(stlIncNfe[I]);
      End;
      fCommit;
      pLimpaConferencia(cdsConsulta);

      edtCodFor.Text := '';
      edtNotEle.Text := '';
      btnNotEle.Enabled := True;
      edtCodCfr.Enabled := True;
      pSetFocus(btnNotEle);

    Except
      on e: exception do
      begin
        fRollBack;
        pMensagensErro(e.message, '[TfrmEntConferPreNota.btnLimparConferenciaClick]');
      End;
    End;

  End;
end;

procedure TfrmEntConferPreNota.btnNotEleClick(Sender: TObject);
  Var
    frmEntSelecionaNotaElet: TfrmEntSelecionaNotaElet;
begin
  inherited;

  strArcCod := '';

  pCriarFormularios(TfrmEntSelecionaNotaElet, frmEntSelecionaNotaElet);

  frmEntSelecionaNotaElet.objConfPreNota := objConfPreNota;

  If frmEntSelecionaNotaElet.ShowModal = mrOK Then
  Begin
    strIdeDig      := objConfPreNota.strIdeDig;
    stlIncNfe.Text := objConfPreNota.strIncrem;
    edtCodFor.Text := objConfPreNota.strCodFor;
    edtNotEle.Text := objConfPreNota.strDocume;
  End;

  btnLimparConferencia.Visible := fCfgSis('TPLREC') = 'N';

  if (fConferenciaDepoisDaEntrada and (fCfgSis('TPLREC', varString) <> 'N')) Then
  Begin
    strArcCod := fCampoTabela('ARC_CODIGO', 'AGEREC', ['ARC_IDEDIG'], [strIdeDig]);
    lblAgeRec.Caption := 'Código do Plano de Recebimento: ' + strArcCod;
    lblAgeRec.Visible := True;

    If (blnRefEnt) And (objConfPreNota.blnPedCompraGarantia) And (Not edtCodIte.Enabled)   Then
      edtCodIte.Enabled := True;
  End;

  pFreeAndNil(frmEntSelecionaNotaElet);

  pVerificaSolicitaSenSep();
  btnLiberarEnderecamento.Visible := (blnCOFEND) And (objConfPreNota.dtaFisDtaEnt > 0);

end;

procedure TfrmEntConferPreNota.pVerificaSolicitaSenSep;
begin
  If Not blnSenCfp Then
    pAtivaCampos
  Else
    pSetFocus(edtCodCfr);
end;

procedure TfrmEntConferPreNota.btnNotEleEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;
  strIdeDig := EmptyStr;
  strArcCod := EmptyStr;
  edtCodFor.Clear;
  stlIncNfe.Clear;
  edtNotEle.Clear;
  edtCodCfr.Clear;
  edtNomCfr.Clear;
end;

procedure TfrmEntConferPreNota.btnSairClick(Sender: TObject);
begin
  pCancela;
end;

procedure TfrmEntConferPreNota.cdsConsultaAfterClose(DataSet: TDataSet);
begin
  inherited;
  pnlTail.Enabled := FALSE;

  If Not blnDocumentoEspecifico Then
    objConfPreNota.pLiberaDocumentos(stlIncNfe);
end;

procedure TfrmEntConferPreNota.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if (cdsConsulta.FieldByName('CONFERIDO').AsString = 'S') then
  begin
    btnConfirma.Enabled := False;
    btnExcluir.Enabled := False;
    pnlTail.Visible := False;
    btnExcluirItensIncons.Enabled := False;
    btnDigCodBarLocFis.Enabled := False;
    btnImpColetor.Enabled := False;
    btnBalanca.Enabled := False;
    btnQtdEti.Enabled := False;
    btnQuantidade.Enabled := False;
    edtCodCfr.Enabled := False;
  end
  else
  begin
    btnConfirma.Enabled := True;
    btnExcluir.Enabled := True;
    pnlTail.Visible := True;
    btnExcluirItensIncons.Enabled := True;
    btnDigCodBarLocFis.Enabled := True;
    btnImpColetor.Enabled := True;
    btnBalanca.Enabled := True;
    btnQtdEti.Enabled := True;
    btnQuantidade.Enabled := True;
    edtCodCfr.Enabled := True;
  end;
end;

procedure TfrmEntConferPreNota.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, IfThen(DataSet.IsEmpty, '', DataSet.FieldByName('ITE_CODITE').AsString));
end;

procedure TfrmEntConferPreNota.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If blnAbrindoConsulta Then
    Exit;

  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, IfThen(DataSet.IsEmpty, '', DataSet.FieldByName('ITE_CODITE').AsString));
  If cdsConsulta.FieldByName('ITE_CODITE').AsString <> '' Then
    btnArquivosAnexos.Visible := DirectoryExists(ExtractFilePath(Application.ExeName)+ 'Arquivos_produto\' + cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmEntConferPreNota.chkImprimeEtiquetaClick(Sender: TObject);
begin
  inherited;
  If chkImprimeEtiqueta.Checked And (lblEtiqueta.Caption = MSG_ETIQUETA) Then
  Begin
    chkImprimeEtiqueta.Checked := fEscolheTipoEtiqueta;
  End;

  If chkImprimeEtiqueta.Checked And (StrToIntDef(edtQtdEti.Text, 0) = 0) Then
    edtQtdEti.Text := '1';
end;

procedure TfrmEntConferPreNota.chkMosEmbClick(Sender: TObject);
begin
  inherited;

  getColumByFieldName('ITE_QTDEMB').Visible := chkMosEmb.Checked;

  If getColumByFieldName('ITE_QTDEMB').Visible Then
    dbgConsulta.Columns[2].Width := 364 - getColumByFieldName('ITE_QTDEMB').Width
  Else
    dbgConsulta.Columns[2].Width := 364;


end;

procedure TfrmEntConferPreNota.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If Not blnITECNF Then
    Exit;

  If (gdSelected in State) Then
    TDBGridCitel(Sender).Canvas.Brush.Color := clSkyBlue;

  If Column.FieldName = 'ITE_QTDCON' Then
  Begin
    Case AnsiIndexStr(cdsConsulta.FieldByName('STATUS_CONF').AsString, ['C','I']) Of
      0: TDBGridCitel(Sender).Canvas.Font.Color := clGreen;
      1: TDBGridCitel(Sender).Canvas.Font.Color := clRed;
    End;
  End;

  TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmEntConferPreNota.pAcaoAbort;
Begin
  pSetFocus(edtCodIte);
End;

procedure TfrmEntConferPreNota.pAtivaCampos;
begin
  If stlIncNfe.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione a NFe para conferência!', ['&O k']);
  End
  Else If (blnDocumentoEspecifico or fDocumentoLiberado)  And fAbreConsulta(TRUE) Then
  Begin
    pnlTail.Enabled := TRUE;
    btnNotEle.Enabled := False;
    edtCodCfr.Enabled := False;

    If fCfgSis('CPESOB', varBoolean) And fItensSemPeso then
      pMensagemOK('Antes de finalizar efetue a pesagem obrigatória dos produtos sem peso!');

    pSetFocus(edtCodIte);
  End
  Else
  Begin
    pLimpaPesquisa;
    cdsConsulta.Close;
    strIdeDig := EmptyStr;
    strArcCod := EmptyStr;
    edtCodFor.Clear;
    stlIncNfe.Clear;
    edtNotEle.Clear;
    edtCodCfr.Clear;
    edtNomCfr.Clear;
  End;
end;

procedure TfrmEntConferPreNota.pAtulizaPlanoDeRecebimento(strIdeDig, strArcCod:String);
Var
  qryUpdate : TUniQuery;
begin
  qryUpdate:= fCriaQuery;
  Try
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(' UPDATE AGEREC SET ARC_STATUS = "CN" WHERE ARC_IDEDIG = :IDEDIG AND ARC_CODEMP = :CODEMP AND ARC_CODIGO = :CODIGO ');
    qryUpdate.ParamByName('IDEDIG').AsString := strIdeDig;
    qryUpdate.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryUpdate.ParamByName('CODIGO').AsString := strArcCod;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmEntConferPreNota.fAbreConsulta(blnLike: Boolean): Boolean;
Begin

  Try
    blnAbrindoConsulta := True;

    Result := inherited fAbreConsulta(blnLike);

    objConfPreNota.pCarregaItensNotaEletronica(stlIncNfe, qryNotEle, cdsConsulta);
    objConfPreNota.pSetaRequeridos(cdsConsulta);

    With cdsConsulta Do
    Begin
      TFloatField(FieldByName('ITE_QTDCON')).DisplayFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmEntConferPreNota.fAbreConsulta]');
    End;
  End;

  blnAbrindoConsulta := False;

  With cdsConsulta Do
  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, IfThen(IsEmpty, '', FieldByName('ITE_CODITE').AsString));
End;

procedure TfrmEntConferPreNota.FormCreate(Sender: TObject);
begin
  inherited;
  blnCOFEND := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D');
  qryConOpe:= fCriaQuery;
  strCodCfr := '';
  edtCodCfr.Visible := False;
  lblCodCfr.Visible := False;
  blnSenCfp  := fCfgSis('SENCFP', varBoolean);

  blnDocumentoEspecifico := False;

  blnImgPro := fCfgSis('IMGPRO') = 'S';

  btnLimparConferencia.Visible := False;

  pnlImgPro.Visible  := blnImgPro;

  stlIncNfe := TStringList.Create;

  qryNotEle := fCriaQuery(Self);

  cdsCriticas.CreateDataSet;
  cdsCriticas.Open;

  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));

  lblEtiqueta.Caption := MSG_ETIQUETA;
  blnBarCen   := (fCfgSis('BARCEN',varBoolean)) Or (fCfgSis('ITEBAR', varBoolean));
  blnFcQtEt   := fCfgSis('FCQTET', VarBoolean);

  If Not rdbCodBar.Checked Then
    rdbCodBar.Checked := blnBarCen;
  rdbCodFab.Visible := Not blnBarCen;

  cdsConsulta.BeforeDelete := pCdsConsultaBeforeDelete;

  objConfPreNota := TConferePreNota.Create;
  If objConfPreNota.blnTrazItensGrid then
    AdicionarColunaQtdNfe;

  If fCfgSis('BARLOT', varBoolean) Then
    objEtiqueta := TProcessaEtiqueta.Create('frmEntConferPreNota');

  blnFluxoCompras := False;

  blnITECNF := fCfgSis('ITECNF', varBoolean) And fVerificaAcessoSistema('RELCPN');

  pnlLegendaConferencia.Visible := blnITECNF;
  If blnITECNF Then
  Begin
    cdsConsulta.BeforePost := objConfPreNota.pBeforePost;
    getColumByFieldName('ITE_QTDCON').Font.Style := [fsBold];
  End;
end;

procedure TfrmEntConferPreNota.AdicionarColunaQtdNfe;
var
  Col: TColumn;
begin
  dbgConsulta.Columns.BeginUpdate;
  try
    Col := dbgConsulta.Columns.Add;
    Col.FieldName := 'ITE_QTDTOT';  // campo do dataset
    Col.Title.Caption := 'Qtd. NF-e';
    Col.Width := 100;
    Col.Alignment := taRightJustify;
    Col.Title.Alignment := taRightJustify;
    Col.ReadOnly := True;
    Col.Index := (getColumByFieldName('ITE_QTDCON').Index);
  finally
    dbgConsulta.Columns.EndUpdate;
  end;
end;


procedure TfrmEntConferPreNota.FormDestroy(Sender: TObject);
begin
  If Assigned(objEtiqueta) Then
    FreeAndNil(objEtiqueta);
  inherited;
end;

procedure TfrmEntConferPreNota.btnConfirmaClick(Sender: TObject);
  Var
    frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
    blnConferenciaRetornoGarantiaComPlanoRecebimento : boolean;
begin
  inherited;
  if not btnConfirma.Enabled then
    exit;

  If (Not cdsConsulta.Active) Then
    Exit;

   blnConferenciaRetornoGarantiaComPlanoRecebimento :=  (fUsaRotinaWMS And fConferenciaDepoisDaEntrada And
                                                        (fCfgSis('TPLREC', varString) <> 'N')          And
                                                        (blnRefEnt )                                   And
                                                        (objConfPreNota.blnPedCompraGarantia)          And
                                                        (lblAgeRec.Visible)                            And
                                                        (fCfgSis('WMSPLA', varString) = 'C'));

  If fUsaRotinaWMS And
     fConferenciaDepoisDaEntrada And
     (fCfgSis('TPLREC', varString) <> 'N') And
     (Not blnRefEnt )And
     (Not objConfPreNota.blnPedCompraGarantia)
  Then
  Begin
    pMensagemOK('Não é permitido concluir a conferência pelo Autcom quando está configurado para utilizar o Coletor de Dados!');
    Exit;
  End;

  If fCfgSis('CPESOB', varBoolean) And fItensSemPeso then
  Begin
    pMensagemOK('Efetue a pesagem obrigatória dos produtos sem peso bruto ou líquido!');
    Exit;
  End;

  If Not fValidaItensEcommerce then
  Begin
    pMensagemOK('Há itens com informações de eCommerce incompletas!');
    Exit;
  End;

  If fMensagem('', 'Confirma a finalização da conferência?', ['&Sim', '&Não']) = 1 Then
  Begin

    If objConfPreNota.fGravaConferencia(cdsConsulta, cdsCriticas, edtNotEle, edtCodFor, qryNotEle, stlIncNfe, strCodCfr) Then
    Begin

      If fCfgSis('LIBPNT', varBoolean) then
      Begin
        pCriarFormularios(TfrmQckLiberacaoArmazenamento, frmQckLiberacaoArmazenamento);
        frmQckLiberacaoArmazenamento.pUtilizarCadSem;
        frmQckLiberacaoArmazenamento.pImprimir(objConfPreNota.strIdeDig, 'frmEntConferPreNota_LIBARM', '', oriLibConferenciaEntradaMercadoria);
        FreeAndNil(frmQckLiberacaoArmazenamento);
      End;

      If objConfPreNota.blnGravou Then
      Begin
        If fCfgSis('IEACPN', varBoolean) Then
          If (fMensagem('', 'Deseja imprimir as etiquetas dos produtos conferidos?', ['&Sim', '&Não']) = 1) Then
            If fEscolheTipoEtiqueta Then
              objConfPreNota.pImprimeEtiqueta(StrToIntDef(edtQtdEti.Text,0), cdsConsulta, qryCfgRel, 'objConfPreNota', True, objConfPreNota.strIdeDig);


      End;

      If blnConferenciaRetornoGarantiaComPlanoRecebimento Then
        pAtulizaPlanoDeRecebimento(strIdeDig, strArcCod);

      If  fVerificaAcessoSistema('frmEntMercadoriasEfetivaMovFiscal') And
         (not fUsaRotinaWMS) And fConferenciaDepoisDaEntrada And
         (fMensagem('','Deseja ativar o movimento fiscal das notas conferidas?', ['&Sim', '&Não'], 2) = 1) Then
      Begin
        TfrmEntMercadoriasEfetivaMovFiscal.pEfetivaMovimentoConferencia(stlIncNfe);
      End;

      If blnFluxoCompras Then
        Self.Close
      Else
        pCancela(False);

    End;

    btnLimparConferencia.Enabled := False;

  End;

end;

function TfrmEntConferPreNota.fRegistraItem: Boolean;
var
  blnBarPrin,
  blnBarEmb: Boolean;
begin
  If Assigned(objEtiqueta) And (Length(edtCodIte.Text) > 20) Then
  begin
    If objEtiqueta.blnEtiquetaIdentificada Then
    begin
      objEtiqueta.pLeEtiqueta(edtCodIte.Text);
      If (Not fEmptyStr(objEtiqueta.Campo['CODBAR'].Valor)) then
        edtCodIte.Text := objEtiqueta.Campo['CODBAR'].Valor;
    End;
  End;

  If rdbCodBar.Checked Then
  Begin

    If (Length(edtCodIte.Text) > fTamCodIte)  Then
    Begin

      blnBarPrin:= Not(fEmptyStr(fCampoTabela('ITE_CODBAR', 'CADITE', ['ITE_CODBAR','ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp], False)));
      blnBarEmb := Not(fEmptyStr(fCampoTabela('ITE_BAREMB', 'CADITE', ['ITE_BAREMB','ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp], False)));

      If Not(fEmptyStr(fCfgSis('PRBPUN', varString))) And blnBarPrin Then
        pMensagemSonora('', 'PRBPUN')
      Else
      If Not(fEmptyStr(fCfgSis('PRBPEM', varString)))And blnBarEmb Then
        pMensagemSonora('', 'PRBPEM');

    End;
  End;

  Result := objConfPreNota.fRegistraItem(rdbCodBar.Checked, rdbCodFab.Checked, chkImprimeEtiqueta.Checked,
                                              edtQtdEti, edtCodIte, edtQtdIte, blnBarCen, cdsConsulta, qryCfgRel, Self.Name,
                                              rdbCodBar, stlIncNfe);
end;

procedure TfrmEntConferPreNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsCriticas.EmptyDataSet;
  cdsCriticas.Close;

  {*************************************}
  {* LIBERA A LISTA DE LOCKS AO FECHAR *}
  {**********************************DP*}
  objConfPreNota.pLiberaDocumentos(stlIncNfe);

  If Assigned(stlIncNfe) Then
    FreeAndNil(stlIncNfe);

  If Assigned(qryNotEle) then
  	FreeAndNil(qryNotEle);

  If Assigned(objConfPreNota) then
  	FreeAndNil(objConfPreNota);

  If Assigned(qryConOpe) Then
    FreeAndNil(qryConOpe);
end;

procedure TfrmEntConferPreNota.btnCriticasClick(Sender: TObject);
begin
  inherited;
  objConfPreNota.pCriticas(cdsConsulta, cdsCriticas, qryNotEle, edtNotEle, edtCodFor, edtCodCfr, False);
end;

procedure TfrmEntConferPreNota.btnQtdEtiClick(Sender: TObject);
begin
  inherited;
  if not btnQtdEti.Enabled then
    exit;
//  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Or (Not btnQtdEti.Enabled) Then
//    Exit;

  chkImprimeEtiqueta.Checked := True;
  edtQtdEti.Enabled := True;
  pSetFocus(edtQtdEti);
end;

procedure TfrmEntConferPreNota.btnArquivosAnexosClick(Sender: TObject);
begin
  pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'Arquivos_produto\' + cdsConsulta.FieldByName('ITE_CODITE').AsString;
    frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos em Anexo )';
    frmGravaArquivoPasta.btnImportar.Enabled := False;
    frmGravaArquivoPasta.blnConsulta := True;

    frmGravaArquivoPasta.ShowModal;
  Finally
    FreeAndNil(frmGravaArquivoPasta);
  End;
end;

procedure TfrmEntConferPreNota.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  Try
    if cdsConsulta.Active then
      cdsConsulta.Refresh;
  Except
    {caso de erro por que esta aguadando o fSalva silencia}
  End;

end;

procedure TfrmEntConferPreNota.btnBalancaClick(Sender: TObject);
var fltPesoBruto,
    fltPesoLiquido: Double;
    frmBalanca : TfrmBalanca;

  function fExistePeso: Boolean;
  Begin
    Result := ((cdsConsulta.FieldByName('ITE_PESBRU').AsFloat > 0) And
               (cdsConsulta.FieldByName('ITE_PESLIQ').AsFloat > 0));
  End;

  procedure pAtualizaPeso;
  var qryUpdate: TUniQuery;
  Begin
    Try
      qryUpdate := fCriaQuery;
      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE CADITE SET ITE_PESOIT = :PESBRU, ITE_PESLIQ = :PESLIQ WHERE ITE_CODITE = :CODITE');
      qryUpdate.ParamByName('CODITE').AsString := cdsConsulta.FieldByName('ITE_CODITE').AsString;
      qryUpdate.ParamByName('PESBRU').AsFloat := fltPesoBruto;
      qryUpdate.ParamByName('PESLIQ').AsFloat := fltPesoLiquido;
      qryUpdate.ExecSQL;
    Finally
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('ITE_PESBRU').AsFloat := fltPesoBruto;
      cdsConsulta.FieldByName('ITE_PESLIQ').AsFloat := fltPesoLiquido;
      cdsConsulta.Post;
      FreeAndNil(qryUpdate);
    End;
  End;
begin
  inherited;
  if not btnBalanca.Enabled then
    exit;

  If not cdsConsulta.isEmpty Then
  Begin
    If not fExistePeso Then
    Begin
      Try
        pCriarFormularios(TfrmBalanca, frmBalanca);
        If frmBalanca.ShowModal = mrOK Then
        Begin
          fltPesoBruto   := frmBalanca.fltPesoBruto;
          fltPesoLiquido := frmBalanca.fltPesoLiquido;
          pAtualizaPeso;
        End;
      Finally
        FreeAndNil(frmBalanca);
      End;
    End
    Else
      pMensagemOK('O produto selecionado esta com o peso informado');
  End;
end;

procedure TfrmEntConferPreNota.btnCadSemClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmRelacSemelhanca, frmRelacSemelhanca);
end;

procedure TfrmEntConferPreNota.rdbCodBarClick(Sender: TObject);
begin
  inherited;

  If (rdbCodBar.Checked) And (Not fVerificaAcessoSistema('QTDEXP', strLoginUsuarioLogado)) Then
    edtQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTPC', varInteger)), 1);

  pSetFocus(edtCodIte);
end;

procedure TfrmEntConferPreNota.spbEtiquetaClick(Sender: TObject);
begin
  inherited;
  fEscolheTipoEtiqueta;
end;

procedure TfrmEntConferPreNota.btnDigCodBarLocFisClick(Sender: TObject);
  Var
    strCodBar: String;
begin
  if not btnDigCodBarLocFis.Enabled then
    exit;

  inherited;

  pOpeProdLocFisTransf(strCodBar);

  If Not fEmptyStr(strCodBar) Then
  Begin
    rdbCodBar.checked := True;
    edtCodIte.Text    := strCodBar;
    pSetFocus(edtCodIte);
  End;
end;

Function TfrmEntConferPreNota.fDocumentoLiberado: Boolean;
  var
    intIndice: Integer;
Begin
  Result := True;

  For intIndice := 0 To stlIncNfe.Count -1 Do
  Begin
    Result := fLock_Unlock('NFE' + stlIncNfe[intIndice], True, False, True);

    If Not Result Then
    Begin
      fMensagem('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                     fGetHostLock('NFE' + stlIncNfe[intIndice])  + '!', ['&Ok']);
      Break;
    End;
  End;

End;

function TfrmEntConferPreNota.fEscolheTipoEtiqueta: Boolean;
  Var
    blnExiPrePro : Boolean;
begin
  Result := untFuncoesEtiqItens.fEscolheTipoEtiqueta(objConfPreNota.tpeEtique, False, blnPrePro, intTabPre, strCodCnd, strCndPag, strNumPar, strDesEti, blnExiPrePro);
  If Result Then
    lblEtiqueta.Caption := strDesEti;
end;

procedure TfrmEntConferPreNota.pCdsConsultaBeforeDelete(Sender: TDataset);
  Var
    qryDelete : TUniQuery;
begin
  try
    qryDelete := fCriaQuery(Self);
    With qryDelete, SQL Do
    Begin
      Clear;
      Add('DELETE FROM DIGELE WHERE AUTOINCREM = :AUTOINC');
      ParamByName('AUTOINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

function TfrmEntConferPreNota.fItensSemPeso: Boolean;
Begin
  Result := False;
  With cdsConsulta do
  Begin
    Try
      DisableControls;
      First;
      While not eof do
      Begin
        If (cdsConsulta.FieldByName('ITE_CPESOB').AsString = 'S') And ((FieldByName('ITE_PESBRU').AsFloat = 0) Or (FieldByName('ITE_PESLIQ').AsFloat = 0)) Then
        Begin
          Result := True;
          Break;
        End;

        Next;
      End;
    Finally
      EnableControls;
    End;
  End;

End;

procedure TfrmEntConferPreNota.btnLiberarEnderecamentoClick(Sender: TObject);
Var
  blnLiberado: Boolean;
begin
  inherited;
  If (cdsConsulta.RecordCount = 0)Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum item foi conferido!', ['&OK']);
    Exit;
  End;

  If Not objConfPreNota.fLiberacaoParaLiberarEnderecamento(edtNotEle) Then
  Begin
    pMensagemOk('Usuário sem permissão para liberar para endereçamento!');
    Exit;
  End;

  If fUtilizaDistribuicaoConferenciaPreNota Then
  Begin
    If fMensagem('ATENÇÃO', 'Após o endereçamento, essa conferência não poderá ser cancelada?', ['&Sim', '&Não']) = 1 Then
    Begin
      if objConfPreNota.ObjDistribuicaoConferencia.TemQuantidadeLiberarEnderecamento then
      begin
        blnLiberado := objConfPreNota
          .fIncNfe(stlIncNfe)
          .fConsulta(cdsConsulta)
          .fLiberarEnderecamentoParcial;

          If blnLiberado Then
          Begin
            fMensagem('ATENÇÃO', 'Endereçamento liberado com sucesso!', ['&OK']);
            objConfPreNota.pLiberaDocumentos(stlIncNfe);
            edtCodFor.Text := '';
            edtNotEle.Text := '';
            btnNotEle.Enabled := True;
            edtCodCfr.Enabled := True;
            pSetFocus(btnNotEle);
          End;
      End;
    End;
  End;
end;

procedure TfrmEntConferPreNota.RestauraItens;
var fltQtdLiberada: Double;
   blnTerminou: Boolean;
begin
  cdsConsulta.First;
  blnTerminou := False;
  while not blnTerminou do
  begin

    fltQtdLiberada := objConfPreNota.ObjDistribuicaoConferencia.GetQuantidadeLiberadaEnderecamento(cdsConsulta.FieldByName('ITE_CODITE').AsString);    If fltQtdLiberada > 0 Then
    begin
      objConfPreNota.fAjustaItem(cdsConsulta, fltQtdLiberada, stlIncNfe);
      cdsConsulta.Next;
      blnTerminou := cdsConsulta.Eof;
    End
    Else
    Begin
      If cdsConsulta.RecNo = cdsConsulta.RecordCount Then
        blnTerminou := True;
      objConfPreNota.ObjDistribuicaoConferencia.DesfazerConferenciaItem(cdsConsulta.FieldByName('ITE_CODTE').AsString);
      cdsConsulta.Delete;
    End;
    If not blnTerminou Then
      blnTerminou := ((cdsConsulta.IsEmpty) Or (cdsConsulta.Eof));
  End;
End;

end.



