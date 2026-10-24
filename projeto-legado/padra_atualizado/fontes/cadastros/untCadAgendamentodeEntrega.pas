unit untCadAgendamentodeEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Uni,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, cxGraphics, cxControls, cxLookAndFeels, StrUtils,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxGrid, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, DateUtils,
  untFuncoes;

type
  TfrmCadAgendamentodeEntrega = class(TfrmPaiCad)
    dtsAgeRec: TDataSource;
    pnlTopo: TPanel;
    Panel2: TPanel;
    lbl4: TLabel;
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodTra: TDBEditFocus;
    edtNomTra: TEditFocus;
    dbePlaca_: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDtaEnt: TDBEditFocus;
    dbeHraEnt: TDBEditFocus;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgDocumentosLevel: TcxGridLevel;
    Bevel1: TBevel;
    edtAcesso: TEditFocus;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtSerie: TEditFocus;
    Label30: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    cxgDocumentosTableViewADC_NUMDOC: TcxGridDBColumn;
    cxgDocumentosTableViewADC_ESPDOC: TcxGridDBColumn;
    cxgDocumentosTableViewADC_SERIE_: TcxGridDBColumn;
    cxgDocumentosTableViewADC_CODFOR: TcxGridDBColumn;
    cxgDocumentosTableViewFOR_NOMFOR: TcxGridDBColumn;
    edtEspDoc: TEditFocus;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgDocumentosTableViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAcessoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbePlaca_Exit(Sender: TObject);
  private
    cdsAgeDoc : TZClient;
    stlDocs: TStringList;
    blnTrfEnd: Boolean;

    procedure pSetMask;
    procedure pCarregaCadTra;
    procedure pCarregaDocumentos;

    function fGetSQLDocumentos : String;
    function fAdicionaDocumento(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp : String): Boolean;
    procedure pLimpaEditsDocumento;
    function fJáExisteAgendado(strCodigo, strCodTra, strPlaca_: String;
      dtaDtaEnt: TDate; Var strAutInc : String): Boolean;
    function fVerificaDocumentoOutosAgendamentos(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp : String; blnShowMessage : Boolean = True) : Boolean;
    function fVerificaDocumentos: Boolean;
    function fCarregarAgendamento(strAutInc: String): Boolean;
    function fIntervaloInvalido(strCodigo, strCodTra, strPlaca_: String): Boolean;
    function fValidaEmbalagensNota: Boolean;
    function fListaDocsToSQL: String;
    procedure pRemoverDocDaLista;
  public
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untTypesSistema;

procedure TfrmCadAgendamentodeEntrega.btnAlterarClick(Sender: TObject);
begin
  If qryTabela.isEmpty Then
    Exit;

  If qryTabela.FieldByName('ARC_STATUS').AsString <> 'AG' Then
  Begin
    fMensagem('', 'Não é possível alterar um agendamento com status diferente de "Recebimento Agendado"', ['&OK']);
    Exit;
  End;

  inherited;
  pHabilitaCodigo(dbeCodigo, dbeCodTra, False);
end;

procedure TfrmCadAgendamentodeEntrega.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsDocumento;
  pCarregaCadTra;
  pCarregaDocumentos;
end;

procedure TfrmCadAgendamentodeEntrega.btnExcluirClick(Sender: TObject);
  Var
    qryDelete : TUniQuery;    
begin

  If qryTabela.isEmpty Then
    Exit;

  If qryTabela.FieldByName('ARC_STATUS').AsString <> 'AG' Then
  Begin
    fMensagem('', 'Não é possível excluir um agendamento com status diferente de "Recebimento Agendado"', ['&OK']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  fStartTransaction;

  qryDelete := fCriaQuery;
  Try
    Try
      qryDelete.Close;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add(' SELECT * FROM AGEDOC WHERE ADC_SEQGER = :SEQGER ');
      qryDelete.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryDelete.Open;

      fVerificaIntegridade(Self.Name, 'AGEDOC', qryDelete, True, False);

      qryDelete.Close;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add(' DELETE FROM AGEDOC WHERE ADC_SEQGER = :SEQGER ');
      qryDelete.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryDelete.ExecSQL;

    Finally
      FreeAndNil(qryDelete);
    End;

    inherited;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCadAgendamentodeEntrega.btnExcluirClick');
      fRollBack;
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimpaEditsDocumento;
  pCarregaCadTra;
  cdsAgeDoc.EmptyDataSet;
  pCarregaDocumentos;
end;

procedure TfrmCadAgendamentodeEntrega.btnGravarClick(Sender: TObject);
  Var
    qryInsert : TUniQuery;
begin
  If (cdsAgeDoc.RecordCount <= 0) Then
  Begin
    fMensagem('', 'Nenhum Documento Para Salvar!', ['&OK']);
    Exit;
  End;

  If Not fVerificaDocumentos Then
    Exit;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try

    If fEmptyStr(ReplaceStr(qryTabela.FieldByName('ARC_PLACA_').AsString, '-','')) Then
      qryTabela.FieldByName('ARC_PLACA_').Clear;

    qryTabela.FieldByName('ARC_DTACAD').AsDateTime := VS_Date;

    inherited;

    If blnGravou Then
    Begin
      Try
        qryInsert := fCriaQuery(Self);
        cdsAgeDoc.First;
        cdsAgeDoc.DisableControls;

        With qryInsert, SQL Do
        Begin
          Close;
          Clear;
          Add(' DELETE FROM AGEDOC WHERE ADC_SEQGER = :SEQGER ');
          ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
          ExecSQL;

          Close;
          Clear;
          Add(' INSERT INTO AGEDOC ( ');
          Add('         AUTOINCREM,  ');
          Add('         ADC_SEQGER,  ');
          Add('         ADC_NUMDOC,  ');
          Add('         ADC_SERIE_,  ');
          Add('         ADC_CODFOR,  ');
          Add('         ADC_ESPDOC,  ');
          Add('         ADC_TIPINC,  ');
          Add('         ADC_CODEMP,  ');
          Add('         ADC_ACESSO)  ');
          Add(' VALUES (:AUTINC,     ');
          Add('         :SEQGER,     ');
          Add('         :NUMDOC,     ');
          Add('         :SERIE_,     ');
          Add('         :CODFOR,     ');
          Add('         :ESPDOC,     ');
          Add('         :TIPINC,     ');
          Add('         :CODEMP,     ');
          Add('         :ACESSO)     ');

          While Not cdsAgeDoc.Eof Do
          Begin
            ParamByName('AUTINC').AsString := cdsAgeDoc.FieldByName('AUTOINCREM').AsString;
            ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
            ParamByName('NUMDOC').AsString := cdsAgeDoc.FieldByName('ADC_NUMDOC').AsString;
            ParamByName('SERIE_').AsString := cdsAgeDoc.FieldByName('ADC_SERIE_').AsString;
            ParamByName('CODFOR').AsString := cdsAgeDoc.FieldByName('ADC_CODFOR').AsString;
            ParamByName('ESPDOC').AsString := cdsAgeDoc.FieldByName('ADC_ESPDOC').AsString;
            ParamByName('TIPINC').AsString := cdsAgeDoc.FieldByName('ADC_TIPINC').AsString;
            ParamByName('CODEMP').AsString := cdsAgeDoc.FieldByName('ADC_CODEMP').AsString;
            ParamByName('ACESSO').AsString := cdsAgeDoc.FieldByName('ADC_ACESSO').AsString;
            ExecSQL;

            cdsAgeDoc.Next;
          End;

        End;

        fCommit;
      Finally
        cdsAgeDoc.First;
        cdsAgeDoc.EnableControls;
        FreeAndNil(qryInsert);
      End;
    End
    Else
      fRollback;

  Except
    On E : Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, 'TfrmCadAgendamentodeEntrega.btnGravarClick');
    End;
  End;

end;

procedure TfrmCadAgendamentodeEntrega.btnIncluirClick(Sender: TObject);
begin
  inherited;

  qryTabela.fieldByName('ARC_STATUS').AsString := 'AG';

  pHabilitaCodigo(dbeCodigo, dbeCodTra, False);
  pCarregaCadTra;
  pSetMask;
  pCarregaDocumentos;
end;

procedure TfrmCadAgendamentodeEntrega.btnPesquisaClick(Sender: TObject);
  Var
    chrKey : Char;
    arrSel : TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqAgendamentoEntregaWMS(Self, Nil, qryTabela, chrKey, arrSel, True, '', '', True) Then
  Begin
    pCarregaCadTra;
    pSetMask;
    pSetFocus(btnAlterar);
    pCarregaDocumentos;
  End;
end;

procedure TfrmCadAgendamentodeEntrega.cxgDocumentosTableViewKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Shift = []) And
     (cdsAgeDoc.Active) And (cdsAgeDoc.RecordCount > 0) Then
  Begin
    If fMensagem('', 'Deseja remover o documento?', ['&Sim', '&Não'],2) = 1 Then
    Begin
      pRemoverDocDaLista;
      cdsAgeDoc.Delete;
    End;
  End;
end;

procedure TfrmCadAgendamentodeEntrega.dbeCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, dbeCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAgendamentodeEntrega.dbePlaca_Exit(Sender: TObject);
begin
  inherited;
  if Not fValidaCampos(dbePlaca_, True) Then
    pSetFocus(dbePlaca_);
end;

procedure TfrmCadAgendamentodeEntrega.edtAcessoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryLivroF : TUniQuery;
    arrSel    : TConsultasArray;
begin
  inherited;
  Try
    qryLivroF := fCriaQuery(Self);
    If fPesqLivroFiscal(Self, qryLivroF, Key, arrSel, True, conAgendamentoEntrega, 'F', '', '', '', True, 0, 0, True, VS_strCodEmp, True) Then
    Begin
      edtNumDoc.Text := qryLivroF.FieldByName('FIS_NUMDOC').AsString;
      edtEspDoc.Text := qryLivroF.FieldByName('FIS_ESPDOC').AsString;
      edtSerie.Text  := qryLivroF.FieldByName('FIS_SERIE_').AsString;
      edtCodFor.Text := qryLivroF.FieldByName('FIS_FORCLI').AsString;
      edtNomFor.Text := fRetNomFornecedor(qryLivroF.FieldByName('FIS_FORCLI').AsString);
      pSetFocus(edtCodFor);
    End;
  Finally
    FreeAndNil(qryLivroF);
  End;

end;

procedure TfrmCadAgendamentodeEntrega.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrConsulta : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, key, arrConsulta) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadAgendamentodeEntrega.fGetSQLDocumentos: String;
begin
  Result := '';
  Result := Result + ' SELECT A.*, FOR_NOMFOR,CAST("" AS CHAR(1)) AS ADC_TRANSF ';
  Result := Result + ' FROM AGEDOC A                                            ';
  Result := Result + ' INNER JOIN CADFOR B ON B.FOR_CODFOR = A.ADC_CODFOR       ';
  Result := Result + ' WHERE ADC_SEQGER = :SEQGER                               ';
end;

procedure TfrmCadAgendamentodeEntrega.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'AGEREC';
  strNomeCampo      := 'ARC_CODIGO';
  qryTabela         := fCriarQuery(' SELECT * FROM AGEREC WHERE FALSE', Self);
  dtsAgeRec.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  cdsAgeDoc := TZClient.Create(Self, fGetSQLDocumentos);
  cxgDocumentosTableView.DataController.DataSource := cdsAgeDoc.dtsSource;

  stlDocs := TStringList.Create;

  blnTrfEnd := fCfgSis('TRFEND', varBoolean);
end;

procedure TfrmCadAgendamentodeEntrega.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  FreeAndNil(stlDocs);
  inherited;
end;

function TfrmCadAgendamentodeEntrega.fValidaCampos(Sender: TWinControl;blnBuscaPorChave: Boolean): Boolean;
Var
  Documento : untTypesSistema.TDocumento;
  strAutInc : String;
  intQtdDig : Integer;
begin

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeCodTra) Then
    Begin
      If fEmptyStr(dbeCodTra.Text) Then
      Begin
        edtNomTra.Clear;
        Result := fMensagem('', 'Informe o Código da Transportadora!', ['&Ok']) = -1;
      End
      Else
      Begin
        pCarregaCadTra;
        If fEmptyStr(edtNomTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeDtaEnt) Then
    Begin
      If fEmptyDate(dbeDtaEnt.Text) Then
      Begin
        Result := fMensagem('', 'Informe a Data de Entrega!', ['&Ok']) =-1;
      End

      Else
      If ( StrToDateDef(dbeDtaEnt.Text, 0) < StrToDate(DateToStr(fNow)) ) Then
      Begin
        Result := fMensagem('', 'A Data de Entrega Deve ser Maior ou Igual a Data de Hoje!', ['&Ok']) =-1;
      End

      Else
      Begin
        If Not fCfgSis('MAGREC', varBoolean)  Then
          Result := Not fJáExisteAgendado(dbeCodigo.Text, dbeCodTra.Text, dbePlaca_.Text, StrToDateDef(dbeDtaEnt.Text,0), strAutInc);
      End;

    End

    Else If (Sender = dbeHraEnt ) Then
    Begin
      If fCfgSis('MAGREC', varBoolean) And (fCfgSis('TPLREC') = 'C') Then
      Begin
        If fEmptyTime(dbeHraEnt.Text) Then
          Result := fMensagem('', 'A Hora deve ser informada!', ['&Ok']) =-1
        Else
        Begin
          Result := Not fIntervaloInvalido(dbeCodigo.Text, dbeCodTra.Text, dbePlaca_.Text);
        End;
      End
    End

    Else
    If (Sender = edtNumDoc) and blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
        Result := fMensagem('','Digite o Número do Documento!', ['&Ok']) = -1;
    End

    Else
    If (Sender = edtAcesso) Then
    Begin
      If Not fEmptyStr(edtAcesso.Text) Then
      Begin
        Documento := fConverteCodigoBarrasChaveAcesso(edtAcesso.Text, True);

        If Result and (fBuscaMatRevGerele(Documento.strNumDoc, Documento.strEspDoc, Documento.strSerie, Documento.strCodEmp, Documento.strCliFor) = 'M') Then
          Result := fMensagem('', 'Entrada de Material de Consumo não gera agendamento!', ['&OK']) = -1;
        If Documento.strFalha <> '' Then
          Result := fMensagem('', Documento.strFalha, ['&OK']) = -1;

        If (Not fEmptyStr(Documento.strNumDoc)) And (Documento.strCodEmp <> VS_strCodEmp) Then
          Result := fMensagem('', 'A Chave de acesso digitada pertence a outra empresa!', ['&OK']) = -1;

        If Result And fApenasClaRet(Documento.strNumDoc,
                         Documento.strEspDoc,
                         Documento.strSerie,
                         Documento.strCliFor,
                         Documento.strCodEmp) Then
          Result := fMensagem('', 'O Documento tem apenas classificação definida na [CFG_CLARET] e foi marcada para não movimentar estoque, logo não gera agendamento !', ['&OK']) = -1;


        If Not Result Then
          Exit;

        If (Not fEmptyStr(Documento.strNumDoc)) Then
        Begin
          Result := fAdicionaDocumento(Documento.strNumDoc,
                                       Documento.strEspDoc,
                                       Documento.strSerie,
                                       Documento.strCliFor,
                                       Documento.strCodEmp);
          If Result Then
          Begin
            blnMudarFoco := False;
            pSetFocus(edtAcesso);
            pLimpaEditsDocumento;
          End;
        End
        Else
        Begin
          Result := fMensagem('', 'Chave de Acesso não encontrada, Verifique se já foi feito a entrada de Mercadorias!', ['&OK']) = -1;
        End;

      End;
    End

    Else
    If (Sender = edtCodFor) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        Result := fMensagem('', 'Digite o Código do Forncedor!', ['&OK']) = -1;
      End
      Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          Result := fMensagem('', 'O Código de Fornecedor Digitado Não Existe!', ['&OK']) = -1;
        End
        Else
        Begin
          Result := fAdicionaDocumento(edtNumDoc.Text, edtEspDoc.Text, edtSerie.Text, edtCodFor.Text, VS_strCodEmp);
          If Result Then
          Begin
            blnMudarFoco := False;
            pSetFocus(edtAcesso);
            pLimpaEditsDocumento;
          End;
        End;

      End;

    End

    Else If (Sender = dbePlaca_) Then
    Begin
      intQtdDig := Length(ReplaceStr(ReplaceStr(dbePlaca_.Text,'-', ''), ' ', ''));
      If (intQtdDig > 0) And (intQtdDig <> 7) Then
      Begin
        pMensagemOk('A placa deve conter 7 dígitos!');
        Result := False;
      End
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmCadAgendamentodeEntrega.fJáExisteAgendado(strCodigo, strCodTra,
  strPlaca_: String; dtaDtaEnt : TDate; Var strAutInc : String):Boolean;
Var
  qryConsul : TUniQuery;
Begin
  qryConsul := fCriaQuery;
  Try
    With qryConsul, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT * FROM AGEREC        ');
      Add(' WHERE ARC_CODIGO <> :CODIGO ');
      Add('   AND ARC_CODTRA =  :CODTRA ');
      If fEmptyStr(ReplaceStr(strPlaca_,'-','')) Then
        Add('   AND ARC_PLACA_ IS NULL ')
      Else
        Add('   AND ARC_PLACA_ =  :PLACA_ ');
      Add('   AND ARC_DTAENT =  :DTAENT ');

      ParamByName('CODIGO').AsString   := strCodigo;
      ParamByName('CODTRA').AsString   := strCodTra;
      If FindParam('PLACA_') <> Nil Then
        ParamByName('PLACA_').AsString   := strPlaca_;
      ParamByName('DTAENT').AsDateTime := dtaDtaEnt;

      Open;

      Result := Not IsEmpty;

      strAutInc := '';

      If Result Then
      Begin
        strAutInc := FieldByName('AUTOINCREM').AsString;
        Result := fCarregarAgendamento(strAutInc);
      End;

      Close;
    End;

  Finally
    FreeAndNIl(qryConsul);
  End;

End;

function  TfrmCadAgendamentodeEntrega.fIntervaloInvalido(strCodigo, strCodTra, strPlaca_: String): Boolean;
var
  strIntervalo: string;
  intIntervalo: integer;
  qryTemp : TUniQuery;
  dataInicial: String;
begin
  strIntervalo := fCfgSis('IAGREC');
  TryStrToInt(strIntervalo, intIntervalo);
  Result := False;
  If (intIntervalo > 0) Then
  Begin

    qryTemp := fCriaQuery;
    Try

      qryTemp.Close;
      qryTemp.SQL.Clear;

      dataInicial := FormatDateTime('YYYY-MM-DD', StrToDate(dbeDtaEnt.Text));
      dataInicial := dataInicial + ' ' + dbeHraEnt.Text + ':00';




      qryTemp.SQL.Add('SET @DATAHORA_BETWEEN = "' +  dataInicial + '";');
      qryTemp.SQL.Add('SELECT  * FROM');
      qryTemp.SQL.Add('(');
      qryTemp.SQL.Add(' SELECT');
      qryTemp.SQL.Add('    CAST(CONCAT(ARC_DTAENT, " ",  ARC_HRAENT) AS DATETIME) AS DATA_HORA');
      qryTemp.SQL.Add('    FROM AGEREC');
      qryTemp.SQL.Add('');
      qryTemp.SQL.Add(' WHERE ARC_CODIGO <> "'+strCodigo+'"');
      qryTemp.SQL.Add('   AND ARC_CODTRA =  :CODTRA ');
      qryTemp.SQL.Add('   AND ARC_PLACA_ =  :PLACA_ ) TMP');
      qryTemp.SQL.Add('   WHERE DATA_HORA BETWEEN  ADDTIME(@DATAHORA_BETWEEN, "-'+IntToStr(intIntervalo-1)+':59:00") AND ADDTIME(@DATAHORA_BETWEEN, "'+IntToStr(intIntervalo-1)+':59:00")');

      qryTemp.ParamByName('CODTRA').AsString   := strCodTra;
      If qryTemp.FindParam('PLACA_') <> Nil Then
       qryTemp.ParamByName('PLACA_').AsString   := strPlaca_;

      qryTemp.Open;

      Result := Not qryTemp.IsEmpty;

      If Result Then
        fMensagem('', 'Intervalo de horas não permitido para esse agendamento.'#13#10' Intervalo mínimo: '+ Format('%s:00h',[fCfgSis('IAGREC')]), ['&Ok']);

      qryTemp.Close;


    Finally
      FreeAndNIl(qryTemp);
    End;
  End;
end;

function TfrmCadAgendamentodeEntrega.fCarregarAgendamento(strAutInc: String): Boolean;
begin

  Result := fPergunta('Já existe um agendamento com esses dados, deseja carregá-lo?');

  If Result Then
  Begin
    btnCancelaClick(Nil);

    qryTabela.Close;
    qryTabela.SQL.Text := 'SELECT * FROM AGEREC WHERE AUTOINCREM = ' + QuotedStr(strAutInc);
    qryTabela.Open;

    pCarregaCadTra;
    pSetMask;
    pCarregaDocumentos;

    btnAlterarClick(Nil);

    blnMudarFoco := False;
    pSetFocus(dbeCodtra);
  End;
end;

Function TfrmCadAgendamentodeEntrega.fAdicionaDocumento(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp : String):Boolean;
  Var
    strAcesso : String;
    strCgcTra : String;
    strErro : String;
    strAutIncMovGer: String;
    blnCFOP_922: Boolean;
Begin

  strAutIncMovGer := fCampoTabela('AUTOINCREM', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_SERIE_', 'GER_CODFOR', 'GER_CODEMP'], [strNumDoc, strEspDoc, strSerie_, strCodFor, VS_strCodEmp]);
  If Not fEmptyStr(strAutIncMovGer) Then
  Begin
    stlDocs.Add(strAutIncMovGer);

    If Not fValidaEmbalagensNota Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  strAcesso := fRetChaveAcesso(strNumDoc, strEspDoc, strCodFor, strCodEmp, strSerie_, 'F');

  Result := not fEmptyStr(strAcesso);

  If Result And cdsAgeDoc.Locate('ADC_ACESSO', strAcesso, []) Then
  Begin
    Result := fMensagem('','Documento já incluso no Agendamento Atual!', ['&Ok']) = -1;
    Exit;
  End
  Else If fEmptyStr(strAcesso) Then
  Begin
    If cdsAgeDoc.Locate('ADC_NUMDOC;ADC_SERIE_;ADC_CODFOR;ADC_ESPDOC', VarArrayOf([strNumDoc, strSerie_, strCodFor, strEspDoc]), []) Then
    Begin
      Result := fMensagem('','Documento já incluso no Agendamento Atual!', ['&Ok']) = -1;
      Exit;
    End;
  End;

  Result := fEntradaExiste(strNumDoc, strEspDoc, strCodFor, strCodEmp, strSerie_, strCgcTra, strErro, blnCFOP_922, True);
  
  If Result and (fBuscaMatRevGerele(strNumDoc, strEspDoc, strSerie_, strCodEmp, strCodFor) = 'M') Then
    strErro := 'Entrada de Material de Consumo não gera agendamento!';

  If Result  And fApenasClaRet(strNumDoc,
                               strEspDoc,
                               strSerie_,
                               strCodFor,
                               strCodEmp) Then
    Result := fMensagem('', 'O Documento tem apenas classificação definida na [CFG_CLARET] e foi marcada para não movimentar estoque, logo não gera agendamento !', ['&OK']) = -1;

  If Result And (strErro <> '') Then
  Begin
    result := False;
    pMensagemOk(strErro);
    Exit;
  End;

  If blnCFOP_922 Then
  Begin
    Result := fMensagem('','Documento com CFOP x922 não pode ser agendado!', ['&Ok']) = -1;
    Exit;
  End; 
 (*If Result Then
  Begin
    If (strCgcTra <> fCampoTabela('TRA_C_G_C_', 'CADTRA', ['TRA_CODTRA'], [dbeCodTra.Text])) Then
    Begin
      Result := fMensagem('','Transportadora do Documento divergente da Transportadora do Agendamento Atual!' + #13 +
                             'Transportadora do Documento: ' + strCgcTra, ['&Ok']) = -1;
      Exit;
    End;

  End;*)

  If Not fVerificaDocumentoOutosAgendamentos(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp) Then
  Begin
    Result := False;
    Exit;
  End;

  If (blnTrfEnd) And (Not fEmptyStr(cdsAgeDoc.FieldByName('ADC_TRANSF').AsString)) Then
  Begin
    If (IIF(fFornecedorFilial(strCodFor),'S','N') <> cdsAgeDoc.FieldByName('ADC_TRANSF').AsString) Then
    Begin
      pMensagemOk('Com a configuração [CFG_TRFEND] ligada, não é possivel vincular notas de transferência com notas normais no agendamento de recebimento de mercadorias!');
      Result := False;
      Exit;
    End;
  End;

  If Result Then
  Begin
    cdsAgeDoc.Append;
    cdsAgeDoc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AGEDOC', VS_strCodEmp);
    cdsAgeDoc.FieldByName('ADC_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    cdsAgeDoc.FieldByName('ADC_NUMDOC').AsString := strNumDoc;
    cdsAgeDoc.FieldByName('ADC_SERIE_').AsString := strSerie_;
    cdsAgeDoc.FieldByName('ADC_CODFOR').AsString := strCodFor;
    cdsAgeDoc.FieldByName('ADC_ESPDOC').AsString := strEspDoc;
    cdsAgeDoc.FieldByName('ADC_TIPINC').AsString := 'A';
    cdsAgeDoc.FieldByName('ADC_CODEMP').AsString := strCodEmp;
    cdsAgeDoc.FieldByName('ADC_ACESSO').AsString := strAcesso;
    cdsAgeDoc.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(strCodFor);
    cdsAgeDoc.FieldByName('ADC_TRANSF').AsString := IIF(fFornecedorFilial(strCodFor), 'S', 'N');
    cdsAgeDoc.Post;

    If Not fEmptyStr(strAutIncMovGer) Then
      stlDocs.Add(strAutIncMovGer);
  End
  Else
    fMensagem('', 'Documento não encontrado no Registro do Livro Fiscal!', ['&OK']);

End;

procedure TfrmCadAgendamentodeEntrega.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadAgendamentodeEntrega.pCarregaCadTra;
Begin
  if fEmptyStr(dbeCodTra.Text) = False then
    edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text)
  else
    edtNomTra.Clear;
End;

procedure TfrmCadAgendamentodeEntrega.pCarregaDocumentos;
var
  strAutIncMovGer,
  strNumDoc,
  strEspDoc,
  strSerie_,
  strCodFor: String;
begin
  Try
    cdsAgeDoc.qryQuery.Close;
    cdsAgeDoc.qryQuery.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    cdsAgeDoc.fAbreClient(True, 'TfrmCadAgendamentodeEntrega.pCarregaDocumentos');
  Finally
    stlDocs.Clear;
    cdsAgeDoc.First;
    While Not cdsAgeDoc.Eof Do
    Begin
      strNumDoc := cdsAgeDoc.FieldByname('ADC_NUMDOC').AsString;
      strEspDoc := cdsAgeDoc.FieldByname('ADC_ESPDOC').AsString;
      strSerie_ := cdsAgeDoc.FieldByname('ADC_SERIE_').AsString;
      strCodFor := cdsAgeDoc.FieldByname('ADC_CODFOR').AsString;
      strAutIncMovGer := fCampoTabela('AUTOINCREM', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_SERIE_', 'GER_CODFOR', 'GER_CODEMP'], [strNumDoc, strEspDoc, strSerie_, strCodFor, VS_strCodEmp]);
      If Not fEmptyStr(strAutIncMovGer) Then
        stlDocs.Add(strAutIncMovGer);

        cdsAgeDoc.Next;
    End;
  End;
end;

procedure TfrmCadAgendamentodeEntrega.pSetMask;
begin
  TStringField(qryTabela.FieldByName('ARC_PLACA_')).EditMask := '>aaa-9a99;1;';
  TStringField(qryTabela.FieldByName('ARC_DTAENT')).EditMask := '99/99/9999';
  TStringField(qryTabela.FieldByName('ARC_HRAENT')).EditMask := '99:99';
  TDateTimeField(qryTabela.FieldByName('ARC_HRAENT')).DisplayFormat := 'hh:mm';
end;

procedure TfrmCadAgendamentodeEntrega.pLimpaEditsDocumento;
Begin
  edtAcesso.Clear;
  edtNumDoc.Clear;
  edtSerie.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
End;


Function TfrmCadAgendamentoDeEntrega.fVerificaDocumentoOutosAgendamentos(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp : String; blnShowMessage : Boolean = True) : Boolean;
  Var
    qryConsul : TUniQuery;
Begin
  Try
    qryConsul := fCriaQuery;
    With qryConsul, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT ARC_CODIGO AS CODIGO,                     ');
      Add('        TRA_CODTRA AS CODTRA,                     ');
      Add('        TRA_NOMTRA AS NOMTRA                      ');
      Add(' FROM AGEDOC                                      ');
      Add(' INNER JOIN AGEREC R ON R.AUTOINCREM = ADC_SEQGER ');
      Add(' INNER JOIN CADTRA T ON T.TRA_CODTRA = ARC_CODTRA ');
      Add(' WHERE ADC_NUMDOC = :NUMDOC                       ');
      Add('   AND ADC_SERIE_ = :SERIE_                       ');
      Add('   AND ADC_CODFOR = :CODFOR                       ');
      Add('   AND ADC_ESPDOC = :ESPDOC                       ');
      Add('   AND ADC_CODEMP = :CODEMP                       ');

      If not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
        Add(' AND ADC_SEQGER <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString));

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('SERIE_').AsString := strSerie_;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := IsEmpty;

      If (Not Result) And blnShowMessage Then
        fMensagem('', 'O Documento digitado já se encontra em outro agendamento!' + #13 +
                      'Código: ' + FieldByName('CODIGO').AsString + ' - Transportadora : ' +
                      FieldByName('CODTRA').AsString + ' - ' + FieldByName('NOMTRA').AsString,['&Ok']);
    End;

  Finally
    FreeAndNil(qryConsul);
  End;

End;


Function TfrmCadAgendamentoDeEntrega.fVerificaDocumentos : Boolean;
  Var
    strDocumentos : String;
Begin
  Try
    strDocumentos := '';
    cdsAgeDoc.DisableControls;
    cdsAgeDoc.First;
    While not cdsAgeDoc.Eof Do
    Begin
      If not fVerificaDocumentoOutosAgendamentos(cdsAgeDoc.FieldByName('ADC_NUMDOC').AsString,
                                                 cdsAgeDoc.FieldByName('ADC_ESPDOC').AsString,
                                                 cdsAgeDoc.FieldByName('ADC_SERIE_').AsString,
                                                 cdsAgeDoc.FieldByName('ADC_CODFOR').AsString,
                                                 cdsAgeDoc.FieldByName('ADC_CODEMP').AsString,
                                                 False) Then
      Begin
        strDocumentos := strDocumentos + cdsAgeDoc.FieldByName('ADC_NUMDOC').AsString + '-' +
                                         cdsAgeDoc.FieldByName('ADC_ESPDOC').AsString + '-' +
                                         cdsAgeDoc.FieldByName('ADC_SERIE_').AsString + '-' +
                                         cdsAgeDoc.FieldByName('ADC_CODFOR').AsString + '-' +
                                         cdsAgeDoc.FieldByName('ADC_CODEMP').AsString + #13;
      End;

      cdsAgeDoc.Next;
    End;

    Result := fEmptyStr(strDocumentos);
    If not Result Then
      fMensagem('', 'Os documentos a baixo já estão em outro plano de recebimento:' + #13 + strDocumentos, ['&OK']);

  Finally
    cdsAgeDoc.First;
    cdsAgeDoc.EnableControls;
  End;

End;

function TFrmCadAgendamentodeEntrega.fListaDocsToSQL: String;
var
  strItens: String;
  I: Integer;
Begin
  If stlDocs.Count = 0 Then
    Exit('');

  For I := 0 To stlDocs.Count-1 Do
    strItens := strItens + IIF(fEmptyStr(strItens),'',',') + QuotedStr(stlDocs[I]);

  Result := strItens;
End;

function TFrmCadAgendamentodeEntrega.fValidaEmbalagensNota: Boolean;
var
  qryCons: TUniQuery;
  stlItens: TStringList;
begin

  qryCons := fCriaQuery;
  Try
    qryCons.SQL.Clear;
    qryCons.SQL.Add('  SELECT                                             ');
    qryCons.SQL.Add('    COUNT(1) AS QTD,                                 ');
    qryCons.SQL.Add('    DET_CODITE                                       ');
    qryCons.SQL.Add('  FROM                                               ');
    qryCons.SQL.Add(' (  SELECT                                           ');
    qryCons.SQL.Add('      DET_CODITE,                                    ');
    qryCons.SQL.Add('      TRI_EMBALA AS CODITE                           ');
    qryCons.SQL.Add('    FROM                                             ');
    qryCons.SQL.Add('      MOVDET                                         ');
    qryCons.SQL.Add('      INNER JOIN MOVGER                              ');
    qryCons.SQL.Add('        ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER     ');
    qryCons.SQL.Add('      INNER JOIN MOVTRI                              ');
    qryCons.SQL.Add('        ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM     ');
    qryCons.SQL.Add('    WHERE MOVDET.DET_SEQGER IN ( ' + fListaDocsToSQL + ')');
    qryCons.SQL.Add('    GROUP BY DET_CODITE,IFNULL(TRI_EMBALA, 1)) TMP   ');
    qryCons.SQL.Add('   GROUP BY DET_CODITE                               ');
    qryCons.SQL.Add('   HAVING QTD > 1;                                   ');

    qryCons.Open;

    Result := qryCons.IsEmpty;

    If Not Result Then
    Begin
      stlItens := TStringList.Create;
      Try
        qryCons.First;
        While Not qryCons.Eof Do
        Begin
          stlItens.Add(qryCons.FieldByName('DET_CODITE').AsString);

          qryCons.Next;
        End;

        pMensagemOk('Não é possível adicionar essa nota pois os itens abaixo possuem embalagens diferentes no documento: '+ #13 + stlItens.CommaText);

      Finally
        FreeAndNil(stlItens);
      End;
    End;

  Finally
    // Sempre remove o ultimo AUTINC da MOVGER da, lista para somente se passar por todas as validaçõs na fAdicionarDocumento ele manter salvo nela
    stlDocs.Delete(stlDocs.Count-1);
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCadAgendamentoDeEntrega.pRemoverDocDaLista;
var
  strAutIncMovGer,
  strNumDoc,
  strEspDoc,
  strSerie_,
  strCodFor: String;
begin
  strNumDoc := cdsAgeDoc.FieldByname('ADC_NUMDOC').AsString;
  strEspDoc := cdsAgeDoc.FieldByname('ADC_ESPDOC').AsString;
  strSerie_ := cdsAgeDoc.FieldByname('ADC_SERIE_').AsString;
  strCodFor := cdsAgeDoc.FieldByname('ADC_CODFOR').AsString;
  strAutIncMovGer := fCampoTabela('AUTOINCREM', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_SERIE_', 'GER_CODFOR', 'GER_CODEMP'], [strNumDoc, strEspDoc, strSerie_, strCodFor, VS_strCodEmp]);
  If Not fEmptyStr(strAutIncMovGer) Then
    stlDocs.Delete(stlDocs.IndexOf(strAutIncMovGer));
end;

end.

