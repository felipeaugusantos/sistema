{***********************}
{* qryConOpe -> CADOPE *}
{********************JB*}

unit untTransfCodVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, ComCtrls,
  Uni, AppEvnts, UniClientDataSet, strUtils, DB, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico,
  untZClient, untModulo;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;  

type
  TForeignKeyArray = Array of TForeignKey;

Type
  TCamposVendedor = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;

  End;

type
  TfrmTransfCodVendedor = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtVenOri: TEditFocus;
    edtDesVenOri: TEditFocus;
    edtVenDes: TEditFocus;
    edtDesVenDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    frxReport: TfrxReport;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtVenOriKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure edtVenDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;
    arrCamposVendedor: Array Of TCamposVendedor;
    cdsVendedor: TZClient;
    objExcelTrans: TTransfImportAutomatico;
    blnDivergencia: Boolean;

    procedure pCarregaVendedor(edtCodigo, edtNome: TEditFocus);

    function fTransfereCodVendedor: Boolean;
    function fAtualizaCodVendedor(strNomArq, strCampo, strVenOri, strVenDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientVendedor;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pGravaLogChq(strTabela, strVenOri, strVenDes: String);
    procedure pPreencheArray;
    procedure pChecarTabelas;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmTransfCodVendedor: TfrmTransfCodVendedor;

implementation

uses untfuncoesSimples,
     untPesqAux, untGravando,
     untConsultas, untCfgRepositorio, untTypesSistema, untTCadChqRepository;

{$R *.dfm}

procedure TfrmTransfCodVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  objExcelTrans := TTransfImportAutomatico.Create;

end;

procedure TfrmTransfCodVendedor.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodVendedor.btnImpExcelClick(Sender: TObject);
begin
  objExcelTrans.pAddEditInput(edtVenOri, 3, True);
  objExcelTrans.pAddEditInput(edtVenDes, 3, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodVendedor.edtVenDesKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtVenDes, edtDesVenDes, qryConOpe, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfCodVendedor.edtVenOriKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtVenOri, edtDesVenOri, qryConOpe, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmTransfCodVendedor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtVenOri) Then
  Begin

    If (fEmptyStr(edtVenOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Operador origem deve ser preenchido!');
      Result := False;
    End
    Else If edtVenOri.Text = edtVenDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Operador origem deve diferente do Operador destino!');
      Result := False;
    End
    Else
    Begin
      pCarregaVendedor(edtVenOri, edtDesVenOri);
      If (fEmptyStr(edtDesVenOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Operador não está cadastrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtVenDes) Then
  Begin

    If (fEmptyStr(edtVenDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O Operador destino deve ser preenchido!');
      Result := False;
    End
    Else If edtVenOri.Text = edtVenDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O Operador destino deve diferente do Operador origem!');
      Result := False;
    End
    Else
    Begin
      pCarregaVendedor(edtVenDes, edtDesVenDes);
      If (fEmptyStr(edtDesVenDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse Operador não está cadastrado!');
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmTransfCodVendedor.pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodigo.Text);
  With qryConOpe Do
  Begin
    edtNome.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

function TfrmTransfCodVendedor.fTransfereCodVendedor: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGen         : TUniQuery;
begin

  intTamMat := Length(arrCamposVendedor);
  intContador := 0;

  qryGen := fCriaQuery(Self);

  Try

    While intContador < intTamMat Do
    Begin

      lsvArqAlterados.Items.Add;
      lsvArqAlterados.Items[intContador].Caption := arrCamposVendedor[intContador].strDesCam;
      lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
      Inc(intContador);
      Application.ProcessMessages;

    End;

    intContador := 0;
    fStartTransaction;

    //Deleta as metas que coincidem
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM CADMET';
    strSQL := strSQL + ' WHERE CADMET.MET_CODVEN = :CODOPE';
    strSQL := strSQL + ' AND MET_MESANO IN (SELECT MET_MESANO FROM CADMET WHERE MET_CODVEN = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'CADMET', qryGen, True);
        Delete;
      End;

      Close;
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM CADMLQ';
    strSQL := strSQL + ' WHERE CADMLQ.MET_CODVEN = :CODOPE';
    strSQL := strSQL + ' AND MET_MESANO IN (SELECT MET_MESANO FROM CADMLQ WHERE MET_CODVEN = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'CADMLQ', qryGen, True);
        Delete;
      End;

      Close;
    End;

    //Deleta as relações de CADGOC (Grupo de ocorrências) que coincidem
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM GOCOPE';
    strSQL := strSQL + ' WHERE GOO_CODOPE = :CODOPE';
    strSQL := strSQL + ' AND GOO_CODGOC IN (SELECT GOO_CODGOC FROM GOCOPE WHERE GOO_CODOPE = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'GOCOPE', qryGen, True);
        Delete;
      End;

      Close;
    End;

    //Deleta as ocorrências em MECDET que coincidem
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM MECDET';
    strSQL := strSQL + ' WHERE DET_CODMEC = :CODOPE';
    strSQL := strSQL + ' AND DET_SEQDET IN (SELECT DET_SEQDET FROM MECDET WHERE DET_CODMEC = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'MECDET', qryGen, True);
        Delete;
      End;

      Close;
    End;

    //Deleta as ocorrências em MECDOR que coincidem
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM MECDOR';
    strSQL := strSQL + ' WHERE FDO_CODMEC = :CODOPE';
    strSQL := strSQL + ' AND FDO_SEQFDO IN (SELECT FDO_SEQFDO FROM MECDOR WHERE FDO_CODMEC = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'MECDOR', qryGen, True);
        Delete;
      End;

      Close;
    End;

    //Deleta as ocorrências em MECGER que coincidem
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM MECGER';
    strSQL := strSQL + ' WHERE GER_CODMEC = :CODOPE';
    strSQL := strSQL + ' AND CONCAT(GER_SEQGER,"-",GER_IDESER) IN (SELECT CONCAT(GER_SEQGER,"-",GER_IDESER) FROM MECGER WHERE GER_CODMEC = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'MECGER', qryGen, True);
        Delete;
      End;

      Close;
    End;

    //Deleta as ocorrências em MECGOR que coincidem
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM MECGOR';
    strSQL := strSQL + ' WHERE FGO_CODMEC = :CODOPE';
    strSQL := strSQL + ' AND CONCAT(FGO_SEQFGO,"-", FGO_IDESER) IN (SELECT CONCAT(FGO_SEQFGO,"-",FGO_IDESER) FROM MECGOR WHERE FGO_CODMEC = :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      While not EOF Do
      Begin
        fVerificaIntegridade(Self.Name, 'MECGOR', qryGen, True);
        Delete;
      End;

      Close;
    End;

    //Deleta a assinatura do operador de origem se os dois possuirem assinatura.
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM OPEASS';
    strSQL := strSQL + ' WHERE ASS_CODOPE IN (:CODOPE, :OPEDES)';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ParamByName('OPEDES').AsString := edtVenDes.Text;
      Open;
      First;

      //Deleta a assinatura do operador de Origem
      If RecordCount > 1 Then
      Begin
        if Locate('ASS_CODOPE', edtVenOri.Text, []) then
          Delete;
      End;

      Close;
    End;


    While intContador < intTamMat Do
    Begin

      If Pos(arrCamposVendedor[intContador].strNomArq, 'CADCHQ') > 0  Then
       pGravaLogChq(arrCamposVendedor[intContador].strNomArq, edtVenOri.Text, edtVenDes.Text);


      Application.ProcessMessages;
      intRegAlterados := 0;

      For intContador2 := 1 To 2 Do
      Begin

        intRegAlterados := intRegAlterados + fAtualizaCodVendedor(arrCamposVendedor[intContador].strNomArq,
                                                                  arrCamposVendedor[intContador].strCamCod,
                                                                  edtVenOri.Text,
                                                                  edtVenDes.Text,
                                                                  intContador2);
        Application.ProcessMessages;

      End;

      lsvArqAlterados.Items[intContador].Selected := True;
      lsvArqAlterados.Items[intContador].MakeVisible(False);
      lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

      Application.ProcessMessages;
      Inc(intContador);

    End;

    {***************************************}
    {EXCLUINDO VENDEDOR DE ORIGEM           }
    {************************************LU*}

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM DIROPE WHERE OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      Open;
      fVerificaIntegridade(Self.Name, 'DIROPE', qryGen, True);
      Close;
    End;


    strSQL := '';
    strSQL := strSQL + 'DELETE FROM DIROPE WHERE OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM DIRTIN WHERE TIN_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      Open;
      fVerificaIntegridade(Self.Name, 'DIRTIN', qryGen, True);
      Close;
    End;


    strSQL := '';
    strSQL := strSQL + 'DELETE FROM DIRTIN WHERE TIN_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM DIRBAN WHERE BAN_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      Open;
      fVerificaIntegridade(Self.Name, 'DIRBAN', qryGen, True);
      Close;
    End;


    strSQL := '';
    strSQL := strSQL + 'DELETE FROM DIRBAN WHERE BAN_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM FXAVEN WHERE FXA_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      Open;
      fVerificaIntegridade(Self.Name, 'FXAVEN', qryGen, True);
      Close;
    End;


    strSQL := '';
    strSQL := strSQL + 'DELETE FROM FXAVEN WHERE FXA_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM OPEGPO WHERE OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      Open;
      fVerificaIntegridade(Self.Name, 'OPEGPO', qryGen, True);
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM OPEGPO WHERE OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADOPE WHERE OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      Open;
      fVerificaIntegridade(Self.Name, 'CADOPE', qryGen, True);
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CADOPE WHERE OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := edtVenOri.Text;
      ExecSQL;
      Close;
    End;

    pGravarTabelaLog(edtVenOri.Text, edtVenDes.Text, 'CADOPE');

    fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      If objExcelTrans.blnExecutandoTransferencia Then
        objExcelTrans.pAddNotificacao(E.Message)
      Else
        pMensagensErro(E.Message, '[fTransfereCodVendedor]');
    End;
  End;

end;

{*****************************************}
{* OPÇÃO:                                *}
{* 1 -> ARQUIVO                          *}
{* 2 -> ARQUIVO DELETADO                 *}
{**************************************MV*}
function TfrmTransfCodVendedor.fAtualizaCodVendedor(strNomArq, strCampo, strVenOri, strVenDes: String;
  intOpcao: Integer): Integer;
  Var
    strSQL   : String;
    strCFG   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    Result := 0;

    qryGenTmp := fCriaQuery(Self);

    If (strNomArq = 'COMPRO') And (intOpcao = 2) Then
      strCampo := 'OPEDEL';

    If intOpcao = 2 Then
      strNomArq := 'DEL_' + strNomArq;

    If Not fTabelaExiste(strNomArq) Then
      Exit;

    if Not fCampoExiste(strNomArq, strCampo) then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ' + strNomArq + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ' + strCampo + ' = :VENDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :VENORI ';

    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADOPE');

      if not fEmptyStr(strCFG) then
        strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
      Else
      Begin
        Result := 0;
        Exit;
      End;

    End;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VENDES').AsString := strVenDes;
      ParamByName('VENORI').AsString := strVenOri;

      Try
        ExecSQL;
      Except
        On E: Exception Do
        Begin
          If (Pos('duplicada', LowerCase(E.Message)) > 0) Or
             (Pos('duplicate', LowerCase(E.Message)) > 0) Then
          Begin
            Result := 0;
          End
          Else
            Raise;
        End;
      End;

      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

procedure TfrmTransfCodVendedor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;
    btnConfirmaDados.Enabled := False;
    If (fTransfereCodVendedor) Then
    Begin
      objExcelTrans.pAddNotificacao('Código de Operador transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtVenOri.Clear;
      edtDesVenOri.Clear;
      edtVenDes.Clear;
      edtDesVenDes.Clear;

      pSetFocus(edtVenOri);
    End;

  End;

end;

procedure TfrmTransfCodVendedor.pChecarTabelas;
Begin
  frmGravandoGenericProcedure.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray;
  pCriaClientVendedor;
End;


procedure TfrmTransfCodVendedor.FormShow(Sender: TObject);
begin
  inherited;

  Try
    TfrmGravando.fExecutarModal(pChecarTabelas, 'Validando Chave Estrangeira do Banco de Dados, Aguarde...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodVendedor.FormShow]');
    End;
  End;

  Screen.Cursor := crDefault;
  pMostraDivergencia;

  pSetFocus(edtVenOri);
end;

procedure TfrmTransfCodVendedor.pGravaLogChq(strTabela, strVenOri, strVenDes: String);
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    repCadChq  : TCadChqRepository;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT *               ';
  strSQL := strSQL + ' FROM ' + strTabela      ;
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   CHQ_CODVEN = :CODVEN ';

  qryConsulta := fCriaQuery;

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODVEN').AsString := strVenOri;
    Open;
    First;

    repCadChq := TCadChqRepository.Create;

    While Not Eof Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          'TRANSFERIU DO VENDEDOR ' + strVenOri + ' PARA ' + strVenDes);
      Next;
    End;

    FreeAndNil(repCadChq);
  End;

  FreeAndNil(qryConsulta);
end;

procedure TfrmTransfCodVendedor.pCriaClientVendedor;
begin

  If Not Assigned(cdsVendedor) Then
  Begin

    cdsVendedor := TZClient.Create(Self);

    With cdsVendedor, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO,');
      Add('  "S" AS EXISTE');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADOPE"');
      Add('  AND referenced_column_name = "OPE_CODOPE"');
      Add('  AND TCA_ARQREL IS NULL');
      Add('  AND NOT LOCATE(table_name, "DIROPE_OPEGPO_ALTEST_CADRCXY_DIRTIN_FXAVEN_DIRBAN")');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClientProduto');
    End;

  End;

end;

procedure TfrmTransfCodVendedor.pMostraDivergencia;
begin

  With cdsVendedor Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodVendedor.pCriaForm;
  Var
    Form: TForm;
    Memo: TMemo;
begin

  Try

    pCriarFormularios(TForm, Form);

    Form.BorderStyle := bsDialog;
	  Form.Position    := poScreenCenter;
	  Form.Width       := 400;
	  Form.Height      := 400;
    Form.Font.Name   := 'Arial';
    Form.Font.Size   := 10;
    Form.Color       := $00FFE4D5;

	  With TLabel.Create(form) do
    Begin
		  Parent     := Form;
		  Caption    := 'Tabela(s) que não existe(m) na lista :';
		  Left       := 10;
		  Top        := 10;
      Font.Style := [fsBold];
	  End;

	  With TBitBtnLocked.Create(form) Do
    Begin
		  Parent  := form;
      Width   := 100;
		  Height  := 23;
		  Left    := 280;
		  Top     := 340;
		  Kind    := bkClose;
      Caption := '&Sair';
	  End;

		Memo := TMemo.Create(form);

	  With Memo Do
    Begin
		  Parent     := form;
		  Left       := 10;
		  Top        := 35;
      Color      := clInfoBk;
		  Width      := form.ClientWidth - 22;
      Height     := 300;
      ScrollBars := ssBoth;

      With cdsVendedor Do
      Begin
        First;
        While Not Eof Do
        Begin

          If (Trim(FieldByName('TABELA').AsString) <> 'DIROPE')  And
             (Trim(FieldByName('TABELA').AsString) <> 'OPEGPO')  And
             (Trim(FieldByName('TABELA').AsString) <> 'ALTEST')  And
             (Trim(FieldByName('TABELA').AsString) <> 'CADRCXY') And
             (Trim(FieldByName('TABELA').AsString) <> 'DIRTIN')  And
             (Trim(FieldByName('TABELA').AsString) <> 'FXAVEN')  And
             (Trim(FieldByName('TABELA').AsString) <> 'DIRBAN')  Then
            Lines.Add(FieldByName('TABELA').AsString + ' - ' + FieldByName('CAMPO').AsString);

          Next;
        End;
      End;

      ReadOnly := True;
	  End;

    Form.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodVendedor.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;

procedure TfrmTransfCodVendedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsVendedor);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodVendedor.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;

end;

procedure TfrmTransfCodVendedor.pPreencheArray;
  Var
    intPosicao: Integer;
    qryTcoArr : TUniQuery;
begin
  Try
    qryTcoArr := fCriaQuery();
    With qryTcoArr, SQL Do
    Begin
      Add(' SELECT                ');
      Add(' TCA_ARQREL,           ');
      Add(' TCA_CAMREL,           ');
      Add(' TCA_DESCRI            ');
      Add(' FROM TCOARR           ');
      Add(' WHERE                 ');
      Add(' TCA_ARQUIV = "CADOPE" ');
      Add(' AND NOT LOCATE(TCA_ARQREL,"DIROPE_OPEGPO_ALTEST_CADRCXY_DIRTIN_FXAVEN_DIRBAN")');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCamposVendedor, succ(intPosicao));

        arrCamposVendedor[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCamposVendedor[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCamposVendedor[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.


