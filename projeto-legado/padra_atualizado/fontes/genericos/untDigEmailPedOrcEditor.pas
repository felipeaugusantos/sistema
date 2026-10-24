unit untDigEmailPedOrcEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, untTypesSistema,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, QColorLabel,
  UniClientDataSet, Uni, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  cxCheckBox;

type
  TfrmDigEmailPedOrcEditor = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    pnlPrincipal: TPanel;
    chkAnexar: TCheckBox;
    gbExporta: TGroupBox;
    lblPdfExc: TColorLabel;
    edtTipExp: TEditFocus;
    grpOpcExcel: TGroupBox;
    rdgNomEmp: TRadioGroup;
    gpbOrdem: TGroupBox;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    edtOrdem: TEditFocus;
    grpDadosPedCd: TGroupBox;
    lbl3: TColorLabel;
    lbl4: TColorLabel;
    edtEmpCab: TEditFocus;
    grpImpMarcaLocFis: TGroupBox;
    chkMarca: TCheckBox;
    gbPreco: TGroupBox;
    lbl5: TColorLabel;
    edtPreco: TEditFocus;
    gpbModo: TGroupBox;
    clblModo: TColorLabel;
    edtModo: TEditFocus;
    grpContatos: TGroupBox;
    grdContatos: TcxGridCitel;
    grdContatosDados: TcxGridDBTableViewCitel;
    grdContatosNivel: TcxGridLevel;
    cdsContatos: TUniClientDataSet;
    dtsContatos: TDataSource;
    cdsContatosSELCTT: TStringField;
    cdsContatosNOMCTT: TStringField;
    cdsContatosDEPCTT: TStringField;
    cdsContatosEMACTT: TStringField;
    grdContatosDadosSELCTT: TcxGridDBColumn;
    grdContatosDadosNOMCTT: TcxGridDBColumn;
    grdContatosDadosDEPCTT: TcxGridDBColumn;
    grdContatosDadosEMACTT: TcxGridDBColumn;
    edtOutrosEmails: TEditFocus;
    lblInformarOutrosEmails: TLabel;
    lblEmails: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtTipExpChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pCarregarContatosCliente(ACodCli : String);
    function fRetornarEmailsSelecionados : String;
  public
    { Public declarations }
    strTipExp: String;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    strNumdoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strEmails : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDigEmailPedOrcEditor: TfrmDigEmailPedOrcEditor;

implementation

uses  untFuncoesSimples, untMsgLiberacao, untLiberacao;

{$R *.dfm}

procedure TfrmDigEmailPedOrcEditor.btnConfirmaClick(Sender: TObject);

  Function fRetornaItens(): TUniQuery;
  Begin
    result := fCriaQuery(Self);

    result.sql.Add('SELECT DISTINCT');
    result.sql.Add(' C.ITE_CODITE');
    result.sql.Add(',C.ITE_DESITE');
    result.sql.Add(',MAR_DESMAR');
    result.sql.Add(',FDO_UNIDAD');
    result.sql.Add(',FDO_QTDITE');
    result.sql.Add(',FDO_UNITAR');
    result.sql.Add(',FDO_TOTITE');
    result.sql.Add(',FDO_UNIORI');
    result.sql.Add(',FGO_NUMDOC');
    result.sql.Add(',FGO_ESPDOC');
    result.sql.Add(',FGO_CODEMP');
    result.sql.Add(',FGO_VLRCON');
    result.sql.Add(',FGO_CODCLI');
    result.sql.Add('FROM FATGOR');
    result.sql.Add('      JOIN FATDOR   ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
    result.sql.Add('      JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE');
    result.sql.Add('LEFT  JOIN CADMAR   ON MAR_CODMAR   = C.ITE_CODMAR');
    result.sql.Add('WHERE FGO_NUMDOC = :NUMDOC');
    result.sql.Add('AND   FGO_ESPDOC = :ESPDOC');
    result.sql.Add('AND   FGO_CODEMP = :CODEMP');
    result.ParamByName('NUMDOC').AsString := strNumdoc;
    result.ParamByName('ESPDOC').AsString := strEspDoc;
    result.ParamByName('CODEMP').AsString := strCodEmp;

    result.open;

  End;

  function fMSG_SenhaImprimirComPreco(): Boolean;
  var
    objTabela    : TRegistroMsgLiberaTabela;
    objLinha     : TLinhaMsgLibera;
    objLiberacao : TLiberacao;
    strCodEmi,
    strDesEmi,
    strMarEmi,
    strUndEmi,
    strQtdEmi,
    strUniTar,
    strTotIte,
    strUniOri    : String;
    qryTabAux    : TUniQuery;
  Begin

    objLiberacao := TLiberacao.Create;

    qryTabAux := TUniQuery.Create(self);
    qryTabAux := fRetornaItens;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Senha para imprimir documento com preço');
    objLiberacao.objMsgLibera.pAddSeparador(75);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                   , fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [qryTabAux.FieldByName('FGO_CODCLI').AsString]) , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Número Dcumento'           , qryTabAux.FieldByName('FGO_NUMDOC').AsString                                                , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor Total do Documento'  , FormatFloat('#,##0.00', qryTabAux.FieldByName('FGO_VLRCON').AsFloat)                        , 24);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Código/Descrição' , 24 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Marca'            , 7  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Und.'             , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Quantidade'       , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Pr. Unitário'     , 13 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Valor Total'      , 14 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Pr. Tabela'       , 13 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
    With qryTabAux Do
    Begin
      First;

      While Not Eof Do
      Begin
        strCodEmi := FieldByName('ITE_CODITE').AsString;
        strDesEmi := FieldByName('ITE_DESITE').AsString;
        strMarEmi := FieldByName('MAR_DESMAR').AsString;
        strUndEmi := fRetSiglaUni(FieldByName('FDO_UNIDAD').AsString);
        strQtdEmi := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_QTDITE').AsFloat);
        strUniTar := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_UNITAR').AsFloat);
        strTotIte := FormatFloat(fMskDigitos(2), FieldByName('FDO_TOTITE').AsFloat);
        strUniOri := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_UNIORI').AsFloat);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Código/Descrição' , strCodEmi + '-' + strDesEmi  , 24 , alEsquerda );
        objLinha.pAddColuna('Marca'            , strMarEmi                    , 7  , alEsquerda );
        objLinha.pAddColuna('Und.'             , strUndEmi                    , 4  , alCentro   );
        objLinha.pAddColuna('Quantidade'       , strQtdEmi                    , 12 , alDireita  );
        objLinha.pAddColuna('Pr. Unitário'     , strUniTar                    , 13 , alDireita  );
        objLinha.pAddColuna('Valor Total'      , strTotIte                    , 14 , alDireita  );
        objLinha.pAddColuna('Pr. Tabela'       , strUniOri                    , 13 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        Next;
      End;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    objLiberacao.strDirAce := 'IMPDCP';
    objLiberacao.strMsgSen := 'Senha para imprimir documento com preço';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCliente := qryTabAux.FieldByName('FGO_CODCLI').AsString + '-' + fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [qryTabAux.FieldByName('FGO_CODCLI').AsString]);
    objLiberacao.strCpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [qryTabAux.FieldByName('FGO_CODCLI').AsString]);

    Result := objLiberacao.fLibera;

    freeAndNil(objLiberacao);
    freeAndNil(qryTabAux);


  End;

begin
  inherited;

  opcComSemPreco := IIF((edtPreco.Text = 'C'), impComPrecoGeral, impSemPrecoGeral) ;

  If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
  Begin
    If (edtPreco.Text = 'C') And (chkMarca.Checked) Then 
      opcComSemPreco := impComPrecoComMarca
    Else If (edtPreco.Text = 'C') And (Not chkMarca.Checked) Then 
      opcComSemPreco := impComPrecoSemMarca
    Else If (edtPreco.Text = 'S') And (chkMarca.Checked) Then   
      opcComSemPreco := impSemPrecoComMarca
    Else If (edtPreco.Text = 'S') And (Not chkMarca.Checked) Then     
      opcComSemPreco := impSemPrecoSemMarca;
  End;

  If (opcComSemPreco in [impComPrecoComMarca, impComPrecoGeral, impComPrecoSemMarca]) Then
  Begin
    If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And (Not fEmptyStr(fCfgSis('SENPRE'))) Then
    Begin
      opcComSemPreco := IIF(fMSG_SenhaImprimirComPreco, opcComSemPreco, impSemPrecoGeral);

      If (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
      Begin
        If (opcComSemPreco = impSemPrecoGeral) Then
        Begin
          Case fGetMenu('Opção para geração do PDF ("Sem Preço" pois não houve liberação!)',['Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
            1:opcComSemPreco := impSemPrecoComMarca;
            2:opcComSemPreco := impSemPrecoSemMarca;
          End;
        End;
      End;
    End;
  End;

  strTipExp := edtTipExp.Text;

  If (strTipExp = 'C') Then
    strTipExp := 'E';

  strEmails := fRetornarEmailsSelecionados + edtOutrosEmails.Text;
  If fEmptyStr(strEmails) Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum e-mail foi selecionado ou informado!', ['&Ok']);
    Exit;
  End;

  If (fVerificaCampos)                                       And
     (fMensagem('', 'Enviar e-mail?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmDigEmailPedOrcEditor.edtTipExpChange(Sender: TObject);
begin
  inherited;
  rdgNomEmp.Enabled := SameText(edtTipExp.Text, IIF((fCfgSis('EXPDOR') = 1), 'E', 'C'));
  edtOrdem.Enabled  := SameText(edtTipExp.Text, IIF((fCfgSis('EXPDOR') = 1), 'E', 'C'));
  lbl1.Enabled      := SameText(edtTipExp.Text, IIF((fCfgSis('EXPDOR') = 1), 'E', 'C'));
  lbl2.Enabled      := SameText(edtTipExp.Text, IIF((fCfgSis('EXPDOR') = 1), 'E', 'C'));
  edtModo.Enabled   := SameText(edtTipExp.Text, IIF((fCfgSis('EXPDOR') = 1), 'E', 'C'));
  clblModo.Enabled  := SameText(edtTipExp.Text, IIF((fCfgSis('EXPDOR') = 1), 'E', 'C'));
end;

procedure TfrmDigEmailPedOrcEditor.FormCreate(Sender: TObject);
begin
  inherited;
  cdsContatos.CreateDataSet;
  cdsContatos.EmptyDataSet;
end;

procedure TfrmDigEmailPedOrcEditor.FormShow(Sender: TObject);
begin
  inherited;

  If (fCfgSis('EXPDOR') = 2) Then
    lblPdfExc.Caption := '(P)df (C)alc-BrOffice';

  If Not fCfgSis('ORCSPR', varBoolean, VS_strCodEmp) Then
    edtPreco.Text := 'C';

  gbPreco.enabled  := fCfgSis('ORCSPR', varBoolean, VS_strCodEmp);
  lbl5.enabled     := lbl5.enabled;
  edtPreco.enabled := lbl5.enabled;

  {Carregar os contatos do cliente}
  If Not fEmptyStr(strCodCli) Then
    pCarregarContatosCliente(strCodCli);

end;

function TfrmDigEmailPedOrcEditor.fRetornarEmailsSelecionados: String;
begin

  If cdsContatos.IsEmpty Then
    Exit('');

  cdsContatos.DisableControls;

  Try

    Result := '';
    cdsContatos.First;
    While Not cdsContatos.Eof Do
    Begin

      If cdsContatosSELCTT.AsString = 'S' Then
        Result := Result + cdsContatosEMACTT.AsString + ';';

      cdsContatos.Next;

    End;

  Finally
    cdsContatos.EnableControls;
  End;

end;

function TfrmDigEmailPedOrcEditor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtOutrosEmails) Then
  Begin
    If (Pos('@', edtOutrosEmails.Text) <= 0) And (Not fEmptyStr(edtOutrosEmails.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', edtOutrosEmails.Text + ' não é um email válido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtModo) And (Pos(edtTipExp.Text, 'E_C_') > 0) Then
  Begin
    If Pos(edtModo.Text,'R_P_') <= 0 Then
    Begin
      fMensagem('','O campo Modo deve ser R ou P.',['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = edtTipExp) Then
  Begin
    If (fCfgSis('EXPDOR') = 1) And (Pos(edtTipExp.Text,'PE') <= 0) Then
    Begin
      fMensagem('','O campo Exportar em deve ser P ou E.',['&O K']);
      Result := False;
    End
    Else If (fCfgSis('EXPDOR') = 2) And (Pos(edtTipExp.Text,'PC') <= 0) Then
    Begin
      fMensagem('','O campo Exportar em deve ser P ou C.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtOrdem) And (grpOpcExcel.Enabled) Then
  Begin
    If Pos(edtOrdem.Text,'123') <= 0 Then
    Begin
      fMensagem('','O campo Ordem deve ser 1, 2 ou 3.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtEmpCab) And (grpOpcExcel.Enabled) Then
  Begin
    If (Pos(edtEmpCab.Text, '12') <= 0) Then
    Begin
      fMensagem('','O campo deve ser 1 ou 2.',['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = edtPreco) And (grpOpcExcel.Enabled) Then
  Begin
    If Pos(edtPreco.Text,'CS') <= 0 Then
    Begin
      fMensagem('','O campo Preço deve ser C ou S.',['&O K']);
      Result := False;
    End;
  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End;
end;


procedure TfrmDigEmailPedOrcEditor.pCarregarContatosCliente(ACodCli: String);
var
  qryCTT       : TUniQuery;
  EhConsumidor : Boolean;
const
  SQL_CON = ' SELECT        ' +
            '   CLI_NOMCTT, ' +
            '   CLI_EMACTT, ' +
            '   CLI_DEPCTT, ' +
            '   CLI_DPTCTT, ' +
            '   DPT_DESDPT  ' +
            ' FROM          ' +
            '   CLICTT      ' +
            '   LEFT JOIN CADDPT D ON (D.DPT_CODDPT = CLI_DPTCTT) ' +
            ' WHERE                                               ' +
            '   CLI_CODCLI = :CODCLI ';

  SQL_CLI = 'SELECT CLI_NOMCLI, CLI_FANSOB, CLI_EMAIL_, CLI_CGCCPF FROM CADCLI WHERE CLI_CODCLI = :CODCLI';

begin

  cdsContatos.EmptyDataSet;

  If fEmptyStr(ACodCli) Then
    Exit;

  qryCTT := fCriaQuery;

  Try

    {Consumidor}
    EhConsumidor := fClienteConsumidor(fRetNomCliente(ACodCli));

    If (EhConsumidor) Then
    Begin
      cdsContatos.Append;
      cdsContatosSELCTT.AsString := 'S'; {Já vem marcado!}
      cdsContatosNOMCTT.AsString := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'NOMCON');
      cdsContatosDEPCTT.AsString := '';
      cdsContatosEMACTT.AsString := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'EMLCON');
      cdsContatos.Post;
    End
    Else
    Begin

      {Cliente}
      qryCTT.Close;
      qryCTT.SQL.Clear;
      qryCTT.SQL.Add(SQL_CLI);
      qryCTT.ParamByName('CODCLI').AsString := ACodCli;
      qryCTT.Open;

      If Not qryCTT.IsEmpty Then
      Begin
        cdsContatos.Append;
        cdsContatosSELCTT.AsString := 'S'; {Já vem marcado!}
        If (qryCTT.FieldByName('CLI_CGCCPF').AsInteger = 1) And (Not fEmptyStr(qryCTT.FieldByName('CLI_FANSOB').AsString)) Then
          cdsContatosNOMCTT.AsString := qryCTT.FieldByName('CLI_FANSOB').AsString
        Else
          cdsContatosNOMCTT.AsString := qryCTT.FieldByName('CLI_NOMCLI').AsString;
        cdsContatosDEPCTT.AsString := '';
        cdsContatosEMACTT.AsString := qryCTT.FieldByName('CLI_EMAIL_').AsString;
        cdsContatos.Post;
      End;

      {Contatos}
      qryCTT.Close;
      qryCTT.SQL.Clear;
      qryCTT.SQL.Add(SQL_CON);
      qryCTT.ParamByName('CODCLI').AsString := ACodCli;
      qryCTT.Open;

      If Not qryCTT.IsEmpty Then
      Begin

        qryCTT.First;
        While Not qryCTT.Eof Do
        Begin

          cdsContatos.Append;
          cdsContatosSELCTT.AsString := 'N';
          cdsContatosNOMCTT.AsString := qryCTT.FieldByName('CLI_NOMCTT').AsString;
          cdsContatosDEPCTT.AsString := IIF(VS_strHabilitarCRM, qryCTT.FieldByName('DPT_DESDPT').AsString, qryCTT.FieldByName('CLI_DEPCTT').AsString);
          cdsContatosEMACTT.AsString := qryCTT.FieldByName('CLI_EMACTT').AsString;
          cdsContatos.Post;

          qryCTT.Next;

        End;

      End;

    End;

  Finally
    cdsContatos.First;
    FreeAndNil(qryCTT);
  End;

end;

end.
