unit untFatDigCartaCorrecao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, ComboBoxFocus, EditFocus,
  BitBtnLockedIncrem, Uni, UniClientDataSet, StrUtils, ImgList,
  cxEditRepositoryItems, Mask, MaskEditFocus, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  untTypesSistema, untConsultas, System.ImageList,
  Datasnap.DBClient, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxImageList, cxProgressBar, untInterfaces;

type
  TfrmFatDigCartaCorrecao = class(TfrmPai)
    pnlTop: TPanel;
    dbgCorrecoesDBTableView1: TcxGridDBTableView;
    dbgCorrecoesLevel1: TcxGridLevel;
    dbgCorrecoes: TcxGrid;
    Label14: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtEspDoc: TEditFocus;
    edtChaveAcesso: TEditFocus;
    Label15: TLabel;
    pnlCorrecoes: TPanel;
    Label1: TLabel;
    cmbCorrecoes: TComboBoxFocus;
    Label2: TLabel;
    edtDescricao: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    CCN_CODCOR: TcxGridDBColumn;
    CCN_NOMCOR: TcxGridDBColumn;
    CCN_DESCOR: TcxGridDBColumn;
    CCN_DTAENV: TcxGridDBColumn;
    CCN_ENVIAD: TcxGridDBColumn;
    btnConfirmaDados: TBitBtnLocked;
    cdsCorrecoes: TUniClientDataSet;
    cdsCorrecoesCCN_SEQGER: TStringField;
    cdsCorrecoesCCN_NOMCOR: TStringField;
    cdsCorrecoesCCN_DESCOR: TStringField;
    dtsCorrecoes: TDataSource;
    cdsCorrecoesCCN_ENVIAD: TIntegerField;
    cdsCorrecoesAUTOINCREM: TStringField;
    cdsCorrecoesCCN_CODCOR: TStringField;
    cxEditRepository: TcxEditRepository;
    cmbImagens: TcxEditRepositoryImageComboBoxItem;
    imgImagens: TcxImageList;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label4: TLabel;
    cdsCorrecoesCCN_DTAENV: TStringField;
    btnCancelar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    Label5: TLabel;
    lblCar: TLabel;
    cdsCorrecoesCCN_PROTOC: TStringField;
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure dbgCorrecoesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsCorrecoesAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    strAutIncSelecionado: String;
    intSequencial: Integer;
    strProtocolo : String;
    strMensagem : String;
    blnAtualizaProtocolo : Boolean;
    procedure pCarregarCorrecoes(strAutInc: String);
    function fRetornaNomeCorrecao(const strTexto: String): String;
    procedure pLimparDadosCorrecao;
    function fEnviarCorrecoesNFe(pgbProgresso: TcxProgressBar): Boolean;
    function fLimpaCaracteresInvalidos(strTexto: String): String;
    function fMontaMensagemCorrecao: TStringList;
    procedure pCarregaMotivos;
    procedure pMarcaCorrecoesComoEnviadas;
    procedure pSalvaNovasCorrecoes;
    procedure pApagaCorrecao(strAutInc: String);
    function fRetornaProximoSequencial: Integer;
    function fRetornaLinhaNaoEnviadaCartaCorrecao(cds: TDataSet):String;
    function fRetonarCaractesRestante: Integer;
    procedure pProcessaExibeCaractesRestante;
    function fExisteDocumentosPendentes: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untLibNfe, untConstantes, untConstantesNFe, untGravando;

{$R *.dfm}

procedure TfrmFatDigCartaCorrecao.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparDadosCorrecao;
  pSetFocus(cmbCorrecoes);
end;

procedure TfrmFatDigCartaCorrecao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  strAutIncSelecionado := '';
  intSequencial := 0;
  edtNumDoc.Clear;
  edtSerie.Clear;
  edtEspDoc.Clear;
  edtChaveAcesso.Clear;
  pLimparDadosCorrecao;
  cdsCorrecoes.EmptyDataSet;

  pSetFocus(mskDtaIni);
end;

procedure TfrmFatDigCartaCorrecao.btnAdicionarClick(Sender: TObject);
  Var
    intAux: Integer;
begin
  inherited;
  If fEmptyStr(edtNumDoc.Text) Then
  Begin
    pMensagemOk('É necessário escolher um documento.');
    Exit;
  End;

  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  intAux := fRetonarCaractesRestante;

  cdsCorrecoes.Append;
  cdsCorrecoesCCN_CODCOR.AsString := LeftStr(cmbCorrecoes.Text, 5);
  cdsCorrecoesCCN_NOMCOR.AsString := fRetornaNomeCorrecao(cmbCorrecoes.Text);
  cdsCorrecoesCCN_DESCOR.AsString := edtDescricao.Text;
  cdsCorrecoesCCN_ENVIAD.AsInteger := 0;

  intAux := intAux - Length(fRetornaLinhaNaoEnviadaCartaCorrecao(cdsCorrecoes));
  If (intAux < 0) Then
  Begin
    cdsCorrecoes.Cancel;
    fMensagem('Atenção!', 'O envio da carta de correção é limitado a 1.000 caracteres.'+#10#13+
                          'Envie as correções já cadastradas através do botão [F10] enviando o restante das correções em uma etapa posterior.', ['&O k']);
  End
  Else
  Begin
    cdsCorrecoes.Post;
  End;

  pLimparDadosCorrecao;
  pSetFocus(cmbCorrecoes);
end;

procedure TfrmFatDigCartaCorrecao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If cdsCorrecoes.IsEmpty Then
  Begin
    Exit;
  End;

  If (fRetonarCaractesRestante < 0) Then
  Begin
    fMensagem('Atenção!', 'O envio da carta de correção é limitado a 1.000 caracteres.'+#10#13+
                          'Exclua alguns itens ou ajuste o texto do mesmos, até o indicador abaixo apontar uma contagem maior/igual a zero, enviando o restante em uma etapa posterior.', ['&O k']);
    Exit;
  End;

  pSalvaNovasCorrecoes;

  If not fExisteDocumentosPendentes Then
  Begin
    fMensagem('Atenção!', 'Não existe correções pendentes para envio.', ['&Ok']);
    Exit;
  End;

  intSequencial := fRetornaProximoSequencial;

  strProtocolo := EmptyStr;

  If TfrmGravando.fExecuta(fEnviarCorrecoesNFe, frmGravando, 'Por favor, aguarde...', False) Then
  Begin
    If not fEmptyStr(strProtocolo) Then
    Begin
      pMarcaCorrecoesComoEnviadas;
      pCarregarCorrecoes(strAutIncSelecionado);
    End;

    If not fEmptyStr(strMensagem) Then
    Begin
      fMensagem('Aviso', strMensagem, ['&Ok']);
    End;
  End;
end;

procedure TfrmFatDigCartaCorrecao.cdsCorrecoesAfterPost(DataSet: TDataSet);
begin
  inherited;
  pProcessaExibeCaractesRestante;
end;

procedure TfrmFatDigCartaCorrecao.pSalvaNovasCorrecoes;
  Var
    qryIns: TUniQuery;
begin
  qryIns := fCriaQuery(Self);
  qryIns.SQL.Add('INSERT INTO CC_NFE ( ');
  qryIns.SQL.Add('  CCN_SEQGER, ');
  qryIns.SQL.Add('  AUTOINCREM, ');
  qryIns.SQL.Add('  CCN_CODCOR, ');
  qryIns.SQL.Add('  CCN_NOMCOR, ');
  qryIns.SQL.Add('  CCN_DESCOR, ');
  qryIns.SQL.Add('  CCN_ENVIAD) ');
  qryIns.SQL.Add('VALUES ( ');
  qryIns.SQL.Add('  :SEQGER, ');
  qryIns.SQL.Add('  :AUTINC, ');
  qryIns.SQL.Add('  :CODCOR, ');
  qryIns.SQL.Add('  :NOMCOR, ');
  qryIns.SQL.Add('  :DESCOR, ');
  qryIns.SQL.Add('  :ENVIAD) ');

  cdsCorrecoes.First;
  While (Not cdsCorrecoes.Eof) Do
  Begin
    If fEmptyStr(cdsCorrecoesCCN_SEQGER.AsString) Then
    Begin
      Try
        qryIns.Close;
        qryIns.ParamByName('SEQGER').AsString := strAutIncSelecionado;
        qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('CC_NFE', VS_strCodEmp);
        qryIns.ParamByName('CODCOR').AsString := cdsCorrecoesCCN_CODCOR.AsString;
        qryIns.ParamByName('NOMCOR').AsString := cdsCorrecoesCCN_NOMCOR.AsString;
        qryIns.ParamByName('DESCOR').AsString := cdsCorrecoesCCN_DESCOR.AsString;
        qryIns.ParamByName('ENVIAD').AsInteger := 0;
        qryIns.ExecSQL;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmFatDigCartaCorrecao.pSalvaNovasCorrecoes]');
        End;
      End;
    End;
    
    cdsCorrecoes.Next;
  End;
  pCarregarCorrecoes(strAutIncSelecionado);
end;

procedure TfrmFatDigCartaCorrecao.pMarcaCorrecoesComoEnviadas;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  Try
    qryAux.SQL.Add(' UPDATE CC_NFE ');
    qryAux.SQL.Add('    SET CCN_ENVIAD = 1 ');
    qryAux.SQL.Add('       ,CCN_DTAENV = ' + fCurrentDateTime);

    If (blnAtualizaProtocolo) Then
      qryAux.SQL.Add('     ,CCN_PROTOC = :PROTOC ');

    qryAux.SQL.Add('       ,CCN_CODSEQ = :CODSEQ ');
    qryAux.SQL.Add('  WHERE CCN_SEQGER = :SEQGER ');
    qryAux.SQL.Add('    AND CCN_ENVIAD = 0 ');

    qryAux.ParamByName('SEQGER').AsString := strAutIncSelecionado;
    qryAux.ParamByName('CODSEQ').AsInteger := intSequencial;

    If (blnAtualizaProtocolo) Then
      qryAux.ParamByName('PROTOC').AsString := strProtocolo;

    qryAux.ExecSQL;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatDigCartaCorrecao.pMarcaCorrecoesComoEnviadas]');
    End;
  End;
  FreeAndNil(qryAux);
end;

procedure TfrmFatDigCartaCorrecao.dbgCorrecoesDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    pSetFocus(cmbCorrecoes);
  End
  Else If Key = VK_DELETE Then
  Begin
    If Not cdsCorrecoes.IsEmpty Then
    Begin
      If cdsCorrecoesCCN_ENVIAD.AsInteger = 1 Then
      Begin
        pMensagemOk('Não é permitido excluir uma correção já enviada.');
      End
      Else If fMensagem('', 'Confirma exclusão?', ['&Sim', '&Não']) = 1 Then
      Begin
        pApagaCorrecao(cdsCorrecoesAUTOINCREM.AsString);
        cdsCorrecoes.Delete;
      End;
    End;
  End;
end;

function TfrmFatDigCartaCorrecao.fEnviarCorrecoesNFe(pgbProgresso: TcxProgressBar): Boolean;
  Var
    stlMensagens: TStringList;
    libNfe: TLibNfe;
    objRetornoCartaCorrecao : TRetornoCartaCorrecao;
begin
  Result := False;
  stlMensagens := fMontaMensagemCorrecao;
  Try
    If stlMensagens.Count > 0 Then
    Begin
      Try
        libNfe := TLibNfe.Create(VS_strCodEmp);
        objRetornoCartaCorrecao := libNfe.fEnviarCartaCorrecao(edtChaveAcesso.Text, stlMensagens, intSequencial);
        Try
          strProtocolo := objRetornoCartaCorrecao.strProtocolo;
          strMensagem  := objRetornoCartaCorrecao.strMensagem;
        Finally
          FreeAndNil(objRetornoCartaCorrecao);
        End;
        Result := True;
      Except
        On E: ExceptionNFePrinter Do
        Begin
          Result := True;
          pMensagemOk(E.Message);
        End;

        On E: ExceptionAutCom Do
        Begin
          pMensagemOk(E.Message);
        End;

        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmFatDigCartaCorrecao.fEnviarCorrecoesNFe]');
        End;
      End;
      FreeAndNil(libNfe);
    End;
  Finally
    FreeAndNil(stlMensagens);
  End;
end;

function TfrmFatDigCartaCorrecao.fLimpaCaracteresInvalidos(strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result,  '”', '');
  Result := AnsiReplaceStr(Result, '''', '');
  Result := AnsiReplaceStr(Result,  '|', '');
  Result := AnsiReplaceStr(Result,  #13, '');
  Result := AnsiReplaceStr(Result,  #10, '');
end;

function TfrmFatDigCartaCorrecao.fMontaMensagemCorrecao: TStringList;
  Var
    strAux: String;
begin
  Result := TStringList.Create;
  cdsCorrecoes.First;
  While (Not cdsCorrecoes.Eof) Do
  Begin

    strAux := fLimpaCaracteresInvalidos(fRetornaLinhaNaoEnviadaCartaCorrecao(cdsCorrecoes));
    If Not fEmptyStr(strAux) Then
      Result.Add(strAux);

    cdsCorrecoes.Next;
  End;
end;

procedure TfrmFatDigCartaCorrecao.pLimparDadosCorrecao;
begin
  cmbCorrecoes.ItemIndex := 0;
  edtDescricao.Clear;
end;

procedure TfrmFatDigCartaCorrecao.pProcessaExibeCaractesRestante;
  Var
    intAux: Integer;
begin
  intAux := fRetonarCaractesRestante;

  lblCar.Caption := IntToStr(intAux);
  lblCar.Font.Color := IIF(intAux >= 0, clWhite, clRed);
end;

function TfrmFatDigCartaCorrecao.fRetonarCaractesRestante: Integer;
  Var
    cdsAux: TUniClientDataSet;
    strAux: String;
begin
  Result := 1000;

  If (Not cdsCorrecoes.IsEmpty) Then
  Begin
    cdsAux := TUniClientDataSet.Create(Self);
    Try
      pCloneDataSet(cdsAux, cdsCorrecoes);
      cdsAux.First;

      While Not cdsAux.Eof Do
      Begin
        strAux := fRetornaLinhaNaoEnviadaCartaCorrecao(cdsAux);
        If Not fEmptyStr(strAux) Then
          Result := Result - Length(strAux);

        cdsAux.Next;
      End;

    Finally
      FreeAndNil(cdsAux);
    End;
  End;
end;

function TfrmFatDigCartaCorrecao.fRetornaLinhaNaoEnviadaCartaCorrecao(cds: TDataSet): String;
begin
  Result := '';

  If (Not cds.IsEmpty) Then
  Begin
    Result := cds.FieldByName('CCN_CODCOR').AsString + '-'  +
              cds.FieldByName('CCN_NOMCOR').AsString + ': ' +
              cds.FieldByName('CCN_DESCOR').AsString;
  End;
end;

function TfrmFatDigCartaCorrecao.fRetornaNomeCorrecao(const strTexto: String): String;
  Var
    intPos: Integer;
begin
  intPos := Pos('-', strTexto);
  Result := Trim(Copy(strTexto, intPos+1, Length(strTexto)));
end;

function TfrmFatDigCartaCorrecao.fRetornaProximoSequencial: Integer;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT MAX(IFNULL(CCN_CODSEQ,0))+1 AS SEQ ');
  qryAux.SQL.Add('FROM CC_NFE WHERE CCN_SEQGER = :SEQGER ');
  qryAux.ParamByName('SEQGER').AsString := strAutIncSelecionado;
  qryAux.Open;

  Result := qryAux.FieldByName('SEQ').AsInteger;
  If Result <= 0 Then
  Begin
    Result := 1;
  End;

  FreeAndNil(qryAux);
end;

function TfrmFatDigCartaCorrecao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End
  Else If Sender = cmbCorrecoes Then
  Begin
    If cmbCorrecoes.ItemIndex < 0 Then
    Begin
      pMensagemOk('É necessário escolher uma opção de correção.');
      Result := False;
    End;
  End
  Else If Sender = edtDescricao Then
  Begin
    If (fEmptyStr(edtDescricao.Text)) Or (Length(edtDescricao.Text)< 15) Then
    Begin
      pMensagemOk('É necessário preencher a descrição da correção, ' +
        'e a mesma deve conter 15 ou mais caracteres.');
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigCartaCorrecao.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGen : TUniQuery;
    arrSel: TConsultasArray;
begin

  If (fEntraCons(Key)) Then
  Begin

    If (Not fValidaCampos(mskDtaIni)) Or (Not fValidaCampos(mskDtaFin)) Then
    Begin
      Exit;
    End;

    Key := '?';
    qryGen :=  fCriaQuery(Self);

    If fPesqLivroFiscal(Self, qryGen, Key, arrSel, True, conCartaCorrecao,
                        '', '', '', '', False, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), True, '', False, True) Then
    Begin
      edtNumDoc.Text := qryGen.FieldByName('FIS_NUMDOC').AsString;
      edtChaveAcesso.Text := qryGen.FieldByName('FIS_ACESSO').AsString;
      edtSerie.Text := qryGen.FieldByName('FIS_SERIE_').AsString;
      edtEspDoc.Text := qryGen.FieldByName('FIS_ESPDOC').AsString;
      strAutIncSelecionado := qryGen.FieldByName('AUTOINCREM').AsString;
      pCarregarCorrecoes(strAutIncSelecionado);
      pSetFocus(cmbCorrecoes);
    End;

    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatDigCartaCorrecao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCorrecoes.CreateDataSet;
  strAutIncSelecionado:= '';
  strProtocolo := EmptyStr;
  intSequencial := 0;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
  blnAtualizaProtocolo := fCampoExiste('CC_NFE', 'CCN_PROTOC', True);
  pCarregaMotivos;
end;

procedure TfrmFatDigCartaCorrecao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnConfirmaDados.Click;
  End;
end;

procedure TfrmFatDigCartaCorrecao.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmFatDigCartaCorrecao.pCarregaMotivos;
  Var
    qryCadIrr: TUniQuery;
begin
  cmbCorrecoes.Items.Clear;
  qryCadIrr := fCriaQuery(Self);
  qryCadIrr.SQL.Add('SELECT * FROM CADIRR');
  qryCadIrr.Open;

  While Not qryCadIrr.Eof Do
  Begin
    cmbCorrecoes.Items.Add(qryCadIrr.FieldByName('IRR_CODIRR').AsString + ' - ' + 
                           qryCadIrr.FieldByName('IRR_DESIRR').AsString);
    qryCadIrr.Next;
  End;

  FreeAndNil(qryCadIrr);
end;

procedure TfrmFatDigCartaCorrecao.pCarregarCorrecoes(strAutInc: String);
  Var
    qryCorrecoes: TUniQuery;
begin
  qryCorrecoes := fCriaQuery(Self);
  qryCorrecoes.SQL.Add('SELECT * FROM CC_NFE WHERE CCN_SEQGER = :SEQGER ORDER BY CCN_DTAENV, AUTOINCREM');
  qryCorrecoes.ParamByName('SEQGER').AsString := strAutInc;
  qryCorrecoes.Open;

  cdsCorrecoes.EmptyDataSet;
  While Not qryCorrecoes.Eof Do
  Begin
    cdsCorrecoes.Append;
    cdsCorrecoesCCN_SEQGER.AsString := strAutInc;
    cdsCorrecoesAUTOINCREM.AsString := qryCorrecoes.FieldByName('AUTOINCREM').AsString;
    cdsCorrecoesCCN_CODCOR.AsString := qryCorrecoes.FieldByName('CCN_CODCOR').AsString;
    cdsCorrecoesCCN_NOMCOR.AsString := qryCorrecoes.FieldByName('CCN_NOMCOR').AsString;
    cdsCorrecoesCCN_DESCOR.AsString := qryCorrecoes.FieldByName('CCN_DESCOR').AsString;
    cdsCorrecoesCCN_DTAENV.AsString := qryCorrecoes.FieldByName('CCN_DTAENV').AsString;
    cdsCorrecoesCCN_ENVIAD.AsInteger := qryCorrecoes.FieldByName('CCN_ENVIAD').AsInteger;
    cdsCorrecoes.Post;

    qryCorrecoes.Next;
  End;  

  FreeAndNil(qryCorrecoes);
end;

procedure TfrmFatDigCartaCorrecao.pEscapePressed;
begin
  If not Assigned(ActiveControl) Then
    inherited
  Else
  Begin
    If ActiveControl.Parent = pnlCorrecoes THen
    Begin
      pSetFocus(mskDtaIni);
    End
    Else
    Begin
      inherited;
    End;
  End;
end;

procedure TfrmFatDigCartaCorrecao.pApagaCorrecao(strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add('DELETE FROM CC_NFE WHERE AUTOINCREM = :AUTINC');
    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.ExecSQL;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatDigCartaCorrecao.pApagaCorrecao]');
    End;
  End;

  FreeAndNil(qryAux);
end;

function TfrmFatDigCartaCorrecao.fExisteDocumentosPendentes: Boolean;
begin
  Result := False;

  cdsCorrecoes.DisableControls;

  Try
    cdsCorrecoes.First;
    While Not cdsCorrecoes.Eof Do
    Begin
      Result := (cdsCorrecoes.FieldByName('CCN_ENVIAD').AsString = '0');

      If Result Then
        Break;

      cdsCorrecoes.Next;
    End;

  Finally
    cdsCorrecoes.EnableControls;
  End;
end;

end.
