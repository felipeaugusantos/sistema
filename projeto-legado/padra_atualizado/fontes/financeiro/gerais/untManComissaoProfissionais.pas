unit untManComissaoProfissionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBCtrls, DBMemoFocus, EditFocus, Mask, DBEditFocus, QColorLabel,
  untComissaoProfissional, DB, StrUtils, Uni, AppEvnts, untFuncFat,
  UniClientDataSet, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untLiberacao;

type
  TfrmManComissaoProfissionais = class(TfrmPaiCad)
    pnlFundo: TPanel;
    bvlLinha: TBevel;
    lblCodigo: TLabel;
    lblDtaCad: TLabel;
    lblCliente: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ColorLabel1: TColorLabel;
    Label4: TLabel;
    Label5: TLabel;
    dbeCodCom: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeCodCli: TDBEditFocus;
    edtDesCliente: TEditFocus;
    dbeNumDoc: TDBEditFocus;
    dbeEspDoc: TDBEditFocus;
    dbeCodEmp: TDBEditFocus;
    edtDesEmpresa: TEditFocus;
    dbeCreDeb: TDBEditFocus;
    dbeVrVenda: TDBEditFocus;
    dbeObserv: TDBMemoFocus;
    Label6: TLabel;
    lblQtdPon: TLabel;
    dbeVrComi: TDBEditFocus;
    dtsComPro: TDataSource;
    dbeCodPro: TDBEditFocus;
    edtProfissional: TEditFocus;
    lblDtaBai: TLabel;
    dbeDtaBai: TDBEditFocus;
    dbeOpeBai: TDBEditFocus;
    Label7: TLabel;
    edtDesOperador: TEditFocus;
    btnCalculo: TBitBtnLocked;
    shpVlrCom: TShape;
    btnEstorno: TBitBtnLocked;
    btnHistMovDocto: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCalculoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodProChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtsComProStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodProExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEstornoClick(Sender: TObject);
    procedure btnHistMovDoctoClick(Sender: TObject);
  private

    objLiberacao : TLiberacao;

    { Private declarations }
    objComPro: TComPro;
    fatVendas: TFatVenda;

    blnEscolhePontosOuValor: Boolean;

    blnLibCre : Boolean;
    blnLibDeb : Boolean;
    StrDtIni  : String;

    blnOperInc: Boolean;   //Inclusao = true; Alteração = False;

    blnLibVlr: Boolean;
    strProAnt: String;
    strDocAnt: String;
    strEspAnt: String;
    strEmpAnt: String;

    blnEntPro: Boolean;
    blnSaiPro: Boolean;
    blnPerVin: Boolean;

    fltComAnt: Double;
    strPRFNEG: String;
    strClaFis: String;
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pCarregaProfissional;
    procedure pCarregaOperador;
    procedure pAfterScroll(DataSet: TDataset);
    procedure pCalculaComissao;

    procedure pValidaTipoComissao;

    procedure pVerificarConf;
    procedure pControlaVerdeVermelhoValorComissao(blnIgnDoc: Boolean = False; blnHabCam: Boolean = True);
    procedure pFazBackupVariaveis;

    function fVerificarSenha : Boolean;

    function fBuscaDocumento: Boolean;
    function fGetPerComProfissional(strCodPro: String): Double;
    function fExisteOutraComissaoDoMesmoDocumento(strNumDoc, strEspDoc, strCodEmp : String): Boolean;
    function fPedeLiberacaoCreditoDebito: Boolean;
    Function fGetSqlDoc: String;
    function fAtualizaProfissional: Boolean;
    function fTeveAlteracaoCampos: Boolean;
    function fTemCreditoDeComissaoSuficiente: Boolean;
    procedure pGetInfoComissaoAlterada(Var fltVrComi: Double; Var strCodPro: String);

    function fRetFornecedorProfissional(strCodPro: String): String;
  public
    { Public declarations }
    blnOpcInc: Boolean;

    VS_strTCoProInterna: String;
    strDataCad : String;

  protected
    procedure pInicializaIndices; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    function fExecutaAntesDoDelete : Boolean; override;
  end;


implementation

uses untFuncoes, untFuncoesSimples, untConsultas, untTypesSistema, untCalculaComissaoProfissionais,
  untPai,untEstornoComissaoProfissionais,untLogCom,untRelLogComAcompNovo;

{$R *.dfm}

procedure TfrmManComissaoProfissionais.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmManComissaoProfissionais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (fatVendas <> Nil) Then
    FreeAndNil(fatVendas);
end;

procedure TfrmManComissaoProfissionais.FormCreate(Sender: TObject);
begin
  inherited;
  blnOpcInc := FALSE;
  blnLibCre := FALSE;
  blnLibDeb := FALSE;
  blnEntPro := False;
  blnSaiPro := False;
  blnPerVin := False;

  fltComAnt := 0;

  objComPro := TComPro.Create(Self);
  objComPro.qryComPro.AfterScroll := pAfterScroll;

  dtsComPro.DataSet := objComPro.qryComPro;

  VS_strTCoProInterna := fCfgSis('TCOPRO');

  blnEscolhePontosOuValor := VS_strTCoProInterna = '4';

  strNomeCampo  := 'COM_CODCOM';
  strNomeTabela := 'COMPRO';
  qryTabela     := objComPro.qryComPro;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCom;
  dbeNumDoc.MaxLength := fTamDocCadRec;
  strPRFNEG := fCfgSis('PRFNEG', varString);
  objLiberacao :=  TLiberacao.Create;
end;


procedure TfrmManComissaoProfissionais.pCarregaEmpresa;
Begin
  edtDesEmpresa.Text := fRetNomeEmpresa(dbeCodEmp.Text);
End;

procedure TfrmManComissaoProfissionais.pCarregaOperador;
begin
  edtDesOperador.Text := fRetNomeOperador(dbeOpeBai.Text);
end;

procedure TfrmManComissaoProfissionais.pCalculaComissao;
  Var
    fltBasComiss,
    fltVlrComiss,
    fltPerIteDef: Double;
begin

  Try

    If (Not assigned(fatVendas)) Then
      Exit;

    fltPerIteDef := 0.00;

    If blnEscolhePontosOuValor Then
      fltPerIteDef := fRetornaPerComProfissional(dbeCodPro.Text);

    fatVendas.strCodDiv := dbeCodPro.Text;
    fatVendas.strEspDoc := dbeEspDoc.Text;
    fatVendas.fGComPro(fltBasComiss, fltVlrComiss, True, False, fltPerIteDef);
    dbeVrVenda.Field.Value := fltBasComiss;
    dbeVrComi.Field.Value  := fltVlrComiss;

    pControlaVerdeVermelhoValorComissao;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmManComissaoProfissionais.pCalculaComissao]');
  End;

end;

procedure TfrmManComissaoProfissionais.pCarregaCliente;
Begin
  edtDesCliente.Text := fRetNomCliente(dbeCodCli.Text);
End;

procedure TfrmManComissaoProfissionais.pCarregaProfissional;
Begin
  edtProfissional.Text := fRetNomProfissional(dbeCodPro.Text);
End;

procedure TfrmManComissaoProfissionais.pControlaVerdeVermelhoValorComissao(blnIgnDoc: Boolean = False; blnHabCam: Boolean = True);
begin

  If (blnHabCam) Then
    dbeVrComi.Enabled     := True;

  shpVlrCom.Brush.Color := clGreen;

  {******************************************************}
  {* SÓ DEVE DEIXAR VERMELHO CASO NÃO TENHA PERMISSÃO E *}
  {* A COMISSÃO ESTIVER VINCULADA A UM DOCUMENTO.       *}
  {***************************************************PZ*}
  If (Not blnLibVlr) And (Not fEmptyStr(dbeNumDoc.Text) Or (blnIgnDoc)) Then
  Begin
    dbeVrComi.Enabled     := False;
    shpVlrCom.Brush.Color := clRed;
  End;

end;

procedure TfrmManComissaoProfissionais.pFazBackupVariaveis;
begin

  strProAnt := dbeCodPro.Text;
  strDocAnt := dbeNumDoc.Text;
  strEspAnt := dbeEspDoc.Text;
  strEmpAnt := dbeCodEmp.Text;

end;

procedure TfrmManComissaoProfissionais.pGetInfoComissaoAlterada(Var fltVrComi: Double; Var strCodPro: String);
  Var
    qryComOri : TUniQuery;
begin
  qryComOri := fCriaQuery(Self);
  Try
    fltVrComi := 0;
    strCodPro := '';

    qryComOri.Close;
    qryComOri.SQL.Clear;
    qryComOri.SQL.Add(' SELECT COM_VRCOMI, COM_CODPRO, COM_CREDEB ');
    qryComOri.SQL.Add('   FROM COMPRO ');
    qryComOri.SQL.Add('  WHERE COM_CODCOM = :CODCOM ');
    qryComOri.SQL.Add('    AND AUTOINCREM = :AUTINC ');
    qryComOri.ParamByName('CODCOM').AsString := qryTabela.FieldByName('COM_CODCOM').AsString;
    qryComOri.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryComOri.Open;

    If (Not qryComOri.IsEmpty) Then
    Begin
      fltVrComi := qryComOri.FieldByName('COM_VRCOMI').AsFloat;
      strCodPro := qryComOri.FieldByName('COM_CODPRO').AsString;

      If (qryComOri.FieldByName('COM_CREDEB').AsString = 'C') Then
        fltVrComi := -fltVrComi;
    End;

    qryComOri.Close;
  Finally
    FreeAndNil(qryComOri);
  End;
end;

procedure TfrmManComissaoProfissionais.pAfterScroll(DataSet: TDataset);
Begin
  pCarregaEmpresa;
  pCarregaCliente;
  pCarregaProfissional;
  pCarregaOperador;
End;

function TfrmManComissaoProfissionais.fAtualizaProfissional: Boolean;
  Var
    qryAux   : TUniQuery;
    strTabela: string;
Begin
  Result    := True;
  qryAux    := fCriaQuery(Self);
  strTabela := EmptyStr;

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(fGetSqlDoc);
    ParamByName('NUMDOC').AsString := dbeNumDoc.Text;
    ParamByName('ESPDOC').AsString := dbeEspDoc.Text;
    ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    Open;
    First;

    If Not IsEmpty Then
      strTabela := 'MOVDET'
    Else
      Result := False;

    If Result And (Not fEmptyStr(strTabela)) Then
    begin
      Try
        SQL.Clear;
        SQL.Add('UPDATE ' + strTabela);
        SQL.Add('SET   DET_CODDIV = :CODDIV ');
        SQL.Add('WHERE DET_NUMDOC = :NUMDOC ');
        SQL.Add('AND   DET_ESPDOC = :ESPDOC ');
        SQL.Add('AND   DET_CODEMP = :CODEMP ');
        ParamByName('CODDIV').AsString := qryTabela.FieldByName('COM_CODPRO').AsString;
        ParamByName('NUMDOC').AsString := dbeNumDoc.Text;
        ParamByName('ESPDOC').AsString := dbeEspDoc.Text;
        ParamByName('CODEMP').AsString := dbeCodEmp.Text;
        ExecSQL;
      Except
        On E:Exception Do
        Begin
          pMensagensErro(E.Message,'[TfrmManComissaoProfissionais.fAtualizaProfissional]');
          Result := False;
        End;
      End;
    End;
  End;

  FreeAndNil(qryAux);
end;

function TfrmManComissaoProfissionais.fBuscaDocumento: Boolean;
  Var
    qryGen   : TUniQuery;
    intPosMat: Integer;
    fltTotPro: Double;
    fltDesEsp: Double;
    fltVlrCon: Double;
Begin
  qryGen := fCriaQuery(Self);

  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add(fGetSqlDoc);
    ParamByName('NUMDOC').AsString := dbeNumDoc.Text;
    ParamByName('ESPDOC').AsString := dbeEspDoc.Text;
    ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    Open;
    First;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strClaFis := qryGen.FieldByName('GER_CLAFIS').AsString;

      qryTabela.FieldByName('COM_CODCLI').AsString := FieldbyName('GER_CODCLI').AsString;
      pCarregaCliente;
      qryTabela.FieldByName('COM_CREDEB').AsString := IfThen(LeftStr(FieldbyName('GER_CLAFIS').AsString, 1) < '5','D','C');

      First;

      If (fatVendas = Nil) Then
        fatVendas := TFatVenda.CreateInstance('VN');

      fatVendas.VS_strTCoPro := VS_strTCoProInterna;

      SetLength(fatVendas.arrMatItens, 0);
      SetLength(fatVendas.arrMatItens, RecordCount);

      intPosMat := 0;
      fltTotPro := 0;
      fltDesEsp := 0;
      fltVlrCon := 0;

      While Not Eof Do
      Begin
        fatVendas.arrMatItens[intPosMat].fltQtdIte := FieldByName('DET_QTDITE').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltQtdPon := FieldByName('DET_QTDPON').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltTotIte := FieldByName('DET_TOTITE').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltDesEsp := FieldByName('DET_DESESP').AsFloat;
        fatVendas.arrMatItens[intPosMat].strCodIte := FieldByName('DET_CODITE').AsString;
        fatVendas.arrMatItens[intPosMat].fltUniOri := FieldByName('DET_UNIORI').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltUniVis := FieldByName('DET_UNIVIS').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltTaxJur := FieldByName('DET_TAXJUR').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltUnitar := FieldByName('DET_UNITAR').AsFloat;
        fatVendas.arrMatItens[intPosMat].fltVal_RT := FieldByName('DET_VAL_RT').AsFloat;
        fatVendas.arrMatItens[intPosMat].strPromoc := FieldByName('DET_PROMOC').AsString;
        fatVendas.arrMatItens[intPosMat].strCodGru := FieldByName('ITE_CODGRU').AsString;
        fatVendas.arrMatItens[intPosMat].strEntSai := IIF(LeftStr(FieldByName('DET_CLAFIS').AsString, 1) < '5', 'E', 'S');

        If LeftStr(FieldByName('DET_CLAFIS').AsString, 1) < '5' Then
        Begin
          fltVlrCon := fltVlrCon - FieldByName('DET_VLRCON').AsFloat;
          fltTotPro := fltTotPro - FieldByName('DET_TOTITE').AsFloat;
          fltDesEsp := fltDesEsp - FieldByName('DET_DESESP').AsFloat;
        End
        Else
        Begin
          fltVlrCon := fltVlrCon + FieldByName('DET_VLRCON').AsFloat;
          fltTotPro := fltTotPro + FieldByName('DET_TOTITE').AsFloat;
          fltDesEsp := fltDesEsp + FieldByName('DET_DESESP').AsFloat;
        End;

        Inc(intPosMat);
        Next;
      End;

      fatVendas.fltTotPro := fltTotPro;
      fatVendas.fltDesEsp := fltDesEsp;
      fatVendas.strCodCli := FieldbyName('GER_CODCLI').AsString;
      qryTabela.FieldByName('COM_VRVEND').AsFloat := Abs(fltVlrCon);

      If fCfgSis('UTI_RT', VarBoolean) Then
        fatVendas.pRateiaValorRT;
    End
    Else
    Begin
      fMensagem('','Documento não encontrado!',['&OK']);
      pSetFocus(dbeNumDoc);
      blnMudarFoco := False;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TfrmManComissaoProfissionais.fExisteOutraComissaoDoMesmoDocumento(strNumDoc, strEspDoc, strCodEmp : String): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COM_CODCOM ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   COMPRO ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   COM_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   COM_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   COM_CODEMP = :CODEMP ';

  With qryGen Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryGen);
end;

function TfrmManComissaoProfissionais.fGetPerComProfissional(strCodPro: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0;

  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADDIV ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DIV_CODDIV = :CODDIV ';

  With qryGen Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODDIV').AsString := strCodPro;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('DIV_PERCOM').AsFloat;
    Close;
  End;

  FreeAndNil(qryGen);
End;

function TfrmManComissaoProfissionais.fGetSqlDoc: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   GER_CODCLI, ';
  strSQL := strSQL + '   GER_VLRCON, ';
  strSQL := strSQL + '   GER_TOTPRO, ';
  strSQL := strSQL + '   GER_CLAFIS, ';
  strSQL := strSQL + '   DET_QTDITE, ';
  strSQL := strSQL + '   DET_TOTITE, ';
  strSQL := strSQL + '   DET_DESESP, ';
  strSQL := strSQL + '   DET_CODITE, ';
  strSQL := strSQL + '   DET_UNIORI, ';
  strSQL := strSQL + '   DET_UNIVIS, ';
  strSQL := strSQL + '   DET_TAXJUR, ';
  strSQL := strSQL + '   DET_UNITAR, ';
  strSQL := strSQL + '   DET_VAL_RT, ';
  strSQL := strSQL + '   DET_VLRCON, ';
  strSQL := strSQL + '   DET_CLAFIS, ';
  strSQL := strSQL + '   DET_PROMOC, ';
  strSQL := strSQL + '   ITE_CODGRU, ';

  If blnEscolhePontosOuValor Then
    strSQL := strSQL + '   IFNULL(ITE_QTPPRO, 0.00) AS DET_QTDPON '
  Else
    strSQL := strSQL + '   IFNULL(DET_QTDPON, 0.00) AS DET_QTDPON ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL +     'MOVGER G ';
  strSQL := strSQL +     'INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL +     'INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL +     'LEFT JOIN  CADITE I ON I.ITE_CODITE = D.DET_CODITE ';

  If blnEscolhePontosOuValor Then
    strSQL := strSQL +     'INNER JOIN ITEGER R  ON DET_CODITE = R.ITE_CODITE AND DET_CODEMP = R.ITE_CODEMP ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   GER_TIP_FC = "C" AND ';
  strSQL := strSQL + '   DET_CLAFIS NOT IN ("1999", "5999") AND ';
  strSQL := strSQL + '   GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   GER_CODEMP = :CODEMP     ';

  Result := strSQL;
end;

function TfrmManComissaoProfissionais.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  blnFocCam: Boolean;

  function fValidaDocumento: Boolean;
  Var
    blnHabCom: Boolean;
  begin
    Result    := True;
    blnHabCom := False;
    If blnBuscaPorChave And (fCfgSis('NROPRO') = '2') Then // 1 profissional
    Begin

      If Not fBuscaPorCamposChave Then
      Begin
        dbeDtaCad.Field.Value := StrDtIni;
        Result    := fBuscaDocumento;
        blnHabCom := True;
      End

      Else If Not qryTabela.FieldByName('COM_DTABAI').IsNull Then
        btnCancela.Click

      Else
        pValidaTipoComissao;

    End

    Else
      Result := fBuscaDocumento;

    pControlaVerdeVermelhoValorComissao(False, blnHabCom);
  end;

begin

  Result    := True;
  blnFocCam := True;

  If (Sender = dbeNumDoc) And blnOpcInc And (qryTabela.State = dsInsert) Then
  Begin
    blnMudarFoco := True;
    If fEmptyStr(dbeNumDoc.Text) Then
    Begin
      fMensagem('','Informe o número do Documento!',['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = dbeEspDoc) And blnOpcInc And (qryTabela.State = dsInsert) Then
  Begin

    If fEmptyStr(dbeEspDoc.Text) Then
    Begin
      fMensagem('','Informe a espécie do Documento!',['&OK']);
      Result := False;
    End
    Else If Not dbeCodEmp.Enabled Then
      Result := fValidaDocumento;

  End

  Else if ( Sender = dbeDtaCad) then
  begin
    if (dbeDtaCad.text <> StrDtIni) then
    begin
      Result := (fVerificarSenha);

      if Result then
        StrDtIni := dbeDtaCad.text;
    end;
  end

  Else If (Sender = dbeCodEmp) And dbeCodEmp.Enabled Then
  Begin
    pCarregaEmpresa;

    If fEmptyStr(dbeCodEmp.Text) Then
    Begin
      fMensagem('','Informe a empresa do Documento!',['&OK']);
      Result := False;
    End
    Else If fEmptyStr(edtDesEmpresa.Text) Then
    Begin
      fMensagem('','Empresa não encontrada!',['&OK']);
      Result := False;
    End
    Else
      Result := fValidaDocumento  ;
  End

  Else If (Sender = dbeCodCli) Then
  Begin

    If Not fEmptyStr(dbeCodCli.Text) Then
    Begin
      pCarregaCliente;
      If fEmptyStr(edtDesCliente.Text) Then
      Begin
        fMensagem('','Cliente não encontrado!',['&OK']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeCodEmp) Then
  Begin

    If Not fEmptyStr(dbeCodEmp.Text) Then
    Begin
      pCarregaEmpresa;
      If fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        fMensagem('','Empresa não encontrada!',['&OK']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeCodPro) Then
  Begin
    If fEmptyStr(dbeCodPro.Text) Then
    Begin
      fMensagem('', 'Profissional precisa ser preenchido!', ['&Ok']);
      Result := False;
    End

    Else
    Begin

      pCarregaProfissional;

      If fEmptyStr(edtProfissional.Text) Then
      Begin
        fMensagem('','Profissional não encontrado!',['&OK']);
        Result := False;
      End

      Else If blnOpcInc And blnBuscaPorChave And (fCfgSis('NROPRO') <> '2') Then // + de 1 profissional
      Begin

        If (fTeveAlteracaoCampos) And (fEmptyStr(dbeNumDoc.Text) Or (Not fBuscaPorCamposChave)) Then
        Begin
          dbeDtaCad.Field.Value := StrDtIni;

          If blnOpcInc And (qryTabela.State = dsInsert) Then
          Begin
            Result := fBuscaDocumento;

            If (Not Result) Then
              blnFocCam := False;

            If (fStrToFloat(dbeVrComi.Text) = 0) Then
              dbeVrComi.Text := FormatFloat('#,##0.00', fStrToFloat(dbeVrVenda.Text) * fGetPerComProfissional(dbeCodPro.Text));

            pControlaVerdeVermelhoValorComissao(True);

            If (Result) Then
              pFazBackupVariaveis;
          End
          Else
            pFazBackupVariaveis;
        End

        Else If Not qryTabela.FieldByName('COM_DTABAI').IsNull Then
          btnCancela.Click

        Else
          pValidaTipoComissao;

        pCarregaEmpresa;
        pCarregaProfissional;

      End
      Else If blnOpcInc And blnBuscaPorChave And (fCfgSis('NROPRO') = '2') Then // 1 profissional
      Begin
        Result := fBuscaDocumento;

        If (Not Result) Then
          blnFocCam := False;
      End;

      If (Result) And (fCfgSis('TCOPRO') = '4') And (Pos(qryTabela.FieldbyName('COM_CODCLI').AsString, fRetClientesFilial) > 0) Then
      Begin
        fMensagem('','Não é permitido efetuar lançamentos de comissão de profissional para clientes filiais!',['&OK']);
        Result := False;
        blnFocCam := False;
      End;

      If (Result)                     And
         (blnOpcInc)                  And
         (qryTabela.State = dsInsert) And
         (blnBuscaPorChave)           Then
      Begin
        If fExisteOutraComissaoDoMesmoDocumento(dbeNumDoc.Text, dbeEspDoc.Text, dbeCodEmp.Text) Then
        Begin

          If Not fPergunta('Já existe um profissional vinculado a este documento' + #13 +
                           'Deseja vincular outro?') Then
          Begin
            Result := False;
            btnCancela.Click;
            btnIncluir.Click;
            pSetFocus(dbeNumDoc);
            blnFocCam := False;
            blnEntPro := False;
          End
          Else
          Begin
            qryTabela.FieldByName('COM_CODEMP').asString := dbeCodEmp.Text;
            blnPerVin := True;
          End;


        End;

        If Result Then
          pCalculaComissao;
      End;

    End;

  End

  Else If (Sender = dbeCreDeb) Then
  Begin

    If Pos(dbeCreDeb.Text,'CD') <= 0 Then
    Begin
      fMensagem('','O Campo crédito/débito deve ser C ou D!',['&OK']);
      Result := False;
    End

    Else Result := fPedeLiberacaoCreditoDebito;

  End

  Else If (Sender = dbeVrComi) Then
  Begin

    If fStrToFloat(AnsiReplaceStr(dbeVrComi.Text,'.','')) <= 0 Then
    Begin
      If VS_strTCoProInterna = '3' Then
        fMensagem('','O Campo Qtd. Pontos deve ser maior que zero!',['&OK'])
      Else
        fMensagem('','O Campo Vr Comissão deve ser maior que zero!',['&OK']);
      Result := False;
    End;

  End;

  If (Not Result) And (blnFocCam) Then
    pSetFocus(Sender);

end;

procedure TfrmManComissaoProfissionais.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('COM_CODCOM');
  stlCamInd.Add('COM_NUMDOC');
  stlCamInd.Add('CLI_NOMCLI');
  stlCamInd.Add('DIV_NOMDIV');
  stlCamInd.Add('COM_DTACAD');

  stlDesInd.Add('Código');
  stlDesInd.Add('Documento');
  stlDesInd.Add('Nome Cliente');
  stlDesInd.Add('Nome Profissional');
  stlDesInd.Add('Dta Cadastro');

end;

procedure TfrmManComissaoProfissionais.dbeObservKeyPress(Sender: TObject; var Key: Char);
Var
  strKey: String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmManComissaoProfissionais.dtsComProStateChange(Sender: TObject);
begin
  btnCalculo.Enabled := Not ((dtsComPro.State In dsEditModes) Or (dtsComPro.DataSet.FieldByName('COM_CODCOM').IsNull) or
                             (Not dtsComPro.DataSet.FieldByName('COM_DTABAI').IsNull));
  btnEstorno.Enabled := Not dtsComPro.DataSet.FieldByName('COM_DTABAI').IsNull;
  btnHistMovDocto.Enabled := Not ((dtsComPro.State In dsEditModes) Or (dtsComPro.DataSet.FieldByName('COM_CODCOM').IsNull));
end;

{****************************************************}
{* PROCEDURE ALTARADO PARA CHAMADA DA NOVA CONSULTA *}
{*************************************************JU*}
procedure TfrmManComissaoProfissionais.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  edtDesCliente.Text   := EmptyStr;
  edtDesEmpresa.Text   := EmptyStr;
  edtProfissional.Text := EmptyStr;
  chrKey := '?';

  If fPesqComissaoProf(conSimples,
                       Self,
                       nil,
                       nil,
                       qryTabela,
                       chrKey,
                       arrSel,
                       blnOpcInc,
                       VS_strTCoProInterna) Then
  Begin
    pControlaVerdeVermelhoValorComissao(False, False);
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmManComissaoProfissionais.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsInsert Then
  Begin
    dbeDtaCad.Field.Value := VS_Date;
    dbeCodEmp.Field.Value := VS_strCodEmp;
    edtDesEmpresa.Text    := fRetNomeEmpresa;

    StrDtIni := DateToStr(VS_Date);

    If blnOpcInc Then
    Begin
      dbeNumDoc.Enabled := TRUE;
      dbeEspDoc.Enabled := TRUE;
      dbeCodEmp.Enabled := fCfgSis('EMPGER', varBoolean);

      If blnUsaProCodigo Then
        pHabilitaCodigo(dbeCodCom, dbeNumDoc, False)
      Else
        pHabilitaCodigo(dbeCodCom, dbeCodCom, True);

    End Else
    Begin
      dbeNumDoc.Enabled := FALSE;
      dbeEspDoc.Enabled := FALSE;
      dbeCodEmp.Enabled := FALSE;

      pSetFocus(dbeCodPro);

      If blnUsaProCodigo Then
        pHabilitaCodigo(dbeCodCom, dbeCodEmp, False)
      Else
        pHabilitaCodigo(dbeCodCom, dbeCodCom, True);
    End;

    If blnEscolhePontosOuValor Then
      qryTabela.FieldByName('COM_TCOPRO').AsString := VS_strTCoProInterna;

    dbeCodCli.Enabled     := False;
    edtDesCliente.Enabled := False;
    dbeVrVenda.Enabled    := False;
    dbeVrVenda.Field.Value:= 0;

    blnOperInc := True;

    pVerificarConf;
    pControlaVerdeVermelhoValorComissao(blnOpcInc);
    pFazBackupVariaveis;
  End;

end;

procedure TfrmManComissaoProfissionais.btnAlterarClick(Sender: TObject);
begin
  If Not qryTabela.FieldByName('COM_DTABAI').IsNull Then
  Begin
    fMensagem('','Comissão baixada não pode ser alterada!',['&OK']);
    Exit;
  End;

  inherited;

  If qryTabela.State = dsEdit Then
  Begin
    dbeNumDoc.Enabled     := False;
    dbeEspDoc.Enabled     := False;
    dbeCodEmp.Enabled     := False;
    dbeCodCli.Enabled     := False;
    edtDesCliente.Enabled := False;
    dbeVrVenda.Enabled    := False;

    pSetFocus(dbeCodPro);

    pHabilitaCodigo(dbeCodCom, dbeCodCli, False);

    StrDtIni := dtsComPro.DataSet.FieldByName('COM_DTACAD').AsString;

    blnOperInc := False;

    pVerificarConf;

  End;

  pControlaVerdeVermelhoValorComissao;
  pFazBackupVariaveis;
end;

procedure TfrmManComissaoProfissionais.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmManComissaoProfissionais.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmManComissaoProfissionais.dbeCodProChange(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeCodPro.Text) Then
    edtProfissional.Clear;
end;

procedure TfrmManComissaoProfissionais.dbeCodProExit(Sender: TObject);
begin
  inherited;

  If (Not blnEntPro) And ((dbeCodPro.Field.Value <> Null) And (Not fEmptyStr(dbeCodPro.Field.Value))) Then
  Begin
    dbeCodPro.Field.Value := fStrZero(dbeCodPro.Text, 8);

    blnSaiPro := ((ActiveControl) = btnGravar);

    fltComAnt := fStrToFloat(dbeVrComi.Text);
    fValidaCampos(dbeCodPro);

    If (blnSaiPro) And (blnPerVin) Then
      btnGravar.Click
    Else
      blnPerVin := False;
  End;

  blnEntPro := False;
end;

procedure TfrmManComissaoProfissionais.dbeCodProKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrDiversos : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, dbeCodPro, edtProfissional, Nil, Key, arrDiversos) Then
  Begin
    If fValidaCampos(dbeCodPro, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmManComissaoProfissionais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F3 Then
    btnCalculo.Click
  Else If (Key = VK_RETURN) And ((ActiveControl) = dbeCodPro) Then
    blnEntPro := True
  Else If (Key = VK_F4) And btnEstorno.Enabled Then
    btnEstorno.Click;

end;

procedure TfrmManComissaoProfissionais.btnCalculoClick(Sender: TObject);
begin
  If dbeCodCom.Field.IsNull Then
    Exit;

  If Not fVerificaAcessoSistema('BCPBF3', strLoginUsuarioLogado) Then
  Begin
    fMensagem('','Sem permisão para acessar esse módulo!',['&OK']);
    Exit;
  End;

  If Not fLock_Unlock('COMPRO' + dbeCodPro.Field.AsString, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Profissional com o código: '+dbeCodPro.Field.AsString+' está sendo utilizado por outra estação: ' + fGetHostLock('COMPRO'+  dbeCodPro.Field.AsString), ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCalculaComissaoProfissionais, frmCalculaComissaoProfissionais);
    frmCalculaComissaoProfissionais.VS_strTCoProInterna  := VS_strTCoProInterna;
    frmCalculaComissaoProfissionais.strCodPro            := dbeCodPro.Field.AsString;
    frmCalculaComissaoProfissionais.strCodFor            := fRetFornecedorProfissional(dbeCodPro.Field.AsString);
    frmCalculaComissaoProfissionais.strCodEmp            := dbeCodEmp.Field.AsString;
    frmCalculaComissaoProfissionais.edtProfissional.Text := dbeCodPro.Field.AsString + ' - ' + edtProfissional.Text;
    frmCalculaComissaoProfissionais.ShowModal;

  Finally
    pFreeAndNil(frmCalculaComissaoProfissionais);
  End;

  qryTabela.Refresh;
  dtsComProStateChange(dtsComPro);

end;

procedure TfrmManComissaoProfissionais.btnCancelaClick(Sender: TObject);
Var
  blnCancelou: Boolean;
begin
  strClaFis := EmptyStr;
  blnCancelou := False;

  inherited;

  If qryTabela.State In [dsBrowse] Then
  Begin
    blnLibCre   := FALSE;
    blnLibDeb   := FALSE;
    blnCancelou := True;
  End;

  pControlaVerdeVermelhoValorComissao(blnOpcInc, Not blnCancelou);
end;

procedure TfrmManComissaoProfissionais.btnEstornoClick(Sender: TObject);
  Var
    LEstornoComissaoProfissionais : TfrmEstornoComissaoProfissionais;
begin
  inherited;

  If dbeCodCom.Field.IsNull Then
    Exit;

  If Not fVerificaAcessoSistema('frmEstornoComissaoProfissionais', strLoginUsuarioLogado) Then
  Begin
    fMensagem('','Sem permisão para acessar esse módulo!',['&OK']);
    Exit;
  End;

  If Not fLock_Unlock('COMPRO' + dbeCodPro.Field.AsString, False, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Profissional com o código: '+dbeCodPro.Field.AsString+' está sendo utilizado por outra estação: ' + fGetHostLock('COMPRO'+  dbeCodPro.Field.AsString), ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmEstornoComissaoProfissionais, LEstornoComissaoProfissionais);
    LEstornoComissaoProfissionais.VS_strTCoProInterna  := VS_strTCoProInterna;
    LEstornoComissaoProfissionais.edtCodPro.Text       := dbeCodPro.Field.AsString;
    LEstornoComissaoProfissionais.edtComPro.Text       := dbeCodCom.Field.AsString;
    LEstornoComissaoProfissionais.LChamouManutencao    := True;
    LEstornoComissaoProfissionais.ShowModal;
  Finally
    pFreeAndNil(LEstornoComissaoProfissionais);
  End;

  qryTabela.Refresh;
  dtsComProStateChange(dtsComPro);

end;

procedure TfrmManComissaoProfissionais.btnExcluirClick(Sender: TObject);
begin
  If Not qryTabela.FieldByName('COM_DTABAI').IsNull Then
  Begin
    fMensagem('','Comissão baixada não pode ser excluída!',['&OK']);
    Exit;
  End;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManComissaoProfissionais.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    blnLibCre := FALSE;
    blnLibDeb := FALSE;
  End
  Else
    fRollBack;

  pControlaVerdeVermelhoValorComissao(blnOpcInc, False);
end;

procedure TfrmManComissaoProfissionais.btnGravarClick(Sender: TObject);
begin

  If blnOpcInc And
   (fCfgSis('TRDOBE') = 'S') And (Pos('117', strClaFis) > 0) Then
  begin
    fMensagem('','O Documento informado se trata de uma Baixa de Entrega Futura!'+
                 ' Sistema configurado para bloquear inclusão para este tipo de documento - [CFG_TRDOBE]',['&OK']);
    Exit;
  end;

  blnPerVin := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fEmptyDate(dbeDtaCad.Text) Then
  Begin
    fMensagem('','A data de cadastro deve ser preenchida!',['&OK']);
    pSetFocus(dbeDtaCad);
    exit;
  End;

  If (Not fValidaCampos(dbeCodPro, False)) Then
    Exit;

  If (blnOpcInc) And (qryTabela.State = dsInsert) Then
  Begin
    If (blnSaiPro) And (fStrToFloat(dbeVrComi.Text) <> fltComAnt) Then
    Begin
      blnSaiPro := False;
      pMensagemOk('O campo "' + lblQtdPon.Caption  + '" foi recalculado.' + #13#10 + 'Favor conferir e gravar novamente.');
      pSetFocus(dbeVrComi);
      Exit;
    End;
  End;

  If Not fTemCreditoDeComissaoSuficiente Then
    Exit;

  If fEmptyStr(qryTabela.FieldByName('COM_NUMDOC').AsString) Or
     fAtualizaProfissional Then
  Begin
    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmManComissaoProfissionais.btnGravarClick]');
      End;
    End;
  End;

  If blnGravou Then
  Begin

    If fGravalogCom(qryTabela.FieldByName('AUTOINCREM').AsString, IIF( blnOperInc,'INCLUSÃO','ALTERAÇÃO'), Self.Name, '') Then
       fCommit
    Else
       fRollback;

    blnLibCre := FALSE;
    blnLibDeb := FALSE;
  End
  Else
    fRollback;

end;

procedure TfrmManComissaoProfissionais.btnHistMovDoctoClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.IsEmpty) Or (fEmptyStr(dbeCodCom.Text))Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelLogComAcompNovo, frmRelLogComAcompNovo);
    frmRelLogComAcompNovo.edtCodEmpresa.Text      := qryTabela.FieldByName('COM_CODEMP').AsString;
    frmRelLogComAcompNovo.edtCodCliente.Text      := qryTabela.FieldByName('COM_CODCLI').AsString;
    frmRelLogComAcompNovo.edtCodProfissional.Text := qryTabela.FieldByName('COM_CODPRO').AsString;
    frmRelLogComAcompNovo.edtCodCom.Text          := qryTabela.FieldByName('COM_CODCOM').AsString;
    frmRelLogComAcompNovo.blnVeioManutencao       := True;
    frmRelLogComAcompNovo.pCarregaCampos;
    if frmRelLogComAcompNovo.qryConsulta.IsEmpty then
       fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k'])
    else
       frmRelLogComAcompNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmManComissaoProfissionais.btnHistMovDocto]');
  End;
  pFreeAndNil(frmRelLogComAcompNovo);

end;

procedure TfrmManComissaoProfissionais.FormShow(Sender: TObject);
begin
  inherited;

  blnLibVlr := fVerificaAcessoSistema('ALTVCP');

  StrDtIni := '';

  objComPro.VS_strTCoProInterna := VS_strTCoProInterna;

  If VS_strTCoProInterna = '3' Then
    lblQtdPon.Caption := 'Qtd. Pontos:';

  If blnOpcInc Then
  Begin
    If fCfgSis('NROPRO') = '2' Then
    Begin
      SetLength(arrCamposChave, 3);
      arrCamposChave[0] := dbeNumDoc;
      arrCamposChave[1] := dbeEspDoc;
      arrCamposChave[2] := dbeCodEmp;
    End Else
    Begin
      SetLength(arrCamposChave, 4);
      arrCamposChave[0] := dbeNumDoc;
      arrCamposChave[1] := dbeEspDoc;
      arrCamposChave[2] := dbeCodEmp;
      arrCamposChave[3] := dbeCodPro;
    End;
  End;

  pControlaVerdeVermelhoValorComissao(blnOpcInc, False);

  If blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Self.Width   := 605;
    btnSair.Left := 520;
  End;

end;

procedure TfrmManComissaoProfissionais.pValidaTipoComissao;
begin
  If blnEscolhePontosOuValor Then
  Begin
    If (Not fEmptyStr(qryTabela.FieldByName('COM_TCOPRO').AsString)) And
       (qryTabela.FieldByName('COM_TCOPRO').AsString <> VS_strTCoProInterna) Then
    Begin
      If qryTabela.FieldByName('COM_TCOPRO').AsString = '3' Then
        pMensagemOk('Não é permitido gravar comissão por valor para este documento, pois já foi calculado comissão por pontos!')
      Else
        pMensagemOk('Não é permitido gravar comissão por pontos para este documento, pois já foi calculado comissão por valor!');

      With qryTabela Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COMPRO LIMIT 0');
        Open;
      End;

      {***************************************************}
      {* LIMPA AS VARIAVEIS DA BASE DE COMISSÃO ANTERIOR *}
      {* ESTAVA MOSTRANDO O VALOR DA VENDA DO REGISTRO   *}
      {* ANTERIOR                                        *}
      {************************************************PZ*}
      If (Assigned(fatVendas)) Then
      Begin
        fatVendas.fltTotPro := 0;
        fatVendas.fltDesEsp := 0;
        fatVendas.strCodCli := '';
      End;

      blnMudarFoco := False;
      btnIncluir.Click;
    End;
  End;
end;

procedure TfrmManComissaoProfissionais.pVerificarConf;
begin
  dbeDtaCad.Enabled := (fCfgSis('ALTMCP') = 'S');
end;

function TfrmManComissaoProfissionais.fVerificarSenha : boolean;
begin
  Result := false;

  if (fCfgSis('ALTMCP') = 'S') then
  begin
    if fCfgSis('SENMCP') <> '' then // Senha estiver preenchida
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Alteração de data de cadastro na manutenção da comissão de profissionais');

      objLiberacao.strDirAce := 'COMPRF_ALT';
      objLiberacao.strSenLib := fCfgSis('SENMCP');
      objLiberacao.strMsgSen := 'Alteração de data de cadastro na manutenção da comissão de profissionais';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    end;
  end;
end;

function TfrmManComissaoProfissionais.fPedeLiberacaoCreditoDebito: Boolean;
  Var
    strDirAce: String;
    strCreDeb: String;
begin
  //Quando informa o documento nao deve pedir senha
  If blnOpcInc Then
  Begin
    Result := True;
    Exit;
  End;

  //Caso for alteracao e nao tenha alterado o campo de credito e debito na deve pedir senha
  If (qryTabela.State In [dsEdit]) And
     (dbeCreDeb.Text = VarToStr(dbeCreDeb.Field.OldValue)) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := ((dbeCreDeb.Text = 'C') And blnLibCre) Or
            ((dbeCreDeb.Text = 'D') And blnLibDeb);

  If Not Result Then
  Begin
    strCreDeb := IIF(dbeCreDeb.Text = 'C', 'Crédito', 'Débito');
    strDirAce := 'COMPRF_' + IIF(dbeCreDeb.Text = 'C', 'CRE', 'DEB');

    Result := fVerificaAcessoSistema(strDirAce, strLoginUsuarioLogado);

    If Not Result Then
    Begin
      If fPergunta('Usuário sem direito de acesso para incluir um ' + strCreDeb + ' ' +
                   'para o profissional!' + #13#10 +
                   'Deseja informar a senha de acesso?') Then
      Begin
        Result := ffrmSenha(strSenha) And
                  fVerificaAcessoSistema(strDirAce, fRetCodVendedor(strSenha));

        If Not Result Then
          pMensagemOk('Senha inválida ou operador sem direito de acesso ' +
                      'para incluir um ' + strCreDeb + ' para o profissional!');
      End;
    End;

    If Result And (dbeCreDeb.Text = 'C') Then
      blnLibCre := True;

    If Result And (dbeCreDeb.Text = 'D') Then
      blnLibDeb := True;
  End;

end;

function TfrmManComissaoProfissionais.fRetFornecedorProfissional(
  strCodPro: String): String;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := '';

  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   DIV_CODFOR ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADDIV ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DIV_CODDIV = :CODDIV ';

  With qryGen Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODDIV').AsString := strCodPro;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('DIV_CODFOR').AsString;
    Close;
  End;

  FreeAndNil(qryGen);

end;

function TfrmManComissaoProfissionais.fTemCreditoDeComissaoSuficiente: Boolean;
  Var
    fltTotCom   : Double;
    fltComOri   : Double;
    fltSalCom   : Double;
    strProOri   : String;
begin
  Result := True;
  If (dbeCreDeb.Text = 'D') And (fStrToFloat(dbeVrComi.Text) <> 0) Then
  Begin
    fltTotCom := fTotalCreditosProfissional(dbeCodPro.Text, True, IIF(VS_strTCoProInterna = '3', 2, 1));
    fltSalCom := fltTotCom;

    If (qryTabela.State = dsInsert) Then
      fltTotCom := fltTotCom - fStrToFloat(dbeVrComi.Text)
    Else
    Begin
      pGetInfoComissaoAlterada(fltComOri, strProOri);

      If (dbeCodPro.Text <> strProOri) Then
        fltComOri := 0;

      fltTotCom := (fltTotCom + fltComOri) - fStrToFloat(dbeVrComi.Text);
    End;

    If (('A_T_').Contains(strPRFNEG)) And (fFormataFloat(fltTotCom, 2) < 0) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('ATENÇÃO! Profissional não possui crédito suficiente para este lançamento. (CFG_PRFNEG)');
      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo da comissão do profissional', FloatToStrF(fltSalCom, ffFixed, 15, 2)                   , 33);
      objLiberacao.objMsgLibera.pAddTextoCaption('Total do débito'                  , FloatToStrF(fStrToFloat(dbeVrComi.Text), ffFixed, 15, 2) , 33);
      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Final'                      , FloatToStrF(fltTotCom, ffFixed, 15, 2)                   , 33);

      objLiberacao.strDirAce := 'ALCOSD';
      objLiberacao.blnTraTel := (strPRFNEG = 'T');
      objLiberacao.strMsgSen := 'ATENÇÃO! Profissional não possui crédito suficiente para este lançamento. (CFG_PRFNEG)';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    End;
  End;
end;

function TfrmManComissaoProfissionais.fTeveAlteracaoCampos: Boolean;
begin

  Result := (strProAnt <> dbeCodPro.Text) Or
            (strDocAnt <> dbeNumDoc.Text) Or
            (strEspAnt <> dbeEspDoc.Text) Or
            (strEmpAnt <> dbeCodEmp.Text);

end;

procedure TfrmManComissaoProfissionais.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  inherited;
end;

function TfrmManComissaoProfissionais.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;
  try

    fGravaLogCom(qryTabela.FieldByName('AUTOINCREM').AsString, 'EXCLUSÃO', Self.Name);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManComissaoProfissionais.fExecutaAntesDoDelete]');
      Exit(False);
    End;
  end;
end;

end.

