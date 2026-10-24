unit untGarantiaBaixaRefugo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB, cxProgressBar, untFuncFat,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem,
  System.ImageList, Vcl.ImgList, System.UITypes, dxGDIPlusClasses;

type
  TfrmGarantiaBaixaRefugo = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    Label1: TLabel;
    Label3: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    chkNaoEnv: TCheckBox;
    imgNaoEnv: TImage;
    Label2: TLabel;
    imgRefugo: TImage;
    Label4: TLabel;
    btnAbreDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure cdsConsultaAfterRefresh(DataSet: TDataSet);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnAbreDadosClick(Sender: TObject);
  private
    blnGerarTE : Boolean;
    strCodCli  : String;


    arrMarca : TConsultasArray;
    arrForne : TConsultasArray;

    //Variaveis para gravação do Pedido de Venda Refugo;
    strAutIncPedDet,
    strAutIncPed,
    strNumPedVen : String;

    function fAbreProgresso(cxProgressBar: TcxProgressBar): Boolean;
    function fIncluiItens(fatVenda: TFatVenda): Boolean;
    procedure pCarregarCliente(fatVenda: TFatVenda);
    function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    function fGravaDocumentoSaida(var strAutIncP, strNumDocP, strEspDocP : String): Boolean;
    procedure pAbreComProgresso;
    function fGravaDocumentos: Boolean;
    procedure pMarcaReprocessamentoDeSaldo(strAutoincrem: String);
    function fGFatDor: Boolean;
    function fGFatGor: Boolean;
    procedure pBaixaFatDor(strSeqFdo, strNumFat, strEspFat: String);
    procedure pSetEnabled;
  public
  protected
     function fGetSql(blnLike: Boolean): String; override;
     function fSetParametros: Boolean; override;
     procedure pAddListaQuery; Override;
     function fValidaCampos(Sender : TWinControl; blnBuscaPorChave: Boolean) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untGravando, untFuncoesSimples, untDigCliente, untFuncFatTypes, untFuncoes,
  untFatTipoFaturamento, untFatDadosFiscais, untObsGarantia, untFatGor,
  untGarant, untFuncoesConsulta, untConsultas;

{ TfrmGarantiaBaixaRefugo }
function TfrmGarantiaBaixaRefugo.fGetSql(blnLike: Boolean): String;
  Var
    blnFilEmp : Boolean;
begin
  Result := '';
  Result := Result + ' SELECT DISTINCT "BX_REFUG" AS OPERAC,                          ';
  Result := Result + '        GAD_CODITE,                                    ';
  Result := Result + '        ITE_DESITE,                                    ';
  Result := Result + '        ITE_REFERE,                                    ';
  Result := Result + '        ITE_CODMAR,                                    ';
  Result := Result + '        ITE_CODFAB,                                    ';
  Result := Result + '        ITE_CODUNI,                                    ';
  Result := Result + '        UNI_SIGUNI,                                    ';
  Result := Result + '        GAU_QTDREF,                                    ';
  Result := Result + '        GAU_SEQGAD,                                    ';
  Result := Result + '        GAD_NUMDOC,                                    ';
  Result := Result + '        GAD_CODEMP,                                    ';
  Result := Result + '        FOR_CODFOR,                                    ';
  Result := Result + '        FOR_NOMFOR,                                    ';
  Result := Result + '        CLI_CODCLI,                                    ';
  Result := Result + '        CLI_NOMCLI,                                    ';
  Result := Result + '        CONCAT(GAD_NUMDOC," - ",GAD_CODEMP) AS NUMDOC, ';
  Result := Result + '        CONCAT(FOR_CODFOR," - ",FOR_NOMFOR) AS CODFOR, ';
  Result := Result + '        CONCAT(CLI_CODCLI," - ",CLI_NOMCLI) AS CODCLI, ';
  Result := Result + '        GAU_AIBXRF,                                    ';
  Result := Result + '        SEQ_FDOREF,                                    ';
  Result := Result + '        MOVGAU.AUTOINCREM                              ';
  Result := Result + ' FROM MOVGAU                                           ';
  Result := Result + '   INNER JOIN MOVGAD ON MOVGAD.AUTOINCREM = GAU_SEQGAD ';
  Result := Result + '   LEFT  JOIN SEQGAR ON MOVGAD.AUTOINCREM = SEQ_MOVGAD ';
  Result := Result + '   INNER JOIN MOVGAG ON MOVGAG.AUTOINCREM = GAD_SEQGAG ';
  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = GAD_CODFOR        ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = GAG_CODCLI        ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = GAD_CODITE        ';
  Result := Result + '   INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI        ';

  If fCfgSis('GARMAT', varBoolean) Then
  Begin
    Result := Result + 'WHERE (( GAU_AIBXRF IS NULL AND SEQ_PCDREF IS NULL AND SEQ_FDOREF IS NULL  )           ';
    Result := Result + '    OR ( ((SELECT PCD_BAIXAD FROM PCMDET WHERE AUTOINCREM = SEQ_PCDREF) = 1) AND       ';
    Result := Result + '         ((SELECT FDO_JAFATU FROM FATDOR WHERE AUTOINCREM = SEQ_FDOREF) = 0) AND       ';
    Result := Result + '         ((SELECT FDO_CODEMP FROM FATDOR WHERE AUTOINCREM = SEQ_FDOREF) = :CODEMP) ) ) ';
  End
  Else
  Begin
    Result := Result + 'WHERE GAG_CODEMP = :CODEMP ';
    Result := Result + '  AND GAU_AIBXRF IS NULL   ';
  End;
  Result := Result + '  AND MOVGAG.GAG_GARIND <> "S" ';
  //NÃO PODE TER ENDEREÇAMENTO EM ABERTO PARA A ENTRADA QUE GEROU O REFUGO, SO LIBERA A EMISSAO DEPOIS DO ENDEREÇAMENTO
  Result := Result + '  AND IFNULL(( ';
  Result := Result + '       SELECT COUNT(0) ';
  Result := Result + '       FROM MOVDET     ';
  Result := Result + '         INNER JOIN EXTGOR ON FGO_DOCEND = CONCAT(DET_NUMDOC, DET_ESPDOC, LEFT(CONCAT(DET_SERIE_,"   "),3), DET_CODEMP, DET_CODFOR, "F") ';
  Result := Result + '         INNER JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO ';
  Result := Result + '       WHERE MOVDET.AUTOINCREM = GAU_SEQDET AND FDO_CODITE = GAD_CODITE),0) = 0 ';

  Result := Result + ' AND GAU_QTDREF > 0 ';
  Result := Result + fStrLocate(edtCodFor, arrForne, 'GAD_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodMar, arrMarca, 'ITE_CODMAR', 'CODMAR');

  If chkNaoEnv.Checked Then
  Begin

    If (fCfgSis('GARMAT', varBoolean)) then
      blnFilEmp := (VS_strCodEmp <> fCfgSis('EMPGAR', varString))
    Else
      blnFilEmp := True;

    Result := Result + ' UNION ALL ';
    Result := Result + ' SELECT "BX_ENVIO" AS OPERAC,                          ';
    Result := Result + '        GAD_CODITE,                                    ';
    Result := Result + '        ITE_DESITE,                                    ';
    Result := Result + '        ITE_REFERE,                                    ';
    Result := Result + '        ITE_CODMAR,                                    ';
    Result := Result + '        ITE_CODFAB,                                    ';
    Result := Result + '        ITE_CODUNI,                                    ';
    Result := Result + '        UNI_SIGUNI,                                    ';
    Result := Result + '        GAD_QTDREQ,                                    ';
    Result := Result + '        D.AUTOINCREM,                                  ';
    Result := Result + '        GAD_NUMDOC,                                    ';
    Result := Result + '        GAD_CODEMP,                                    ';
    Result := Result + '        FOR_CODFOR,                                    ';
    Result := Result + '        FOR_NOMFOR,                                    ';
    Result := Result + '        CLI_CODCLI,                                    ';
    Result := Result + '        CLI_NOMCLI,                                    ';
    Result := Result + '        CONCAT(GAD_NUMDOC," - ",GAD_CODEMP) AS NUMDOC, ';
    Result := Result + '        CONCAT(FOR_CODFOR," - ",FOR_NOMFOR) AS CODFOR, ';
    Result := Result + '        CONCAT(CLI_CODCLI," - ",CLI_NOMCLI) AS CODCLI, ';
    Result := Result + '        NULL,                                          ';
    Result := Result + '        NULL,                                          ';
    Result := Result + '        D.AUTOINCREM                                   ';
    Result := Result + ' FROM MOVGAG G                                         ';
    Result := Result + '   INNER JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM  ';
    Result := Result + '   INNER JOIN CADITE I ON D.GAD_CODITE = I.ITE_CODITE  ';
    Result := Result + '   INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI  ';
    Result := Result + '   INNER JOIN CADFOR F ON F.FOR_CODFOR = D.GAD_CODFOR  ';
    Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = GAG_CODCLI        ';
    Result := Result + ' WHERE TRUE ';
    Result := Result + '  AND G.GAG_GARIND <> "S" ';
    Result := Result + fStrLocate(edtCodFor, arrForne, 'GAD_CODFOR', 'CODFOR');
    Result := Result + fStrLocate(edtCodMar, arrMarca, 'ITE_CODMAR', 'CODMAR');

    If blnFilEmp Then
      Result := Result + '  AND G.GAG_CODEMP = :CODEMP '
    Else
    Begin
      Result := Result + ' AND LOCATE(G.GAG_CODEMP, ( SELECT GROUP_CONCAT(SIS_CODEMP SEPARATOR "_") ';
      Result := Result + '                            FROM CFGSIS                                   ';
      Result := Result + '                            WHERE SIS_CODCFG = "CFG_GARMAT"               ';
      Result := Result + '                            AND SIS_VALCFG = "S")) > 0                    ';
    End;

    Result := Result + '  AND ABS(GAD_QTDRET + GAD_QTDREF) < GAD_QTDREQ ';


    Result := Result + '  AND ((SELECT COUNT(1) FROM MOVGAE ';
    Result := Result + '         WHERE GAE_SEQGAD = D.AUTOINCREM ';
    Result := Result + '         AND MOVGAE.AUTOINCREM IN (SELECT GAU_SEQGAE FROM MOVGAU ';
    Result := Result + '                                    WHERE GAU_SEQGAE = MOVGAE.AUTOINCREM ';
    Result := Result + '                                      AND GAU_QTDREF > 0)) > 0 ';
    Result := Result + '   OR ((SELECT COUNT(1) FROM MOVGAE  ';
    Result := Result + '         WHERE GAE_SEQGAD = D.AUTOINCREM) = 0)) ';

    If fUsaRotinaGarantiaItensPesados Then
      Result := Result + '  AND D.GAD_GARFIL = "S" '
    Else
      Result := Result + '  AND D.GAD_GARFIL = "N" ';

  End;

end;

procedure TfrmGarantiaBaixaRefugo.btnAbreDadosClick(Sender: TObject);
begin
  inherited;
  pAbreComProgresso;
end;

procedure TfrmGarantiaBaixaRefugo.btnConfirmaClick(Sender: TObject);
Begin
  If fGravaDocumentos Then
  Begin
    pMensagemOk('Operação realizada com sucesso!');
    pAbreComProgresso;
  End;
End;

function TfrmGarantiaBaixaRefugo.fGravaDocumentos : Boolean;
  Var
    qryMovGau : TUniQuery;
    qryMovGad : TUniQuery;
    qryMovGad2: TUniQuery;
    strAutIncGer : String;
    strNumDocGer : String;
    strEspDocGer : String;

begin
  inherited;
  Result := fGravaDocumentoSaida(strAutIncGer, strNumDocGer, strEspDocGer);

  If Result Then
  Begin
    Try
      qryMovGau := fCriaQuery;
      qryMovGad := fCriaQuery;
      qryMovGad2:= fCriaQuery;
      Try
        With qryMovGau, SQL Do
        Begin
          Close;
          Clear;
          Add(' UPDATE MOVGAU SET GAU_AIBXRF = :AIBXRF ');
          Add(' WHERE AUTOINCREM = :AUTINC             ');
        End;

        With qryMovGad, SQL Do
        Begin
          Close;
          Clear;
          Add(' UPDATE MOVGAD SET GAD_REFBAI = GAD_REFBAI + :QTDBAI ');
          Add(' WHERE AUTOINCREM = :AUTINC                          ');
        End;

        With qryMovGad2, SQL Do
        Begin
          Add(' UPDATE MOVGAD                           ');
          Add('  SET GAD_QTDRET = :QTDRET,              ');
          Add('      GAD_MOTBAI = :MOTBAI,              ');

          Add('      GAD_NUMENV = :NUMDOC,              ');
          Add('      GAD_ESPENV = :ESPDOC,              ');
          Add('      GAD_DTAENV = ' + fCurrentDate + ',' );

          Add('      GAD_NUMRET = :NUMDOC,              ');
          Add('      GAD_DTARET = ' + fCurrentDate       );

          Add(' WHERE AUTOINCREM = :AUTINC              ');
        End;

        With cdsConsulta Do
        Begin
          DisableControls;
          First;

          While Not Eof Do
          Begin
            If fInLista And (FieldByName('GAU_QTDREF').AsFloat > 0) And
               SameText('BX_REFUG', FieldByName('OPERAC').AsString) Then
            Begin
              If fEmptyStr(FieldByName('GAU_AIBXRF').AsString) Then
              Begin
                qryMovGau.ParamByName('AUTINC').AsString:= FieldByName('AUTOINCREM').AsString;
                qryMovGau.ParamByName('AIBXRF').AsString:= strAutIncGer;
                qryMovGau.ExecSQL;

                qryMovGad.ParamByName('QTDBAI').AsFloat := FieldByName('GAU_QTDREF').AsFloat;
                qryMovGad.ParamByName('AUTINC').AsString:= FieldByName('GAU_SEQGAD').AsString;
                qryMovGad.ExecSQL;
              End
              Else
                pBaixaFatDor(FieldByName('SEQ_FDOREF').AsString, strNumDocGer, strEspDocGer);
            End
            //Baixa Envio e Rotorno do Fornecedor Finalizando a Garantia.
            Else
            If fInLista And (FieldByName('GAU_QTDREF').AsFloat > 0) And
               SameText('BX_ENVIO', FieldByName('OPERAC').AsString) Then
            Begin
              qryMovGad2.ParamByName('QTDRET').AsFloat  := FieldByName('GAU_QTDREF').AsFloat;
              qryMovGad2.ParamByName('MOTBAI').AsString := 'Emissão de Perda/Transferência de Produtos Refugados';
              qryMovGad2.ParamByName('AUTINC').AsString := FieldByName('GAU_SEQGAD').AsString;

              qryMovGad2.ParamByName('NUMDOC').AsString := strNumDocGer;
              qryMovGad2.ParamByName('ESPDOC').AsString := strEspDocGer;

              qryMovGad2.ExecSQL;

            End;
            pMarcaReprocessamentoDeSaldo(FieldByName('GAU_SEQGAD').AsString);

            Next;
          End;

          EnableControls;

        End;



        If blnGerarTE And Result Then
          Result := fGFatGor And fGFatDor;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.message, 'TfrmGarantiaBaixaRefugo.fGravaDocumentos');
          Result := False;
        End;
      End;
    Finally
      FreeAndNil(qryMovGau);
      FreeAndNil(qryMovGad);
      FreeAndNil(qryMovGad2);
    End;

  End;

end;


function TfrmGarantiaBaixaRefugo.fGravaDocumentoSaida(var strAutIncP, strNumDocP, strEspDocP : String) : Boolean;
  var
    fatVenda   : TFatVenda;
begin
  inherited;
  strCodCli := '';
  Try
    pCriarFormularios(TfrmDigCliente, frmDigCliente);
    Result :=	frmDigCliente.ShowModal = MrOK;
    If Result Then
      strCodCli := frmDigCliente.edtCodCli.Text;
  Finally
    FreeAndNil(frmDigCliente);
  End;

  If Not fCfgSis('GARMAT', varBoolean) Then
  begin
    If fClienteFilial(strCodCli) Then
    begin
      If fRetCodEmpClienteFilial(strCodCli) <> VS_strCodEmp Then
      Begin
        If fPergunta('O Cliente filial informado deve ser o da propria loja logada, deseja Trocar?') Then
          strCodCli := fRetornaClienteFilial(VS_strCodEmp)
        Else
          Result := False;
      End;
    end;
  end;

  if Not Result then
    Exit(False);

  //Caso Escolher um cliente filial, nao pode marcar registro onde ja esta feito envio para filial
  If not ((fRetCodEmpClienteFilial(strCodCli) = VS_strCodEmp) Or (fRetCodEmpClienteFilial(strCodCli) = '')) Then
  Begin
    With cdsConsulta Do
    Begin
      Try
        DisableControls;
        First;
        While Not Eof Do
        Begin
          If not fEmptyStr(FieldByName('SEQ_FDOREF').AsString) Then
          Begin
            fMensagem('', 'Existe(m) documento(s) de retorno da matriz, esse tipo de documento não pode ser enviado a outra loja!' + #13 +
                          'Efetue a baixa para a empresa logada ou para o cliente!', ['&Ok']);
            Result := False;
            Break;
          End;
          Next;
        End;

      Finally
        First;
        EnableControls;
      End;
    End;
  End;

  If Not Result Then
    Exit;

  Try
    pCriarCdsVenda(Self);
    cdsVenda.EmptyDataSet;

    fatVenda                := TFatVenda.CreateInstance('VN');
    fatVenda.blnBaixaRefugo := true;
    fatVenda.strOpcDocTrue  := 'OU';
    fatVenda.blnVerEstOrc   := False;
    fatVenda.strNomeForm    := 'frmFatVendas';
    fatVenda.strMen001 := 'GARANTIA(TE)';
    fatVenda.strMen002 := '';
    fatVenda.strOpcDoc := 'OU';
    fatVenda.strOriDoc := 'V';
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
    fatVenda.strConPag := '01000';
    //fatVenda.strCodForTe := edtCodFor.Text;

    pCarregarCliente(fatVenda);

    Result := fIncluiItens(fatVenda) And
              fGetTipoFaturamento(fatVenda);

    If (Result) Then
    Begin
      fatVenda.pCarregaAliquotasRetencao;

      fatVenda.pPreencheMatrizFechamento;

      fatVenda.pCalculaPesBruLiq;

      fatVenda.pCalculaTotGer(False, False);

      If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
          fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
      End;

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.pCalculaTotGer;

      blnGerarTE := False;
      If (fRetCodEmpClienteFilial(strCodCli) = VS_strCodEmp) Or (fRetCodEmpClienteFilial(strCodCli) = '') Then
      Begin
        fatVenda.strClaFis := '5' + fCfgSis('CLAREF', varString);
        If (fRetCodEmpClienteFilial(strCodCli) = VS_strCodEmp) Then
          fatVenda.strOpcDoc := 'TE';
      End
      Else
      Begin
        blnGerarTE := True;
        fatVenda.strOpcDoc := 'TE';
        fatVenda.blnCliFil := True;
        fatVenda.blnPedGarTEEnvioRefugo := True;
        fatVenda.pAtualizaClassTransferencias;
        fatVenda.strTEPREV := fGetTEPREV(fRetCodEmpClienteFilial(strCodCli), strCodCli);
      End;

      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      fatVenda.pCalculaTotalParaCadRec;

      fatVenda.pRateiaValores;

      If (fatVenda.strEspDoc = 'NF') Then
      Begin
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
          frmFatDadosFiscais.blnForcaEdiBas    := True;
          frmFatDadosFiscais.fatVenda := fatVenda;

          frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
          frmFatDadosFiscais.blnPodeCancelar := True;
          frmFatDadosFiscais.fraDadosFechamentoVendaMSGFatFrame.edtMens01.Enabled := False; //A observação 1 tem que ser fixa para baixar o Pedido de Compra e preencher o campo PCD_DOCEMI ao fazer a entrada na filial;
          frmFatDadosFiscais.blnBaixaRefugo := True;
          frmFatDadosFiscais.ShowModal;

          Result := frmFatDadosFiscais.blnConfirma;

        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;

        pFreeAndNil(frmFatDadosFiscais);
      End
      Else
      Begin
        Try
          pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
          frmObsGarantia.ShowModal;

          Result := frmObsGarantia.ModalResult = mrOk;

          If Result Then
          Begin
            fatVenda.strMen002 := frmObsGarantia.edtObs1.Text;
            fatVenda.strMen003 := frmObsGarantia.edtObs2.Text;
          End
          else
          Begin
            fatVenda.strMen002 := '';
            fatVenda.strMen003 := '';
          End;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;

        pFreeAndNil(frmObsGarantia);
      End;

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.strChave            := 'FATFATURA';
        frmGravando.fExecutarAcao       := fatVenda.fGravaArquivos;
        frmGravando.lblGravando.Caption := 'Aguarde, Gravando Retorno...';
        frmGravando.ShowModal;
        Result                          := frmGravando.blnConfirma;
        If Result Then
        Begin
          strAutIncP := fatVenda.strAutInc;
          strNumDocP := fatVenda.strNumDoc;
          strEspDocP := fatVenda.strEspDoc;
        End;
        pFreeAndNil(frmGravando);

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
          pFreeAndNil(frmGravando);
        End;
      End;

    End;

  Finally
    FreeAndNil(fatVenda);
  End;

end;

procedure TfrmGarantiaBaixaRefugo.pCarregarCliente(fatVenda : TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(strCodCli);
  fatVenda.strCodVen := strLoginUsuarioLogado;
end;

procedure TfrmGarantiaBaixaRefugo.pMarcaReprocessamentoDeSaldo(strAutoincrem: String);
var qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Add('UPDATE ITEGER ');
    qryUpdate.SQL.Add('INNER JOIN MOVGAD ON MOVGAD.GAD_CODITE = ITEGER.ITE_CODITE AND MOVGAD.GAD_CODEMP = ITEGER.ITE_CODEMP ');
    qryUpdate.SQL.Add('SET ITE_REPAUD = "S" ');
    qryUpdate.SQL.Add('WHERE MOVGAD.AUTOINCREM = "' + strAutoincrem + '"');
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End
end;

procedure TfrmGarantiaBaixaRefugo.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  With cdsConsulta Do
  Begin
    Try
      DisableControls;
      First;
      While Not Eof Do
      Begin
        Case TBitBtnLocked(Sender).Tag Of
          0 : Begin
                If Not fInLista Then
                  pAddListaQuery;
              End;

          1 : Begin
                If fInLista Then
                  pAddListaQuery;
              End;
        End;

        Next;
      End;
    Finally
      First;
      EnableControls;
    End;
  End;
end;

procedure TfrmGarantiaBaixaRefugo.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pSetEnabled;
end;

procedure TfrmGarantiaBaixaRefugo.cdsConsultaAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  pSetEnabled;
end;

procedure TfrmGarantiaBaixaRefugo.dbgConsultaDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If SameText(Column.Field.FieldName, 'OPERAC') Then
  Begin
    If SameText(TDBGrid(Sender).DataSource.DataSet.FieldByName('OPERAC').AsString, 'BX_ENVIO') Then
    Begin
      TDBGridCitel(Sender).Canvas.FillRect(Rect);
      TDBGridCitel(Sender).Canvas.Draw(Rect.Left+1, Rect.Top+1, imgNaoEnv.Picture.Graphic);
    End
    Else
    Begin
      TDBGridCitel(Sender).Canvas.FillRect(Rect);
      TDBGridCitel(Sender).Canvas.Draw(Rect.Left+1, Rect.Top+1, imgRefugo.Picture.Graphic);
      //TDBGridCitel(Sender).Canvas.Font.Color := TDBGridCitel(Sender).Canvas.Brush.Color;
      //TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;

end;

procedure TfrmGarantiaBaixaRefugo.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrForne, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmGarantiaBaixaRefugo.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrForne, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGarantiaBaixaRefugo.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomeMarca, nil, 'da marca');
end;

procedure TfrmGarantiaBaixaRefugo.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmGarantiaBaixaRefugo.fAbreProgresso(cxProgressBar : TcxProgressBar):Boolean;
Begin
  Result := fAbreConsulta;
End;

procedure TfrmGarantiaBaixaRefugo.FormCreate(Sender: TObject);
begin
  inherited;
  lflLastField.intIndCol := 3;
  lflLastField.ftyTipCam := ftString;
  lflLastField.strNomCam := 'ITE_DESITE';
end;

procedure TfrmGarantiaBaixaRefugo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Shift = [] Then
    Case Key Of
      VK_F6 : btnMarcarTodos.Click;
      VK_F7 : btnDesmarcarTodos.Click;
    End;
end;

function TfrmGarantiaBaixaRefugo.fSetParametros: Boolean;
  Var
    strForne : String;
begin
  Result := Inherited;
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  pSetaParam(edtCodFor.Text, arrForne, strForne, 'CODFOR', qryConsulta);
  pSetaParam(edtCodMar.Text, arrMarca, strForne, 'CODMAR', qryConsulta);

end;

function TfrmGarantiaBaixaRefugo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrForne);
    End
    Else
    If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmGarantiaBaixaRefugo.pAbreComProgresso;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAbreProgresso;
    frmGravando.pgbStatus.Visible := False;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;

procedure TfrmGarantiaBaixaRefugo.pAddListaQuery;
begin
  inherited;
  pSetEnabled;
end;

procedure TfrmGarantiaBaixaRefugo.pSetEnabled;
Begin
  btnConfirma.Enabled := (stlListSelecao.Count > 0) And (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0);
End;

function TfrmGarantiaBaixaRefugo.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strIteDes   : String;
    fltPreEnv   : Double;
    cdsGroup    : TUniClientDataSet;
Begin
  Try
    qryGenIte := fCriaQuery;
    cdsGroup  := TUniClientDataSet.Create(Self);
    cdsGroup.FieldDefs := cdsConsulta.FieldDefs;
    cdsGroup.CreateDataSet;
    cdsGroup.EmptyDataSet;

    With cdsConsulta Do
    Begin
      DisableControls;
      First;

      cdsGroup.Close;
      cdsGroup.Open;

      While Not Eof Do
      Begin
        If fInLista And (FieldByName('GAU_QTDREF').AsFloat > 0) Then
        Begin
          If Not cdsGroup.Locate('GAD_CODITE', FieldByName('GAD_CODITE').AsString, []) Then
          Begin
            cdsGroup.Insert;
            cdsGroup.FieldByName('GAD_CODITE').AsString := FieldByName('GAD_CODITE').AsString;
            cdsGroup.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
            cdsGroup.FieldByName('ITE_REFERE').AsString := FieldByName('ITE_REFERE').AsString;
            cdsGroup.FieldByName('ITE_CODFAB').AsString := FieldByName('ITE_CODFAB').AsString;
            cdsGroup.FieldByName('UNI_SIGUNI').AsString := FieldByName('UNI_SIGUNI').AsString;
            cdsGroup.FieldByName('GAU_SEQGAD').AsString := FieldByName('GAU_SEQGAD').AsString;
            cdsGroup.FieldByName('GAU_QTDREF').AsFloat  := FieldByName('GAU_QTDREF').AsFloat;
            cdsGroup.FieldByName('GAU_QTDREF').AsFloat  := FieldByName('GAU_QTDREF').AsFloat;
            cdsGroup.Post;
          End
          Else
          Begin
            cdsGroup.Edit;
            cdsGroup.FieldByName('GAU_QTDREF').AsFloat  := cdsGroup.FieldByName('GAU_QTDREF').AsFloat +
                                                           FieldByName('GAU_QTDREF').AsFloat;
            cdsGroup.Post;
          End;
        End;

        Next;
      End;

      EnableControls;
    End;

    With cdsGroup Do
    Begin
      DisableControls;

      fatVenda.fltDesEsp := 0;

      intContador := 0;
      First;

      While Not Eof Do
      Begin


        inc(intContador);

        If (intContador = 1) Then
        Begin
          fatVenda.strCodVen    := strLoginUsuarioLogado;
          fatVenda.strNomVen    := fRetNomVendRep(fatVenda.strCodVen);
        End;

        fGetItem(qryGenIte,FieldByName('GAD_CODITE').AsString);

        strIteDes := FieldByName('ITE_DESITE').AsString;
        If (fCfgSis('IMPREF', varBoolean)) Then
          If (fCfgSis('MONDES', varString) = '1') Then
            strIteDes := FieldByName('ITE_DESITE').AsString +
                         IIF(Not fEmptyStr(FieldByName('ITE_REFERE').AsString),' ' + FieldByName('ITE_REFERE').AsString, '') +
                         IIF(Not fEmptyStr(FieldByName('ITE_CODFAB').AsString),' ' + FieldByName('ITE_CODFAB').AsString, '')
          Else
            strIteDes := IIF(Not fEmptyStr(FieldByName('ITE_CODFAB').AsString),FieldByName('ITE_CODFAB').AsString + ' ', '') +
                         IIF(Not fEmptyStr(FieldByName('ITE_REFERE').AsString),FieldByName('ITE_REFERE').AsString + ' ', '') +
                         FieldByName('ITE_DESITE').AsString;

        fltPreEnv := qryGenIte.FieldByName('ITE_PRECUS').AsFloat;

        fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                             Nil,
                                             'NOR',
                                             qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                             FieldByName('GAD_CODITE').AsString,
                                             qryGenIte.FieldByName('ITE_DESITE').AsString,
                                             strIteDes,
                                             qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                             qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                             qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                             qryGenIte.FieldByName('ITE_CODMAR').AsString,
                                             qryGenIte.FieldByName('ITE_CODFOR').AsString,
                                             qryGenIte.FieldByName('ITE_REFERE').AsString,
                                             fltPreEnv, // fltUniOri
                                             fltPreEnv, // fltUniVis
                                             fltPreEnv, // fltUniTar
                                             0.0,
                                             0.0,
                                             FieldByName('GAU_QTDREF').AsFloat,
                                             fltPreEnv*FieldByName('GAU_QTDREF').AsFloat, // fltTotIte
                                             'S',
                                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat, // fltPreCus
                                             fFormataFloat(qryGenIte.FieldByName('ITE_PRECUS').AsFloat * FieldByName('GAU_QTDREF').AsFloat, 2), // fltTotCus
                                             qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                             qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                             0.0,
                                             qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                             'N',
                                             qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                             qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                             qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('GAU_QTDREF').AsFloat,
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                             qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             '',
                                             0,
                                             0,
                                             0.00,
                                             0.00,
                                             0.00,
                                             'N',
                                             '',
                                             0,
                                             0,
                                             qryGenIte.FieldByName('ABF_CODABF').AsString,
                                             qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                             'N',
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                             qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                             -1,
                                             0,
                                             '',
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                             fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             0,
                                             '',
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                             fltPreEnv, // fltUniDig
                                             qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                             '',
                                             '',
                                             fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                             0.00,
                                             intContador,
                                             '',
                                             '',
                                             '',
                                             False,
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             '1',
                                             qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                             qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                             '',
                                             0.0,
                                             '',
                                             0.0,
                                             'R',
                                             '',
                                             'N',
                                             '',
                                             0,
                                             FieldByName('GAU_QTDREF').AsFloat,
                                             0.0,
                                             0,
                                             qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                             '',
                                             0.00,
                                             0.00,
                                             0.00,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             recForTin,
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_NUMLOT').AsString,
                                             '',
                                             '',
                                             False,
                                             'N',
                                             'NOR',
                                             0,
                                             '',
                                             qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             1,
                                             True,
                                             '',
                                             '',
                                             '',
                                             0,
                                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat, // fltCusIte
                                             '',
                                             '',
                                             recMadeira,
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('GAU_QTDREF').AsFloat,
                                             0,
                                             0,
                                             FieldByName('GAU_SEQGAD').AsString,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             '',
                                             'N',
                                             0,
                                             0,
                                             0,
                                             False,
                                             False,
                                             'N',
                                             '',
                                             0,
                                             0,
                                             '',
                                             'N',
                                             0,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0.00,
                                             '',
                                             '',
                                             '',
                                             'S',
                                             'N',
                                             '',
                                             '',
                                             '',
                                             '',
                                             False,
                                             -1,
                                             -1,
                                             'N',
                                             '',
                                             'N',
                                             0,
                                             0,
                                             0,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             False,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             'N',
                                             'N',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

        Next;

      End;

      EnableControls;
    End;

    Result := TRUE;

    FreeAndNil(qryGenIte);
    FreeAndNil(cdsGroup);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmGarantiaBaixaRefugo.fIncluiItens]');
    End;

  End;

end;

function TfrmGarantiaBaixaRefugo.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODFOR, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  U.UNI_CODUNI, ';
    strSQL := strSQL + '  U.UNI_DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';

    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06, ';
    strSQL := strSQL + '  G.ITE_PREDOL, ';

    strSQL := strSQL + '  IFNULL(  '+
                          ' (SELECT LOT_NUMLOT FROM CADLOT '+
                          '        WHERE '+
                          '            LOT_GARPRI = "S" '+
                          '        AND LOT_STATUS = "S" '+
                          '        AND LOT_CODITE = :CODITE '+
                          '        AND LOT_CODEMP = :CODEMP '+
                          ' ),"") AS ITE_NUMLOT, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmGarantiaBaixaRefugo.fGetItem]');
    End;

  End;

end;

function TfrmGarantiaBaixaRefugo.fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  arrOpcoes[1].strDesCri := 'Faturamento Futuro';
  arrOpcoes[1].strEspDoc := 'FF';
  arrOpcoes[1].strOpcLet := 'F';
  arrOpcoes[1].strMosMen := 'N';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmGarantiaEnvFornecedor.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

Function TfrmGarantiaBaixaRefugo.fGFatGor : Boolean;
  Var
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  strNumPedVen := fRetSequencialPedido(fRetCodEmpClienteFilial(strCodCli));
  Result := fGravaFatGor(strAutIncPed,
                         fRetCodEmpClienteFilial(strCodCli),
                         strNumPedVen,
                         'PD',
                         strCodCli,
                         strLoginUsuarioLogado,
                         '',
                         '',
                         VS_Date,
                         fTime(),
                         '01000',
                         fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCli)) ,1),
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         arrDuplic,
                         '',
                         '',
                         'GARANTIA',
                         'DEVOLUÇÃO - REFUGO REFERENTE A GARANTIA',
                         False,
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         0.0,
                         0,
                         strLoginUsuarioLogado,
                         '',
                         '',
                         recServicos,
                         '',
                         0,
                         0,
                         0,
                         '',
                         '',
                         '',
                         0,
                         '',
                         0,
                         '1',
                         '',
                         0,
                         '',
                         '',
                         False,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         False,
                         VS_Date,
                         'N',
                         'V',
                         VS_Date,
                         '',
                         0,
                         '',
                         '',
                         '',
                         False,
                         '',
                         Nil,
                         '',
                         '',
                         0,
                         0,
                         0,
                         '',
                         Nil,
                         '',
                         0,
                         0,
                         '',
                         '',
                         0,
                         '',
                         0,
                         '',
                         '0',
                         'N',
                         'N');

End;

Function TfrmGarantiaBaixaRefugo.fGFatDor : Boolean;
  var
    objGarant: TMovGag;
begin
  Result := True;

  Try
    objGarant := TMovGag.Create(Nil);
    cdsConsulta.DisableControls;
    Try
      With cdsConsulta Do
      Begin
        First;
        While Result And (Not Eof) Do
        Begin
          If fInLista Then
          Begin
            strAutIncPedDet := '';
            Result := fGravaFatDor(strAutIncPedDet,
                                   strAutIncPed,
                                   fRetCodEmpClienteFilial(strCodCli),
                                   strCodCli,
                                   strLoginUsuarioLogado,
                                   FieldByName('GAD_CODITE').AsString,
                                   FieldByName('ITE_CODMAR').AsString,
                                   '',
                                   strNumPedVen,
                                   'PD',
                                   '',
                                   VS_Date,
                                   fTime(),
                                   '01000',
                                   '',
                                   FieldByName('ITE_DESITE').AsString,
                                   FieldByName('ITE_REFERE').AsString,
                                   FieldByName('ITE_CODUNI').AsString,
                                   fRetFornecedorItem(FieldByName('GAD_CODITE').AsString),
                                   FieldByName('GAU_QTDREF').AsFloat,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   fRetCodRepresCliente(strCodCli),
                                   '',
                                   0,
                                   0,
                                   0,
                                   '5999',
                                   '',
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   False,
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0.0,
                                   'NOR',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   0,
                                   0,
                                   '',
                                   0,
                                   0,
                                   0,
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0.0,
                                   0,
                                   0,
                                   0,
                                   '',
                                   0,
                                   '',
                                   '',
                                   False,
                                   '1',
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   0,
                                   '',
                                   '',
                                   'N',
                                   '',
                                   0,
                                   0,
                                   0,
                                   0,
                                   '',
                                   '',
                                   '',
                                   False,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   0,
                                   0,
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0,
                                   0,
                                   0);

            If (Result) Then
                Result := objGarant.objMovGad.fAtualizaSeqGarantia('SEQ_FDOREF', strAutIncPedDet, 'SEQ_MOVGAD', FieldByName('GAU_SEQGAD').AsString);
          End;
          Next;
        End;

      End;
    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmGarantiaBaixaRefugo.fGFatDor');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(objGarant);
    cdsConsulta.EnableControls;
  End;

End;

procedure TfrmGarantiaBaixaRefugo.pBaixaFatDor(strSeqFdo, strNumFat, strEspFat : String);

  Procedure pBaixaPedidoSeNecessario;
  Var
    qryPed: TUniQuery;
    strNumDoc,
    strEspDoc,
    strCodEmp: String;
  Begin
    Try
      qryPed := fCriaQuery(Nil);
      With qryPed, SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT FDO_NUMDOC,         ');
        Add('        FDO_ESPDOC,         ');
        Add('        FDO_CODEMP          ');
        Add(' FROM FATDOR                ');
        Add(' WHERE AUTOINCREM = :AUTINC ');

        ParamByName('AUTINC').AsString := strSeqFdo;

        Open;

        strNumDoc := FieldByName('FDO_NUMDOC').AsString;
        strEspDoc := FieldByName('FDO_ESPDOC').AsString;
        strCodEmp := FieldByName('FDO_CODEMP').AsString;

        Close;
        SQL.Clear;
        SQL.Add(' SELECT FDO_NUMDOC          ');
        SQL.Add(' FROM FATDOR                ');
        SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC ');
        SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
        SQL.Add('   AND FDO_CODEMP = :CODEMP ');
        SQL.Add('   AND FDO_JAFATU <> 1      ');

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If IsEmpty Then
        Begin
          Close;
          Clear;

          Add(' UPDATE FATGOR SET FGO_JAFATU = 1,       ');
          Add('                   FGO_NUMFAT = :NUMFAT, ');
          Add('                   FGO_TIPFAT = :TIPFAT, ');
          Add('                   FGO_EMPFAT = :EMPFAT  ');
          Add(' WHERE FGO_NUMDOC = :NUMDOC              ');
          Add('   AND FGO_ESPDOC = :ESPDOC              ');
          Add('   AND FGO_CODEMP = :CODEMP              ');

          ParamByName('NUMFAT').AsString := strNumFat;
          ParamByName('TIPFAT').AsString := strEspFat;
          ParamByName('EMPFAT').AsString := VS_strCodEmp;
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;
          ExecSQL;
        End;

      End;

    Finally
      FreeAndNil(qryPed);
    End;

  End;

  Var
    qryFatDor : TUniQuery;

Begin
  Try
    qryFatDor := fCriaQuery;
    With qryFatDor, SQL Do
    Begin
      Add('UPDATE FATDOR SET FDO_JAFATU = 1,       ');
      Add('                  FDO_NUMFAT = :NUMFAT, ');
      Add('                  FDO_TIPFAT = :TIPFAT, ');
      Add('                  FDO_EMPFAT = :EMPFAT  ');
      Add('WHERE AUTOINCREM = :AUTINC              ');

      ParamByName('NUMFAT').AsString := strNumFat;
      ParamByName('TIPFAT').AsString := strEspFat;
      ParamByName('EMPFAT').AsString := VS_strCodEmp;
      ParamByName('AUTINC').AsString := strSeqFdo;

      ExecSQL;
    End;

    pBaixaPedidoSeNecessario;

  Finally
    FreeAndNil(qryFatDor);
  End;

End;

end.
