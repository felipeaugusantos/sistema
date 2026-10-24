unit untOrdProEmiPerdaRefugo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  dxGDIPlusClasses, cxProgressBar, untFuncoesSimples, untFatVendas, untFuncFat,
  untFatTipoFaturamento, untConsultas;

type
  TfrmOrdProEmiPerdaRefugo = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodBar: TEditFocus;
    btnAbreDados: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure btnAbreDadosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure cdsConsultaAfterRefresh(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodBarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    blnGerarTE: Boolean;
    strCodCli  : String;

    function fAbreProgresso(cxProgressBar: TcxProgressBar): Boolean;
    procedure pAbreComProgresso;
    procedure pSetEnabled;
    function fGravaDocumentos: Boolean;
    function fGravaDocumentoSaida(var strAutIncP, strNumDocP, strEspDocP : String): Boolean;
    procedure pCarregarCliente(fatVenda: TFatVenda);
    function fIncluiItens(fatVenda: TFatVenda): Boolean;
    function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fOpBaixada: Boolean;
  public
  protected
     function fGetSql(blnLike: Boolean): String; override;
     function fSetParametros: Boolean; override;
     procedure pAddListaQuery; Override;
     function fValidaCampos(Sender : TWinControl; blnBuscaPorChave: Boolean) : Boolean; Override;
  end;

var
  frmOrdProEmiPerdaRefugo: TfrmOrdProEmiPerdaRefugo;

implementation

{$R *.dfm}

uses untGravando, untDigCliente, untFatDadosFiscais, untFuncFatTypes,
  untTypesSistema, untFuncoes;

{ TfrmOrdProEmiPerdaRefugo }

procedure TfrmOrdProEmiPerdaRefugo.btnAbreDadosClick(Sender: TObject);
begin
  inherited;
  If fOpBaixada Then
    pAbreComProgresso
  Else
  Begin
    pMensagemOk('Esta ordem de produção ainda não foi baixada!');
    pSetFocus(edtCodBar);
  End;
end;

procedure TfrmOrdProEmiPerdaRefugo.pAbreComProgresso;
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

procedure TfrmOrdProEmiPerdaRefugo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fGravaDocumentos Then
  Begin
    pMensagemOk('Operação realizada com scuesso!');
    pAbreComProgresso;
    pDesmarcaTodos;
  End;
end;

function TfrmOrdProEmiPerdaRefugo.fGravaDocumentos: Boolean;
var
  strAutIncGer : String;
  strNumDocGer : String;
  strEspDocGer : String;
  qryUpd: TUniQuery;
begin
  inherited;
  Result := fGravaDocumentoSaida(strAutIncGer, strNumDocGer, strEspDocGer);

  If Result Then
  Begin
    qryUpd := fCriaQuery;
    Try
      With cdsConsulta Do
      Begin
        DisableControls;
        First;

        While Not Eof Do
        Begin
          If fInLista And (FieldByName('ORD_QTDITE').AsFloat > 0) Then
          Begin
            qryUpd.SQL.Clear;
            qryUpd.SQL.Add(' UPDATE RFGORD SET ORD_JAFATU = "S", ORD_SEQGER = :SEQGER WHERE AUTOINCREM = :AUTINC ');
            qryUpd.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
            qryUpd.ParamByName('SEQGER').AsString := strAutIncGer;
            qryUpd.ExecSQL;
          End;

          Next;
        End;

        EnableControls;
      End;
    Finally
      FreeAndNil(qryUpd);
    End;
  End;
end;

procedure TfrmOrdProEmiPerdaRefugo.pCarregarCliente(fatVenda : TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(strCodCli);
  fatVenda.strCodVen := strLoginUsuarioLogado;
end;

function TfrmOrdProEmiPerdaRefugo.fGravaDocumentoSaida(var strAutIncP, strNumDocP, strEspDocP : String): Boolean;
var
  fatVenda   : TFatVenda;
begin
  inherited;
  strCodCli := cdsConsulta.FieldByName('CLI_CODCLI').AsString;

  Try
    fatVenda                := TFatVenda.CreateInstance('VN');
    fatVenda.blnBaixaRefugo := true;
    fatVenda.strOpcDocTrue  := 'OU';
    fatVenda.blnVerEstOrc   := False;
    fatVenda.strNomeForm    := 'frmFatVendas';
    fatVenda.strMen001 := 'REFUGO(OP)';
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
        fatVenda.strClaFis := '5927';
        If (fRetCodEmpClienteFilial(strCodCli) = VS_strCodEmp) Then
          fatVenda.strOpcDoc := 'TE';
      End
      Else
      Begin
        blnGerarTE := True;
        fatVenda.strOpcDoc := 'TE';
        fatVenda.blnCliFil := True;
        fatVenda.blnPedGarTEEnvioRefugo := False;
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
        frmGravando.lblGravando.Caption := 'Aguarde, Gravando refugo...';
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

procedure TfrmOrdProEmiPerdaRefugo.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcaTodos;
end;

procedure TfrmOrdProEmiPerdaRefugo.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos;
end;

procedure TfrmOrdProEmiPerdaRefugo.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pSetEnabled;
end;

procedure TfrmOrdProEmiPerdaRefugo.cdsConsultaAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  pSetEnabled;
end;

procedure TfrmOrdProEmiPerdaRefugo.edtCodBarKeyPress(Sender: TObject;
  var Key: Char);
 Var
    strSQL: String;
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'WHERE PRO_DTABAI IS NOT NULL ';
    strSQL := strSQL + '  AND PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    qryTabela := fCriaQuery;
    Try
      if fPesqOrdemProd(conSimples, Self, Nil, nil, qryTabela, Key, arrSel, strSQL) then
      Begin
        edtCodBar.Text := qryTabela.FieldByName('PRO_CODPRO').AsString;

        If fValidaCampos(edtCodBar, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    Finally
      FreeAndNil(qryTabela);
    End;
  End;
end;

function TfrmOrdProEmiPerdaRefugo.fAbreProgresso(cxProgressBar : TcxProgressBar):Boolean;
Begin
  Result := fAbreConsulta;
  If Not fEmptyStr(edtCodBar.Text) Then
  Begin
    cdsConsulta.Filter := 'PRO_CODPRO = ' + QuotedStr(edtCodBar.Text);
    cdsConsulta.Filtered := True;
  End
  Else
  Begin
    cdsConsulta.Filter := '';
    cdsConsulta.Filtered := False;
  End;
End;

function TfrmOrdProEmiPerdaRefugo.fGetSql(blnLike: Boolean): String;
begin
  Result := Inherited;
  Result := '';
  Result := Result + ' SELECT DISTINCT "BX_REFUG" AS OPERAC,                 ';
  Result := Result + '        RFGORD.AUTOINCREM,                             ';
  Result := Result + '        ORD_CODITE,                                    ';
  Result := Result + '        ORD_NUMLOT,                                    ';
  Result := Result + '        ITE_DESITE,                                    ';
  Result := Result + '        ITE_REFERE,                                    ';
  Result := Result + '        ITE_CODMAR,                                    ';
  Result := Result + '        ITE_CODFAB,                                    ';
  Result := Result + '        ITE_CODUNI,                                    ';
  Result := Result + '        UNI_SIGUNI,                                    ';
  Result := Result + '        EMP_CODEMP,                                    ';
  Result := Result + '        ORD_QTDITE,                                    ';
  Result := Result + '        PRO_CODEMP,                                    ';
  Result := Result + '        PRO_CODPRO,                                    ';
  Result := Result + '        CLI_CODCLI,                                    ';
  Result := Result + '        CLI_NOMCLI,                                    ';
  Result := Result + '        CONCAT(CLI_CODCLI," - ",CLI_NOMCLI) AS CODCLI  ';
  Result := Result + ' FROM RFGORD                                           ';
  Result := Result + '   INNER JOIN CADEMP ON EMP_CODEMP = :CODEMP           ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = EMP_CLIFIL        ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE        ';
  Result := Result + '   INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI        ';
  Result := Result + '   INNER JOIN MOVPRO ON ORD_SEQORD = MOVPRO.AUTOINCREM ';
  Result := Result + ' WHERE TRUE                                            ';
  Result := Result + '   AND ORD_JAFATU = "N"                                ';
end;

procedure TfrmOrdProEmiPerdaRefugo.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarCdsVenda(Nil);
end;

procedure TfrmOrdProEmiPerdaRefugo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Shift = [] Then
  Case Key Of
    VK_F6 : btnMarcarTodos.Click;
    VK_F7 : btnDesmarcarTodos.Click;
  End;
end;

function TfrmOrdProEmiPerdaRefugo.fSetParametros: Boolean;
begin
  Result := True;
  qryConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;
end;

function TfrmOrdProEmiPerdaRefugo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmOrdProEmiPerdaRefugo.pAddListaQuery;
begin
  inherited;
  pSetEnabled;
end;

procedure TfrmOrdProEmiPerdaRefugo.pSetEnabled;
begin
  btnConfirma.Enabled := (stlListSelecao.Count > 0) And (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0);
end;

function TfrmOrdProEmiPerdaRefugo.fIncluiItens(fatVenda: TFatVenda): Boolean;
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
        If fInLista And (FieldByName('ORD_QTDITE').AsFloat > 0) Then
        Begin
          If Not cdsGroup.Locate('ORD_CODITE', FieldByName('ORD_CODITE').AsString, []) Then
          Begin
            cdsGroup.Insert;
            cdsGroup.FieldByName('ORD_CODITE').AsString := FieldByName('ORD_CODITE').AsString;
            cdsGroup.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
            cdsGroup.FieldByName('ITE_REFERE').AsString := FieldByName('ITE_REFERE').AsString;
            cdsGroup.FieldByName('ITE_CODFAB').AsString := FieldByName('ITE_CODFAB').AsString;
            cdsGroup.FieldByName('UNI_SIGUNI').AsString := FieldByName('UNI_SIGUNI').AsString;
            cdsGroup.FieldByName('ORD_NUMLOT').AsString  := FieldByName('ORD_NUMLOT').AsString;
            cdsGroup.FieldByName('ORD_QTDITE').AsFloat  := FieldByName('ORD_QTDITE').AsFloat;
            cdsGroup.Post;
          End
          Else
          Begin
            cdsGroup.Edit;
            cdsGroup.FieldByName('ORD_QTDITE').AsFloat  := cdsGroup.FieldByName('ORD_QTDITE').AsFloat +
                                                           FieldByName('ORD_QTDITE').AsFloat;
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

        fGetItem(qryGenIte,FieldByName('ORD_CODITE').AsString);

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
                                             FieldByName('ORD_CODITE').AsString,
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
                                             FieldByName('ORD_QTDITE').AsFloat,
                                             fltPreEnv*FieldByName('ORD_QTDITE').AsFloat, // fltTotIte
                                             'S',
                                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat, // fltPreCus
                                             fFormataFloat(qryGenIte.FieldByName('ITE_PRECUS').AsFloat * FieldByName('ORD_QTDITE').AsFloat, 2), // fltTotCus
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
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('ORD_QTDITE').AsFloat,
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
                                             FieldByName('ORD_QTDITE').AsFloat,
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
                                             FieldByName('ORD_NUMLOT').AsString,
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
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('ORD_QTDITE').AsFloat,
                                             0,
                                             0,
                                             '',
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
                                             '',
                                             '',
                                            'N',
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
      pMensagensErro(E.Message,'[TfrmOrdProEmiPerdaRefugo.fIncluiItens]');
    End;

  End;

end;

function TfrmOrdProEmiPerdaRefugo.fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
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
      pMensagensErro(E.Message, '[TfrmOrdProEmiPerdaRefugo.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

function TfrmOrdProEmiPerdaRefugo.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
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

    {strSQL := strSQL + '  IFNULL(  '+
                          ' (SELECT LOT_NUMLOT FROM CADLOT '+
                          '        WHERE '+
                          '            LOT_PRIPRO = "S" '+
                          '        AND LOT_STATUS = "S" '+
                          '        AND LOT_CODITE = :CODITE '+
                          '        AND LOT_CODEMP = :CODEMP '+
                          ' ),"") AS ITE_NUMLOT, ';   }

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
      pMensagensErro(E.Message,'[TfrmOrdProEmiPerdaRefugo.fGetItem]');
    End;

  End;

end;

function TfrmOrdProEmiPerdaRefugo.fOpBaixada: Boolean;
begin
  Result := fCampoTabela('IFNULL(PRO_DTABAI,"N") AS BAIXAD','MOVPRO',['PRO_CODPRO','PRO_CODEMP'],[edtCodBar.Text, VS_StrCodemp]) <> 'N';
end;

end.
